% Date: June 12, 2013
% Modified by Ankoor, from Jinhoun, from Gunwoo
% Modified July 20, 2014 by JDS
% Calculate second-by-second Vehicle Specific Power to use OpMode



function [link_emi2]=RunOpMode_MOVES_R2(trajectory,moves_cate)

tic;

load 'SegmentLink.txt'; % Load TM Segment, Link, Direction (Fwy = 1, Art = 0), Calpuff Area ID (Later!)

trajectory(:,4)=[]; % Remove Distance column (4th col)

trajectory=sortrows(trajectory, [1,2]); % Sort VehID rows, then Time rows in ascending order

trajectory(:,2)=[]; % Remove Time column (2nd col)
IDs=unique(trajectory(:,1)); % Find and store unique vehicle ID's
segIDs=unique(trajectory(:,2)); % Find and stort unique Segment ID's

check_temp=zeros(size(trajectory,1),1);
traj_vehIDs=trajectory(:,1);
trajectory(:,1)=[]; % remove vehID col
traj_segment=trajectory(:,1);
trajectory(:,1)=[]; % remove segment col
traj_speed=trajectory(:,1);
%trajectory(:,1)=[]; % remove speed col

clear trajectory;

% Parameters: (1) Vehicle Type, (2) Rolling Term-A, (3) Rotating Term-B, (4) Drag Term-C,
% (5) Source Mass, (6) Fixed Mass Factor  
param=[21	0.156461	0.00200193	0.000492646	1.4788	1.4788;
31	0.22112	0.00283757	0.000698282	1.86686	1.86686;
32	0.235008	0.00303859	0.000747753	2.05979	2.05979;
51	1.41705	0	0.00357228	20.6845	17.1;
52	0.561933	0	0.00160302	7.64159	17.1;
53	0.498699	0	0.00147383	6.25047	17.1;
54	0.617371	0	0.00210545	6.73483	17.1;
43	0.746718	0	0.00217584	9.06989	17.1;
42	1.0944	0	0.00358702	16.556	17.1;
41	1.29515	0	0.00371491	19.5937	17.1;
61	1.96354	0	0.00403054	29.3275	17.1;
62	2.08126	0	0.00418844	31.4038	17.1;
11	0.0251	0	0.000315	0.285	0.285];

veh_type=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18;
 21 21 31 31 32 32 51 51 52 52 53 53 61 61 62 62 62 62
 1  1   2  2  3  3  4  4  5  5  6  6 11 11 12 12 12 12]';
ref=find(veh_type(:,1)==moves_cate);
% Check which OP rate needs to be used for 15

rTermA=param(veh_type(ref,3),2);
rTermB=param(veh_type(ref,3),3);
dTermC=param(veh_type(ref,3),4);
sMass=param(veh_type(ref,3),5);
fMass=param(veh_type(ref,3),6);

% Input units meter/sec or meter/sec2 from mile/hour (m/s=0.447*mph)
% ft/sec2*(0.3048)=meter/sec2
% setRef=find(trajectory(:,3)==3250 | trajectory(:,3)==2102);

