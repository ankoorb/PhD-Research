% Aggregate Emission for Each Class
% Author: Ankoor 
% Date: July 1, 2013.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc;
VehClass = 18;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
load 'SegmentLink.txt';
link = unique(SegmentLink(:,2));
LinkEmission=zeros(size(link,1),8);

for a=1:96 % Change as needed.
s1=int2str(VehClass);
s2=int2str(a);
s3=strcat('LinkEmi_',s1,'_',s2,'.csv');

LinkEmi = load(s3);

LinkEmi2 = zeros(size(LinkEmi,1),10);

temp_LinkEmi2 = LinkEmi(:,2:9);

LinkEmission = LinkEmission + temp_LinkEmi2;



%copyfile('LinkEmi_*.csv','L:/....')

end
LinkEmission(:,9)=LinkEmi(:,1);
LinkEmission(:,10)=LinkEmi(:,10);
LinkEmission=LinkEmission(:,[9,1,2,3,4,5,6,7,8,10]); % Changing the order of columns

s4=strcat('PortTruck_24H_Emission.csv');

csvwrite(s4,LinkEmission);

fprintf('Finished aggregating emission for Port Truck \n')

toc



