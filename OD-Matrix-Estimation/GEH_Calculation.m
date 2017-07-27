i=1:2:size(Data,2);
j=2:2:size(Data,2);
k = size(i,2);
Diff = zeros(28,k);

for m = 1:k
    
    Diff(:,m)=Data(:,i(m))-Data(:,j(m));
    Per(:,m)= ((Data(:,i(m))-Data(:,j(m)))./Data(:,i(m)));
end