
%add new-new OD flows into AM Ankoor OD matrices
zoneAllOD=xlsread('zoneAll_OD.xlsx');
p=2717;
for g=1:10 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newJ1_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    
    for j=1:p-1
        for i=1:q-1
            if Ankoor(i+1,1:2)==zoneAllOD(j+1,1:2)
               for t=3:8
                Ankoor(i+1,t)=Ankoor(i+1,t)*0.75;
               end
            break
            end
        end
    end
    s3=strcat('Ankoor_OD_newK1_',s1,'.csv');
    csvwrite(s3,Ankoor);

end

%add new-new OD flows into PM Ankoor OD matrices

for g=1:16 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newJ3_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    
    for j=1:p-1
        for i=1:q-1
            if Ankoor(i+1,1:2)==zoneAllOD(j+1,1:2)
               Ankoor(i+1,3:8)=Ankoor(i+1,3:8)*0.75;
            
            break
            end
        end
    end
    s3=strcat('Ankoor_OD_newK3_',s1,'.csv');
    csvwrite(s3,Ankoor);
end


%add new-new OD flows into Midday Ankoor OD matrices

for g=1:24 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newJ2_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    
    for j=1:p-1
        for i=1:q-1
            if Ankoor(i+1,1:2)==zoneAllOD(j+1,1:2)
               Ankoor(i+1,3:8)=Ankoor(i+1,3:8)*0.75;
            
            break
            end
        end
    end
    s3=strcat('Ankoor_OD_newK2_',s1,'.csv');
    csvwrite(s3,Ankoor);
end
