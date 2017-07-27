
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
    zoneAllOD=load('ThreeAll_OD.csv');
for g=1:24 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newD2_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    [p,~]=size(zoneAllOD);
    for i=1:q-1
        for j=1:p-1
            if Ankoor(i+1,1)==zoneAllOD(j+1,1);
                if Ankoor(i+1,2)==zoneAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=zoneAllOD(j+1,t+2)*Temporal(g+1,t+1); %50 % reduction
                   end
                   break
                end
            end
        end
    end
    s3=strcat('Ankoor_OD_newE2_',s1,'.csv');
    csvwrite(s3,Ankoor);
end

for g=1:24 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newE2_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    [p,~]=size(zoneAllOD);
    for i=1:q-1
        for j=1:p-1
            if Ankoor(i+1,1)==zoneAllOD(j+1,1);
                if Ankoor(i+1,2)==zoneAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=Ankoor(i+1,t+2)*0.5;
                   end
                   break
                end
            end
        end
    end
    s3=strcat('Ankoor_OD_newF2_',s1,'.csv');% 75%reduction 
    csvwrite(s3,Ankoor);
end