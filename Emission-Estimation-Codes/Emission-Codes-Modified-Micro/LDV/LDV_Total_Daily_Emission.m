% Aggregate (24H) Emission for LDT (3, 4, 5, 6)
% Author: Ankoor 
% Date: July 1, 2013.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
load 'SegmentLink.txt';
link = unique(SegmentLink(:,2));
LDV=zeros(size(link,1),8);

for i=1:2 % Change as needed.
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

        LDV = LDV + temp_LinkEmi2;
        
    end
end
LDV(:,9)=LinkEmi(:,1);
LDV(:,10)=LinkEmi(:,10);
LDV=LDV(:,[9,1,2,3,4,5,6,7,8,10]); % Changing the order of columns

s4=strcat('LDV_24H_Emission.csv');

csvwrite(s4,LDV);

fprintf('Finished aggregating emission for LDV \n')

toc


