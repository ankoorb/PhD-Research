clear;clc;

tic

Ori=load('Origins.txt'); %load centroid origin IDs
Des=load('Destinations.txt'); %load centroid destination IDs

[oriN,a]=size(Ori); %oriN is number of origin IDs
[desN,b]=size(Des); %desN is number of destination IDs

demand=dlmread('demands_1.txt');
[c,d]=size(demand); 
clear a b d

for i=1:2 % Change 2 to 96 for 96 demand files
    s1=int2str(i);
    s2=strcat('demands_',s1,'.txt');
    data = dlmread(s2);  
    var=zeros(length(data),1); %create column of zeros
  	data(:,9)=var; %attach column of zeros to OD matrix as electric trucks OD
    
    
for e=1:oriN
    for f=1:desN
        for j=1:c
    
        if data(j,1)== Ori(e,1) && data(j,2)==Des(f,1) % Sarah you used || which is used for "or" this caused lot of errors, you need to use "and" -> && 
            
           data(j,9)=data(j,8)*0.8; %Assign 80 percent of port OD for electric OD
           data(j,8)=data(j,8)*0.2; %Assing 20 percent...
           
        end
        
        end
    end
end

s3=strcat('demands_',s1,'.txt'); %save as new demand files text
dlmwrite(s3,data,'newline','pc'); %'newline','pc' -> saves text newline pc format

%s4=strcat('demands_',s1,'.csv') %save as csv files
%csvwrite(s4,data);

clear data e f j

end
