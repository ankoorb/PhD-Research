%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Calculate second-by-second Vehicle Specific Power to use OpMode
% Modified/created by Ankoor, JDS, Kevin from Jinhoun and Gunwoo
% Last modified November 14, 2014 by JDS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [link_emi2,VehStat]=RunOpMode_MOVES_V6(s3c,s3n,VehClass,Op_rate,SegmentLink,modes,param,veh_type,Exclude)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Load trajectory
% trajectory: 1st column: VehID; 
%             2nd column: Time;
%             3rd column: Segment;
%             4th column: Distance;
%             5th column: Speed;
fid=fopen(s3c); % Open trajectory file for current period
trajectory=textscan(fid,'%d %d %d %f32 %f32','Delimiter',','); % Read data in cell array, then convert to array
trajectory=[double(cell2mat(trajectory(1))) double(cell2mat(trajectory(2))) double(cell2mat(trajectory(3))) double(cell2mat(trajectory(4))) double(cell2mat(trajectory(5)))];
fclose(fid);
trajectory=sortrows(trajectory, 1:2); % Sort on VehID and then time in ascending order

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Exclude selected vehicles

Lia=ismember(trajectory(:,1),Exclude); % find vehicles to exclude
trajectory(Lia,:)=[]; % Exclude vehicles
clear Lia
trajectory=sortrows(trajectory, 1:2); % Sort on VehID and then time in ascending order

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Report vehicle count during time interval, VHT and VMT

if size(trajectory(:,1),1)==0 % No more trajectories during time for vehicle class
    Veh_count=0;
    VMT=0;
    VHT=0;
    TCT=0;
    VehStat=[Veh_count VMT VHT TCT];
    clear trajectory
    link_emi2=[0 0 0 0 0 0 0 0 0 0];
else
    traj_vehIDs=trajectory(:,1); % Store vehicle IDs
    traj_segment=trajectory(:,3); % Store segment IDs
    traj_speed=trajectory(:,5); % Store speed

% Count vehicles
    [VehID, ivfir, ivx] = unique(trajectory(:,1)); % Find unique VehIDs
    Veh_count = size(VehID,1); % Vehicle count

    check_n = exist(s3n,'file'); % Check if there are trajectories for the next period
    if (check_n==2)
        fid=fopen(s3n); % Open trajectories of next period
        Veh_nxt=unique(cell2mat(textscan(fid,'%d %*d %*d %*f %*f','Delimiter',',')));
        fclose(fid);
        Lia=ismember(Veh_nxt,Exclude); % find vehicles to exclude
        Veh_nxt(Lia,:)=[]; % Exclude vehicles from next period
        Vdnf = ismember(VehID,Veh_nxt);
        Veh_fin = size(VehID,1)-sum(Vdnf); % Vehicles that finished during current period
        clear Lia Veh_nxt Vdnf
    else
        Veh_fin = size(VehID,1); % Vehicle that finished during current period
    end
    
    % Index for 
    if (Veh_count==1)
        ivlas = size(trajectory(:,1),1);
    else
        ivlas=[ivfir(2:end)-ones(Veh_count-1,1); size(trajectory(:,1),1)];
    end

    % Calculate distance (in mi) as the difference of cummulated distances + correction
    Veh_distance = trajectory(ivlas,4)-trajectory(ivfir,4)+trajectory(ivfir,5)/3600;
    VMT = sum(Veh_distance);

    % Calculate VHT 2 ways
    Veh_time=trajectory(ivlas,2)-trajectory(ivfir,2); % Unit is second
    VHT=(sum(Veh_time)+Veh_fin)/3600; % Convert seconds to hours
    TCT=(size(trajectory(:,1),1)+Veh_fin)/3600; % 2nd way of calculating VHT = # time steps
    
    % Return variables    
    VehStat=[Veh_fin VMT VHT TCT];
    
    clear trajectory ivfir ivx ivlas VMT VHT TCT check_n Veh_fin
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%4. Determine OpMode ID for each trajectory record

