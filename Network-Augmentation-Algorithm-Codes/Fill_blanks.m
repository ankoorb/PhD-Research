TC1=csvread('MD-Inbound.csv');
[~,b]=size(TC1);
Title=zeros(1,b);
TC1=[Title;TC1(:,:)];
csvwrite('TC_inbound3.csv',TC1);

TC2=csvread('MD-Outbound.csv');
[~,b]=size(TC2);
Title=zeros(1,b);
TC2=[Title;TC2(:,:)];
csvwrite('TC_outbound3.csv',TC2);
for g=1:55
    s1=int2str(g);
    s2=strcat('MDTL-',s1,'.csv');
    TC=csvread(s2);
    [~,b]=size(TC);
    Title=zeros(1,b);
    TC=[Title;TC(:,:)];
    s3=strcat('TC_2link3_',s1,'.csv');
    csvwrite(s3,TC);
end