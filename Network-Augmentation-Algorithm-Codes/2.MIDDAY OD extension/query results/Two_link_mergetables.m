
for g=1:32
s1=int2str(g);
s2=strcat('TC_2link1_',s1,'.csv');
TC=load(s2);
[i,j]=size(TC);
n=(j-2)/10;
t=6*n+2;
TC2=zeros(i,t);
for c=1:2
    for r=1:i
        TC2(r,c)=TC(r,c);
    end
end
for a=1:n
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
    TC2(1,c1:c6)=TC(1,b1:b6);
      
    for r=1:i-1
        TC2(r+1,c1)=TC(r+1,b1)+TC(r+1,b7);
        TC2(r+1,c2)=TC(r+1,b2)+TC(r+1,b3);
        TC2(r+1,c3:c5)=TC(r+1,b4:b6);
        TC2(r+1,c6)=TC(r+1,b8)+TC(r+1,b9)+TC(r+1,b10);
    end
end
s3=strcat('TC_2link1_',s1,'.csv');
csvwrite(s3,TC2);
end