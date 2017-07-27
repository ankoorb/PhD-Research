ramp=xlsread('ramp.xlsx');
[v,c]=size(ramp);
adt=xlsread('carson.xlsx');
[m,n]=size(adt);
for i=2:m
    for j=1:v
        if adt(i,3)==ramp(j,1)
            if ramp(j,4)==1
                for a=1:96
                    adt(i,3+a)=adt(i,2)*ramp(j,5+a);
                end
                break
            end
        end
    end
end
xlswrite('carson.xlsx',adt);