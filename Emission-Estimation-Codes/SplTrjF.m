%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Code to split 'trajectory.bin' in 15 minute periods
% Last update: December 7, 2014 by JDS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

diary('SplitTrajPost.txt');

fprintf('\n* Split trajectory.bin file in 15 min time periods * \n')
mydt = datestr(now);
fprintf('Starting date and time: %s \n',mydt)

mydir=pwd; % Remove existing result files
for iti=1:96
    sn = [mydir '\trajx.bin_out_time_' int2str(iti)];
    if  exist(sn,'file')==2
        delete(sn);
    end
end    

% File parameters and reading parameters
%
fileInfo=dir('.\trajectory.bin');
nrec=fileInfo.bytes/44; % Total number of records (44 bytes per record)
fprintf('Total number of records to process: %d\n',nrec);
%
iin = 3000000; % Block of records mapped and read
brd = iin; % Number of records in a block
fprintf('Number of records in a block: %d\n',iin);
%
nit = floor(nrec/iin); % Number of iterations
if (nit*iin==nrec) % If the number of observations is a multiple of block size
    nit1 = nit;
    flag = 0;
else  % case when a few extra records need to be read
    nit1 = nit + 1;
    flag = 1;
end    
iofs=0; % Offset parameter for memory mapping
fprintf('Number of iterations: %d\n\n',nit1);

tic
for ii=1:nit1 % Loop on blocks of records to read
    if (flag==1) & (ii==nit1)
        brd=nrec-iin*nit; % last block of data read
    end
    
    % Vehicle ID
    %
    mmp = memmapfile( 'trajectory.bin', ...
    'Format',   {'int32', [11 1], 'xyz'},...
    'Repeat', brd,'Offset',iofs);
    VID=mmp.Data;
    VID=cell2mat(struct2cell(VID));
    VID=VID(1:11:end)';

    % Time, distance, speed, acceleration
    %
    mmp = memmapfile( 'trajectory.bin', ...
    'Format',   {'single', [11 1], 'xyz'},...
    'Repeat', brd,'Offset',iofs);
    Vdt=mmp.Data;
    Vdt=cell2mat(struct2cell(Vdt));
    Vdt=[Vdt(2:11:end)',Vdt(9:11:end)',Vdt(10:11:end)',Vdt(11:11:end)'];

    % Segment
    %
    mmp = memmapfile( 'trajectory.bin', ...
    'Format',   {'int16', [9 1], 'xy1';...
    'int32', [1 1], 'Segment'; 'int16', [11 1], 'xy2'},...
    'Repeat', brd,'Offset',iofs);
    Vsg=mmp.Data;
    Vsg=rmfield(Vsg,'xy1');
    Vsg=rmfield(Vsg,'xy2');
    Vsg=cell2mat(struct2cell(Vsg))';

    Vdat=[double(VID), double(Vdt(:,1)), double(Vsg),...
      double(Vdt(:,2)), double(Vdt(:,3)), double(Vdt(:,4)),...
      double(floor((Vdt(:,1)-1)/900)+1)];
    Vtim = sort(unique(Vdat(:,end))); % Find unique time periods
    for iti=1:numel(Vtim) % Loop on 15 min time periods
        itj=Vtim(iti);
        s1=int2str(itj); 
        sn=strcat('trajx.bin_out_time_',s1); % Name of file where to export records
        Lia = ismember(Vdat(:,end),itj);
        fID=fopen(sn,'a');
        % WriteVehID, time, segment, distance, speed, and acceleration
        fprintf(fID,'%.0d,%.0d,%.0d,%.3f,%.3f,%.3f\n',Vdat(Lia,1:6)');
        fclose(fID);
        Vdat(Lia,:)=[]; % Remove records that were just saved
    end
    
    if mod(ii,10)==0
        fprintf('Iteration: %d; elapsed time for last 10 iterations: %8.2f s\n',ii,toc);
        tic
    end
    iofs=iofs+44*iin;
end

mydt = datestr(now);
fprintf('Ending date and time: %s \n',mydt)

