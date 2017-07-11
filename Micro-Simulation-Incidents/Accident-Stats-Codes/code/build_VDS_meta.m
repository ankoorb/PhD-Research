clear;
fprintf(1, '[Load VDS Meta-data]\n');

% read north file
cd e:\projects\PeMS\data;

fid = fopen('I5_north_vds_sequence.txt', 'r');
vds_header = textscan(fid, '%s %s %s %*[^\n]', 1); 
vds_info = textscan(fid, '%s %d %s %s %s %f %f %d %*[^\n]', 'delimiter', '\t');
fclose(fid);

% matrix [vds_id, abs_postmile]
vds_I5_north_raw =[];
vds_I5_north_raw(:,1)=vds_info{6};
vds_I5_north_raw(:,2)=vds_info{8};

% delete duplicate
[uniq, idx] = unique(vds_I5_north_raw(:,1));
vds_I5_north = [];
vds_I5_north(:,1) = uniq;
for i = 1:size(uniq)
    vds_I5_north(i,2) = vds_I5_north_raw(idx(i),2);
end


% read south file
fid = fopen('I5_south_vds_sequence.txt', 'r');
vds_header = textscan(fid, '%s %s %s %*[^\n]', 1); 
vds_info = textscan(fid, '%s %d %s %s %s %f %f %d %*[^\n]', 'delimiter', '\t');
fclose(fid);

% matrix [vds_id, abs_postmile]
vds_I5_south_raw=[];
vds_I5_south_raw(:,1)=vds_info{6};
vds_I5_south_raw(:,2)=vds_info{8};

% delete duplicate
[uniq, idx] = unique(vds_I5_south_raw(:,1));
vds_I5_south = [];
vds_I5_south(:,1) = uniq;
for i = 1:size(uniq)
    vds_I5_south(i,2) = vds_I5_south_raw(idx(i),2);
end


save vds_I5_north;
save vds_I5_south;

fprintf(1, '[Saved vds info]\n');