% Check which Vehicle Type needs to be used, and find the corresponding Rolling 
% Term-A, Rotating Term-B, Drag Term-C, Source Mass and Fixed Mass Factor       
    ref=find(veh_type(:,1)==VehClass);
    rTermA=param(veh_type(ref,3),2);
    rTermB=param(veh_type(ref,3),3);
    dTermC=param(veh_type(ref,3),4);
    sMass=param(veh_type(ref,3),5);
    fMass=param(veh_type(ref,3),6);

% Convert the speed unit to meter/second (m/s=0.447*mph)
    spd1=0.447*traj_speed;
    
    acc=(spd1(2:end,1)-spd1(1:end-1,1)).*(traj_vehIDs(2:end,1)==traj_vehIDs(1:end-1,1));%Calculate acceleration rates
    acc=[0;acc];%Set the first acceleration rate as zero  

%Calculate the vehicle specific power (VSP)
    VSP=(rTermA.*spd1+rTermB.*spd1.^2+dTermC.*spd1.^3+sMass.*spd1.*acc)./fMass;  

% Def of Braking in OpMode: case 1: Acc(t) <= -2 mph
% or case 2: Acc(t) < -1 mps & Acc(t-1) < -1 & Acc(t-2) <-1
    mps2mph=1/0.447; %convert meter/sec to mile/hour
    acc1=acc.*mps2mph;
    case1= acc1 <= -2; %Find records that do not satisfy case 1
    case2= (acc1(3:end)<-1).*(acc1(2:end-1)<-1).*(acc1(1:end-2)<-1).*(traj_vehIDs(3:end)==traj_vehIDs(2:end-1,1)).*(traj_vehIDs(3:end)==traj_vehIDs(1:end-2,1));
    case2=[0;0;case2];% The first two records do not satisfy case 2

% Determine OpMode ID for each trajectory record
    op0 = case1==1 | case2==1; % Braking mode
    clear traj_vehIDs spd1 acc acc1 case1 case2; %Clear useless data to release memory
    op1 =(traj_speed <1 & traj_speed>=-1); % idling mode
    op11=11*(VSP<0 & traj_speed <25 & traj_speed>=1);
    op12=12*(VSP>=0 & VSP<3 & traj_speed <25 & traj_speed>=1);
    op13=13*(VSP>=3 & VSP<6 & traj_speed <25 & traj_speed>=1);
    op14=14*(VSP>=6 & VSP<9 & traj_speed <25 & traj_speed>=1);
    op15=15*(VSP>=9 & VSP<12 & traj_speed <25 & traj_speed>=1);
    op16=16*(VSP>=12 & traj_speed <25 & traj_speed>=1);
    op21=21*(VSP<0 & traj_speed <50 & traj_speed>=25);
    op22=22*(VSP>=0 & VSP<3 & traj_speed <50 & traj_speed>=25);
    op23=23*(VSP>=3 & VSP<6 & traj_speed <50 & traj_speed>=25);
    op24=24*(VSP>=6 & VSP<9 & traj_speed <50 & traj_speed>=25);
    op25=25*(VSP>=9 & VSP<12 & traj_speed <50 & traj_speed>=25);
    op27=27*(VSP>=12 & VSP<18 & traj_speed <50 & traj_speed>=25);
    op28=28*(VSP>=18 & VSP<24 & traj_speed <50 & traj_speed>=25);
    op29=29*(VSP>=24 & VSP<30 & traj_speed <50 & traj_speed>=25);
    op30=30*(VSP>=30 & traj_speed <50 & traj_speed>=25);
    op33=33*(VSP<6 & traj_speed>=50);
    op35=35*(VSP>=6 & VSP<12 & traj_speed>=50);
    op37=37*(VSP>=12 & VSP<18 & traj_speed>=50);
    op38=38*(VSP>=18 & VSP<24 & traj_speed>=50);
    op39=39*(VSP>=24 & VSP<30 & traj_speed>=50);
    op40=40*(VSP>=30 & traj_speed>=50);
% Store opModeID's
    opMode=(1-op0).*((1-op1).*(op11+op12+op13+op14+op15+op16+op21+op22+op23+op24+op25+op27+op28+op29+op30+op33+op35+op37+op38+op39+op40)+op1);
%Clear useless data to release memory
    clear traj_speed VSP op0 op1 op11 op12 op13 op14 op15 op16 op21 op22 op23 op24 op25 op27 op28 op29 op30 op33 op35 op37 op38 op39 op40;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%5. Choose emission rates for each trajectory record

