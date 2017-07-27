clc;clear;
Origin=[10075;10075;10075;10075;10075;10075;10074];
Destination=[10190;10189;10414;10299;10415;10420;10190];
[q,z]=size(Origin);
Origin_1=10300;
Origin_2=10301;

for g=1:96
    s1=int2str(g);
    s2=strcat('demands_',s1,'.txt');
    Ankoor=load(s2);
    for j=1:q
        i=find(Ankoor(:,1)==Origin(j,1) & Ankoor(:,2)==Destination(j,1));
        transfer_1=find(Ankoor(:,1)==Origin_1 & Ankoor(:,2)==Destination(j,1));
        transfer_2=find(Ankoor(:,1)==Origin_2 & Ankoor(:,2)==Destination(j,1));                                 
        Ankoor(transfer_1,3:8)=Ankoor(transfer_1,3:8)+Ankoor(i,3:8)*0.5;
        Ankoor(transfer_2,3:8)=Ankoor(transfer_2,3:8)+Ankoor(i,3:8)*0.5;
        Ankoor(i,3:8)=[1,1,0,0,0,0];
           
     end
    
    s3=strcat('demands_',s1,'.txt');
    dlmwrite(s3,Ankoor,'delimiter',',','newline','pc');
    
end