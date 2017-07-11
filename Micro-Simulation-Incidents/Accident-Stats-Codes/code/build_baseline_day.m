%convert_baseline_day
% read VDS_info and VDS_traffic, make 1day baseline and store it
% input: VDS_info_n, VDS_info_s, strDir, strVDS_traffic, strBaseline
function [ base_time_N, base_postmile_N, base_flow_N, base_speed_N, ...
    base_time_S, base_postmile_S, base_flow_S, base_speed_S ] = ...
    build_baseline_day( vds_info_N, vds_info_S, strDir, str_vds_data_file)

global g_str_m_code;

fprintf(1, '[build baseline for %s]\n', str_vds_data_file);

% -------------------------------------------------------------------------
% load VDS_data (it has all traffic data in D11)
s = ['cd ' sprintf('%s',strDir)];
eval(s);
s = ['fid = fopen(''' sprintf('%s',str_vds_data_file) ''', ''r'');'];
eval(s);

% read day traffic file
% 1: day 
% 2: month
% 3: year
% 4: hour
% 5: min
% 6: time (string)
% 7: station 
% 8: district 
% 9: route
% 10: dirction (string)
% 11: station type (string)
% 12: station length 
% 13: samples (total number of samples)
% 14: % obs (observed)
% 15: total flow
% 16: avg occupancy
% 17: avg speed (mph)
vds_5min = textscan(fid, '%d%d%d %d%d%d %d %d %d %s %s %f %f %f %f %f %f %*[^\n]', 'delimiter', ':/ ,', 'emptyValue', -1);
fclose(fid);

% remember missing data filled with "-1"
s_day = vds_5min{1};
s_mon = vds_5min{2};
s_year = vds_5min{3};
s_hour = vds_5min{4};
s_min = vds_5min{5};
s_sec = vds_5min{6};
s_station = vds_5min{7};
s_district = vds_5min{8};
s_route = vds_5min{9};
s_direction = vds_5min{10};
s_type = vds_5min{11};
s_length = vds_5min{12};
s_samples = vds_5min{13};
s_percObs = vds_5min{14};
s_ttFlow = vds_5min{15};
s_avgOcc = vds_5min{16};
s_avgSpeed = vds_5min{17};

% matrix [station flow occ speed year month day time]
day_traffic=[];
day_traffic(:,1) = s_station;
day_traffic(:,2) = s_ttFlow;
day_traffic(:,3) = s_avgOcc;
day_traffic(:,4) = s_avgSpeed;
day_traffic(:,5) = s_year;
day_traffic(:,6) = s_mon;
day_traffic(:,7) = s_day;
day_traffic(:,8) = 12*s_hour + s_min/5 + 1; % from 1 ~ 288 time slots

%--------------------------------------------------------------------------
% init
s = ['cd ' sprintf('%s',g_str_m_code)];
eval(s);


maxPostmile = 55;
gridSizePostmile = 0.1;
maxTime = 24*60;
gridSizeTime = 5;

nPostmile = maxPostmile/gridSizePostmile;
nSlot = maxTime/gridSizeTime;

%--------------------------------------------------------------------------
% I5 North

[nVds, nItem] = size(vds_info_N);

% matrix allocation
map_time_N = []; %zeros(nVds, nSlot); % [time]
map_flow_N = []; %zeros(nVds, nSlot); % [flow]
map_speed_N = []; %zeros(nVds, nSlot); % [speed]
map_vds_N = []; %zeros(nVds, nSlot); % [vds_id]
map_postmile_N = []; %zeros(nVds, nSlot); % [postMile]

% allocate baseline matices
baseline_time_N = 1:1:nSlot;
baseline_postmile_N = 0:0.1:maxPostmile;
baseline_flow_N = zeros(length(baseline_postmile_N), length(baseline_time_N));
baseline_speed_N = zeros(length(baseline_postmile_N), length(baseline_time_N));

% do something
for time=1:nSlot;
    nMatched = 0;
    for i=1:nVds
        vds_id = vds_info_N(i,2);
        postMile = vds_info_N(i,1);
        [a]=find(day_traffic(:,1)== vds_id & day_traffic(:,8)==time);
        [mA, nA] = size(a);
        if ( mA == 0 ) 
            continue
        end
        
        matched_day_traffic = day_traffic(a,:); % copy the row
        flow = matched_day_traffic(2);
        speed = matched_day_traffic(4);
        if ( flow == -1 || speed == -1 )
           fprintf(1, '------Warning------------------------------\n');
           fprintf(1, 'Data skipped in %s\n', str_vds_data_file);
           fprintf(1, 'VDS ID %d, TimeSlot %d\n', vds_id, time);
           fprintf(1, '-------------------------------------------\n');            
           continue;
        end
                
        nMatched = nMatched + 1;
        map_time_N(nMatched,time) = time;
        map_vds_N(nMatched,time) = vds_id;
        map_postmile_N(nMatched,time) = postMile;
        map_flow_N(nMatched,time) = matched_day_traffic(2);
        map_speed_N(nMatched,time) = matched_day_traffic(4);
        
    end
    
       
    % flow interpolation for highway stretch
    x = map_postmile_N(:,time);
    yFlow = map_flow_N(:,time);
    outFlow = getSpline1(x, yFlow, 0, maxPostmile, 0.1, 0);
    baseline_flow_N(:,time) = outFlow(:,2);
   
    
    % speed interpolation for highway stretch
    x = map_postmile_N(:,time);
    ySpeed = map_speed_N(:,time);
    outSpeed = getSpline1(x, ySpeed, 0, maxPostmile, 0.1, 0);
    baseline_speed_N(:,time) = outSpeed(:,2);
    
end

% graph
strJpgFile = sprintf('N_flow_%s', str_vds_data_file);
strJpgFile = regexprep(strJpgFile, '.txt', '.jpg');
strTitle = regexprep(strJpgFile, '.jpg', '');
strTitle = regexprep(strTitle, '_', ' ');
strJpgFullPath = sprintf('%s\\%s', strDir, strJpgFile);
createfigure_flow(baseline_time_N, baseline_postmile_N, baseline_flow_N, strJpgFullPath, strTitle);

strJpgFile = sprintf('N_speed_%s', str_vds_data_file);
strJpgFile = regexprep(strJpgFile, '.txt', '.jpg');
strTitle = regexprep(strJpgFile, '.jpg', '');
strTitle = regexprep(strTitle, '_', ' ');
strJpgFullPath = sprintf('%s\\%s', strDir, strJpgFile);
createfigure_speed(baseline_time_N, baseline_postmile_N, baseline_speed_N, strJpgFullPath, strTitle);

base_time_N = baseline_time_N;
base_postmile_N = baseline_postmile_N;
base_flow_N = baseline_flow_N;
base_speed_N = baseline_speed_N;

%--------------------------------------------------------------------------
% I5 South
[nVds, nItem] = size(vds_info_S);

% matrix allocation
map_time_S = []; %zeros(nVds, nSlot); % [time]
map_flow_S = []; %zeros(nVds, nSlot); % [flow]
map_speed_S = []; %zeros(nVds, nSlot); % [speed]
map_vds_S = []; %zeros(nVds, nSlot); % [vds_id]
map_postmile_S = []; %zeros(nVds, nSlot); % [postMile]

% allocate baseline matices
baseline_time_S = 1:1:nSlot;
baseline_postmile_S = 0:0.1:maxPostmile;
baseline_flow_S = zeros(length(baseline_postmile_S), length(baseline_time_S));
baseline_speed_S = zeros(length(baseline_postmile_S), length(baseline_time_S));

% do something
for time=1:nSlot;
    nMatched = 0;
    for i=1:nVds
        vds_id = vds_info_S(i,2);
        postMile = vds_info_S(i,1);
        [a]=find(day_traffic(:,1)== vds_id & day_traffic(:,8)==time);
        [mA, nA] = size(a);
        if ( mA == 0 ) 
            continue
        end
        
        matched_day_traffic = day_traffic(a,:); % copy the row
        flow = matched_day_traffic(2);
        speed = matched_day_traffic(4);
        if ( flow == -1 || speed == -1 )
           fprintf(1, '------Warning------------------------------\n');
           fprintf(1, 'Data skipped in %s\n', str_vds_data_file);
           fprintf(1, 'VDS ID %d, TimeSlot %d\n', vds_id, time);
           fprintf(1, '-------------------------------------------\n');             
           continue;
        end
        
        nMatched = nMatched + 1;
        map_time_S(nMatched,time) = time;
        map_vds_S(nMatched,time) = vds_id;
        map_postmile_S(nMatched,time) = postMile;
        map_flow_S(nMatched,time) = matched_day_traffic(2);
        map_speed_S(nMatched,time) = matched_day_traffic(4);
        
    end
    
    % flow interpolation for highway stretch
    x = map_postmile_S(:,time);
    yFlow = map_flow_S(:,time);
    outFlow = getSpline1(x, yFlow, 0, maxPostmile, 0.1, 0);
    baseline_flow_S(:,time) = outFlow(:,2);
    
    % speed interpolation for highway stretch
    x = map_postmile_S(:,time);
    ySpeed = map_speed_S(:,time);
    outSpeed = getSpline1(x, ySpeed, 0, maxPostmile, 0.1, 0);
    baseline_speed_S(:,time) = outSpeed(:,2);
    
end

% graph
strJpgFile = sprintf('S_flow_%s', str_vds_data_file);
strJpgFile = regexprep(strJpgFile, '.txt', '.jpg');
strTitle = regexprep(strJpgFile, '.jpg', '');
strTitle = regexprep(strTitle, '_', ' ');
strJpgFullPath = sprintf('%s\\%s', strDir, strJpgFile);
createfigure_flow(baseline_time_S, baseline_postmile_S, baseline_flow_S, strJpgFullPath, strTitle);

strJpgFile = sprintf('S_speed_%s', str_vds_data_file);
strJpgFile = regexprep(strJpgFile, '.txt', '.jpg');
strTitle = regexprep(strJpgFile, '.jpg', '');
strTitle = regexprep(strTitle, '_', ' ');
strJpgFullPath = sprintf('%s\\%s', strDir, strJpgFile);
createfigure_speed(baseline_time_S, baseline_postmile_S, baseline_speed_S, strJpgFullPath, strTitle);

base_time_S = baseline_time_S;
base_postmile_S = baseline_postmile_S;
base_flow_S = baseline_flow_S;
base_speed_S = baseline_speed_S;

%--------------------------------------------------------------------------
% Write baseline_oneday (S + N)
% save('fileName', 'var1', 'var2');
s = ['cd ' sprintf('%s',strDir)];
eval(s);


strTextFile = sprintf('%s', str_vds_data_file);
strExt = '.txt';
strMatFile = regexprep(strTextFile, strExt, '.mat');

s = ['save(''' sprintf('%s',strMatFile) ''',' ...
    '''baseline_time_N'', ''baseline_postmile_N'', ''baseline_speed_N'', ''baseline_flow_N'', ' ...
    '''baseline_time_S'', ''baseline_postmile_S'', ''baseline_speed_S'', ''baseline_flow_S'')'];
eval(s);



