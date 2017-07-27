%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Estimate emissions from TransModeler trajectories using MOVES OpMode
% and calculates basic statistics
% Authors: Ankoor, JDS, Kevin
% Last revision: Dec 9, 2014 by JDS
%
% Program component: RunOpMode_MOVES_R5.m
% 
% Input data: SegmentLink.txt
%             Op_lookup_matrix.mat
%             trajectory.bin_out_veh_cate_#_##
%             trips3.bin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clc;
diary('CalcEmisV6_NPost.txt')

mydt = datestr(now);
fprintf('Current date and time: %s \n',mydt)
fprintf('\n* Calculate emissions from trajectories using MOVES, and some vehicle stats * \n')
fprintf('* Queued vehicles are excluded * \n')

tic

RFile = [pwd '\Summary_EVVTPV6_NPost.xls'];
warning('off','MATLAB:xlswrite:AddSheet'); % Disable Excel warning when adding new sheets

%%%%%%%%%%%%%%%%%%%%%%%%%%%      Setting    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=[1:14,16:17]; % List of vehicle classes
TP=96; % Number of time periods

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The list of OpMode ID's
modes=[0;1;11;12;13;14;15;16;21;22;23;24;25;27;28;29;30;33;35;37;38;39;40];
% Parameters: (1) Vehicle Type, (2) Rolling Term-A, (3) Rotating Term-B, (4) Drag Term-C,
% (5) Source Mass, (6) Fixed Mass Factor  
param=[21	0.156461	0.00200193	0.000492646	1.4788	 1.4788
       31	0.22112	    0.00283757	0.000698282	1.86686	 1.86686
       32	0.235008	0.00303859	0.000747753	2.05979	 2.05979
       51	1.41705	    0	        0.00357228	20.6845	 17.1
       52	0.561933	0	        0.00160302	7.64159	 17.1
       53	0.498699	0	        0.00147383	6.25047	 17.1
       54	0.617371	0	        0.00210545	6.73483	 17.1
       43	0.746718	0	        0.00217584	9.06989	 17.1
       42	1.0944	    0	        0.00358702	16.556	 17.1
       41	1.29515	    0	        0.00371491	19.5937	 17.1
       61	1.96354	    0	        0.00403054	29.3275	 17.1
       62	2.08126	    0	        0.00418844	31.4038	 17.1
       11	0.0251	    0	        0.000315	0.285	 0.285];

% (1)VehClass (2)Vehicle Type (3)Location in param
veh_type=[ 1          21             1
           2          21             1
           3          31             2
           4          31             2
           5          32             3
           6          32             3
           7          51             4
           8          51             4
           9          52             5
           10         52             5
           11         53             6
           12         53             6
           13         61             11
           14         61             11
           15         62             12
           16         62             12
           17         62             12];
%
% Vehicle type                  Fuel   Vehicle class code
%
% Passenger Cars                Gas         1  LDV
%                               Diesel      2  LDV
% Passenger Trucks              Gas         3  LDT
%                               Diesel      4  LDT
% Light Commercial Trucks       Gas         5  LDT
%                               Diesel      6  LDT
% Refuse Trucks                 Gas         7  MDT
%                               Diesel      8  MDT
% Single Unit Short haul Trucks	Gas         9  HDT
%                               Diesel      10 HDT
% Single Unit Long-haul Trucks	Gas         11 HDT
%                               Diesel      12 HDT
% Combination Short-haul Trucks	Gas         13 HDT
%                               Diesel      14 HDT
% Combination Long-haul Trucks	Gas         15 (none)
%                               Diesel      16 HDT
% Combination Long-haul Trucks	Diesel      17 PRT
       
