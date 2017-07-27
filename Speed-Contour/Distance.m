% Distance between two points with coordinates(x1,y1) and (x2,y2)

% Define variables 
    % x1 -- x coordinate of first point
    % x2 -- x coordinate of second point
    % y1 -- y coordinate of first point
    % y2 -- y coordinate of second point
    % d -- distance between two points
    
% Prompt user for input
x1 = input('Enter value of x1: \n');
y1 = input('Enter value of y1: \n');
x2 = input('Enter value of x2: \n');
y2 = input('Enter value of y2: \n');

% Distance calculation

d = sqrt(((x1-x2)^2)+((y1-y2)^2));

% Display value
str = ['The distance between two points is 'num2str(d) 'units.']
disp(str);