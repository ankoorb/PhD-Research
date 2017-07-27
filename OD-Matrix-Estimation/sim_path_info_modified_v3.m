% Date: April 25, 2013
% Modified by Ankoor
% Input from TransModeler Version 3.0
% Generating input data: sim_path_info.dat
% 1. origin
% 2. destination
% 3. start (departure) interval
% 4. arrival interval
% 5. total number of vehicles including SOV, HOV, and Truck
% 6. number of SOV vehicles
% 7. number of HOV vehicles
% 8. number of Pick Up Trucks
% 9. number of Small Trucks
% 10. number of HD Trucks
% 11. number of HD Trucks (Port Trucks)
% 12. number of detectors consisting of the path (n)
% 13~13+n. list of detector names

% test simulation network runs from 7:00 am = 25200 

% Defining new paths considering time interval based on link paths
clear all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defining Time parameters

interval=15*60; % time interval, here 15 min (900 sec)25200
simul_time=0+1800; % simulation start time from midnight (sec) Enter 0
clearance_time=25;
no_interval=(clearance_time*3600-simul_time)./interval;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% Preparing Matlab to read trips2.bin file 
ft(1).length = 1;ft(1).type = 'integer*4';ft(1).name = 'VehID';
ft(2).length = 1;ft(2).type = 'integer*4';ft(2).name = 'OriID';
ft(3).length = 1;ft(3).type = 'integer*4';ft(3).name = 'DesID';
ft(4).length = 1;ft(4).type = 'char';ft(4).name = 'Class';
ft(5).length = 1;ft(5).type = 'char';ft(5).name = 'Truck';
ft(6).length = 1;ft(6).type = 'char';ft(6).name = 'UserA';
ft(7).length = 1;ft(7).type = 'char';ft(7).name ='UserB';
ft(8).length = 1;ft(8).type = 'char';ft(8).name = 'Status';
ft(9).length = 1;ft(9).type = 'real*4';ft(9).name = 'DepTime';
ft(10).length = 1;ft(10).type = 'real*4';ft(10).name ='ArrTime';
ft(11).length = 1;ft(11).type = 'integer*4';ft(11).name ='Path';
ft(12).length = 1;ft(12).type = 'integer*2';ft(12).name='HOV';

% Reading "trips2.bin" file
trip = readfields('trips2.bin',ft);
totObs = size(trip,1); % Finds total # of observations

fprintf('finished reading Trips2.bin \n')
toc

tic
% Storing different attributes in different column vectors
VehID=[trip(1:totObs).VehID];VehID=VehID';
VehType=[trip(1:totObs).Class];VehType=VehType';
Truck=[trip(1:totObs).UserA];Truck=Truck';
Port=[trip(1:totObs).UserB];Port=Port';
Status=[trip(1:totObs).Status]; Status=Status'; 
OriID=[trip(1:totObs).OriID];OriID=OriID';
DesID=[trip(1:totObs).DesID];DesID=DesID';
Path=[trip(1:totObs).Path]; Path=Path';
DepTime=[trip(1:totObs).DepTime];DepTime=DepTime';
ArrTime=[trip(1:totObs).ArrTime];ArrTime=ArrTime';
HOV=[trip(1:totObs).HOV]; HOV=HOV'; 
% Checks (To find and store vehicle types)
check=VehType=='1'|VehType=='2'|VehType=='3';%PC=1~3, LDT=4, MDT=5, HDT=6 - checks and find vehicle type 1,2,3
check2=VehType=='4'; check2=check2*4; % checks and stores veh type LDT
check3=VehType=='5'; check3=check3*5; % checks and stores veh type MDT
check4=VehType=='6'; check4=check4*6; % checks and stores veh type HDT
check_hov=HOV==2; % checks if veh is HOV
VehType2=ones(totObs,1);
VehType2=VehType2.*check;
VehType2=VehType2+check_hov;
VehType2=VehType2+check2+check3+check4;

