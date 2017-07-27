%TC ID to TM ID
TC_inbound=load('TC_inbound3.csv');
tm=load('tc-tm.txt');
[k,g]=size(tm);
[i,j]=size(TC_inbound);

%inbound TC ID to TM ID
for c=1:2
    for r=1:i-1
        for r2=1:k-1
            if tm(r2+1,2)==TC_inbound(r+1,c)
               TC_inbound(r+1,c)=tm(r2+1,1);
               break
            end
        end
    end
end
% merge repeated TM OD pairs, and delete
for r=i-1:-1:1
    
    for x=r-1:-1:1
        
           if TC_inbound(r+1,1)==TC_inbound(x+1,1) 
              if TC_inbound(r+1,2)==TC_inbound(x+1,2)
                  
                  for c=1:j-2
                     TC_inbound(x+1,c+2)=TC_inbound(r+1,c+2)+TC_inbound(x+1,c+2);
                  end
                  TC_inbound(r+1,:)=[];
                  break
              end
           end
     end
end
csvwrite('TM_inbound1.csv',TC_inbound);
%outbound TC ID to TM ID
TC_outbound=load('TC_outbound3.csv');
[b,d]=size(TC_outbound);
for c=1:2
    for r=1:b-1
        for r2=1:k-1
            if tm(r2+1,2)==TC_outbound(r+1,c)
               TC_outbound(r+1,c)=tm(r2+1,1);
               break
            end
        end
    end
end
% merge repeated TM OD pairs, and delete
for r=b-1:-1:1
    
    for x=r-1:-1:1
        
           if TC_outbound(r+1,1)==TC_outbound(x+1,1) 
              if TC_outbound(r+1,2)==TC_outbound(x+1,2)
                  
                  for c=1:d-2
                     TC_outbound(x+1,c+2)=TC_outbound(r+1,c+2)+TC_outbound(x+1,c+2);
                  end
                  TC_outbound(r+1,:)=[];
                  break
              end
           end
     end
end
csvwrite('TM_outbound1.csv',TC_outbound);

%2-link query result TC ID to TM ID
TC_2link=load('TC_2link3.csv');
[n,m]=size(TC_2link);
for c=1:2
    for r=1:n-1
        for r2=1:k-1
            if tm(r2+1,2)==TC_2link(r+1,c)
               TC_2link(r+1,c)=tm(r2+1,1);
            end
        end
    end
end
% merge repeated TM OD pairs, and delete
for r=n-1:-1:1
    
    for x=r-1:-1:1
        
           if TC_2link(r+1,1)==TC_2link(x+1,1) 
              if TC_2link(r+1,2)==TC_2link(x+1,2)
                  
                  for c=1:m-2
                     TC_2link(x+1,c+2)=TC_2link(r+1,c+2)+TC_2link(x+1,c+2);
                  end
                  TC_2link(r+1,:)=[];
                  break
              end
           end
     end
end
csvwrite('TM_2link1.csv',TC_2link);