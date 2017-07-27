TC_inbound=load('TC_inbound1.csv');
TC_outbound=load('TC_outbound1.csv');
[~,j]=size(TC_inbound);
[~,m]=size(TC_outbound);
%add title as query numbers
for a=1:570
    t=floor((a-1)/10)+1;
    TC_inbound(1,a+2)=t;
    TC_outbound(1,a+2)=t;
end
%delete last 57 columns
TC_inbound(:,573:j)=[];
TC_outbound(:,573:m)=[];

%transfer query number to Gunwoo IDs
Query1=xlsread('Query_ID.xlsx');
for a=1:57 % number of queries
    for t=1:10
        c=(a-1)*10+t;
        TC_inbound(1,c+2)=Query1(a+1,2);
        TC_outbound(1,c+2)=Query1(a+1,2);
    end
end
%merge 10 tables into 6 tables
[i,j]=size(TC_inbound);
[n,m]=size(TC_outbound);
j1=(j-2)/10;
t1=6*j1+2;
m2=(m-2)/10;
t2=6*m2+2;
TC=zeros(i,t1); %inbound
TC2=zeros(n,t2);%outbound
%tables merge
for c=1:2
    for r=1:i
        TC(r,c)=TC_inbound(r,c);
    end
end
for c=1:2
    for r=1:n
        TC2(r,c)=TC_outbound(r,c);
    end
end
for a=1:57
    c1=6*(a-1)+3;
    c2=6*(a-1)+4;
    c3=6*(a-1)+5;
    c4=6*(a-1)+6;
    c5=6*(a-1)+7;
    c6=6*(a-1)+8;
    b1=10*(a-1)+3;
    b2=10*(a-1)+4;
    b3=10*(a-1)+5;
    b4=10*(a-1)+6;
    b5=10*(a-1)+7;
    b6=10*(a-1)+8;
    b7=10*(a-1)+9;
    b8=10*(a-1)+10;
    b9=10*(a-1)+11;
    b10=10*(a-1)+12;
    %first row 
    TC(1,c1:c6)=TC_inbound(1,b1:b6);
    TC2(1,c1:c6)=TC_outbound(1,b1:b6);
        
    for r=1:i-1
        TC(r+1,c1)=TC_inbound(r+1,b1)+TC_inbound(r+1,b7);
        TC(r+1,c2)=TC_inbound(r+1,b2)+TC_inbound(r+1,b3);
        TC(r+1,c3:c5)=TC_inbound(r+1,b4:b6);
        TC(r+1,c6)=TC_inbound(r+1,b8)+TC_inbound(r+1,b9)+TC_inbound(r+1,b10);
    end
    for r=1:n-1
        TC2(r+1,c1)=TC_outbound(r+1,b1)+TC_outbound(r+1,b7);
        TC2(r+1,c2)=TC_outbound(r+1,b2)+TC_outbound(r+1,b3);
        TC2(r+1,c3:c5)=TC_outbound(r+1,b4:b6);
        TC2(r+1,c6)=TC_outbound(r+1,b8)+TC_outbound(r+1,b9)+TC_outbound(r+1,b10);
    end
end
%merge queries that share the same Gunwoo ID
s=[48,34,32,30,28,25,23,20,11,7,3,1]; %query numbers that share the same Gunwoo ID with 49,35,33,31,......
for r=s 
    c=(r-1)*6+1; 
    TC(2:i,c+8:c+13)=TC(2:i,c+2:c+7)+TC(2:i,c+8:c+13);
    TC2(2:n,c+8:c+13)=TC2(2:n,c+2:c+7)+TC2(2:n,c+8:c+13);
end
for r=s
    c=(r-1)*6+1;
    TC(:,c+2:c+7)=[];
    TC2(:,c+2:c+7)=[];
end
csvwrite('TC_inbound1.csv',TC);
csvwrite('TC_outbound1.csv',TC2);