% Aggregate VMT by time period for LDV (1, 2), LDT (3, 4, 5, 6), MDT (7, 8)
% HDT (9, 10, 11, 12, 13, 14, 15, 16), Port HDT (17)
% Author: Ankoor 
% Date: November 18

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    LDV=zeros(96,2);
    LDT=zeros(96,2);
    MDT=zeros(96,2);
    HDT=zeros(96,2);
    PHDT=zeros(96,2);
    
    for i=1:2
        s1=int2str(i);
        s2=strcat('Veh_Count_Class_',s1,'.csv'); % Col-1: Art, Col-2: Fwy
        
        VMTLDV = load(s2);
        temp_VMTLDV = VMTLDV(:,1:2);
        LDV = LDV + temp_VMTLDV;
    end
   
    s3=strcat('LDV_Count.csv');
    csvwrite(s3,LDV);
    
    for i=3:6
        s1=int2str(i);
        s2=strcat('Veh_Count_Class_',s1,'.csv'); % Col-1: Art, Col-2: Fwy
        
        VMTLDT = load(s2);
        temp_VMTLDT = VMTLDT(:,1:2);
        LDT = LDT + temp_VMTLDT;
    end
   
    s4=strcat('LDT_Count.csv');
    csvwrite(s4,LDT);
   
        for i=7:8
        s1=int2str(i);
        s2=strcat('Veh_Count_Class_',s1,'.csv'); % Col-1: Art, Col-2: Fwy
        
        VMTMDT = load(s2);
        temp_VMTMDT = VMTMDT(:,1:2);
        MDT = MDT + temp_VMTMDT;
    end
   
    s5=strcat('MDT_Count.csv');
    csvwrite(s5,MDT);

        for i=9:16
        s1=int2str(i);
        s2=strcat('Veh_Count_Class_',s1,'.csv'); % Col-1: Art, Col-2: Fwy
        
        VMTHDT = load(s2);
        temp_VMTHDT = VMTHDT(:,1:2);
        HDT = HDT + temp_VMTHDT;
    end
   
    s6=strcat('HDT_Count.csv');
    csvwrite(s6,HDT);
    
    s1=int2str(17);
    s2=strcat('Veh_Count_Class_',s1,'.csv'); % Col-1: Art, Col-2: Fwy    
    PHDT = load(s2);
    s7=strcat('PHDT_Count.csv');
    csvwrite(s7,PHDT);

