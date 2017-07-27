%add title as query numbers
link1=load('link1.txt');
for g=1:55
    s1=int2str(g);
    s2=strcat('TC_2link3_',s1,'.csv'); %load 2-link select link analysis result for PM
    PM=load(s2);
    Q1=link1(g,5)+1;
    Q2=link1(g+1,5);
    Q3=(Q2-Q1+1); %#of queries
    for i=1:Q3
        for t=(10*i-9):(10*i)
        PM(1,t+2)=i+Q1-1;
        end
    end
    s3=strcat('TC_2link3_',s1,'.csv'); 
    csvwrite(s3,PM);
end
%delete last 53 or 54 columns
for g=1:55
    s1=int2str(g);
    s2=strcat('TC_2link3_',s1,'.csv');
    PM=load(s2);
    [i,j]=size(PM);
    for a=3:j
        if PM(1,a)==0
           break
        end
    end
    PM(:,a:j)=[];
    s3=strcat('TC_2link3_',s1,'.csv');
    csvwrite(s3,PM);
end