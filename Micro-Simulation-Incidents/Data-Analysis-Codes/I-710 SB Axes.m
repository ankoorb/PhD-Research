function createaxes(Parent1, xdata1, ydata1, zdata1)
%CREATEAXES(PARENT1,XDATA1,YDATA1,ZDATA1)
%  PARENT1:  axes parent
%  XDATA1:  contour x
%  YDATA1:  contour y
%  ZDATA1:  contour z

%  Auto-generated by MATLAB on 05-Oct-2010 14:45:12

% Create axes
axes1 = axes('Parent',Parent1,...
    'YTickLabel',{'DEL AMO 1 ','LONG BEACH','N OF 91','ALONDRA','COMPTON','ROSECRANS 1','ROSECRANS 2','FM RTE 105','S OF 105','KING 1','KING 2','IMPERIAL 1','IMPERIAL 2','FIRESTONE 1','FIRESTONE 2','FLORENCE 2','ATLANTIC 2','WASHINGTON','S OF 5','OLYMPIC','OLYMPIC BLVD','EASTERN','THIRD','CESAR CHAVEZ AV'},...
    'YTick',[5.99 6.93 8.15 8.87 9.42 9.77 10.05 10.29 10.34 10.94 11.54 11.927 11.987 13.427 13.517 14.597 16.887 17.537 18.167 18.477 18.507 18.714 19.547 19.897],...
    'XTick',[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24],...
    'OuterPosition',[0 6.93889390390723e-018 1 1],...
    'Layer','top',...
    'FontSize',5,...
    'FontName','Calibri',...
    'CLim',[0 70]);
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 24]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[5.99 19.897]);
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'all');

% Create contour
contour(xdata1,ydata1,zdata1,'LineColor',[0 0 0],'Fill','on','Parent',axes1);

% Create xlabel
xlabel('Time (Hour)');

% Create ylabel
ylabel('Postmile');

% Create title
title('Speed Contour Plot for I-710 S (February 1, 2005)');

