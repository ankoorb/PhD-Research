%%PART ONE. Common-new pairs%%
%load common node ID list
Common=load('Common_ID.txt');
%number of common IDs
[i,j]=size(Common);
%inbound
for g=1:1  %AM,PM,mid-day, g=1:3
    s1=int2str(g);
    s2=strcat('TM_inbound',s1,'.csv');
    % Load TransCAD Critical Matrix Query file
    % number only,no title
    TC=load(s2);
    % Size of TransCAD Critical Matrix Query file
    [m,n]=size(TC);
    
    Proportion = zeros(m,n);
    Sums=zeros(i+1,n-1);
    j=1;
    for a=1:i %common node 1-i
        for b=1:m-1  %Destinations 1 - (m-1)
            if TC(b+1,2)==Common(a,1)
               for c=1:n-2 %number of queries n-2
                Sums(a+1,c+1)=Sums(a+1,c+1)+TC(b+1,c+2);
               end
            end
        end
    end
    for a=1:i  %common node 1-i
        for  b=1:m-1    %Destinations 1 - (m-1)
             if TC(b+1,2)==Common(a,1)
                 Proportion(j+1,1)=TC(b+1,1);
                 Proportion(j+1,2)=TC(b+1,2);
                                  
                for c=1:n-2   %number of queries n-2
                    if Sums(a+1,c+1)>0
                    Proportion(j+1,c+2)=TC(b+1,c+2)/Sums(a+1,c+1);
                    else Proportion(j+1,c+2)=0;
                    end
                end
                j=j+1;
             end
        end
    end
    Proportion_AM_D_size=j;
    for c=1:n-2   %number of queries n-2
        Proportion(1,c+2)=TC(1,c+2);
    end
    
  s3=strcat('Proportion_D',s1,'.csv');
  csvwrite(s3,Proportion)

end
%outbound

for g=1:1  
    s1=int2str(g);
    s2=strcat('TM_outbound',s1,'.csv');
    % Load TransCAD Critical Matrix Query (1, 2, …) file
    % number only,no title
    TC=load(s2);
    % Size of TransCAD Critical Matrix Query (1, 2, …)
    [m,n]=size(TC);
    
    Proportion = zeros(m,n);
    Sums=zeros(i+1,n-1);
    j=1;
    for a=1:i %common node 1-i
        for b=1:m-1  %Origins 1 - (m-1)
            if TC(b+1,1)==Common(a,1)
               for c=1:n-2 %number of queries n-2
                Sums(a+1,c+1)=Sums(a+1,c+1)+TC(b+1,c+2);
               end
            end
        end
    end
    for a=1:i   %common node 1-i
        for  b=1:m-1   %Origins 1 - (m-1)
             if TC(b+1,1)==Common(a,1)
                 Proportion(j+1,1)=TC(b+1,1);
                 Proportion(j+1,2)=TC(b+1,2);
                for c=1:n-2
                    if Sums(a+1,c+1)>0
                    Proportion(j+1,c+2)=TC(b+1,c+2)/Sums(a+1,c+1);
                    else Proportion(j+1,c+2)=0;
                    end
                
                end
                j=j+1; 
             end
        end
    end
    Proportion_AM_O_size=j;
    for c=1:n-2   %number of queries n-2
        Proportion(1,c+2)=TC(1,c+2);
    end
  s3=strcat('Proportion_O',s1,'.csv');
  csvwrite(s3,Proportion)

end


for g=1:1  
    s2=int2str(g);
    s3=strcat('Proportion_O',s2,'.csv');
    s4=strcat('Proportion_D',s2,'.csv');
    
    TC_D=load(s4);
    TC_O=load(s3);
    for h=1:10 %number of Gunwoo's 15min matrix, 2 for example.
    s0=int2str(h);
    s1=strcat('Gunwoo_OD',s2,'_',s0,'.csv');
    %Gunwoo’s 15min matrix
    Gunwoo=load(s1);
    [w,v]=size(Gunwoo);
    Ankoor=load('Ankoor_OD.csv'); %empty OD matrix, first row is (1,2,3,4,5,6,7,8), second column is Ankoor's Destination ID, first column is Ankoor' Origin ID
    [p,q]=size(Ankoor);
    [a1,a2]=size(TC_O);
    [b1,b2]=size(TC_D);
    %%%Common node is Origin
    for a=1:i   %common node 1-i
        for d=1:Proportion_AM_O_size-1 %row of TC_O
            if TC_O(d+1,1)==Common(a,1)
               for b=1:449:p-1 %first column of Ankoor OD matrix, 455 is the #of Ankoor nodes
                   if Ankoor(b+1,1)==Common(a,1)
                      for c=b:b+448 %second column of Ankoor OD matrix,455 #of nodes in Ankoor OD matrix
                           if Ankoor(c+1,2)==TC_O(d+1,2)
                               for r=1:6:a2-2 %column of TC_O, 6is #of submatrix
                                   for f=1:270:w-1  %first row of Gunwoo's OD matrix,270 is the #of Gunwoo nodes
                                       if Gunwoo(f+1,1)==Common(a,1)
                                           for e=f:f+269 %second row of Gunwoo's OD matrix,270 is the #of Gunwoo nodes
                                               if Gunwoo(e+1,2)==TC_O(1,r+2)
                                                  for j=1:6  %submatrix 1-6
                                                      Ankoor(c+1,j+2)=Ankoor(c+1,j+2)+Gunwoo(e+1,j+2)*TC_O(d+1,r+j+1);
                                                  end
                                               end
                                           end
                                           
                                       end
                                   end
                               end
                           end
                       end
                    end
                end
            end
        end
    end
    
    %%%common node is Destination
    for a=1:i   %common node 1-i
        for d=1:Proportion_AM_D_size-1 %row of TC_O
            if TC_D(d+1,2)==Common(a,1)
               for b=1:449 %second column of Ankoor OD matrix, 6 for example, 455 is the #of Ankoor nodes
                   if Ankoor(b+1,2)==Common(a,1)
                      for c=b:449:p-1 %first column of Ankoor OD matrix,6 for example 455 for Ankoor OD matrix
                           if Ankoor(c+1,1)==TC_D(d+1,1)
                               for r=1:6:b2-2 %column of TC_O, 6 is #of submatrix
                                   for f=1:270  %second column of Gunwoo's OD matrix,6 for example, 270 is the #of Gunwoo nodes
                                       if Gunwoo(f+1,2)==Common(a,1)
                                           for e=f:270:w-1 %first column of Gunwoo's OD matrix,6 for example, 270 is the #of Gunwoo nodes
                                               if Gunwoo(e+1,1)==TC_D(1,r+2)
                                                  for j=1:6  %submatrix 1-6
                                                      Ankoor(c+1,j+2)=Ankoor(c+1,j+2)+Gunwoo(e+1,j+2)*TC_D(d+1,r+j+1);
                                                  end
                                               end
                                           end
                                           
                                       end
                                   end
                               end
                           end
                       end
                    end
                end
            end
        end
    end
           
    s5=strcat('Ankoor_OD_newA',s2,'_',s0,'.csv');
    csvwrite(s5,Ankoor);
    end
