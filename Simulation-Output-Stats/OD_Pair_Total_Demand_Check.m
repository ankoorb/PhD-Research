clear;clc;
tic
%2013-3-22, check the changes of demands after each iteration of OD
%estimation
iter=11;% Number of iterations
%create a empty OD matrix
demands=dlmread('L:\PORT(UCTC-3.0)\ODE\demand_for_update\000\demands_1.txt');
[n,m]=size(demands);
matrix=zeros(n,3+iter);
matrix(:,1:2)=demands(:,1:2);
matrix(:,3)=sum(demands(:,3:8),2);
%load seed od matrix
for t=1:iter
    for g=1:96     %61:76 is PM Peak. 1:96
        s1=int2str(t);
        s2=int2str(g);
        if t<10
        s3=strcat('L:\PORT(UCTC-3.0)\ODE\demand_for_paramics\00',s1,'\demands_',s2,'.txt');
        else
        s3=strcat('L:\PORT(UCTC-3.0)\ODE\demand_for_paramics\0',s1,'\demands_',s2,'.txt');
        end
        demands=dlmread(s3);
        matrix(:,3+t)=matrix(:,3+t)+sum(demands(:,3:8),2);
        
    end
end
for i=1:n
    if matrix(i,1:2)==[10489,10501]
        break
    end
end

plot(matrix(i,3:3+iter));
toc