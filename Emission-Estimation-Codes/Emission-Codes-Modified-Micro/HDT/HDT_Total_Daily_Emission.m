% Aggregate (24H) Emission for LDT (3, 4, 5, 6)
% Author: Ankoor 
% Date: July 1, 2013.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
load 'SegmentLink.txt';
link = unique(SegmentLink(:,2));
HDT=zeros(size(link,1),8);

for i=9:16 % Change as needed.
    for j=1:96 
        s1=int2str(i);
        s2=int2str(j);
        s3=strcat('LinkEmi_',s1,'_',s2,'.csv');

        % Check if file 'trajectory.bin_out_veh_cate_#_i' exists or not
        checkfile = exist(s3, 'file');

            if checkfile == 0; % if the file does not exist, continute to the next i.
                continue
            end
        
        LinkEmi = load(s3);

%         LinkEmi2 = zeros(size(LinkEmi,1),10);

        temp_LinkEmi2 = LinkEmi(:,2:9);

        HDT = HDT + temp_LinkEmi2;
        
    end
end
HDT(:,9)=LinkEmi(:,1);
HDT(:,10)=LinkEmi(:,10);
HDT=HDT(:,[9,1,2,3,4,5,6,7,8,10]); % Changing the order of columns

s4=strcat('HDT_24H_Emission.csv');

csvwrite(s4,HDT);

fprintf('Finished aggregating emission for HDT \n')

toc