clear check check2 check3 check4 VehType check_hov HOV
check5=Truck=='2';% if Truck=2, Other wise=1
Truck2=ones(totObs,1)+check5;

check6=Port=='2';% if Truck=2, Other wise=1
Port2=ones(totObs,1)+check6;% if PortTruck=2, Other wise=1

check7=find(Status=='1'| Status=='2' | DepTime>3600*clearance_time);% Queued=1,Enroute=2,Stalled=3,Missed=4,Done=5
%check7=find(Status=='1'| DepTime>3600*(clearance_time-1)|DepTime<simul_time);% Queued=1,Enroute=2,Stalled=3,Missed=4,Done=5

%remove_set=VehID(check7);
check8= Status=='4'; % Check if vehicle status is "Missed"
temp_check8=1-check8; 
check8=check8.*-1; 
temp_check8=temp_check8+check8; % "-ve" values for vehicle with status = missed and 
new_trip=[VehID,VehType2+(Truck2.*Port2)*10,OriID,DesID,DepTime,ArrTime,Path.*temp_check8]; 
%clear VehID OriID DesID ArrTime DepTime Path Truck Port Status trip Port2 Truck2 VehType2 check5 check6 ft
%Path.*temp_check8 gives vehicle with status missed a "-ve" value
%1&3 = 21 – SOV, Pick-up Trucks
%2 = 12 – HOV
%4 = 24 – LDT
%5 = 25 – MDT
%6 = 26,46 – HDT, Port HDT

new_trip(check7,:)=[]; % Remove vehicles with status: Queued or Enroute or Stalled or Departure time > Clearance time
clear ft trip check5 check6 check7 check8 temp_check8 ArrTime DepTime Path
clear DesID OriID Port Port2 Status Truck Truck2 VehID VehType2 totObs

new_trip=sortrows(new_trip,7); % Sort Path column in ascending order
missed_ref=find(new_trip(:,7)<=0); % Find indices with "-ve" Path ID
new_trip(missed_ref,:)=[];

clear missed_ref %add_path_ids mx

[temp_path,temp_ref]=unique(new_trip(:,7),'first'); % Find indices of unique path's
temp_vehicle_path=[new_trip(temp_ref,1),temp_path]; % Vehicle ID and Unique Path ID

