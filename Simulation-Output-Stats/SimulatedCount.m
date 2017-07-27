% Code to create Simulated Count from TransModeler Output.

% Reading Point Sensor Data
Count = load('PointCount.txt');
Sensor = load('Detector.txt');


alpha = 0.5;
n=96;
data=a;
data(2:n-1) = alpha*data(2:n-1) + (1-alpha)*0.5*(data(1:n-2)+data(3:n));
plot(a);
%data(2:n-1) = alpha*data(2:n-1) + (1-alpha)*0.5*(data(1:n-2)+data(3:n));
%data(2:n-1) = alpha*data(2:n-1) + (1-alpha)*0.5*(data(1:n-2)+data(3:n));
%data(2:n-1) = alpha*data(2:n-1) + (1-alpha)*0.5*(data(1:n-2)+data(3:n));
%plot(a);
hold on
plot(data);