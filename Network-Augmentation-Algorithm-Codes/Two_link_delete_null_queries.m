%load 55 query results and delete queries whose cells are all zero value
c=2;%count number of non-zero queries
for g=1:55
    s1=int2str(g);
    s2=strcat('TC_2link3_',s1,'.csv');
    TC=load(s2);
    sums=sum(TC);
    [w,v]=size(TC);
    for i=1:v
        sums(1,i)=sums(1,i)-TC(1,i);
    end
    for i=v-2:-6:1
        if sums(1,i+2)+sums(1,i+1)+sums(1,i)+sums(1,i-1)+sums(1,i-2)+sums(1,i-3)==0
           TC(:,i-3:i+2)=[];
        end
    end
    s3=strcat('TC_2link3_',s1,'.csv');
    csvwrite(s3,TC);
    [m,n]=size(TC);
    c=c+n-2;
    
end
csvwrite('count_queries.csv',c)
%count number of non-zero queries