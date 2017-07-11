%clear
A = xlsread('c:\Users\Ankoor\Desktop\I710S.xlsx');



Postmile = A(:,1);
TimeStamp = A(:,2)/60; %Time in hours.
Speed = A(:,3);


tmp=find(Postmile==Postmile(1));
PostMileRange=tmp(2)-1; %Find length of postmile range
TimeRange=length(Speed)/PostMileRange;

%Create Speed Matrix of dimensions PostMileRange x TimeRange

for i=1:PostMileRange
    for j=1:TimeRange
        SpeedMatrix(i,j) = Speed((j-1)*PostMileRange+i);
    end
end

contourf(TimeStamp(1:PostMileRange:length(TimeStamp)),Postmile(1:PostMileRange), SpeedMatrix)
