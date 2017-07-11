clear;

% create global variables
global g_str_m_code g_str_data;
g_str_m_code = 'E:\Projects\PeMS\m_code';
g_str_data = 'E:\Projects\PeMS\data';


% BATCH procedure 4*4
str_data_dir = 'E:\Projects\PeMS\data';
str_data_season = 'season_1_mon';

% make a baseline for one season - one day
s = ['cd ' sprintf('%s\\%s',str_data_dir, str_data_season)];
eval(s);

files = dir('*.mat');
nFiles = length(files);

nTime = 288;
nPostmile = 551;

postmile = zeros(1, nPostmile);
time = zeros(1, nTime);

flow_N = zeros(nPostmile, nTime, nFiles);
flow_S = zeros(nPostmile, nTime, nFiles);
speed_N = zeros(nPostmile, nTime, nFiles);
speed_S = zeros(nPostmile, nTime, nFiles);

% load data
for idx = 1:nFiles;    

    str_file_name = files(idx).name;
    s = ['load ' sprintf('%s',str_file_name)];
    eval(s);
    
    if ( idx == 1 )
        postmile = baseline_postmile_N;
        time = baseline_time_N;
    end
    
    flow_N(:,:,idx) = baseline_flow_N;
    flow_S(:,:,idx) = baseline_flow_S;
    speed_N(:,:,idx) = baseline_speed_N;
    speed_S(:,:,idx) = baseline_speed_S;
    
end

s = ['cd ' sprintf('%s',g_str_m_code)];
eval(s);

% calculate mean
mean_flow_N = mean(flow_N, 3);
mean_flow_S = mean(flow_S, 3);
mean_speed_N = mean(speed_N, 3);
mean_speed_S = mean(speed_S, 3);

strJpgFile = sprintf('%s_N_flow_mean.jpg', str_data_season);
strTitle = regexprep(strJpgFile, '.jpg', '');
strTitle = regexprep(strTitle, '_', ' ');
strJpgFullPath = sprintf('%s\\%s', str_data_dir, strJpgFile);
createfigure_flow(time, postmile, mean_flow_N, strJpgFullPath, strTitle);

strJpgFile = sprintf('%s_S_flow_mean.jpg', str_data_season);
strTitle = regexprep(strJpgFile, '.jpg', '');
strTitle = regexprep(strTitle, '_', ' ');
strJpgFullPath = sprintf('%s\\%s', str_data_dir, strJpgFile);
createfigure_flow(time, postmile, mean_flow_S, strJpgFullPath, strTitle);

strJpgFile = sprintf('%s_N_speed_mean.jpg', str_data_season);
strTitle = regexprep(strJpgFile, '.jpg', '');
strTitle = regexprep(strTitle, '_', ' ');
strJpgFullPath = sprintf('%s\\%s', str_data_dir, strJpgFile);
createfigure_speed(time, postmile, mean_speed_N, strJpgFullPath, strTitle);

strJpgFile = sprintf('%s_S_speed_mean.jpg', str_data_season);
strTitle = regexprep(strJpgFile, '.jpg', '');
strTitle = regexprep(strTitle, '_', ' ');
strJpgFullPath = sprintf('%s\\%s', str_data_dir, strJpgFile);
createfigure_speed(time, postmile, mean_speed_S, strJpgFullPath, strTitle);


% calculate percentiles
nPerc = [ 50 60 75 85 ]; 0~100%

for i=1:length(nPerc);
    
    perc = nPerc(i);
    perc_flow_N = prctile(flow_N, perc, 3);
    perc_flow_S = prctile(flow_S, perc, 3);
    perc_speed_N = prctile(speed_N, perc, 3);
    perc_speed_S = prctile(speed_S, perc, 3);

    strJpgFile = sprintf('%s_N_flow_%dth_percentile.jpg', str_data_season, perc);
    strTitle = regexprep(strJpgFile, '.jpg', '');
    strTitle = regexprep(strTitle, '_', ' ');
    strJpgFullPath = sprintf('%s\\%s', str_data_dir, strJpgFile);
    createfigure_flow(time, postmile, perc_flow_N, strJpgFullPath, strTitle);

    strJpgFile = sprintf('%s_S_flow_%dth_percentile.jpg', str_data_season, perc);
    strTitle = regexprep(strJpgFile, '.jpg', '');
    strTitle = regexprep(strTitle, '_', ' ');
    strJpgFullPath = sprintf('%s\\%s', str_data_dir, strJpgFile);
    createfigure_flow(time, postmile, perc_flow_S, strJpgFullPath, strTitle);

    strJpgFile = sprintf('%s_N_speed_%dth_percentile.jpg', str_data_season, perc);
    strTitle = regexprep(strJpgFile, '.jpg', '');
    strTitle = regexprep(strTitle, '_', ' ');
    strJpgFullPath = sprintf('%s\\%s', str_data_dir, strJpgFile);
    createfigure_speed(time, postmile, perc_speed_N, strJpgFullPath, strTitle);

    strJpgFile = sprintf('%s_S_speed_%dth_percentile.jpg', str_data_season, perc);
    strTitle = regexprep(strJpgFile, '.jpg', '');
    strTitle = regexprep(strTitle, '_', ' '); 
    strJpgFullPath = sprintf('%s\\%s', str_data_dir, strJpgFile);
    createfigure_speed(time, postmile, perc_speed_S, strJpgFullPath, strTitle);

end;


