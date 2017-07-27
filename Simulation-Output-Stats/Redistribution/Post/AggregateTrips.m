clear;clc;

Totaltrucks=zeros(96,1);%empty total trucks demands matrix
for i=1:96
    s1=int2str(i);
    s2=strcat('demands_',s1,'.txt');
    PortTruck=dlmread(s2);
    Totaltrucks(i,1)=sum(PortTruck(:,8)); %Sum total truck traffic over each time period
    
end
csvwrite('totalpc.csv',Totaltrucks);


