clear all; clc
load('demands_1.txt');

port_ODs=demands_1(:,1:2);
port_ODs=zeros(size(port_ODs,1),6);
for j=1:96

temp_var=['demands_', num2str(j),'.txt'];
    decision=eval(['exist(''',temp_var ''',''file'');']);
         if decision~=0; % if not 0, it has data file.
             eval(['temp_ODs=load(''',temp_var,''');']);
             port_ODs(:,1:6)=port_ODs(:,1:6)+temp_ODs(:,3:8);
             temp_ODs=[];
         end   
             
end