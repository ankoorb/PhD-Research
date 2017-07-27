%
% Estimate Emissions based on TransModeler trajectories using MOVES OpMode
% Authors: Ankoor and JDS
% Last revision: July 20, 2014
%
% Components: RunOpMode_MOVES_R2.m, BrakingMode.m, OpLookupTable_all.m, 
% Op_lookup_matrix.mat
% Data: SegmentLink.txt, trajectory.bin_out_veh_cate_#_##
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; 
clc;
diary('ElecI710-072114')

VehClass = 18; % Change for another vehicle class
moves_cate = VehClass; % Used by RunOpMode Code
fprintf('*** Processing trajectories to find emissions using MOVES OpMode for vehicle class %d\n',VehClass)
fprintf('\n')
tic

for a=1:96 % Change as needed.

    fprintf('* Starting time period %d\n',a)
    
    % Input file to process
    %
    s1=int2str(VehClass);
    s2=int2str(a);
    s3=strcat('trajectory.bin_out_veh_cate_',s1,'_',s2); 
    checkfile = exist(s3, 'file');
    if checkfile == 2; 
      trajectory = load(s3); % Upload input file

      [link_emi2]=RunOpMode_MOVES_R2(trajectory,moves_cate); % Calculate emissions

      s4=strcat('LinkEmi_',s1,'_',s2,'.csv'); 
      csvwrite(s4,link_emi2); % Save emissions in csv file

      fprintf('Done with time period %d\n',a)
      toc
      fprintf('\n')
      
    end
 
end

fprintf('Finished Emission Estimation for VehClass %d\n',VehClass)
toc