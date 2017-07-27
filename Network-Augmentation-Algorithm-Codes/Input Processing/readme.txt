1. Open folder "Data transfer". For inbound, outbound and 2-link query results, run Fill_blanks.m (this code is for PM, you may need to change loading path a little bit according to Midday files' names)

2. For inbound and outbound, run One_link_alltransfer.m

3. For 2_link query results, run Two_link_add_title.m, then run Two_link_mergetables.m, then run Two_link_delete_null_queries.m, then run Two_link_builder.m.Remember the c value. Run link2_link3_generater.m, change link2.xlsx and link3.xlsx manually.

3-2.Then run Two_link_mergequeries.m.change count value equals to c first.
    run check.m

4. if check is correct, run tc-tm.m

5. copy TM_inbound1.csv, TM_outbound1.csv and TM_2link1.csv to folder "OD extension".

6. Insert first row as title to Midday Gunwoo OD matrices, using excel. The title should has 8 cells, all are 0. Copy them to folder "OD extension".

7. run Proportion_Midday.m, Ankoor_OD_newC1_1 to Ankoor_OD_newC1_24 are the final results. 
change #ankoor nodes, current value is 449
change#2-link qurries, current value is 3168