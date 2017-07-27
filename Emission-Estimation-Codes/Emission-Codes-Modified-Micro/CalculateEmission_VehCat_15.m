% Estimate Emissions 
% Author: Ankoor
% Date: June 27, 2013

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;

VehClass = 15; % Need to change this for calculating emissions for different classes.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
moves_cate = VehClass; % Used by RunOpMode Code

tic

for a=1:96 % Change as needed.
s1=int2str(VehClass);
s2=int2str(a);
s3=strcat('trajectory.bin_out_veh_cate_',s1,'_',s2);


% Check if file 'trajectory.bin_out_veh_cate_#_i' exists or not
checkfile = exist(s3, 'file');

if checkfile == 0; % if the file does not exist, continute to the next i.
    continue
end


trajectory = load(s3);


[link_emi2]=RunOpMode_MOVES_Revised_VehCat_15(trajectory,moves_cate);



s4=strcat('LinkEmi_',s1,'_',s2,'.csv');
csvwrite(s4,link_emi2);

%copyfile('LinkEmi_*.csv','L:/....')

    if a==48;
        fprintf('currently 50 percent completed \n')
    end

end


fprintf('Finished Emission Estimation for VehClass \n')
toc