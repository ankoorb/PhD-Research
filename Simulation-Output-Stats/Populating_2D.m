clear; clc

load ('UTM_Coordinates.csv')
UTM = UTM_Coordinates;
x_val = UTM(:,2);
y_val = UTM(:,3);

data = UTM(:,1);

index = find(x_val == x_val(1));
x_range = index(2)-1;
y_range = length(data)/x_range;

for i = 1:x_range %x 
    for j = 1:y_range % y 
        %conc(j,i) = data((j-1)*x_range+i);
        conc(i,j) = data((j-1)*x_range+i);
    end
end

A = rot90(conc);
B = rot90(conc,2);
C = rot90(conc,3);
D = rot90(conc,-1);
E = rot90(conc,-2);






%set(gca,'dataAspectRatio',[1 1 1])