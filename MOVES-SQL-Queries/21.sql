CREATE TABLE win_mean_test_out.emmissions_summary AS
SELECT SUBSTRING(tab1.linkID,1,2) vehclass, tab1.fuelTypeID, SUBSTRING(tab1.linkID,3,2) opid, 
 tab1.emissionQuant em1,
 tab2.emissionQuant em2,
 tab3.emissionQuant em3,
 tab4.emissionQuant em90,
 tab5.emissionQuant em91,
 tab6.emissionQuant em98,
 tab7.emissionQuant em100,
 tab8.emissionQuant em110
FROM
 win_mean_test_out.movesoutput tab1,
 win_mean_test_out.movesoutput tab2,
 win_mean_test_out.movesoutput tab3,
 win_mean_test_out.movesoutput tab4,
 win_mean_test_out.movesoutput tab5,
 win_mean_test_out.movesoutput tab6,
 win_mean_test_out.movesoutput tab7,
 win_mean_test_out.movesoutput tab8
WHERE tab1.pollutantID = 1
AND tab2.pollutantID = 2
AND tab3.pollutantID = 3
AND tab4.pollutantID = 90
AND tab5.pollutantID = 91
AND tab6.pollutantID = 98
AND tab7.pollutantID = 100
AND tab8.pollutantID = 110
-- 3, 90, 91, 98, 100, 110
AND tab1.linkID = tab2.linkID
AND tab1.fuelTypeID = tab2.fuelTypeID
AND tab1.linkID = tab3.linkID
AND tab1.fuelTypeID = tab3.fuelTypeID
AND tab1.linkID = tab4.linkID
AND tab1.fuelTypeID = tab4.fuelTypeID
AND tab1.linkID = tab5.linkID
AND tab1.fuelTypeID = tab5.fuelTypeID
AND tab1.linkID = tab6.linkID
AND tab1.fuelTypeID = tab6.fuelTypeID
AND tab1.linkID = tab7.linkID
AND tab1.fuelTypeID = tab7.fuelTypeID
AND tab1.linkID = tab8.linkID
AND tab1.fuelTypeID = tab8.fuelTypeID
ORDER BY tab1.linkID, fuelTypeID
