%create an empty 1 file of all 55 2-link query results
count=load('count_queries.csv'); %This is the number of columns of the empty file
    
%copy 55query results into this empty file
link1=load('link1.txt');
link2=load('link2.txt');
link3=load('link3.txt');
TC0=load('TC0.csv');
[w,v]=size(TC0); %  unique OD pairs
TC=zeros(w+1,count(1,1));
%copy od pairs from uniqe od pairs
for i=1:w
    for j=1:2
        TC(i+1,j)=TC0(i,j);
    end
end

%copy all 55 query files' titles and center fields
d=2;
for k=1:55
    s1=int2str(k);
    s2=strcat('TC_2link3_',s1,'.csv');
    x=load(s2);
    [a,b]=size(x);
    if b>2
       TC(1,d+1:d+b-2)=x(1,3:b);
       
       for xod=1:a-1
           for TCod=1:w
               if x(xod+1,1)==TC(TCod+1,1)
                   if x(xod+1,2)==TC(TCod+1,2)
                      TC(TCod+1,d+1:d+b-2)=x(xod+1,3:b);
                   end
               end
           end
       end
    d=d+b-2;   
    end
end

%merge query results belonging to the same deleted node
for i=1:6:count(1,1)-8
    for q=1:2946
    if link2(q+1,1)==TC(1,i+2)
       if link2(q+1,4)==1
          for j=i+6:6:count(1,1)-2
              if TC(1,j+2)==link2(q+2,1)
                 TC(2:w+1,j+2:j+7)=TC(2:w+1,j+2:j+7)+TC(2:w+1,i+2:i+7);
              end
           end
        end
     end
     end
end
%delete repeat queries
for i=count(1,1)-2:-6:1
    for j=1:2946
        if link3(j+1,1)==TC(1,i+2)
           if link3(j+1,4)==1
              TC(:,i-3:i+2)=[];
           end
        end
    end
end
    
csvwrite('TC_2link3.csv',TC);