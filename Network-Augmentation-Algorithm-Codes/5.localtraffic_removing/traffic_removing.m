c=[10,24,16];
type1=dlmread('type1_localtraffic.txt');
[q,~]=size(type1);
rate=0;
for g=1:3 
    s1=int2str(g);
    
    for h=1:c(1,g) %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s2=int2str(h);
    s3=strcat('Ankoor_OD_newK',s1,'_',s2,'.csv');
    Ankoor=csvread(s3);
    [p,~]=size(Ankoor);
    for j=1:q-1
        for i=1:p-1
            if Ankoor(i+1,1:2)==type1(j+1,1:2);
                
               Ankoor(i+1,3:8)=Ankoor(i+1,3:8)*rate;
               break
            end
            
        end
    end
    s4=strcat('Ankoor_OD_newK',s1,'_',s2,'.csv');
    csvwrite(s4,Ankoor);
    end
end

type2=dlmread('type4_localtrafficreducing.txt');
[q,~]=size(type2);
rate=0.1;
for g=1:3 
    s1=int2str(g);
    
    for h=1:c(1,g) %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s2=int2str(h);
    s3=strcat('Ankoor_OD_newK',s1,'_',s2,'.csv');
    Ankoor=csvread(s3);
    [p,~]=size(Ankoor);
    for j=1:q-1
        for i=1:p-1
            if Ankoor(i+1,1:2)==type2(j+1,1:2);
                
               Ankoor(i+1,3:8)=Ankoor(i+1,3:8)*rate;
               break
            end
            
        end
    end
    s4=strcat('Ankoor_OD_newK',s1,'_',s2,'.csv');
    csvwrite(s4,Ankoor);
    end
end


type3=dlmread('type5_localtrafficreducing.txt');
[q,~]=size(type3);
rate=0.2;
for g=1:3 
    s1=int2str(g);
    
    for h=1:c(1,g) %%%%%%%%%%%%%%%10 for Am, 16 for Pm, 24 for midday
    s2=int2str(h);
    s3=strcat('Ankoor_OD_newK',s1,'_',s2,'.csv');
    Ankoor=csvread(s3);
    [p,~]=size(Ankoor);
    for j=1:q-1
        for i=1:p-1
            if Ankoor(i+1,1:2)==type3(j+1,1:2);
                
               Ankoor(i+1,3:8)=Ankoor(i+1,3:8)*rate;
               break
            end
            
        end
    end
    s4=strcat('Ankoor_OD_newK',s1,'_',s2,'.csv');
    csvwrite(s4,Ankoor);
    end
end