c=[10,24,16];
type1=load('type1_localtraffic.txt');
[q,~]=size(type1);
for g=1:3 
    s1=int2str(g);
    
    for h=1:c(1,g) %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s2=int2str(h);
    s3=strcat('Ankoor_OD_newD',s1,'_',s2,'.csv');
    Ankoor=csvread(s3);
    [p,~]=size(Ankoor);
    for j=1:q-1
        for i=1:p-1
            if Ankoor(i+1,1)==type1(j+1,1);
                if Ankoor(i+1,2)==type1(j+1,2);
                   for t=1:6
                       Ankoor(i+1,t+2)=0;
                   end
                   break
                end
            end
        end
    end
    s4=strcat('Ankoor_OD_newE',s1,'_',s2,'.csv');
    csvwrite(s4,Ankoor);
end
end