pems=xlsread('kevin_SR91W.xlsx');
[i,j]=size(pems);
ramp=xlsread('ramp-arterial_check2.xlsx');
[m,n]=size(ramp);

for b=1:m
        for a=2:288:i
        if pems(a,1)==ramp(b,4)
            V=pems(a:a+287,5);
            ramp(b,6)=sum(V);
            for c=1:96
                W=pems(a+3*c-3:a+3*c-1,5);
                ramp(b,6+c)=sum(W)/ramp(b,6);
            end
            break
        end
    end
end
xlswrite('ramp-arterial_check2.xlsx',ramp);