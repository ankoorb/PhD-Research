clear;clc;

tic

Ori = 10463; % NB Origin
Des=load('DestinationNB.txt'); % NB Destinations

for i=71:96
    s1=int2str(i);
    s2=strcat('demands_',s1,'.txt');
    Demand=dlmread(s2);

    for j=1:size(Des,1)
        pair(j,1) = find(Demand(:,1)==Ori & Demand(:,2)==Des(j,1));
    end
    
    for k=3:8
        Demand(pair(:,1),k)=Demand(pair(:,1),k)*0.1;  
    end

    clear pair
    
    s3=strcat('demands_',s1,'.txt'); %save as new demand files
    dlmwrite(s3,Demand);

end

toc








