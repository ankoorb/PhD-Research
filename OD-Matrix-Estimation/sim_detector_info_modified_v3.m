% Date: March April 30, 2013
% Modified by Ankoor
% Input from TransModeler Version 3.0

function sim_detector_info_modified_v3()
% Generating input data for sim_detector_info.dat
% 1. Detector Name (ID)
% 2. Arrival Interval (when vehicles arrive at the detector)
% 3. Path Identification (line number in sim_path_info.dat) - ???
% 4. total number of vehicles passing the detectors during the interval (2. arrival interval) including SOV, HOV and Trucks
% 5. number of SOV vehicles
% 6. number of HOV vehicles (????)
% 7. number of Trucks (????)
% 8. average speed (DO NOT USE IT... I'm not sure if it's right or not) (? ???)
% 9. average speed 1 (DO NOT USE IT... I'm not sure if it's right or not) (????)
% 10. average speed 2 (DO NOT USE IT... I'm not sure if it's right or not) (????)
% 11. average speed 3 (DO NOT USE IT... I'm not sure if it's right or not) (????)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For Loop detector (or Sensors) case
interval=15*60; % time interval, here 15 min (900 sec)
simul_time=0+1800; % simulation start time from midnight (sec) 7am
clearance_time=25;
no_interval=(clearance_time*3600-simul_time)/interval;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The "*.exe" (detector2) uses "detector2.bin" and "temp_vehicle_set.txt"
% (generated during last step of "path_info" Matlab code) as input to
% generate "detector2.bin_out_veh_path" as output.

!Gwlee_BC_detector2_ODME.exe detector2.bin temp_vehicle_set.txt

load detector2.bin_out_veh_path; %Time vehicle was detected, SensorID, VehicleID, Speed, PathID,Vehicle Type

load temp_vehicle_set.txt

remove_set=find(detector2(:,1)<simul_time);
detector2(remove_set,:)=[];
clear remove_set

totObs2 = size(detector2,1);
timeIndex1=zeros(size(detector2(:,1),1),1);

for i=1:no_interval
    if i==1
index1= detector2(:,1) < simul_time+interval*i; timeIndex1=timeIndex1+index1*i;
    elseif i==no_interval
index1= simul_time+interval*(i-1) <= detector2(:,1); timeIndex1=timeIndex1+index1*i;
   else
index1= simul_time+interval*(i-1) <= detector2(:,1) & detector2(:,1) < simul_time+interval*i; timeIndex1=timeIndex1+index1*i;
    end
end

detector2(:,1)=timeIndex1;
detector2(:,7)=detector2(:,5)*10^4+detector2(:,2); %generating new Path ID combined with path line reference and sensorID
detector2=sortrows(detector2,7);
[detector_set,fdet]=unique(detector2(:,7),'first');
[detector_set,ldet]=unique(detector2(:,7),'last');
%Time Vehicle was detected, SensorID, VehicleID, Speed, PathID, Vehicle Type
% sensor_matrix2
%   1        2        3        4         5           6     7 
%[SensorID, Interval, VehID, Speed, CrossingTime, PathID, combined_pathID]

fid = fopen('sim_detector_info_.dat','wt');

for i=1:size(detector_set,1)
   
    if round(size(detector_set,1)/2)==i
        fprintf('currently 50 percent completed \n')
    end
    temp_det=detector2(fdet(i):ldet(i),:);
    check1=temp_det(:,6)==11; check2=temp_det(:,6)==12;check3=temp_det(:,6)==24;
    check4=temp_det(:,6)==25; check5=temp_det(:,6)==26;check6=temp_det(:,6)==46;
   
            fprintf(fid,'%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%3.1f,%3.1f,%3.1f,%3.1f,%3.1f,%3.1f,%3.1f\n',[temp_det(1,2),temp_det(1,1),temp_det(1,5),size(temp_det,1),...
                sum(check1),sum(check2),sum(check3),sum(check4),sum(check5),sum(check6),...
        sum(temp_det(:,4))./max(1,size(temp_det,1)),sum(temp_det(:,4).*check1)./max(1,sum(check1)),sum(temp_det(:,4).*check2)./max(1,sum(check2)),sum(temp_det(:,4).*check3)./max(1,sum(check3)),...
        sum(temp_det(:,4).*check4)./max(1,sum(check4)),sum(temp_det(:,4).*check5)./max(1,sum(check5)),sum(temp_det(:,4).*check6)./max(1,sum(check6))]');  

end
fclose(fid);

copyfile('sim_*.dat','L:/PORT(UCTC-3.0)/ODE/simulated_data')
