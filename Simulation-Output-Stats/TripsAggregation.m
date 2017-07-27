clear;clc;
tic

Demand=dlmread('demands_1.txt');
[r,c]=size(Demand);

SumDemand = zeros(r,96);
AggDemand = zeros(r,3);
AggDemand(:,1)= Demand(:,1);
AggDemand(:,2)= Demand(:,2);


for i=1:96
    s1=int2str(i);
    s2=strcat('demands_',s1,'.txt');
demand=dlmread(s2);
SumDemand(:,i)=demand(:,3)+demand(:,4)+demand(:,5)+demand(:,6)+demand(:,7)+demand(:,7);
end

Data=zeros(r,1);
for j=1:r
    data(j,1)=sum(SumDemand(j,[1:96]));
end
AggDemand(:,3)= data(:,1);

% s3=strcat('AggregateDemand.txt'); 
% dlmwrite(s3,AggDemand);

csvwrite('AggregateDemand.csv',AggDemand);

toc



% Sum=zeros((size(B,1)),2);
% for i = 1:size(B,1)
%     temp = find(Queued(:,2)==B(i));
%     queue = Queued(temp,:);
%     Sum(i,1)=B(i);
%     Sum(i,2)=sum(queue(:,3));
%     
% end