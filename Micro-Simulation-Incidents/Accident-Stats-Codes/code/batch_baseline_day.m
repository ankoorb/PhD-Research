clear;

% create global variables
global g_str_m_code g_str_data;
g_str_m_code = 'E:\Projects\PeMS\m_code';
g_str_data = 'E:\Projects\PeMS\data';

% load VDS information
load e:\projects\PeMS\data\vds_I5_north.mat;
load e:\projects\PeMS\data\vds_I5_south.mat;


% procedure 4*4 folders
str_data_season = 'E:\Projects\PeMS\data\season_2_sun';
%str_data_season = 'E:\Projects\PeMS\data\test';
%str_data_season = 'E:\Projects\PeMS\data\season_3_sun';

% make a baseline for one season - one day
s = ['cd ' sprintf('%s',str_data_season)];
eval(s);

files = dir('*.txt');
nFiles = length(files);

baseline_flow_S = [];
baseline_speed_S = [];
baseline_time_S = [];
baseline_postmile_S = [];

baseline_flow_N = [];
baseline_speed_N = [];
baseline_time_N = [];
baseline_postmile_N = [];

for idx = 1:nFiles;    

    str_file_name = files(idx).name;
    
    s = ['cd ' sprintf('%s',g_str_m_code)];
    eval(s);
    [ time_N, postmile_N, flow_N, speed_N, ...
        time_S, postmile_S, flow_S, speed_S ] = ...
        build_baseline_day( vds_I5_north, vds_I5_south, str_data_season, str_file_name);

    if (idx == 1)
        baseline_time_N = time_N;
        baseline_postmile_N = postmile_N;
        baseline_flow_N = flow_N;
        baseline_speed_N = speed_N;
        
        baseline_time_S = time_S;
        baseline_postmile_S = postmile_S;
        baseline_flow_S = flow_S;
        baseline_speed_S = speed_S;        
    else
        baseline_flow_S = (flow_S + (baseline_flow_S*(idx-1)))/idx;
        baseline_speed_S = (speed_S + (baseline_speed_S*(idx-1)))/idx;
        baseline_flow_N = (flow_N + (baseline_flow_N*(idx-1)))/idx;
        baseline_speed_N = (speed_S + (baseline_speed_N*(idx-1)))/idx;
    end;
    
end


