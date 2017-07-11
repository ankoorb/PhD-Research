clear

A = xlsread('C:\Users\Ankoor\Desktop\Micro-Simulating Truck Accidents\710TD4\710NB.xlsx','Report Data');

% Define Variables
 
TimeStamp = A(:,2); % If Time is given in 5 mins then /60 -> Time in hours.
Postmile = A(:,3);
Speed = A(:,6);
 
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

contourf(TimeStamp(1:PostmileRange:length(TimeStamp)),Postmile(1:PostmileRange), SpeedMatrix,10)

hold on

B = xlsread('C:\Users\Ankoor\Desktop\Micro-Simulating Truck Accidents\710TD4\710NB.xlsx','Info');

x = B(:,6);
y = B(:,8);

plot (x,y,'s')

hold off 
