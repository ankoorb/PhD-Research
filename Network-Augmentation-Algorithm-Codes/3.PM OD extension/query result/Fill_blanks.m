TC1=csvread('PM-inbound.csv');
[~,b]=size(TC1);
Title=zeros(1,b);
TC1=[Title;TC1(:,:)];
csvwrite('TC_inbound1.csv',TC1);

TC2=csvread('PM-outbound.csv');
[~,b]=size(TC2);
Title=zeros(1,b);
TC2=[Title;TC2(:,:)];
csvwrite('TC_outbound1.csv',TC2);
for g=1:32
    s1=int2str(g);
    s2=strcat('PMTL-',s1,'.csv');
    TC=csvread(s2);
    [~,b]=size(TC);
    Title=zeros(1,b);
    TC=[Title;TC(:,:)];
    s3=strcat('TC_2link1_',s1,'.csv');
    csvwrite(s3,TC);
end