% op_Rate: 1st column: Opmode ID;
%          2nd column: pollutants (CO2_e), Units: grams/sec;
%          3rd column: CO2_a;
%          4th column: FC;
%          5th column: CO;
%          6th colimn: HC;
%          7th column: NOX;
%          8th column: PM10;
%          9th column: PM2.5        

    opRate=Op_rate(:,9*VehClass-8:9*VehClass); % Load emission rates for each vehicle class

% Create empty files to store emission data
    traj_emi0=zeros(size(opMode,1),size(opRate,2)-1);

% Choose emission rates for each trajectory record
    for i=1:size(modes,1)
        ref=find(opMode==modes(i));   
        % Air pollution type 1-8   
        traj_emi0(ref,:)=ones(size(ref,1),1)*opRate(i,2:end);
    end
    clear opMode;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%6. Store Link ID's in check_temp based on trajectory's Segment ID's

    traj_emi=[traj_segment,traj_emi0]; % Join segment ID's with emissions
    clear traj_segment traj_emi0;
    traj_emi=sortrows(traj_emi,1); % Sort emissions based on segment ID's
    link_temp=zeros(size(traj_emi,1),2);% Create an empty vector to store link ID's
    segIDs=unique(traj_emi(:,1)); % Find and store unique Segment ID's

% Create pointers for segment ID's
    if size(segIDs)==1 % If there is only one segment in the trajectory file
        check=[1;size(traj_emi,1)+1];
    else          % If there are multiple segments in the trajectory file
        check=find(traj_emi(2:end,1)~=traj_emi(1:end-1,1)); 
        check=check+ones(size(check,1),1);
        check=[1;check;size(traj_emi,1)+1]; % Add the first and last pointer
    end

    for i=1:size(segIDs,1)
        ref = find(SegmentLink(:,1)==segIDs(i),1,'first'); 
        linkID=SegmentLink(ref,2:3);% match link ID with segment ID
        if ~isempty(linkID)    % If the match is successful 
            link_temp(check(i):check(i+1)-1,:)=ones(check(i+1)-check(i),1)*linkID;% convert the vector of segmentID's to linkID's
        else
            fprintf('**Segment ID: %d not found\n',segIDs(i))
        end    
    end
    traj_emi=[link_temp,traj_emi(:,2:end)]; % Join link ID's with emissions
    clear link_temp;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%7. Sum up different type of pollutants for each link ID and stores them in link_emi

    traj_emi=sortrows(traj_emi,1); % Sort emissions based on link ID's
    linkIDs=unique(traj_emi(:,1:2),'rows'); % Find and store unique link ID's
    link_emi=zeros(size(linkIDs,1),size(opRate,2)-1); %Create an empty matrix to store sum of pollutants

% Create pointers for link ID's
    if size(linkIDs,1)==1 % If there is only one linkID pair in the trajectory file
        check=[1;size(traj_emi,1)+1];
    else                % If there are multiple linkID pairs in the trajectory file
        check=find(traj_emi(2:end,1)~=traj_emi(1:end-1,1)); 
        check=check+ones(size(check,1),1);
        check=[1;check;size(traj_emi,1)+1]; % Add the first and last pointer
    end
    for i=1:size(linkIDs,1)
        link_emi(i,:)=sum(traj_emi(check(i):check(i+1)-1,3:end),1);
    end
    clear traj_emi;
    link_emi=[linkIDs,link_emi]; % Join link ID's with sum of pollutants

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%8. Add link IDs that are not included in trajectory to link_emi2

    linkIDs2=unique(SegmentLink(:,2:3),'rows');
    link_emi2=zeros(size(linkIDs2,1),10);% Create a new matrix
    link_emi2(:,1:2)=linkIDs2; 
    for k=1:size(linkIDs,1)
        ref=find(linkIDs2(:,1)==link_emi(k,1),1,'first'); 
        if ~isempty(ref)
            link_emi2(ref,3:end)=link_emi(k,3:end);
        end 
    end
    link_emi2=[link_emi2,link_emi2(:,2)];
    link_emi2(:,2)=[]; % Move direction ID's from the 2nd column to the last column
end