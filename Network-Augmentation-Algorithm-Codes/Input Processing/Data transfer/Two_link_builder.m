%find numnber of unique OD pairs in 32 2-link query files
%add all OD pairs together
a=1;
for g=1:32
    s1=int2str(g);
    s2=strcat('TC_2link+1_',s1,'.csv');
    TC=load(s2);
    [a1,a2]=size(TC);
    TC0(a:a+a1-2,1:2)=TC(2:a1,1:2);
    a=a+a1-1;
end

TC1=unique(TC0,'rows');

csvwrite('TC_2link_ODlist.csv',TC1);