% Structure of trips3.bin file 
%
ft(1).length = 1; ft(1).type = 'integer*4'; ft(1).name = 'VehID';
ft(2).length = 1; ft(2).type = 'integer*4'; ft(2).name = 'OriID';
ft(3).length = 1; ft(3).type = 'integer*4'; ft(3).name = 'DesID';
ft(4).length = 1; ft(4).type = 'char';      ft(4).name = 'Class';
ft(5).length = 1; ft(5).type = 'char';      ft(5).name = 'Truck';
ft(6).length = 1; ft(6).type = 'char';      ft(6).name = 'UserA';
ft(7).length = 1; ft(7).type = 'char';      ft(7).name ='UserB';
ft(8).length = 1; ft(8).type = 'char';      ft(8).name = 'Status';
ft(9).length = 1; ft(9).type = 'real*4';    ft(9).name = 'DepTime';
ft(10).length = 1;ft(10).type = 'real*4';   ft(10).name ='ArrTime';
ft(11).length = 1;ft(11).type = 'integer*4';ft(11).name ='Path';
ft(12).length = 1;ft(12).type = 'integer*2';ft(12).name='HOV';
ft(13).length = 1;ft(13).type = 'real*4';   ft(13).name='Dist';

trip = readfields('trips3.bin',ft);
totObs = size(trip,1); % Find total # of trips

VehID=[trip(1:totObs).VehID]'; % Vehicle ID
VehType=[trip(1:totObs).Class]'; % Vehicle type
Status=[trip(1:totObs).Status]'; % Vehicle status: Queued=1,Enroute=2,Stalled=3,Missed=4,Done=5
DepTime=[trip(1:totObs).DepTime]'; % Departure time (sec)
ArrTime=[trip(1:totObs).ArrTime]'; % Arrival time (sec)
Dist=[trip(1:totObs).Dist]'; % Trip distance (mi)

new_trip=[VehID,DepTime,ArrTime,Dist]; 

clear trip DepTime ArrTime Dist


% Vehicle status: Queued=1, Enroute=2, Stalled=3, Missed=4, Done=5
% Find basic stats
%
fprintf('\n* Statistics from trips3.bin *\n');
%
ntrp = sum(Status=='1'); % Queued trips
fprintf('\n Number of queued trips: %i \n',ntrp);
if ntrp>0
    fprintf('    Queued trips: distance (miles)= 0, time (hours)= 0 \n');
end
%
ntrp = sum(Status=='2'); % En route trips
fprintf('\n Number of en route trips: %i \n',ntrp);
if ntrp>0
    check6 = find(Status=='2');
    temp_set = new_trip(check6,:);
    ms_dist = sum(temp_set(:,4));
    ms_time = ((ntrp*24*3600)-sum(temp_set(:,2)))/3600; % Change 24 if duration not 24 hours
    fprintf('    En route trips: distance (miles)= %8.1f, time (hours)= %8.1f \n',ms_dist,ms_time);
end
%
ntrp = sum(Status=='3'); % Stalled trips
fprintf('\n Number of stalled trips: %i \n',ntrp);
if ntrp>0
    check6 = find(Status=='3');
    temp_set = new_trip(check6,:);
    ms_dist = sum(temp_set(:,4));
    ms_time = (sum(temp_set(:,3))-sum(temp_set(:,2)))/3600;
    fprintf('    Stalled trips: distance (miles)= %8.1f, time (hours)= %8.1f \n',ms_dist, ms_time);
end
%
ntrp = sum(Status=='4'); % Missed trips
fprintf('\n Number of missed trips: %i \n',ntrp);
if ntrp>0
    check6 = find(Status=='4');
    temp_set = new_trip(check6,:);
    ms_dist = sum(temp_set(:,4));
    ms_time = (sum(temp_set(:,3))-sum(temp_set(:,2)))/3600;
    fprintf('    Missed trips: distance (miles)= %8.1f, time (hours)= %8.1f \n',ms_dist, ms_time);
