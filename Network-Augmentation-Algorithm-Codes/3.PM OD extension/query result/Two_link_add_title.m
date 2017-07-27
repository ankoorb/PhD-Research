%add title as query numbers
for g=1:31
    s1=int2str(g);
    s2=strcat('TC_2link1_',s1,'.csv'); %load 2-link select link analysis result for PM
    AM=csvread(s2);
    [a,b]=size(AM);
    for t=1:1000
        AM(1,t+2)=(g-1)*100+floor((t-1)/10)+1;
    end
    AM(:,1003:b)=[];%delete last 100 columns
    s3=strcat('TC_2link1_',s1,'.csv'); 
    csvwrite(s3,AM);
end
 AM=csvread('TC_2link1_32.csv');
 [a,b]=size(AM);
 for t=1:680
     AM(1,t+2)=3100+floor((t-1)/10)+1;
 end
 AM(:,683:b)=[];%delete last 68 columns
 csvwrite('TC_2link1_32.csv',AM);