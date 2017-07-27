link2=csvread('link2.csv');
[l,~]=size(link2);
a=1;
for g=1:32
    s1=int2str(g);
    s2=strcat('TC_2link+1_',s1,'.csv');
    TC=load(s2);
    [~,a2]=size(TC);
    if a2>2
    for i=1:6:a2-2        
        for j=1:l-1
            if TC(1,i+2)==link2(j+1,1)
               link2(j+1,5)=1;
            end
        end
    end
    end
end
xlswrite('link2.xlsx',link2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%generate link2 and link3 manually