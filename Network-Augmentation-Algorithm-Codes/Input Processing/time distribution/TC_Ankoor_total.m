%Build full size empty TC ankoor OD matrix
tic
AM=csvread('TC_Ankoor_AM.csv');
PM=csvread('TC_Ankoor_PM.csv');
MD=csvread('TC_Ankoor_MD.csv');
empty=[AM(:,1:2);MD(:,1:2);PM(:,1:2)];%the title of am pm and midday are the same
TC_Ankoor_empty=unique(empty, 'rows');
[a,~]=size(TC_Ankoor_empty);
TC_Ankoor_empty(:,3:12)=zeros(a,10);

xlswrite('TC_Ankoor_empty.xlsx',TC_Ankoor_empty);

%merge Am, pm, middday TC OD matrices after sub-area analysis into one
%full size matrix
TC_Ankoor_Sum=TC_Ankoor_empty;
[m,~]=size(AM);
[n,~]=size(PM);
[l,~]=size(MD);
for i=1:a-1
    for j=1:m-1
        if TC_Ankoor_Sum(i+1,1)==AM(j+1,1)
           if TC_Ankoor_Sum(i+1,2)==AM(j+1,2)
           TC_Ankoor_Sum(i+1,3:12)=AM(j+1,3:12)*5/6;
           break
           end
        end
    end
end
for i=1:a-1
    for j=1:n-1
        if TC_Ankoor_Sum(i+1,1)==PM(j+1,1)
           if TC_Ankoor_Sum(i+1,2)==PM(j+1,2)
           TC_Ankoor_Sum(i+1,3:12)=TC_Ankoor_Sum(i+1,3:12)+PM(j+1,3:12);
           break
           end
        end
    end
end
for i=1:a-1
    for j=1:l-1
        if TC_Ankoor_Sum(i+1,1)==MD(j+1,1)
           if TC_Ankoor_Sum(i+1,2)==MD(j+1,2)
           TC_Ankoor_Sum(i+1,3:12)=TC_Ankoor_Sum(i+1,3:12)+MD(j+1,3:12);
           break
           end
        end
    end
end


% merge 10 tables into 6 tables
TC_Ankoor_Sum(:,3)=TC_Ankoor_Sum(:,3)+TC_Ankoor_Sum(:,9);
TC_Ankoor_Sum(:,4)=TC_Ankoor_Sum(:,4)+TC_Ankoor_Sum(:,5);
TC_Ankoor_Sum(:,5:7)=TC_Ankoor_Sum(:,6:8);
TC_Ankoor_Sum(:,8)=TC_Ankoor_Sum(:,10)+TC_Ankoor_Sum(:,11)+TC_Ankoor_Sum(:,12);
TC_Ankoor_Sum(:,9:12)=[];

%TC ID to TM ID
TC=TC_Ankoor_Sum;

tm=xlsread('tc-tm.xlsx');
[k,~]=size(tm);
[i,j]=size(TC);

for c=1:2
    for r=1:i-1
        for r2=1:k-1
            if tm(r2+1,2)==TC(r+1,c)
               TC(r+1,c)=tm(r2+1,1);
               break
            end
        end
    end
end
% delete duplicate rows
for r=i-1:-1:1
    for x=r-1:-1:1
        if TC(r+1,1)==TC(x+1,1) 
              if TC(r+1,2)==TC(x+1,2)
                 TC(x+1,3:8)=TC(r+1,3:8)+TC(x+1,3:8);
                 TC(r+1,:)=[];
                  break
              end
           end
     end
end
xlswrite('TM_Ankoor_Sum.xlsx',TC);