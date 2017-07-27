%
% Estimate Emissions based on TransModeler trajectories using MOVES OpMode
% Authors: Ankoor and JDS
% Last revision: Aug 25, 2014
%
% Components: RunOpMode_MOVES_R4.m, 
% Op_lookup_matrix.mat
% Data: SegmentLink.txt, trajectory.bin_out_veh_cate_#_##
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clc;
diary('ElecI710-072114.txt')
tic
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Activate parallel computation
CPU=str2double(getenv('NUMBER_OF_PROCESSORS')); %Check the number of CPU cores
if matlabpool('size') < CPU
   matlabpool('open','local',CPU)% Activate parallel computation using local configuration
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Op_lookup_matrix.mat; %Load pullutant emission rates
Op_rate=[Op_rate1,Op_rate2,Op_rate3,Op_rate4,Op_rate5,Op_rate6,Op_rate7,Op_rate8,Op_rate9,Op_rate10,Op_rate11,Op_rate12,Op_rate13,Op_rate14,Op_rate14,Op_rate16,Op_rate17];
clear Op_rate1 Op_rate2 Op_rate3 Op_rate4 Op_rate5 Op_rate6 Op_rate7 Op_rate8 Op_rate9 Op_rate10 Op_rate11 Op_rate12 Op_rate13 Op_rate14 Op_rate16 Op_rate17

SegmentLink=load('SegmentLink.txt'); % Load TM Segment, Link, Direction (Fwy = 1, Art = 0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Main Part
for i=1:size(N,2) % Total N vehicle classes, and TP periods for each class
    VehClass=N(i);
    parfor time=1:TP
        fprintf('Processing trajectories using MOVES OpMode for vehicle class %d , time period %d\n',VehClass,time)
    
        % Input file to process       
        s1=int2str(VehClass);
        s2=int2str(time);
        s3=strcat('trajectory.bin_out_veh_cate_',s1,'_',s2); 
    
        checkfile = exist(s3, 'file'); % Check if the file exists  
        if checkfile == 2;          
           link_emi2=RunOpMode_MOVES_R4(s3,VehClass,Op_rate,SegmentLink,modes,param,veh_type); % Calculate emissions          

           % Save emissions in bin file
           s4=strcat('LinkEmi_',s1,'_',s2,'.csv'); 
           csvwrite(s4,link_emi2);
       
          fprintf('Done with vehicle class %d , time period %d\n',VehClass,time)          
        else fprintf('Vehicle class: %d, Time period: %d. Trajectory file not found\n',VehClass,time);
        end
    end
end
toc

