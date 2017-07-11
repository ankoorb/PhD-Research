% getSpline 
% in: x[n:1],y[n:1] observed data, min(double), max(double),
%     intval(double), bPrint(bool)
% out: output[xx, yy] 
function [ output ] = getSpline1(x, y, min, max, intval, bPrint)

x = x'; % postmile
y = y'; % value (flow or speed)

[a] = find(y == -1);
if ( isempty(a) == 0 )
   fprintf(1, 'warning: empty vds data (flow or speed)\n'); 
end

xx=(min:intval:max)';
%yy = spline(x,y,xx);
yy = interp1(x,y,xx, 'pchip');

for i=1:length(yy)
   if ( yy(i) < 0 )
       yy(i)=0;
   end
end

if ( bPrint )
    plot(x,y,'o',xx,yy,'-');
end

output = [xx yy]; 
