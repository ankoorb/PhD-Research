clear;clc;

tic

Ori = 10463; % NB Origin
Des=load('DestinationNB.txt'); % NB Destinations
Demand_NB = zeros(size(Des,1),97);
Demand_NB(:,1)=Des;

for i=1:96
    s1=int2str(i);
    s2=strcat('demands_',s1,'.txt');
    Demand=dlmread(s2);

for j = 1:size(Des,1)
Pair(j,1) = find(Demand(:,1)==Ori & Demand(:,2)==Des(j,1));
end

temp_demand = Demand(Pair,:);
sum_demand = temp_demand(:,3)+temp_demand(:,4)+temp_demand(:,5)+temp_demand(:,6)+temp_demand(:,7)+temp_demand(:,8);

Demand_NB(:,i+1)=sum_demand;
end

csvwrite('Demand_NB.csv',Demand_NB);

toc









