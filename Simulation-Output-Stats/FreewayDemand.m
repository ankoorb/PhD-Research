clear;clc;
tic

NBtot = zeros(96,6);
SBtot = zeros(96,6);

for i=1:96
    s1=int2str(i);
    s2=strcat('demands_',s1,'.txt');
Demand=dlmread(s2);
NB = find(Demand(:,1)==10463);
SB = find(Demand(:,1)==10444);
totNB = sum(Demand(NB,3:8));
totSB = sum(Demand(SB,3:8));
%NBtot(i,:) = totNB;
%SBtot(i,:) = totSB;

 NBtot(i,:) = sum(totNB);
 SBtot(i,:) = sum(totSB);

end

csvwrite('NB_Demand.csv',NBtot);
csvwrite('SB_Demand.csv',SBtot);

toc



% Sum=zeros((size(B,1)),2);
% for i = 1:size(B,1)
%     temp = find(Queued(:,2)==B(i));
%     queue = Queued(temp,:);
%     Sum(i,1)=B(i);
%     Sum(i,2)=sum(queue(:,3));
%     
% end