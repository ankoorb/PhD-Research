% Aggregate Emission for each Vehicle class for each time period
% Author: Ankoor 
% Date: July 1, 2013.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
load 'SegmentLink.txt';
link = unique(SegmentLink(:,2));
LinkEmission=zeros(size(link,1),8);


for a=1:96 % Change as needed.
s1=int2str(a);
s2=strcat('HDT_',s1,'.csv');


% Check if file 'trajectory.bin_out_veh_cate_#_i' exists or not
checkfile = exist(s2, 'file');

if checkfile == 0; % if the file does not exist, continute to the next i.
    continue
end

LinkEmi = load(s2);

FwyEmi = LinkEmi(LinkEmi(:,10)==1,:);
ArtEmi = LinkEmi(LinkEmi(:,10)==0,:);

s3=strcat('HDT_Freeway_Emission_',s1,'.csv');
s4=strcat('HDT_Arterial_Emission_',s1,'.csv');

csvwrite(s3,FwyEmi);

csvwrite(s4,ArtEmi);
end



Freeway = zeros(96,8); % Change to 96
Arterial = zeros(96,8); % Change to 96

for b=1:96
    s5=int2str(b);
    s6=strcat('HDT_Freeway_Emission_',s5,'.csv');
    s7=strcat('HDT_Arterial_Emission_',s5,'.csv');
    
    % Check if file 'trajectory.bin_out_veh_cate_#_i' exists or not
checkfile = exist(s6, 'file');

if checkfile == 0; % if the file does not exist, continute to the next i.
    continue
end
       
Fwy = load(s6);
Art = load(s7);


Freeway(b,1) = sum(Fwy(:,2));
Freeway(b,2) = sum(Fwy(:,3));
Freeway(b,3) = sum(Fwy(:,4));
Freeway(b,4) = sum(Fwy(:,5));
Freeway(b,5) = sum(Fwy(:,6));
Freeway(b,6) = sum(Fwy(:,7));
Freeway(b,7) = sum(Fwy(:,8));
Freeway(b,8) = sum(Fwy(:,9));

Arterial(b,1) = sum(Art(:,2));
Arterial(b,2) = sum(Art(:,3));
Arterial(b,3) = sum(Art(:,4));
Arterial(b,4) = sum(Art(:,5));
Arterial(b,5) = sum(Art(:,6));
Arterial(b,6) = sum(Art(:,7));
Arterial(b,7) = sum(Art(:,8));
Arterial(b,8) = sum(Art(:,9));


end

s9=strcat('HDT_Freeway_Time_Period.csv');
s10=strcat('HDT_Arterial_Time_Period.csv');

csvwrite(s9,Freeway);

csvwrite(s10,Arterial);

toc




