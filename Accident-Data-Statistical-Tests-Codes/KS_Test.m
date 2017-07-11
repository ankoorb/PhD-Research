
% x = n;
% y = s;

% Null Hypothesis = x and y are from same continuous distribution
% h = 1 if test rejects the null at 5% significance level

[h,p,k] = kstest2(x,y)

F1 = cdfplot(x);

hold on
F2 = cdfplot(y);

set(F1,'LineWidth',2,'Color','r')
set(F2,'LineWidth',2, 'Color','b')

% legend([F1 F2],'06-Q4 Car Acc','07-Q4 Car Acc','Location','SE')

% hold on
% F2 = cdfplot(y);
% F3 = cdfplot(z);
% F4 = cdfplot(w);
% set(F1,'LineWidth',2,'Color','r')
% set(F2,'LineWidth',2, 'Color','g')
% set(F3,'LineWidth',2, 'Color','b')
% set(F4,'LineWidth',2, 'Color','y')
% legend([F1 F2 F3 F4],'Winter','Spring','Summer','Fall','Location','SE')

% F1 = cdfplot(x);
% hold on
% F2 = cdfplot(y);
% set(F1,'LineWidth',2,'Color','r')
% set(F2,'LineWidth',2)
% legend([F1 F2],'NB','SB','Location','NW')



% F1 = cdfplot(x);
% Y-axis is cumulative fraction
% hold on
% F2 = cdfplot(y)
% set(F1,'LineWidth',2,'Color','r')
% set(F2,'LineWidth',2)
% legend([F1 F2],'F1(x)','F2(x)','Location','NW')



% h = cdfplot(x);
% y = get(h,'YData');
% y = unique(y);