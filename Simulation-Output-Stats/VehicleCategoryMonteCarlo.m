% Date: June 3, 2013
% Author: Ankoor
% Uses input from TransModeler Version 3.0
% Reads VehClass.bin and Map TM Vehicle Class to MOVES Vehicle Class
% Monte Carlo Simulation???
% Use this code for TRB 2014 Paper.

clear all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
% Preparing Matlab to read VehClass.bin file 
ft(1).length = 1;ft(1).type = 'integer*4';ft(1).name = 'VehID';
ft(2).length = 1;ft(2).type = 'char';ft(2).name = 'Class';
ft(3).length = 1;ft(3).type = 'char';ft(3).name = 'Truck';
ft(4).length = 1;ft(4).type = 'char';ft(4).name = 'UserA';
ft(5).length = 1;ft(5).type = 'char';ft(5).name ='UserB';


% Reading "VehClass.bin" file
VehClass = readfields('VehClass.bin',ft);
totObs = size(VehClass,1); % Finds total # of observations
fprintf('finished reading VehClass.bin \n')
toc

% Storing different attributes in different column vectors
VehID=[VehClass(1:totObs).VehID];VehID=VehID';
VehType=[VehClass(1:totObs).Class];VehType=VehType';
Truck=[VehClass(1:totObs).UserA];Truck=Truck';
Port=[VehClass(1:totObs).UserB];Port=Port';

% Checks (To find and store vehicle types)
PC=VehType=='1'|VehType=='2'|VehType=='3';%PC=1~3, LDT=4, MDT=5, HDT=6 - checks and find vehicle type 1,2,3
LDT = VehType=='4'; LDT=LDT*4; % checks and stores veh type LDT i.e. Pickup Trucks
MDT=VehType=='5'; MDT=MDT*5; % checks and stores veh type MDT i.e. Small Trucks
HDT=VehType=='6'; HDT=HDT*6; % checks and stores veh type HDT trucks (including Port trucks)

VehType2=ones(totObs,1);
VehType2=VehType2.*PC;
VehType2=VehType2+LDT+MDT+HDT;

Check_Truck=Truck=='2';% if Truck=2, Other wise=1
Truck2=ones(totObs,1)+Check_Truck;

Check_Port_Truck=Port=='2';% if Port Truck=2, Otherwise=1
Port2=ones(totObs,1)+Check_Port_Truck;% if PortTruck=2, Otherwise=1

VehCat=[VehID,VehType2+(Truck2.*Port2)*10]; % 11 = PC, 24 = LDT(PU), 25 = MDT(ST), 26 = HDT(non Port), 46 = HDT(Port)

% Generate Random Number from uniform distribution on the interval [a, b]:
% r = a + (b-a).*rand(100,1);

% Find indices of different vehicle classes.

refPC = find(VehCat(:,2)==11); % Find VehCat = PC
refLDT = find(VehCat(:,2)==24); % Find VehCat = LDT(PU)
refMDT = find(VehCat(:,2)==25); % Find VehCat = MDT(ST)
refHDT = find(VehCat(:,2)==26); % Find VehCat = HDT(non Port)
refHDTP = find(VehCat(:,2)==46); % Find VehCat = HDT(Port)
    

% Assign new class to PC based on Fleet distribution using Uniform Distribution
for j = 1:size(refPC,1)
    rPC = 0.00001 + (100-0.00001).*rand(1,1);
    if rPC <= 99.54 % Gas
    VehCat(refPC(j,1),2)=1;   
    else % Diesel
    VehCat(refPC(j,1),2)=2;  
    end
end
% Assign new class to LDT based on Fleet distribution using Uniform Distribution
for j = 1:size(refLDT,1)
    rLDT = 0 + (100-0).*rand(1,1);
    if rLDT > 0.91 && rLDT <= 24.07 % Passenger Truck Gas (24.07 - 0.91 = 23.16)
    VehCat(refLDT(j,1),2)=3;   
    elseif rLDT > 0.19 && rLDT <= 0.91 % Passenger Truck Diesel (0.91 - 0.19 = 0.72)
    VehCat(refLDT(j,1),2)=4;  
    elseif rLDT > 24.07 && rLDT <= 100.0 % Light Commercial Truck Gas (100.00 - 24.07 = 73.95)
    VehCat(refLDT(j,1),2)=5; 
    else % Light Commercial Truck Diesel
    VehCat(refLDT(j,1),2)=6;    
    end
