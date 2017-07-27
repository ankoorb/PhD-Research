%Build new-new OD pairs for each zone
for g=1:5
    s1=int2str(g);
    s2=strcat('zone',s1,'.txt');
    zone=load(s2);
    [a,~]=size(zone);
    b=1;
    zone1=zeros((a-1)*(a-2),2);
    for i=1:a-1
        for j=1:a-1
            if i~=j
            zone1(b,1)=zone(i+1,1);
            zone1(b,2)=zone(j+1,1);
            b=b+1;
            end
        end
    end
    s3=strcat('zone_OD',s1,'.csv');
    csvwrite(s3,zone1);
end
%%%%%%%%%%%%sum up zone1 to zone5
zone1=load('zone_OD1.csv');
zone2=load('zone_OD2.csv');
zone3=load('zone_OD3.csv');
zone4=load('zone_OD4.csv');
zone5=load('zone_OD5.csv');
zone6=xlsread('zone_OD6.xlsx');     %from 3 ramps to others, creat manually
zoneAll=[0,0;zone1;zone2;zone3;zone4;zone5;zone6];
%create zoneAll.csv
Ankoor=xlsread('TM_Ankoor_Sum.xlsx'); 
[q,~]=size(Ankoor);
[p,~]=size(zoneAll);
for i=1:p-1
    for j=1:q-1
        if Ankoor(j+1,1)==zoneAll(i+1,1)
            if Ankoor(j+1,2)==zoneAll(i+1,2)
               zoneAll(i+1,3:8)=Ankoor(j+1,3:8);
               break
            end
        end
    end
end
  

%%%%%%%%%%%%delete zero OD pairs%%%%%%%%%%

for i=p-1:-1:1
    if zoneAll(i+1,3:8)==[0,0,0,0,0,0]
       zoneAll(i+1,:)=[];
    end
end
xlswrite('zoneAll_OD.xlsx',zoneAll);

%add new-new OD flows into AM Ankoor OD matrices
zoneAllOD=xlsread('zoneAll_OD.xlsx');
Temporal=load('Temporal1.txt');   %%%%%%%%%%%% 1 for AM, 2 for midday, 3 for PM
for g=1:10 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newC1_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    [p,~]=size(zoneAllOD);
    for i=1:q-1
        for j=1:p-1
            if Ankoor(i+1,1)==zoneAllOD(j+1,1);
                if Ankoor(i+1,2)==zoneAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=zoneAllOD(j+1,t+2)*Temporal(g+1,t+1);
                   end
                   break
                end
            end
        end
    end
    s3=strcat('Ankoor_OD_newD1_',s1,'.csv');
    csvwrite(s3,Ankoor);
end


%add new-new OD flows into PM Ankoor OD matrices
zoneAllOD=load('zoneAll_OD.csv');
Temporal=load('Temporal3.txt');   %%%%%%%%%%%% 1 for AM, 2 for midday, 3 for PM
for g=1:16 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newC3_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    [p,~]=size(zoneAllOD);
    for i=1:q-1
        for j=1:p-1
            if Ankoor(i+1,1)==zoneAllOD(j+1,1);
                if Ankoor(i+1,2)==zoneAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=zoneAllOD(j+1,t+2)*Temporal(g+1,t+1);
                   end
                   break
                end
            end
        end
    end
    s3=strcat('Ankoor_OD_newD3_',s1,'.csv');
    csvwrite(s3,Ankoor);
end


%add new-new OD flows into Midday Ankoor OD matrices
zoneAllOD=load('zoneAll_OD.csv');
Temporal=load('Temporal2.txt');   %%%%%%%%%%%% 1 for AM, 2 for midday, 3 for PM
for g=1:24 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newC2_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    [p,~]=size(zoneAllOD);
    for i=1:q-1
        for j=1:p-1
            if Ankoor(i+1,1)==zoneAllOD(j+1,1);
                if Ankoor(i+1,2)==zoneAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=zoneAllOD(j+1,t+2)*Temporal(g+1,t+1);
                   end
                   break
                end
            end
        end
    end
    s3=strcat('Ankoor_OD_newD2_',s1,'.csv');
    csvwrite(s3,Ankoor);
end
    



%add 3-all OD flows into AM Ankoor OD matrices
%%%%%Trips in ThreeAll_OD.csv are already reduced by half%%%%%%%%%%%
ThreeAllOD=load('ThreeAll_OD.csv');
Temporal=load('Temporal1.txt');   %%%%%%%%%%%% 1 for AM, 2 for midday, 3 for PM
for g=1:10 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newD1_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    [p,~]=size(ThreeAllOD);
    for i=1:q-1
        for j=1:p-1
            if Ankoor(i+1,1)==ThreeAllOD(j+1,1);
                if Ankoor(i+1,2)==ThreeAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=ThreeAllOD(j+1,t+2)*Temporal(g+1,t+1);
                   end
                   break
                end
            end
        end
    end
    s3=strcat('Ankoor_OD_newE1_',s1,'.csv');
    csvwrite(s3,Ankoor);
end


%add 3-all OD flows into PM Ankoor OD matrices
%%%%%Trips in ThreeAll_OD.csv are already reduced by half%%%%%%%%%%%
ThreeAllOD=load('ThreeAll_OD.csv');
Temporal=load('Temporal3.txt');   %%%%%%%%%%%% 1 for AM, 2 for midday, 3 for PM
for g=1:16 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newD3_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    [p,~]=size(ThreeAllOD);
    for i=1:q-1
        for j=1:p-1
            if Ankoor(i+1,1)==ThreeAllOD(j+1,1);
                if Ankoor(i+1,2)==ThreeAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=ThreeAllOD(j+1,t+2)*Temporal(g+1,t+1);
                   end
                   break
                end
            end
        end
    end
    s3=strcat('Ankoor_OD_newE3_',s1,'.csv');
    csvwrite(s3,Ankoor);
end


%add 3-all OD flows into Midday Ankoor OD matrices
%%%%%Trips in ThreeAll_OD.csv are already reduced by half%%%%%%%%%%%
ThreeAllOD=load('ThreeAll_OD.csv');
Temporal=load('Temporal2.txt');   %%%%%%%%%%%% 1 for AM, 2 for midday, 3 for PM
for g=1:24 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newD2_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    [p,~]=size(ThreeAllOD);
    for i=1:q-1
        for j=1:p-1
            if Ankoor(i+1,1)==ThreeAllOD(j+1,1);
                if Ankoor(i+1,2)==ThreeAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=ThreeAllOD(j+1,t+2)*Temporal(g+1,t+1);
                   end
                   break
                end
            end
        end
    end
    s3=strcat('Ankoor_OD_newE2_',s1,'.csv');
    csvwrite(s3,Ankoor);
end
