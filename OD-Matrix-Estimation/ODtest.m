clear;clc;

tic

nbo=load('centroidsnbo.txt'); %load north bound centroid origin IDs
nbd=load('centroidsnbd.txt'); %load north bound centroid destination IDs
sbo=load('centroidssbo.txt'); %load south bound centroid origin IDs
sbd=load('centroidssbd.txt'); %load south bound centroid destination IDs
[Nbo,a]=size(nbo); %Nbo is number of north bound origin IDs
[Nbd,b]=size(nbd); %Nbd is number of north bound destination IDs
[Sbo,c]=size(sbo); %Sbo is number of south bound origin IDs
[Sbd,d]=size(sbd); %Sbd is number of south bound destination IDs

data=dlmread('demands_1.txt');
[q,y]=size(data); 


for g=1:Nbo %for number of north bound origins
for h=1:Nbd %for number of north bound destinations
for m=1:Sbo %for number of south bound origins
for n=1:Sbd %for number of south bound destinations
	for i=1 
    s1=int2str(i);
  	s2=strcat('demands_',s1,'.txt');
  	data=dlmread(s2);
  	var=zeros(length(data),1); %create column of zeros
  	data(:,9)=var; %attach column of zeros to OD matrix as electric trucks OD
    
  		for j=1:q
       		if data(j,1)==nbo(g,1) || data(j,2)==nbd(h,1) %Judge if this OD pair is electric port related
       		data(j,9)=data(j,8)*0.8; %Assign 80 percent of port OD for electric OD
            end

       		if data(j,1)==sbo(m,1) || data(j,2)==sbd(n,1) %Judge if this OD pair is electric port
       		data(j,9)=data(j,8)*0.8; %Assign 80 percent of port OD for electric OD
            end  
        end
        
        %for k=1:q
         %   if data(k,1)==nbo(g,1) || data(k,2)==nbd(h,1) %Judge if this OD pair is electric port related
       	%	data(k,8)=data(k,8)*0.2; %Assign 80 percent of port OD for electric OD
         %   end
            
          %  if data(k,1)==sbo(m,1) || data(k,2)==sbd(n,1) %Judge if this OD pair is electric port related
       		%data(k,8)=data(k,8)*0.2; %Assign 80 percent of port OD for electric OD
            %end
        %end
        
    	s3=strcat('demands_',s1,'.txt'); %save as new demand files
    	dlmwrite(s3,data);
    
    	end
end
end
end
end

toc