Time=[10,24,16];
r=1;
Ankoor2=zeros(10000,3);
for t=1:3
for g=1:Time(t)%%%Time(t) %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s0=int2str(t);
    s1=int2str(g);
    s2=strcat('Ankoor_OD_newD',s0,'_',s1,'.csv');
    s3=strcat('Ankoor_OD_newE',s0,'_',s1,'.csv');
    Ankoor=load(s2);
    Ankoor1=load(s3);
    
    [q,~]=size(Ankoor);
    
    for i=2:q
        if Ankoor(i,3:8)~=Ankoor1(i,3:8)
           Ankoor2(r,1:2)=Ankoor(i,1:2);
           Ankoor2(r,3)=(sum(Ankoor(i,3:8))-sum(Ankoor1(i,3:8)))/sum(Ankoor(i,3:8));
           r=r+1;
        end       
    end
end
end
s4=strcat('Reduction_check.csv');
csvwrite(s4,Ankoor2);




j=1;
Ankoor3=zeros(q,2);
for i=2:q
        for t=3:8
            if Ankoor2(i,t)~=0 
                if Ankoor2(i,t) <1
                   Ankoor3(j,1:2)=Ankoor2(i,1:2);
                j=j+1;
                end
            end
        end
end