end
%
ntrp = sum(Status=='5'); % Completed trips
fprintf('\n Number of completed trips: %i \n',ntrp); 
if ntrp>0
    check6 = find(Status=='5');
    temp_set = new_trip(check6,:);
    ms_dist = sum(temp_set(:,4));
    ms_time = (sum(temp_set(:,3))-sum(temp_set(:,2)))/3600;
    fprintf('    Completed trips: distance (miles)= %8.1f, time (hours)= %8.1f \n',ms_dist, ms_time);
end
fprintf(' \n');

clear new_trip temp_set check6 ms_dist ms_time


% Create a list of vehIDSs to be excluded 
check = (Status=='1');
Exclusion=VehID(check,1);
Exclusion=sortrows(Exclusion,1);

clear VehID Status 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Parallel processing
% Increase default value of NumWorkers for a Local cluster
CPU=str2double(getenv('NUMBER_OF_PROCESSORS')); % Check number of CPU cores
myCluster = parcluster('local');
myCluster.NumWorkers = CPU;  
saveProfile(myCluster);    
%
% Activate parallel computation
if matlabpool('size') < CPU
   matlabpool('open','local',CPU)% Activate parallel computation using local configuration
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Op_lookup_matrix.mat; %Load pullutant emission rates
Op_rate=[Op_rate1,Op_rate2,Op_rate3,Op_rate4,Op_rate5,Op_rate6,Op_rate7,Op_rate8,Op_rate9,Op_rate10,Op_rate11,Op_rate12,Op_rate13,Op_rate14,Op_rate14,Op_rate16,Op_rate17];
clear Op_rate1 Op_rate2 Op_rate3 Op_rate4 Op_rate5 Op_rate6 Op_rate7 Op_rate8 Op_rate9 Op_rate10 Op_rate11 Op_rate12 Op_rate13 Op_rate14 Op_rate16 Op_rate17

