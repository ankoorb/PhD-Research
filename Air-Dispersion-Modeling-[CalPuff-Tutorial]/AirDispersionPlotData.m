
clear; clc

load ('NOx.csv');
val = NOx;
x_val = val(:,1);
y_val = val(:,2);

for k = 1:2

data = val(:,k+2);

index = find(x_val == x_val(1));
x_range = index(2)-1;
y_range = length(data)/x_range;

for i = 1:x_range
    for j = 1:y_range
        
        conc(i,j,k) = data((j-1)*x_range+i);
       
    end
end
        
end

 Night = rot90(conc(:,:,1));
 Day = rot90(conc(:,:,2));
 
 %set(gca,'dataAspectRatio',[1 1 1])
%  h = colorbar;
% title(h,'Microgram/cubic meter')