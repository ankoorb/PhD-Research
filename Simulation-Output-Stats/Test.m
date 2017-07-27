% Calculate VMT based on Road Class and Vehicle Class
% Author: Ankoor
% Date: Nov 21, 2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;

%VehClass = 1; % Need to change this for calculating emissions for different classes.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



VMT=zeros(96,2);
VehCount=zeros(96,2);

for b=1:17
    
    tic
    s6=int2str(b);
    s7=strcat('Vehicle Class-',s6,' files are being processed');
    h = waitbar(0, s7); % Waitbar
    steps=17;
    
for a=1:96 % Change as needed (96).
s1=int2str(b);
s2=int2str(a);
s3=strcat('trajectory.bin_out_veh_cate_',s1,'_',s2); 


% Check if file 'trajectory.bin_out_veh_cate_#_i' exists or not
checkfile = exist(s3, 'file');

if checkfile == 0; % if the file does not exist, continute to the next i.
    continue
end


trajectory = load(s3);

load 'SegmentLink.txt'; % Load TM Segment, Link, Direction (Fwy = 1, Art = 0)

trajectory=sortrows(trajectory, [1,2]);

trajectory(:,5)=[]; % Remove Speed column (4th col)
trajectory(:,2)=[]; % Remove Time column (2nd col)

segIDs=unique(trajectory(:,2)); % Find and stort unique Segment ID's

check_temp=zeros(size(trajectory,1),1);
traj_vehID=trajectory(:,1);
trajectory(:,1)=[]; % vehID col
traj_segment=trajectory(:,1);
trajectory(:,1)=[]; % remove segment col
traj_dist=trajectory(:,1);
trajectory(:,1)=[]; % remove speed col
clear trajectory;


% The for loop below stores Road Type in check_temp based on Trajectory
% Segment ID
for i=1:size(segIDs,1)

    ref=find(SegmentLink(:,1)==segIDs(i));
    linkID=SegmentLink(ref,3);
    check=traj_segment==segIDs(i);
    check=check.*linkID;
    
    check_temp=check_temp+check;
    
   clear check;
end
distance=[traj_vehID,traj_dist,check_temp];

distance=sortrows(distance,[1,2]); % Sort generated unique VehID and cum. dist in ascending order
[new_set,fref]=unique(distance(:,1),'first'); % Find index when unique road type appears first time
[new_set,lref]=unique(distance(:,1),'last'); % Find index when unique road type appears last time

for i=1:size(new_set,1)
temp=distance(fref(i):lref(i),:);

%----------Find Distance Traveled based on Cumulative Distance-------------
    for j=1:size(temp,1)-1
        if j==[];
        temp(j,4)=0;
        else
        temp(j,4)=temp(j+1,2)-temp(j,2);
        end
    end
%--------------------------------------------------------------------------

temp=sortrows(temp,3); % Sort generated unique road type in ascending order (Fwy = 1, Art = 0, Ramp = 2)
[temp_set,frefT]=unique(temp(:,3),'first'); % Find index when unique road type appears first time
[temp_set,lrefT]=unique(temp(:,3),'last'); % Find index when unique road type appears last time


temp_art_VMT=[0];
temp_fwy_VMT=[0];
%--------------First "IF"--------------------------------------------------
if size(temp_set,1)==1 && temp_set(1,1)==0
    
    temp_art=temp(frefT(1):lrefT(1),:);
    if size(temp_art,2)==3;
        temp_art_VMT=0;
        %temp_VMT(i,1)=temp_art_VMT;
    else
        temp_art_VMT=sum(temp_art(:,4));
        %temp_VMT(i,1)=temp_art_VMT;
    end
      
elseif size(temp_set,1)==1 && temp_set(1,1)==1
    temp_fwy=temp(frefT(1):lrefT(1),:);
    if size(temp_fwy,2)==3;
        temp_fwy_VMT=0;
        %temp_VMT(i,2)=temp_fwy_VMT;
    else
        temp_fwy_VMT=sum(temp_fwy(:,4));
        %temp_VMT(i,2)=temp_fwy_VMT;
    end
else
    temp_fwy=temp(frefT(2):lrefT(2),:);
    if size(temp_fwy,2)==3;
        temp_fwy_VMT=0;
        %temp_VMT(i,2)=temp_fwy_VMT;
    else
        temp_fwy_VMT=sum(temp_fwy(:,4));
        %temp_VMT(i,2)=temp_fwy_VMT;
    end
end

%-------------Second "IF"--------------------------------------------------
if size(temp_set,1)==2 && temp_set(1,1)==0
    temp_art=temp(frefT(1):lrefT(1),:);
    if size(temp_art,2)==3;
        temp_art_VMT=0;
        %temp_VMT(i,1)=temp_art_VMT;
    else
        temp_art_VMT=sum(temp_art(:,4));
        %temp_VMT(i,1)=temp_art_VMT;
    end
        
elseif size(temp_set,1)==2 && temp_set(2,1)==1
    temp_fwy=temp(frefT(1):lrefT(1),:);
    if size(temp_fwy,2)==3;
        temp_fwy_VMT=0;
        %temp_VMT(i,2)=temp_fwy_VMT;
    else
        temp_fwy_VMT=sum(temp_fwy(:,4));
        %temp_VMT(i,2)=temp_fwy_VMT;
    end
end
%--------------------------------------------------------------------------

temp_VMT(i,1)=temp_art_VMT;
temp_VMT(i,2)=temp_fwy_VMT;
end

VMT(a,1)=sum(temp_VMT(:,1));
VMT(a,2)=sum(temp_VMT(:,2));

clear temp_VMT


%%%%%-------------------Veh Count Calculations-----------------------------

count=[check_temp,traj_vehID];
count=sortrows(count,1); % Sort generated unique VehID and cum. dist in ascending order
[count_set,frefC]=unique(count(:,1),'first'); % Find index when unique road type appears first time
[count_set,lrefC]=unique(count(:,1),'last'); % Find index when unique road type appears last time


% Vehicle Count Calculation Based on Road Type and Vehicle Class Starts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(count_set,1)==1 && count_set(1,1)==0
    arterial=count(frefC(1):lrefC(1),:);
    [new_art_set,frefA]=unique(arterial(:,2),'first'); 
    VehCount(a,1)=size(new_art_set,1);
    
elseif size(count_set,1)==1 && count_set(1,1)==1
    freeway=count(frefC(1):lrefC(1),:);
    [new_fwy_set,frefF]=unique(freeway(:,2),'first'); 
    VehCount(a,2)=size(new_fwy_set,1);
else
    freeway=count(frefC(2):lrefC(2),:);
    [new_fwy_set,frefF]=unique(freeway(:,2),'first'); 
    VehCount(a,2)=size(new_fwy_set,1);
end


if size(count_set,1)==2 && count_set(1,1)==0
    arterial=count(frefC(1):lrefC(1),:);
    [new_art_set,frefA]=unique(arterial(:,2),'first'); 
    VehCount(a,1)=size(new_art_set,1);
    
elseif size(count_set,1)==2 && count_set(2,1)==1
    freeway=count(frefC(1):lrefC(1),:);
    [new_fwy_set,frefF]=unique(freeway(:,2),'first'); %
    VehCount(a,2)=size(new_fwy_set,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vehicle Count Calculation Based on Road Type and Vehicle Class Ends


waitbar(b/steps) % Waitbar

end

close(h) % Close waitbar



s4=strcat('VMT_Class_',s1,'.csv');
csvwrite(s4,VMT);

s5=strcat('Veh_Count_Class_',s1,'.csv');
csvwrite(s5,VehCount);

end