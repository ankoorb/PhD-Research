%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  MOVES Output Processing and Unit Conversion                            % 
%  Author: Ankoor (10/22/2013)                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

% File format "Comma separated" *.csv file (after deleting unnecessary col)
% Col-1: VehClass, Col-2: FuelID (Port = 3), Col-3: OpMode ID, Col-4: HC, 
% Col-5: CO, Col-6: NOx, Col-7: Atm. CO2, Col-8: Energy/FC, Col-9: CO2 Eq., 
% Col-10: PM(10), Col-11: PM(2.5)
% Read file
clear;clc;
data = load('win-mean-out-T.csv'); % Need to change as per file name

% Create Unique Identifier for Vehicle Type and Fuel Type combination
data(:,12) = zeros; % Col-12: Unique Identifier

for i = 1:size(data,1)
    
    if data(i,1)==21 && data(i,2)==1 % PC Gas
    data(i,12)=1; 
    elseif data(i,1)==21 && data(i,2)==2 % PC Diesel
    data(i,12)=2; 
    elseif data(i,1)==31 && data(i,2)==1 % LDT-1 Gas
    data(i,12)=3;  
    elseif data(i,1)==31 && data(i,2)==2 % LDT-1 Diesel
    data(i,12)=4; 
    elseif data(i,1)==32 && data(i,2)==1 % LDT-2 Gas
    data(i,12)=5;  
    elseif data(i,1)==32 && data(i,2)==2 % LDT-2 Diesel
    data(i,12)=6; 
    elseif data(i,1)==51 && data(i,2)==1 % MDT Gas
    data(i,12)=7;  
    elseif data(i,1)==51 && data(i,2)==2 % MDT Diesel
    data(i,12)=8; 
    elseif data(i,1)==52 && data(i,2)==1 % LHDT-1 Gas
    data(i,12)=9;  
    elseif data(i,1)==52 && data(i,2)==2 % LHDT-1 Diesel
    data(i,12)=10; 
    elseif data(i,1)==53 && data(i,2)==1 % LHDT-2 Gas
    data(i,12)=11;  
    elseif data(i,1)==53 && data(i,2)==2 % LHDT-2 Diesel
    data(i,12)=12; 
    elseif data(i,1)==61 && data(i,2)==1 % MHDT Gas
    data(i,12)=13;  
    elseif data(i,1)==61 && data(i,2)==2 % MHDT Diesel
    data(i,12)=14; 
    elseif data(i,1)==62 && data(i,2)==2 % HDT Diesel
    data(i,12)=16; 
    else % Port HDT Diesel
    data(i,12)=17;    
    end
    
end

data = sortrows(data,[12,3]); % Sort rows first based on Unique Identifier (VehClass + FuelType) then OpMode ID

[vehClass,fref]=unique(data(:,12),'first'); % Find index when Unique Identifier appears first time
[vehClass,lref]=unique(data(:,12),'last'); % Find index when Unique Identifier appears last time

% Unit Conversion from Gram-Vehicle/Hour to Gram/Second

vol = 10000; % Flow = 10000 vehicles assumed in MOVES
sec = 3600; % Seconds in an hour
med_Speed = [1 1 13 13 13 13 13 13 37.5 37.5 37.5 37.5 37.5 37.5 37.5 37.5 37.5 60 60 60 60 60 60]; % Median Speed assumption

factor = (vol*sec)./med_Speed';

for j=1:size(vehClass,1)

    temp = data(fref(j):lref(j),:);
    temp(:,1:2)=[]; % Drop VehClass and Fuel ID
    
    for k=2:9
        temp(:,k)=temp(:,k)./factor;
    end
    temp(:,10)=[]; % Drop Unique Identifier
    
    Op_Rate{j}=temp;
   %Op_Rate(:,:,j)=temp;
end
    
% Emission Rate in Multi-Dimensional Array Format

Op_rate1=Op_Rate{1,1};
Op_rate2=Op_Rate{1,2};
Op_rate3=Op_Rate{1,3};
Op_rate4=Op_Rate{1,4};
Op_rate5=Op_Rate{1,5};
Op_rate6=Op_Rate{1,6};
Op_rate7=Op_Rate{1,7};
Op_rate8=Op_Rate{1,8};
Op_rate9=Op_Rate{1,9};
Op_rate10=Op_Rate{1,10};
Op_rate11=Op_Rate{1,11};
Op_rate12=Op_Rate{1,12};
Op_rate13=Op_Rate{1,13};
Op_rate14=Op_Rate{1,14};
Op_rate16=Op_Rate{1,15}; % Change here: 16 uses 15
Op_rate17=Op_Rate{1,16}; % Change here: 17 uses 16

% After running select Op_rate* matrices and save as "Op_lookup_matrix.mat"





