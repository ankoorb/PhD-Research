
Port=[10001,10002,10003,10004,10005];%The centroid ID of port
N=5; %N is the number of port IDs
redist=load('new_profile.txt'); %Load new 15min distribution of trucks
Ankoor=dlmread('demands_1.txt');
[q,~]=size(Ankoor); 
Totaltrucks=zeros(q,3);%empty total trucks demands matrix
Totaltrucks(:,1:2)=Ankoor(:,1:2);% copy All OD pairs
for i=1:96
    s1=int2str(i);
    s2=strcat('demands_',s1,'.txt');
Ankoor=dlmread(s2);
Totaltrucks(:,3)=Totaltrucks(:,3)+Ankoor(:,8); %Sum total truck traffic over 24 hours
end
csvwrite('totaltrucks.csv',Totaltrucks);


for g=1:N %N is the number of port IDs
    for i=1:96 
    s1=int2str(i);
    s2=strcat('demands_',s1,'.txt');
    Ankoor=dlmread(s2);
    for j=1:q
        if Ankoor(j,1)==Port(g,1) || Ankoor(j,2)==Port(g,1) %Judge if this OD pair is port related
        Ankoor(j,8)=Totaltrucks(j,3)*redist(i,1);%re-distribution
        end
    end
    s3=strcat('demands_',s1,'txt'); %save as new demand files
    csvwrite(s3,Ankoor);
    
    end
end

