random=xlsread('C:\Users\kevin\Desktop\OD_Random_Sampling.xlsx');
Time=[10,24,16];

[p,~]=size(random);
random(:,3:4)=zeros(p,2);
for t=3:3
for g=1:Time(t) %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    s0=int2str(t);
    s2=strcat('E:\UCTC Project\OD extension\7.Trucks redistribution\Ankoor_OD_newK',s0,'_',s1,'.csv');
    Ankoor=load(s2);
    [q,~]=size(Ankoor);
    
    for j=1:p
        for i=1:q-1
            if Ankoor(i+1,1:2)==random(j,1:2);
               random(j,3)=random(j,3)+Ankoor(i+1,3)+Ankoor(i+1,4)+Ankoor(i+1,5)+Ankoor(i+1,6)+Ankoor(i+1,7)+Ankoor(i+1,8);
               break
            end
        end
    end
    
   end
end

random=csvread('E:\UCTC Project\OD extension\5.localtraffic_removing\random.csv');
for g=61:76 %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s1=int2str(g);
    
    s2=strcat('C:\Users\kevin\Desktop\Iteration-8PM\demands_',s1,'.txt');
    Ankoor=dlmread(s2);
    [q,~]=size(Ankoor);
    
    for j=1:p
        for i=1:q
            if Ankoor(i,1:2)==random(j,1:2);
               random(j,5)=random(j,5)+Ankoor(i,3)+Ankoor(i,4)+Ankoor(i,5)+Ankoor(i,6)+Ankoor(i,7)+Ankoor(i,8);
               break
            end
        end
    end
    
   end
