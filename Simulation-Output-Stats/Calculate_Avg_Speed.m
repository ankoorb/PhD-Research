% Calculate Average Speed based on Road Class 
% Author: Ankoor
% Date: Nov 26, 2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for b=1:17
    
    tic
    s6=int2str(b);
    s7=strcat('Vehicle Class-',s6,' files are being processed');
    h = waitbar(0, s7); % Waitbar
    steps=17;

    tic
    
for a=1:96 % Change as needed.
s1=int2str(b);
s2=int2str(a);
s3=strcat('trajectory.bin_out_veh_cate_',s1,'_',s2);


% Check if file 'trajectory.bin_out_veh_cate_#_i' exists or not
checkfile = exist(s3, 'file');

if checkfile == 0; % if the file does not exist, continute to the next i.
    continue
end


trajectory = load(s3);

load 'SegmentLinkType.csv'; % Load TM Segment, Link, Direction (Fwy = 1, Art = 0, Ramp = 3)

trajectory(:,4)=[]; % Remove Distance column (4th col)
trajectory(:,2)=[]; % Remove Time column (2nd col)
trajectory(:,1)=[]; % Remove VehID column (1st col)

segIDs=unique(trajectory(:,1)); % Find and stort unique Segment ID's

check_temp=zeros(size(trajectory,1),1);
traj_segment=trajectory(:,1);
trajectory(:,1)=[]; % remove segment col
traj_speed=trajectory(:,1);
trajectory(:,1)=[]; % remove speed col
clear trajectory;


% The for loop below stores Road Type in check_temp based on Trajectory
% Segment ID
for i=1:size(segIDs,1)

    ref=find(SegmentLinkType(:,1)==segIDs(i));
    linkID=SegmentLinkType(ref,3);
    check=traj_segment==segIDs(i);
    check=check.*linkID;
    
    check_temp=check_temp+check;
    
   clear check;
end
speed=[check_temp,traj_speed];

speed=sortrows(speed,1); % Sort generated unique road type in ascending order (Fwy = 1, Art = 0, Ramp = 3)
[new_speed_set,fref]=unique(speed(:,1),'first'); % Find index when unique road type appears first time
[new_speed_set,lref]=unique(speed(:,1),'last'); % Find index when unique road type appears last time

 
for i=1:size(new_speed_set,1)   
    temp_set=speed(fref(i):lref(i),:);
    Info(a,i)=[sum(temp_set(:,2))/size(temp_set,1)];      
end

waitbar(b/steps) % Waitbar

end

toc

close(h) % Close waitbar

s4=strcat('Speed_Road_Type_',s1,'.csv');
csvwrite(s4,Info);
end