fprintf('Generated temp_vehicle_path \n')
toc
% The code below writes "temp_vehicle_path" to a text file
fid = fopen('temp_vehicle_path.txt','w');
fprintf(fid,'%8d, %6.0f\n',temp_vehicle_path');
fclose(fid);

clear temp_path temp_ref
tic
% C++ code that join's segpass.bin to temp_vehicle_path.txt
! Gwlee_BC_path segpass.bin temp_vehicle_path.txt
path=load('segpass.bin_out_veh_path'); clear segpass;
path=sortrows(path,[1,3]);
toc

% The code below changes ArrTime & DepTime fromat to 15 min peroids
timeIndex1=zeros(size(new_trip(:,1),1),1);
timeIndex2=zeros(size(new_trip(:,1),1),1);

for i=1:no_interval
    if i==1
index1= new_trip(:,5) < simul_time+interval*i; timeIndex1=timeIndex1+index1*i;
index2= new_trip(:,6) < simul_time+interval*i; timeIndex2=timeIndex2+index2*i;
    elseif i==no_interval
index1= simul_time+interval*(i-1) <= new_trip(:,5); timeIndex1=timeIndex1+index1*i;
index2= simul_time+interval*(i-1) <= new_trip(:,6); timeIndex2=timeIndex2+index2*i;

    else
index1= simul_time+interval*(i-1) <= new_trip(:,5) & new_trip(:,5) < simul_time+interval*i; timeIndex1=timeIndex1+index1*i;
index2= simul_time+interval*(i-1) <= new_trip(:,6) & new_trip(:,6) < simul_time+interval*i; timeIndex2=timeIndex2+index2*i;
    end
end

new_trip(:,5)=timeIndex1;
new_trip(:,6)=timeIndex2;

clear timeIndex1 timeIndex2 index1 index2


fprintf('Time format changed \n')
toc

%_ _ _ _ _ _ _ _ _ _  _  _  _
%1 2 3 4 5 6 7 8 9 10 11 12 13
%(Ori) (Des)(dept)(arr) (path)
% Generate unique path's based on Ori, Des, Dep time period, Path ID's 
new_path=(new_trip(:,3)-10000).*10^10+(new_trip(:,4)-10000).*10^7+new_trip(:,5).*10^5+new_trip(:,7);
new_trip(:,8)=new_path; % Store new_path in new_trip

clear new_path

new_trip=sortrows(new_trip,8); % Sort generated unique new path's in ascending order
[new_path_set,fref]=unique(new_trip(:,8),'first'); % Find index when unique new path appears first time
[new_path_set,lref]=unique(new_trip(:,8),'last'); % Find index when unique new path appears last time


tic
% The loop below generates core part of "path info" file: row consists of 
% unique new path id, ori, des, dep, arr, tot veh, sum SOV+PUT, sum HOV, sum LDT, sum MDT, sum HDT, sum Port HDT 
for i=1:size(new_path_set,1)   
    temp_set=new_trip(fref(i):lref(i),:);
        path_info(i,:)=[temp_set(1,7),temp_set(1,3),temp_set(1,4),temp_set(1,5),temp_set(1,6),...
        size(temp_set,1),sum(temp_set(:,2)==11),sum(temp_set(:,2)==12),...
        sum(temp_set(:,2)==24),sum(temp_set(:,2)==25),sum(temp_set(:,2)==26),sum(temp_set(:,2)==46)];
        new_trip(fref(i):lref(i),9)=i; % new_trip: col9 = i. 
        
        % size(new_path_set) = total number of Unique New Paths
        % new_trip col9 title: Path_Info Line #. For each veh ID in new_trip
        % with same Unique New Path ID is assigned Path_Info Line # = i, thus there will be i lines.
        
        
end

clear fref lref  temp new_path_set temp_set

fprintf('path_info done \n')
toc



clear ref temp_vehicle_path

[path_set,fpath]=unique(path(:,4),'first'); % Find index when unique path appears first time in path_data
[path_set,lpath]=unique(path(:,4),'last'); % Find index when unique path appears last time in path_data


tic

% The code below writes "sim_path_info_.dat" file
fid = fopen('sim_path_info_.dat','wt');  

for i=1:size(path_info,1)
    
        fprintf(fid,'%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d',path_info(i,2:12)');
        % Prints ori, des, dep, arr, tot veh, sum SOV+PUT, sum HOV, sum
        % LDT, sum MDT, sum HDT, sum Port HDT
        
        ref=find(path_set==path_info(i,1));
        temp_sensor=path(fpath(ref):lpath(ref),2);
        ref=find(temp_sensor>0);
        cnt=size(ref,1);
        fprintf(fid,',%d',cnt);
        
        if cnt==0
            fprintf(fid,',%d',0);
        else
            for k=1:cnt
              fprintf(fid,',%d',temp_sensor(ref(k),1));
            end
        end
        
        fprintf(fid,'\n');        
end

fclose(fid);

fprintf('sim_path_info_.dat generated \n')
toc

clear temp_sensor fpath lpath path_data path_set
 
% The code below writes "temp_vehicle_set.txt" 
fid = fopen('temp_vehicle_set.txt','w');
fprintf(fid,'%9d, %8d, %3d\n',[new_trip(:,1),new_trip(:,9),new_trip(:,2)]');
% col1 = Veh ID, col2 = Path ID, col3 = Veh Class (11,12,24,25,26,46)
fclose(fid);
clear new_trip

% Call function to generate sim_detector_info_.dat
sim_detector_info_modified_v3()

toc
