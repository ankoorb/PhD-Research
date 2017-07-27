query=load('query link list .txt');
r=1;
query2=zeros(2947,7);
for i=1:55
    for j=1:55
        if query(i+1,1)~=query(j+1,1)
           r=r+1;
           query2(r,1)=r-1;
           query2(r,2)=query(i+1,1);
           query2(r,3)=query(j+1,1);
           query2(r,4)=query(i+1,2);
           query2(r,5)=query(i+1,3);
           query2(r,6)=query(j+1,2);
           query2(r,7)=query(j+1,4);
        end
    end
end
csvwrite('2-link_query.csv',query2);
