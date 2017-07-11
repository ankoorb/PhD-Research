A = xlsread('C:\Users\Ankoor\Desktop\Trajectory\Trajectory.xls','Sample');

ID = unique(A(:,2));

D=cell(length(ID),1); %D(i) contains indices for the "i"th Vehicle ID 
for i=1:length(ID)
    D{i} = (find(ID(i)==A(:,4)))
end
time_in_sec=A(:,3);
time_in_sec=(D{1})
A(D{1},:)
    