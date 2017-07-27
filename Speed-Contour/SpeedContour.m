clear

A=xlsread('C:\Documents and Settings\ankoor\Desktop\Matlab Programming\SpeedContour\2010.xls','Report Data');

% Define Variables
 
TimeStamp = A(:,1)/60; %Time in hours.
Postmile = A(:,2);
Speed = A(:,3);
 
% Finding Range of Postmile and Time

Index = find(Postmile==Postmile(1));
PostmileRange=Index(2)-1; %Find length of postmile range
TimeRange=length(Speed)/PostmileRange;
 
% Create Speed Matrix of dimensions PostMileRange x TimeRange
 
for i=1:PostmileRange
    for j=1:TimeRange
        SpeedMatrix(i,j) = Speed((j-1)*PostmileRange+i);
    end
end

contourf(TimeStamp(1:PostmileRange:length(TimeStamp)),Postmile(1:PostmileRange), SpeedMatrix,7)