end

% Assign new class to MDT based on Fleet distribution using Uniform Distribution
for j = 1:size(refMDT,1)
    rMDT = 0 + (100-0).*rand(1,1);
    if rMDT <= 99.57 % Refuse Truck Gas
    VehCat(refMDT(j,1),2)=7;   
    else % Refuse Truck Diesel
    VehCat(refMDT(j,1),2)=8;  
    end
end

% Assign new class to HDT (non-Port) based on Fleet distribution using Uniform Distribution
for j = 1:size(refHDT,1)
    rHDT = 0 + (100-0).*rand(1,1);
    if rHDT > 60.06 && rHDT <= 100 % LHDT-1 Gas (100.00 - 60.06 = 39.94)
    VehCat(refHDT(j,1),2)=9;   
    elseif rHDT > 1.55 && rHDT <= 6.39 % LHDT-1 Diesel (6.39 - 1.55 = 4.84)
    VehCat(refHDT(j,1),2)=10; 
    elseif rHDT > 18.86 && rHDT <= 27.47 % LHDT-2 Gas (27.47 - 18.86 = 8.61)
    VehCat(refHDT(j,1),2)=11; 
    elseif rHDT > 6.39 && rHDT <= 11.75 % LHDT-2 Diesel (11.75 - 6.39 = 5.36)
    VehCat(refHDT(j,1),2)=12; 
    elseif rHDT > 11.75 && rHDT <= 18.86 % MHDT Gas (18.86 - 11.75 = 7.11)
    VehCat(refHDT(j,1),2)=13; 
    elseif rHDT > 39.14 && rHDT <= 60.06 % MHDT Diesel (60.06 - 39.14 = 20.92)
    VehCat(refHDT(j,1),2)=14; 
    elseif rHDT > 27.47 && rHDT <= 39.14 % HHDT Diesel (39.14 - 27.47 = 11.67)
    VehCat(refHDT(j,1),2)=16; 
    else % HHDT Gas Code should be "15" but since MOVES doesn't have this class so assign when using Emission Estimation use MHDT Gas code = "13" for Vehicle Category
    VehCat(refHDT(j,1),2)=15; % i.e. > 0 and <= 1.55     
    end
end

% Assign new class (OP Rate ID = 17) to HDT (Port) 
% for j = 1:size(refHDTP,1)
%     
%     rHDTP = 0 + (100-0).*rand(1,1);
%     HDTgas = (1.55/(1.55+11.67))*100;
%     if rHDTP <= (1-HDTgas)*100 % HHDT Diesel
%     VehCat(refHDTP(j,1),2)=17;   
%     else % HHDT Gas
%     VehCat(refHDTP(j,1),2)=18;  
%     end
% end


% Assign new class (OP Rate ID = 17) to HDT (Port)
for j = 1:size(refHDTP,1)
    if refHDTP(j,1) == 46 % HHDT Diesel
    VehCat(refHDTP(j,1),2)=17;
    else
    VehCat(refHDTP(j,1),2)=17;    
    end
end

fid = fopen('VehicleCategoryPre.txt','w');
fprintf(fid,'%d,%2d\n',[VehCat(:,1),VehCat(:,2)]');
fclose(fid);

fprintf('VehicleCategoryPre.txt Generated! \n')
toc

% trajectory.bin_out_veh_cate_i_j, where i = moves category, and j = 15 min
% intervals. Col(1) = Vehicle ID, Col(2) = Time(seconds), Col(3) = Segment
% ID, Col(4) = Distance (Don't need this), Col(5) = Speed.

% (sum(VehCat(:,2)==9)/size(refHDT,1))*100