SegmentLink=load('SegmentLink.txt'); % Load TM Segment, Link, Direction (Fwy = 1, Art = 0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loops on vehicle classes and time periods to calculate emissions
% and basic statistics
%
Vinfo = zeros(size(N,2)+1,TP,4);
s0 = 'trajectory.bin_out_veh_cate_';
for i=1:size(N,2) % Loop on vehicle classes
    VehClass=N(i); % Actual vehicle classes
    s1=int2str(VehClass);
    parfor time=1:TP % TP periods for each class
        fprintf('Processing vehicle class %d, time period %d\n',VehClass,time)
        s2c=int2str(time);
        s3c=strcat(s0,s1,'_',s2c); % Current period trajectories
        check_c = exist(s3c, 'file'); % Check if the file exists  
        if (check_c == 2)
            s2n=int2str(time+1);
            s3n=strcat(s0,s1,'_',s2n); % Next period trajectories
            [link_emi2,Veh_stat]=RunOpMode_MOVES_V6(s3c,s3n,VehClass,Op_rate,SegmentLink,modes,param,veh_type,Exclusion); % Calculate emissions          
            Vinfo(i,time,:)=Veh_stat;
            % Save emissions in bin file
            if link_emi2(1)>0
                s4=strcat('LinkEmi_',s1,'_',s2c,'.csv');
                csvwrite(s4,link_emi2);
                fprintf('Done with vehicle class %d, time period %d\n',VehClass,time)
            else
                fprintf('No valid trajectory for vehicle class %d in time period %d\n',VehClass,time)
            end
        else
            Vinfo(i,time,:)=[0 0 0 0];
            fprintf('Vehicle class %d, time period: %d: Trajectory file not found\n',VehClass,time);
        end
    end
end

fprintf('\n* Writing results to %s *\n',RFile);

% Save vehicle counts, VMT, and VHT into RFile
%
header={'VehClass','TimePeriod','VehCount','VMT','VHT(h)','iVHT(h)'};
timper=[1:TP]';
Vsuma = zeros(4,1); % Stores summary for each vehicle type summed over time periods
for i=1:size(N,2) % Total N vehicle classes, and TP periods for each class
    s1 = int2str(N(i)); % Vehicle class
    s2 = ['VehClass',s1]; % Name of worksheet where results are saved
    xlswrite(RFile,header,s2,'a1'); % Header
    vcat=(N(i)*ones(TP,1));
    xlswrite(RFile,vcat,s2,'a2'); % Vehicle category
    xlswrite(RFile,timper,s2,'b2'); % Time period
    Vinf2 = squeeze(Vinfo(i,:,:));
    xlswrite(RFile,Vinf2,s2,'c2'); % Write # active veh, VMT and VHT
    Vsuma(1:4) = sum(Vinf2(:,1:4)); % Sum for corresponding vehicle type
    xlswrite(RFile,Vsuma',s2,'c99'); % Write results
    xlswrite(RFile,{'Totals'},s2,'a99'); % Caption
end

% Summary by time period for all vehicle categories
%
Vinfo(end,:,1:4)=sum(Vinfo(1:size(N,2),:,1:4));
s2 = ['AllVeh']; % Name of worksheet where results are saved
xlswrite(RFile,header,s2,'a1'); % Header
vcat=99*ones(TP,1);
xlswrite(RFile,vcat,s2,'a2'); % Vehicle category
xlswrite(RFile,timper,s2,'b2'); % Time period
Vinf2 = squeeze(Vinfo(end,:,:));
xlswrite(RFile,Vinf2,s2,'c2'); % Write VMT, VHT, iVHT, VehCount
Vsuma(1:4) = sum(Vinf2(:,1:4)); % Sum for corresponding vehicle type
xlswrite(RFile,Vsuma',s2,'c99'); % Write results
xlswrite(RFile,{'Totals'},s2,'a99'); % Caption

% Summary by vehicle category
%
header={'TimePeriod','VehCount','VMT','VHT(h)','iVHT(h)'};
Vsumm = zeros(5,TP,4); % Stores summary for each vehicle category by time period
Vsuma = zeros(6,4); % Stores summary for each vehicle category summed over time periods
Vsumm(1,:,1:4) = sum(Vinfo(1:2,:,1:4)); % LDVs
Vsumm(2,:,1:4) = sum(Vinfo(3:6,:,1:4)); % LDTs
Vsumm(3,:,1:4) = sum(Vinfo(7:8,:,1:4)); % MDTs
Vsumm(4,:,1:4) = sum(Vinfo(9:15,:,1:4)); % HDTs
Vsumm(5,:,1:4) = Vinfo(16,:,1:4); % PRTs (Port trucks)
VehCat={'LDV', 'LDT', 'MDT', 'HDT', 'PRT'}; % Name of aggregate vehicle category
for iv=1:5 % Loop on vehicle categories
    s2=VehCat{iv};
    xlswrite(RFile,header,s2,'a1'); % Header
    xlswrite(RFile,timper,s2,'a2'); % Time period
    Vinf2 = squeeze(Vsumm(iv,:,:));
    xlswrite(RFile,Vinf2,s2,'b2');  % Write # of vehicles, VMT and VHT
    Vsuma(iv,1:4) = sum(Vinf2(:,1:4)); % Sum for corresponding vehicle category
    xlswrite(RFile,Vsuma(iv,1:4),s2,'b99'); % Write results
    xlswrite(RFile,{'Totals'},s2,'a99'); % Caption
end
Vsuma(6,:)=sum(Vsuma(1:5,:));
s2='AllVehStats';
header={'VehicleClass','VehCount','VMT','VHT(h)','iVHT(h)'};
xlswrite(RFile,header,s2,'a1'); % Header
xlswrite(RFile,VehCat',s2,'a2');
xlswrite(RFile,Vsuma,s2,'b2');
xlswrite(RFile,{'Totals'},s2,'a7');

fprintf('\n* Done writing results to %s *\n',RFile);

toc

mydt = datestr(now);
fprintf('Current date and time: %s \n',mydt)

diary off