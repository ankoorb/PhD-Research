zoneAllOD=xlsread('zoneAll_OD.xlsx');
ramp=14090;
[p,~]=size(zoneAllOD);
A=0;
Time=[10,24,16];
for t=1:3
for g=1:Time(t) %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newE',t','_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    
    for j=1:ramp
        for i=1:q-1
            if Ankoor(i+1,1)==zoneAllOD(1+j,1);
                if Ankoor(i+1,2)==zoneAllOD(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=Ankoor(i+1,t+2)*0.7;
                   end
                   break
                end
            end
        end
    end
   s3=strcat('Ankoor_OD_newF',t','_',s1,'.csv');
   xlswrite(s3,Ankoor);
end
end