end

%Common-Common pairs %%                           
for g=1:1  
    s2=int2str(g);
      
    for h=1:10 %number of Gunwoo's 15min matrix                             
        s0=int2str(h);
        s3=strcat('Ankoor_OD_newA',s2,'_',s0,'.csv');
        s1=strcat('Gunwoo_OD',s2,'_',s0,'.csv');
        Ankoor=load(s3);
        %Gunwoo’s 15min matrix
        Gunwoo=load(s1);
        [w,v]=size(Gunwoo);
        for a=1:i   %common node 1-i
            for b=1:270:w-1  %% Gunwoo first row, 6 for example, 270 for #of Gunwoo node
                if Gunwoo(b+1,1)==Common(a,1)
                    for c=1:i  %% common node 1-i 
                        for d=b:b+269 %% Gunwoo second row, 6 for example, 269 for #of Gunwoo node
                              if Gunwoo(d+1,2)==Common(c,1)
                                  for f=1:449:p-1  %% Ankoor first row, 6 for example, 455 for ankoor
                                      if Ankoor(f+1,1)==Common(a,1)
                                          for k=f:f+448 %% Ankoor second row, 6 for example, 455 for ankoor
                                              if Ankoor(k+1,2)==Common(c,1)
                                                 for r=1:6 % submatrix 1-6
                                                  Ankoor(k+1,r+2)=Gunwoo(d+1,r+2);
                                                 end
                                              end
                                          end
                                      end
                                  end
                              end
                         end
                    end
                end
             end
        end
            
        
        s5=strcat('Ankoor_OD_newB',s2,'_',s0,'.csv');
        csvwrite(s5,Ankoor);
    end
end
 
%%new-new pairs%%
Query=csvread('Query_ID2.csv');
[z,x]=size(Query);
for g=1:1   %AM,PM,mid-day, g=1:3
       s2=int2str(g);   
    for h=1:10 %number of Gunwoo's 15min matrix                             
        s0=int2str(h);
        s3=strcat('Ankoor_OD_newB',s2,'_',s0,'.csv');
        s1=strcat('Gunwoo_OD',s2,'_',s0,'.csv');
        Ankoor=load(s3);
        %Gunwoo’s 15min matrix
        Gunwoo=load(s1);
        [w,v]=size(Gunwoo);
            s4=strcat('TM_2link1.csv');
            TC_2link=load(s4);
            [i,j]=size(TC_2link);
                        
            Sums=sum(TC_2link);
            for r=1:j-2
            Sums(1,r+2)=Sums(1,r+2)-TC_2link(1,r+2);
            end  
            for c=1:6:j-2  %# of query
                for r=1:3168  %number of queries
                    if Query(r+1,1)==TC_2link(1,c+2)
                       for a=1:270:w-1  %first column of Gunwoo OD matrix,6 for example, 270 for Gunwoo
                           if Gunwoo(a+1,1)==Query(r+1,2)
                              for b=a:a+269  % 5 for example, 269 for Gunwoo
                                  if Gunwoo(b+1,2)==Query(r+1,3)
                                     for d=1:6 %submatrix 1-6
                                         if Sums(1,c+1+d)>0
                                            for t=1:i-1 %row of TC_2link
                                                TC_2link(t+1,c+1+d)=TC_2link(t+1,c+1+d)*Gunwoo(b+1,d+2)/Sums(1,c+1+d);
                                            end
                                         end
                                     end
                                  end
                               end
                            end
                        end
                    end
                end
            end
        
        
            for r=1:i-1 %first column of TC_2link
                for a=1:449:p-1 % 6 for example, 455 for Ankoor
                    if Ankoor(a+1,1)==TC_2link(r+1,1)
                        for b=a:a+448 % 455 for Ankoor
                            if Ankoor(b+1,2)==TC_2link(r+1,2)
                               for c=1:6 %submatrix 1-6
                                   for t=1:6:j-2 % column of TC_2link, submatrix 1-6
                                       Ankoor(b+1,c+2)=Ankoor(b+1,c+2)+TC_2link(r+1,t+c+1);
                                   end
                               end
                            end
                        end
                    end
                end
            end
        
                
                 
        s5=strcat('Ankoor_OD_newC',s2,'_',s0,'.csv');
        csvwrite(s5,Ankoor);
    
    end
end 