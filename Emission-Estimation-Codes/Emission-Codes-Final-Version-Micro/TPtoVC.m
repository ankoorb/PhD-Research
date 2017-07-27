%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Split time period files by vehicle categories
%
% Author: JDS, December 8, 2014
%
% Input:  VehicleCategoryPost.txt, trajx.bin_out_time_#
% Output: trajectory.bin_out_veh_cate_#_#
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

mydt = datestr(now);
fprintf('Current date and time: %s \n',mydt)
fprintf('* Split trajectory time files by vehicle category *\n')

tic

N=[1:14,16:17]; % List of vehicle classes
TP=96; % Number of time periods

VehCla=dlmread('VehicleCategoryPost.txt'); % Load info about vehicle categories
cvc=cell(17,1);
for iv=1:17
    myv=ismember(VehCla(:,2),iv);
    cvc{iv,1}=VehCla(myv,1);
end

for itpe=1:TP % Loop on all time periods
    stp=int2str(itpe);
    % Load file with trajectories for all vehicle classes for time period
    sfn=['trajx.bin_out_time_',stp];
    fi1=fopen(sfn);
    traj=textscan(fi1,'%d %d %d %f32 %f32 %f32','Delimiter',',');
    fclose(fi1);
    % Keep vehID, time, segment, distance, speed
    traj=[double(cell2mat(traj(1))) double(cell2mat(traj(2))) double(cell2mat(traj(3)))...
        double(cell2mat(traj(4))) double(cell2mat(traj(5)))];    
    % Exclude vehicles
    %Lia=ismember(traj(:,1),ExcludVeh); % Find vehicles to exclude
    %traj(Lia,:)=[]; % Exclude vehicles
    for ivc=1:size(N,2)
        VehClass=N(ivc); 
        svc=int2str(VehClass);
        Lia=ismember(traj(:,1), cvc{VehClass,1});
        Mdat=traj(Lia,1:5);
        if numel(Mdat)>0 % If there are data to save
            sfn=['trajectory.bin_out_veh_cate_',svc,'_',stp];
            fi2=fopen(sfn,'w');
            % Write VehID, time, segment, distance, and speed
            fprintf(fi2,'%.0d,%.0d,%.0d,%.3f,%.3f\n',Mdat(:,1:5)');
            fclose(fi2);
            traj(Lia,:)=[];
        end
    end
    fprintf('Done with time period %d; elapsed time: %.2f \n',itpe,toc)
    tic
end

mydt = datestr(now);
fprintf('Current date and time: %s \n',mydt)