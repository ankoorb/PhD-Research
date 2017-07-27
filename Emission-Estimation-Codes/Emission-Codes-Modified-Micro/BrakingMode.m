function [idx]=BrakingMode(spd,acc)

% Def of Braking in OpMode
% considering vehicle deceleration
% Acc(t) <= -2.0 mph-sec OR
% Acc(t) < -1.0 mph-sec & Acc(t-1) < -1.0 & Acc(t-2) < -1.0

mps2mph=2.2369362920544; %meter/sec --> mph
acc=acc.*mps2mph;
spd=spd.*mps2mph;


case1= acc <=-2.0;
case2=zeros(size(acc,1),1);
for i=1:size(acc,1)

    if i>=3
        
        if acc(i)<-1 && acc(i-1)<-1 && acc(i-2)<-1
            case2(i)=1;
        end
    end
end

idx= case1==1 | case2==1;