opMode=[]; % Loop on vehicle IDs
for i=1:size(IDs,1)
 
    setRef= traj_vehIDs==IDs(i,1); 
    
    speed=0.447.*traj_speed(setRef,1);
    spd1=speed;
    spd2=zeros(length(spd1),1);
    spd2(2:length(spd2),1)=spd1(1:length(spd2)-1,1);
    acc=spd1-spd2; acc(1)=0;
 

    VSP=(rTermA.*speed+rTermB.*speed.^2+dTermC.*speed.^3+sMass.*speed.*acc)./fMass; 

    mps2mph=2.2369362920544;

    opModeID=zeros(length(speed),1);

    op0=BrakingMode(speed,acc); % Calling BrakingMode function to calcuate braking in OpMode

    op1 =(speed.*mps2mph <1 & speed.*mps2mph>=-1);
    op11=(VSP<0 & speed.*mps2mph <25 & speed.*mps2mph>=1);
    op12=(VSP>=0 & VSP<3 & speed.*mps2mph <25 & speed.*mps2mph>=1);
    op13=(VSP>=3 & VSP<6 & speed.*mps2mph <25 & speed.*mps2mph>=1);
    op14=(VSP>=6 & VSP<9 & speed.*mps2mph <25 & speed.*mps2mph>=1);
    op15=(VSP>=9 & VSP<12 & speed.*mps2mph <25 & speed.*mps2mph>=1);
    op16=(VSP>=12 & speed.*mps2mph <25 & speed.*mps2mph>=1);
    op21=(VSP<0 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op22=(VSP>=0 & VSP<3 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op23=(VSP>=3 & VSP<6 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op24=(VSP>=6 & VSP<9 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op25=(VSP>=9 & VSP<12 & speed.*mps2mph <50 & speed.*mps2mph>=25);
%op26=(VSP<12 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op27=(VSP>=12 & VSP<18 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op28=(VSP>=18 & VSP<24 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op29=(VSP>=24 & VSP<30 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op30=(VSP>=30 & speed.*mps2mph <50 & speed.*mps2mph>=25);
    op33=(VSP<6 & speed.*mps2mph>=50);
    op35=(VSP>=6 & VSP<12 & speed.*mps2mph>=50);
%op36=(VSP>=12 & speed.*mps2mph>=50);
    op37=(VSP>=12 & VSP<18 & speed.*mps2mph>=50);
    op38=(VSP>=18 & VSP<24 & speed.*mps2mph>=50);
    op39=(VSP>=24 & VSP<30 & speed.*mps2mph>=50);
    op40=(VSP>=30 & speed.*mps2mph>=50);
% breaking case Opmode = 0 because of speed and acceleration is zero.
opModeID=op11*11+op12*12+op13*13+op14*14+op15*15+op16*16+op21*21+op22*22+op23*23+op24*24+op25*25+op27*27+op28*28+op29*29+op30*30+op33*33+op35*35+op37*37+op38*38+op39*39+op40*40;


    opModeID=(1-op1).*opModeID+op1; % add idling mode
    opModeID=(1-op0).*opModeID; % add braking mode

    opMode=[opMode;opModeID];
    clear speed setref spd1 spd2 acc opModeID;

end

% Opmode ID (col1),pollutants (CO2_e(col2),
% CO2_a(col3),FC(col4),CO(col5),HC(col6),NOX(col7),PM10(col8),PM2.5(col9))
% Units: grams/sec

opRate=OpLookupTable_all(moves_cate);

%opRate=OpLookupTable_port(); 
%opRate=OpLookupTable_port_2012();

modes=[0;1;11;12;13;14;15;16;21;22;23;24;25;27;28;29;30;33;35;37;38;39;40;];
traj_emi=zeros(size(opMode,1),size(opRate,2)-1);
temp_emi=zeros(size(opMode,1),size(opRate,2)-1);

for i=1:size(modes,1)

    check=opMode==modes(i);
    
    for j=2:size(opRate,2)
        temp_emi(:,j-1)=check.*opRate(i,j);
    end
    
    traj_emi=traj_emi+temp_emi;
end
clear temp_emi opMode check;


% This loop stores LinkID in check_temp based on Trajectory Segment ID
%
  check_temp=zeros(size(traj_vehIDs,1),1);
for i=1:size(segIDs,1)
 
    ref=find(SegmentLink(:,1)==segIDs(i)); % is segID in SegmentLink?
    linkID=SegmentLink(ref,2);
    if linkID>0
 %     fprintf('Loop: %d; segID: %d; segment link: %d\n',i, segIDs(i), linkID)
      clear check;
      check=traj_segment==segIDs(i);
      check=check.*linkID;
      check_temp=check_temp+check;
    else
      fprintf('Loop: %d; segID: %d; segment link: NOT FOUND\n',i, segIDs(i))
    end    

end
clear check;


linkIDs=unique(check_temp(:,1)); % Find unique LinkID from check_temp
traj_emi=[check_temp,traj_emi]; % Join check_temp with traj_emi
traj_emi=sortrows(traj_emi,1); % Sort traj_emi rows based on link ID (col-1)
%link_emi=zeros(size(linkIDs,1),size(traj_emi,2));
temp_emi=zeros(1,8); 
iniID=traj_emi(1,1); 
j=1;

% The loop below sums up different type of pollutants for unique links
% and stores in link_emi
for i=1:size(traj_emi,1)
    if iniID==traj_emi(i,1) && size(traj_emi,1)~=i
        temp_emi=temp_emi+traj_emi(i,2:9);
    elseif size(traj_emi,1)==i
        temp_emi=temp_emi+traj_emi(i,2:9);
        link_emi(j,:)=[traj_emi(i,1),temp_emi];
    else
        link_emi(j,:)=[traj_emi(i-1,1),temp_emi];
        j=j+1; 
        temp_emi=traj_emi(i,2:9);iniID=traj_emi(i,1);   
    end 
end

for i=1:size(link_emi,1)
    ref1=find(SegmentLink(:,2)==link_emi(i,1));
    if length(ref1>0)
        link_emi(i,10)=SegmentLink(ref1(1),3);
    else
        fprintf('Index: %d; segment link: NOT FOUND\n',i)
    end    
end

linkIDs2=unique(SegmentLink(:,2));
link_emi2=zeros(length(linkIDs2),10);
link_emi2(:,1)=linkIDs2;

for k=1:size(link_emi,1)
    ref2=find(link_emi2(:,1)==link_emi(k,1)); 
    if length(ref2>0)
        link_emi2(ref2,2:10)=link_emi(k,2:10);
    else
        fprintf('Index: %d; link emi: NOT FOUND\n',i)
    end            
end

ref3=find(link_emi2(:,10)==0);

for j=1:size(ref3,1)
    ref4=find(SegmentLink(:,2)==link_emi2(ref3(j),1));
    link_emi2(ref3(j),10)=SegmentLink(ref4(1),3);
end


% Generate Aggregated Results
% header={'CombinedID','CO2_equi','CO2_at','FC','CO','HC','NOx','PM10','PM2.5 (unit:gram)'};
% xlswrite('HH01T01_OpResults.xlsx',header,'Sheet1','a1');
% xlswrite('HH01T01_OpResults.xlsx',newID_OpResult,'Sheet1','a2');

