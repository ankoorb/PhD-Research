a=0;
for i=1:32
s1=int2str(i);
s2=strcat('TC_2link+1_',s1,'.csv');
TC=csvread(s2);
[w,v]=size(TC);
if v>2
b=sum(TC(2:w,3:v));
c=sum(b,2);
a=a+c;
end
end




d=0;
for i=1:32
s1=int2str(i);
s2=strcat('TC_2link1_',s1,'.csv');
TC=csvread(s2);
[w,v]=size(TC);

b=sum(TC(2:w,3:v));
c=sum(b,2);
d=d+c;
end

TC=csvread('TC_2link+1.csv');
[w,v]=size(TC);
b=sum(TC(2:w,3:v));
e=sum(b,2);


f=0;
for i=1:32
s1=int2str(i);
s2=strcat('MDTL-',s1,'.csv');
TC=csvread(s2);
[w,v]=size(TC);

b=sum(TC(2:w,3:v));
c=sum(b,2);
f=f+c;
end

%%%%%%%%%%   a should be equal to d and to e, h3 and to 1/2 f   %%%%%%%%%%%%%%


TC=csvread('MD-inbound.csv');
[w,v]=size(TC);
b=sum(TC(2:w,3:v));
g=sum(b,2);
TC=csvread('TC_inbound1.csv');
[w,v]=size(TC);
b=sum(TC(2:w,3:v));
g2=sum(b,2);

TC=csvread('MD-outbound.csv');
[w,v]=size(TC);
b=sum(TC(2:w,3:v));
g3=sum(b,2);
TC=csvread('TC_outbound1.csv');
[w,v]=size(TC);
b=sum(TC(2:w,3:v));
g4=sum(b,2);

%%%%%%%%%%   g should be equal to 1/2 g2,h1  %%%%%  g3 equal to 1/2 g4, h2   %%%%%%%%%%%%%%

TC=csvread('TM_inbound1.csv');
[w,v]=size(TC);
b=sum(TC(2:w,3:v));
h1=sum(b,2);
TC=csvread('TM_outbound1.csv');
[w,v]=size(TC);
b=sum(TC(2:w,3:v));
h2=sum(b,2);
TC=csvread('TM_2link1.csv');
[w,v]=size(TC);
b=sum(TC(2:w,3:v));
h3=sum(b,2);