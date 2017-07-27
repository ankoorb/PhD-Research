%find numnber of unique OD pairs in 55 2-link query results
%add all OD pairs together
a=1;
for g=1:55
    s1=int2str(g);
    s2=strcat('TC_2link3_',s1,'.csv');
    TC=load(s2);
    [a1,a2]=size(TC);
    TC0(a:a+a1-2,1:2)=TC(2:a1,1:2);
    a=a+a1-1;
end
csvwrite('TC0.csv',TC0);