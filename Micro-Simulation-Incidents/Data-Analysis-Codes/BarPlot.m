
subplot(2,3,1);
bar(x(4,:),'b');
xlabel('Hour'); 
ylabel('Probability'); 
title('(a) 2005 I-710 Car Accident Probability'); 
grid on;

subplot(2,3,2);
bar(x(5,:),'b');
xlabel('Hour'); 
ylabel('Probability'); 
title('(b) 2006 I-710 Car Accident Probability'); 
grid on;

subplot(2,3,3);
bar(x(6,:),'b');
xlabel('Hour'); 
ylabel('Probability'); 
title('(c) 2007 I-710 Car Accident Probability'); 
grid on;

subplot(2,3,4);
bar(x(1,:),'r');
xlabel('Hour'); 
ylabel('Probability'); 
title('(d) 2005 I-710 Truck Accident Probability'); 
grid on;

subplot(2,3,5);
bar(x(2,:),'r');
xlabel('Hour'); 
ylabel('Probability'); 
title('(e) 2006 I-710 Truck Accident Probability'); 
grid on;

subplot(2,3,6);
bar(x(3,:),'r');
xlabel('Hour'); 
ylabel('Probability'); 
title('(f) 2007 I-710 Truck Accident Probability'); 
grid on;
% 
% %bar3(a,0.5,'detached');
% %bar3(a,'detached');
% %bar(a, 'grouped')
% % xlabel('Hour'); 
% % ylabel('Month'); 
% % title('I-710 SB (2005)'); 
% 
% %set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]);
% 
% 
% a = x;
% b = y;
% c = z;
% 
% subplot(1,3,1);
% bar(a,'y');
% xlabel('Hour'); 
% ylabel('Probability'); 
% title('I-710 SB (2005 TA Probability)'); 
% grid on;
% 
% subplot(1,3,2);
% bar(b,'y');
% xlabel('Hour'); 
% ylabel('Probability'); 
% title('I-710 SB (2006 TA Probability)'); 
% grid on;
% 
% subplot(1,3,3);
% bar(c,'y');
% xlabel('Hour'); 
% ylabel('Probability'); 
% title('I-710 SB (2007 TA Probability)'); 
% grid on;
% 
% 
% a = x';
% b = y';
% c = z';
% 
% subplot(1,3,1);
% contourf(a);
% xlabel('Month'); 
% ylabel('Hour'); 
% title('(a) 2005 I-110 Truck VMT%'); 
% grid on;
% 
% subplot(1,3,2);
% contourf(b);
% xlabel('Month'); 
% ylabel('Hour'); 
% title('(b) 2006 I-110 Truck VMT%'); 
% grid on;
% 
% subplot(1,3,3);
% contourf(c);
% xlabel('Month'); 
% ylabel('Hour'); 
% title('(c) 2007 I-110 Truck VMT%'); 
% grid on;


% a = x;
% b = y;
% c = z;
% d = u;
% e = v;
% f = w;
% subplot(3,2,1);
% bar3(a,'detached');
% xlabel('Hour'); 
% ylabel('Month'); 
% zlabel('VMT');
% title('(a) 2005 I-710 N VMT'); 
% grid on;
% 
% subplot(3,2,2);
% bar3(b,'detached');
% xlabel('Hour'); 
% ylabel('Month'); 
% zlabel('VMT');
% title('(b) 2006 I-710 N VMT'); 
% grid on;
% 
% subplot(3,2,3);
% bar3(c,'detached');
% xlabel('Hour'); 
% ylabel('Month');
% zlabel('VMT');
% title('(c) 2007 I-710 N VMT'); 
% grid on;
% subplot(3,2,4);
% bar3(a,'detached');
% xlabel('Hour'); 
% ylabel('Month'); 
% zlabel('VMT');
% title('(d) 2005 I-710 S VMT'); 
% grid on;
% 
% subplot(3,2,5);
% bar3(b,'detached');
% xlabel('Hour'); 
% ylabel('Month'); 
% zlabel('VMT');
% title('(e) 2006 I-710 S VMT'); 
% grid on;
% 
% subplot(3,2,6);
% bar3(c,'detached');
% xlabel('Hour'); 
% ylabel('Month');
% zlabel('VMT');
% title('(f) 2007 I-710 S VMT'); 
% grid on;