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