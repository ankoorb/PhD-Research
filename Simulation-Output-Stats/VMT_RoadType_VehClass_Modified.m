% Calculate Average Speed based on Road Class 
% Author: Ankoor
% Date: Nov 17, 2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


VMT=zeros(96,2);
VehCount=zeros(96,2);
for b=2:17
    
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
distance=[check_temp,traj_vehID,traj_dist];

distance=sortrows(distance,1); % Sort generated unique road type in ascending order (Fwy = 1, Art = 0, Ramp = 2)
[new_set,fref]=unique(distance(:,1),'first'); % Find index when unique road type appears first time
[new_set,lref]=unique(distance(:,1),'last'); % Find index when unique road type appears last time



if size(new_set,1)==1 && new_set(1,1)==0
    arterial=distance(fref(1):lref(1),:);
    arterial(:,1)=[];
    arterial=sortrows(arterial, [1,2]);
    [new_art_set,frefA]=unique(arterial(:,1),'first'); % Find index when unique road type appears first time
    [new_art_set,lrefA]=unique(arterial(:,1),'last'); % Find index when unique road type appears last time
    
    for i=1:size(new_art_set,1)   
        temp_art=arterial(frefA(i):lrefA(i),:);
        InfoA(i,1)=[temp_art(size(temp_art,1),2)-temp_art(1,2)];      
    end
    VMT(a,1)=sum(InfoA);
    VehCount(a,1)=size(new_art_set,1);
    
elseif size(new_set,1)==1 && new_set(1,1)==1
    freeway=distance(fref(1):lref(1),:);
    freeway(:,1)=[];
    freeway=sortrows(freeway, [1,2]);
    [new_fwy_set,frefF]=unique(freeway(:,1),'first'); % Find index when unique vehID appears first time
    [new_fwy_set,lrefF]=unique(freeway(:,1),'last'); % Find index when unique vehID appears last time

    for i=1:size(new_fwy_set,1)   
        temp_fwy=freeway(frefF(i):lrefF(i),:);
        InfoF(i,1)=[temp_fwy(size(temp_fwy,1),2)-temp_fwy(1,2)]; 
    end
        VMT(a,2)=sum(InfoF);
        VehCount(a,2)=size(new_fwy_set,1);
else
    freeway=distance(fref(2):lref(2),:);
    freeway(:,1)=[];
    freeway=sortrows(freeway, [1,2]);
    [new_fwy_set,frefF]=unique(freeway(:,1),'first'); % Find index when unique vehID appears first time
    [new_fwy_set,lrefF]=unique(freeway(:,1),'last'); % Find index when unique vehID appears last time

    for i=1:size(new_fwy_set,1)   
        temp_fwy=freeway(frefF(i):lrefF(i),:);
        InfoF(i,1)=[temp_fwy(size(temp_fwy,1),2)-temp_fwy(1,2)]; 
    end
        VMT(a,2)=sum(InfoF);
        VehCount(a,2)=size(new_fwy_set,1);
end


if size(new_set,1)==2 && new_set(1,1)==0
    arterial=distance(fref(1):lref(1),:);
    arterial(:,1)=[];
    arterial=sortrows(arterial, [1,2]);
    [new_art_set,frefA]=unique(arterial(:,1),'first'); % Find index when unique vehID appears first time
    [new_art_set,lrefA]=unique(arterial(:,1),'last'); % Find index when unique vehID appears last time
    
    for i=1:size(new_art_set,1)   
        temp_art=arterial(frefA(i):lrefA(i),:);
        InfoA(i,1)=[temp_art(size(temp_art,1),2)-temp_art(1,2)];      
    end
    VMT(a,1)=sum(InfoA);
    VehCount(a,1)=size(new_art_set,1);
    
elseif size(new_set,1)==2 && new_set(2,1)==1
    freeway=distance(fref(1):lref(1),:);
    freeway(:,1)=[];
    freeway=sortrows(freeway, [1,2]);
    [new_fwy_set,frefF]=unique(freeway(:,1),'first'); % Find index when unique vehID first time
    [new_fwy_set,lrefF]=unique(freeway(:,1),'last'); % Find index when unique vehID appears last time

    for i=1:size(new_fwy_set,1)   
        temp_fwy=freeway(frefF(i):lrefF(i),:);
        InfoF(i,1)=[temp_fwy(size(temp_fwy,1),2)-temp_fwy(1,2)]; 
    end
        VMT(a,2)=sum(InfoF);
        VehCount(a,2)=size(new_fwy_set,1);

end


waitbar(b/steps) % Waitbar

end

close(h) % Close waitbar

s4=strcat('VMT_Class_',s1,'.csv');
csvwrite(s4,VMT);

s5=strcat('Veh_Count_Class_',s1,'.csv');
csvwrite(s5,VehCount);

toc
end


%     s6=int2str(b);
%     s7=strcat('Vehicle Class',s6,' is being processed');
%     h = waitbar(b, s7); % Waitbar
%     for b = 1:n
%         xxxxx
%         waitbar(b/b)
%     end
%     close(h)



