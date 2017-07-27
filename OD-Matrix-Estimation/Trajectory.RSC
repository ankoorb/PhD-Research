//
// loading existing OD matrix files and OD text file generated from OD toolbox
//

Macro "Load Matrix"

shared d_matrix_options
direct="L:\\Port(UCTC)\\output\\Traj_Test_Data\\"
dim m[96]

m[1] = OpenMatrix(direct+"OD_0000_0015.mtx", "True")
m[2] = OpenMatrix(direct+"OD_0015_0030.mtx", "True")
m[3] = OpenMatrix(direct+"OD_0030_0045.mtx", "True")
m[4] = OpenMatrix(direct+"OD_0045_0100.mtx", "True")
m[5] = OpenMatrix(direct+"OD_0100_0115.mtx", "True")
m[6] = OpenMatrix(direct+"OD_0115_0130.mtx", "True")
m[7] = OpenMatrix(direct+"OD_0130_0145.mtx", "True")
m[8] = OpenMatrix(direct+"OD_0145_0200.mtx", "True")
m[9] = OpenMatrix(direct+"OD_0200_0215.mtx", "True")
m[10] = OpenMatrix(direct+"OD_0215_0230.mtx", "True")
m[11] = OpenMatrix(direct+"OD_0230_0245.mtx", "True")
m[12] = OpenMatrix(direct+"OD_0245_0300.mtx", "True")
m[13] = OpenMatrix(direct+"OD_0300_0315.mtx", "True")
m[14] = OpenMatrix(direct+"OD_0315_0330.mtx", "True")
m[15] = OpenMatrix(direct+"OD_0330_0345.mtx", "True")
m[16] = OpenMatrix(direct+"OD_0345_0400.mtx", "True")
m[17] = OpenMatrix(direct+"OD_0400_0415.mtx", "True")
m[18] = OpenMatrix(direct+"OD_0415_0430.mtx", "True")
m[19] = OpenMatrix(direct+"OD_0430_0445.mtx", "True")
m[20] = OpenMatrix(direct+"OD_0445_0500.mtx", "True")
m[21] = OpenMatrix(direct+"OD_0500_0515.mtx", "True")
m[22] = OpenMatrix(direct+"OD_0515_0530.mtx", "True")
m[23] = OpenMatrix(direct+"OD_0530_0545.mtx", "True")
m[24] = OpenMatrix(direct+"OD_0545_0600.mtx", "True")
m[25] = OpenMatrix(direct+"OD_0600_0615.mtx", "True")
m[26] = OpenMatrix(direct+"OD_0615_0630.mtx", "True")
m[27] = OpenMatrix(direct+"OD_0630_0645.mtx", "True")
m[28] = OpenMatrix(direct+"OD_0645_0700.mtx", "True")
m[29] = OpenMatrix(direct+"OD_0700_0715.mtx", "True")
m[30] = OpenMatrix(direct+"OD_0715_0730.mtx", "True")
m[31] = OpenMatrix(direct+"OD_0730_0745.mtx", "True")
m[32] = OpenMatrix(direct+"OD_0745_0800.mtx", "True")
m[33] = OpenMatrix(direct+"OD_0800_0815.mtx", "True")
m[34] = OpenMatrix(direct+"OD_0815_0830.mtx", "True")
m[35] = OpenMatrix(direct+"OD_0830_0845.mtx", "True")
m[36] = OpenMatrix(direct+"OD_0845_0900.mtx", "True")
m[37] = OpenMatrix(direct+"OD_0900_0915.mtx", "True")
m[38] = OpenMatrix(direct+"OD_0915_0930.mtx", "True")
m[39] = OpenMatrix(direct+"OD_0930_0945.mtx", "True")
m[40] = OpenMatrix(direct+"OD_0945_1000.mtx", "True")
m[41] = OpenMatrix(direct+"OD_1000_1015.mtx", "True")
m[42] = OpenMatrix(direct+"OD_1015_1030.mtx", "True")
m[43] = OpenMatrix(direct+"OD_1030_1045.mtx", "True")
m[44] = OpenMatrix(direct+"OD_1045_1100.mtx", "True")
m[45] = OpenMatrix(direct+"OD_1100_1115.mtx", "True")
m[46] = OpenMatrix(direct+"OD_1115_1130.mtx", "True")
m[47] = OpenMatrix(direct+"OD_1130_1145.mtx", "True")
m[48] = OpenMatrix(direct+"OD_1145_1200.mtx", "True")
m[49] = OpenMatrix(direct+"OD_1200_1215.mtx", "True")
m[50] = OpenMatrix(direct+"OD_1215_1230.mtx", "True")
m[51] = OpenMatrix(direct+"OD_1230_1245.mtx", "True")
m[52] = OpenMatrix(direct+"OD_1245_1300.mtx", "True")
m[53] = OpenMatrix(direct+"OD_1300_1315.mtx", "True")
m[54] = OpenMatrix(direct+"OD_1315_1330.mtx", "True")
m[55] = OpenMatrix(direct+"OD_1330_1345.mtx", "True")
m[56] = OpenMatrix(direct+"OD_1345_1400.mtx", "True")
m[57] = OpenMatrix(direct+"OD_1400_1415.mtx", "True")
m[58] = OpenMatrix(direct+"OD_1415_1430.mtx", "True")
m[59] = OpenMatrix(direct+"OD_1430_1445.mtx", "True")
m[60] = OpenMatrix(direct+"OD_1445_1500.mtx", "True")
m[61] = OpenMatrix(direct+"OD_1500_1515.mtx", "True")
m[62] = OpenMatrix(direct+"OD_1515_1530.mtx", "True")
m[63] = OpenMatrix(direct+"OD_1530_1545.mtx", "True")
m[64] = OpenMatrix(direct+"OD_1545_1600.mtx", "True")
m[65] = OpenMatrix(direct+"OD_1600_1615.mtx", "True")
m[66] = OpenMatrix(direct+"OD_1615_1630.mtx", "True")
m[67] = OpenMatrix(direct+"OD_1630_1645.mtx", "True")
m[68] = OpenMatrix(direct+"OD_1645_1700.mtx", "True")
m[69] = OpenMatrix(direct+"OD_1700_1715.mtx", "True")
m[70] = OpenMatrix(direct+"OD_1715_1730.mtx", "True")
m[71] = OpenMatrix(direct+"OD_1730_1745.mtx", "True")
m[72] = OpenMatrix(direct+"OD_1745_1800.mtx", "True")
m[73] = OpenMatrix(direct+"OD_1800_1815.mtx", "True")
m[74] = OpenMatrix(direct+"OD_1815_1830.mtx", "True")
m[75] = OpenMatrix(direct+"OD_1830_1845.mtx", "True")
m[76] = OpenMatrix(direct+"OD_1845_1900.mtx", "True")
m[77] = OpenMatrix(direct+"OD_1900_1915.mtx", "True")
m[78] = OpenMatrix(direct+"OD_1915_1930.mtx", "True")
m[79] = OpenMatrix(direct+"OD_1930_1945.mtx", "True")
m[80] = OpenMatrix(direct+"OD_1945_2000.mtx", "True")
m[81] = OpenMatrix(direct+"OD_2000_2015.mtx", "True")
m[82] = OpenMatrix(direct+"OD_2015_2030.mtx", "True")
m[83] = OpenMatrix(direct+"OD_2030_2045.mtx", "True")
m[84] = OpenMatrix(direct+"OD_2045_2100.mtx", "True")
m[85] = OpenMatrix(direct+"OD_2100_2115.mtx", "True")
m[86] = OpenMatrix(direct+"OD_2115_2130.mtx", "True")
m[87] = OpenMatrix(direct+"OD_2130_2145.mtx", "True")
m[88] = OpenMatrix(direct+"OD_2145_2200.mtx", "True")
m[89] = OpenMatrix(direct+"OD_2200_2215.mtx", "True")
m[90] = OpenMatrix(direct+"OD_2215_2230.mtx", "True")
m[91] = OpenMatrix(direct+"OD_2230_2245.mtx", "True")
m[92] = OpenMatrix(direct+"OD_2245_2300.mtx", "True")
m[93] = OpenMatrix(direct+"OD_2300_2315.mtx", "True")
m[94] = OpenMatrix(direct+"OD_2315_2330.mtx", "True")
m[95] = OpenMatrix(direct+"OD_2330_2345.mtx", "True")
m[96] = OpenMatrix(direct+"OD_2345_0000.mtx", "True")

//Initially generate Seed matrix
//for i=1 to 96 do	
//fileName=direct+"demands_"+i2s(i)
//RunMacro("Export Matrix",m[i],fileName)
//end


//Update Matrix and .txt changed to .csv

for i=1 to 96 do
Matrix = OpenTable("Matrix", "CSV", {direct+"demands_"+i2s(i)+".txt"})
RunMacro("Update Matrix",m[i],Matrix)
CloseView(Matrix)
end

endMacro


//
// Upadating estimated flows from OD toolbox to existing flows in OD matrixes
// FIELD_3=SOV, FIELD_4=HOV, FIELD_5=LDT, FIELD_6=MDT, FIELD_7=HDT, FIELD_8=PORT
//


// If Parse error check the veh class name in OD matrix and make changes accordingly

Macro "Update Matrix" (mtx, tbl)

viewset = tbl + "|"

update_flds = {tbl+".FIELD_3", tbl+".FIELD_4", tbl+".FIELD_5", tbl+".FIELD_6", tbl+".FIELD_7", tbl+".FIELD_8"}

UpdateMatrixFromView(mtx, viewset, "FIELD_1", "FIELD_2", null, update_flds, "Replace",{{"Missing is zero", "Yes"}})

endMacro


//
// Exporting matrix (bin files) into CSV format
//

Macro "Export Matrix" (mtx,fileName)

CreateTableFromMatrix(mtx,fileName, "CSV",{{"Complete", "Yes"}})

endMacro



//
// Export Trips.bin files into text format
//

Macro "Export Tripsbin"

direct="L:\\Port(UCTC)\\output\\data\\"


Trips = OpenTable("Trips", "FFB", {direct+"trips.bin"})
strct = GetTableStructure(Trips)
selected_flds={"ID","OriID","DesID","Class","Truck","UserA", "UserB", "Status","DepTime","ArrTime","Path","Occupants"}
ExportView(Trips+"|", "FFB", direct+"Trips2.bin",selected_flds,)
scheck=strct.length
CloseView(Trips)
endMacro


//
// Export Trips.bin files into text format
//

Macro "Export Detector"

detector2 = OpenTable("detector2", "FFB", {"L:\\Port(UCTC)\\output\\data\\detector2.bin"})
strct2 = GetTableStructure(detector2)

selected_flds2={"Time","Sensor", "Vehicle","Speed"}

ExportView(detector2+"|", "CSV", "L:\\Port(UCTC)\\output\\data\\detector2.csv",selected_flds2,)
scheck=strct2.length  
CloseView(detector2)
endMacro


//
// Export Trips.bin files into text format
//
Macro "Export Segpass"

segpass = OpenTable("segpass", "FFB", {"L:\\Port(UCTC)\\output\\data\\segpass.bin"})
strct = GetTableStructure(segpass)
selected_flds={"VehicleID","SegmentIndex","TimeEnter"}
ExportView(segpass+"|", "CSV", "L:\\Port(UCTC)\\output\\data\\segpass.csv",,)

CloseView(segpass)
endMacro



//
// Join two dataset (detector2.bin and Trips.bin) in order to generate path & detector info
//

Macro "Join Detector_Trips"

detector2 = OpenTable("detector2", "FFB", {"L:\\Port(UCTC)\\output\\data\\Traj_Test_Data\\detector2.bin"})
strct2 = GetTableStructure(detector2)

trips = OpenTable("trips", "FFB", {"L:\\Port(UCTC)\\output\\data\\trips.bin"})
strct_trip=GetTableStructure(trips)

//set_trip={"ID","Time","Sensor", "Vehicle", "Class", "Speed", "OriID", "DesID","Class", "UserA", "UserB", "Status", "DepTime", "ArrTime"}

det_trip = JoinViews("det_trip", "detector2.Vehicle", "trips.ID",)

set_trip={"Vehicle","Time","Sensor","detector2.Class", "Speed", "detector2.OriID", "detector2.DesID", "UserA", "UserB", "Status", "DepTime", "ArrTime","trips.path"}                

ExportView(det_trip+"|", "FFB", "L:\\Port(UCTC)\\output\\data\\detector_trip.bin",set_trip,)

CloseView(detector2)
CloseView(trips)
CloseView(det_trip)

endMacro


//direct="L:\\Port(UCTC)\\output\\Traj_Test_Data\\"


//
// Join two dataset (trajectory.bin and Segment_.bin) in order to generate path & detector info
//

Macro "Join TrajSeg"

trajectory = OpenTable("trajectory", "FFB", {"L:\\Port(UCTC)\\output\\data\\Traj_Test_Data\\trajectory.bin"})
strct2 = GetTableStructure(trajectory)

segment_ = OpenTable("segment_", "FFB", {"L:\\Port(UCTC)\\output\\data\\Traj_Test_Data\\Segment_.bin"})
strct_segment_=GetTableStructure(segment_)

//set_segment_={"ID","Type","Lanes"}

det_segment_ = JoinViews("det_segment_", "trajectory.Segment", "segment_.ID",)

set_segment_ ={"ID","Time","Longitude","Latitude", "Segment", "Speed", "segment_.ID"}                

ExportView(det_segment_+"|", "FFB", "L:\\Port(UCTC)\\output\\data\\Traj_Test_Data\\TrajSeg.bin",set_segment_,)

CloseView(trajectory)
CloseView(segment_)
CloseView(det_segment_)

endMacro




Macro "GetSegment_info"


	ptr2 = OpenFile("L:\\Port(UCTC)\\sensor_list.txt", "r")
	road_info = ReadArray(ptr2)
	CloseFile(ptr2)
	
	fptr = OpenFile("L:\\Port(UCTC)\\output\\data\\segment_sensor_list.txt", "w")
	            
	dim segment_ids[road_info.length,2]
	for i=1 to road_info.length do	
	
		sensor_info=GetSensorInfo(S2I(road_info[i]))
		segment_ids[i][1]=sensor_info[1].Segment //segment id
		segment_ids[i][2]=S2I(road_info[i])      //sensor id
		
		line=Format(sensor_info[1].Segment, "*")+ "," + Format(S2I(road_info[i]), "*")
		WriteLine(fptr, line)
    
	
	end


	size=segment_ids.length
				           
     CloseFile(fptr)            
                
				
endMacro




//
// Export Vehicle ID and Category 
//
Macro "Export VehCat"

direct="L:\\Port(UCTC)\\output\\data\\"


detector_trip = OpenTable("detector_trip", "FFB", {direct+"detector_trip.bin"})
strct = GetTableStructure(detector_trip)
selected_flds={"Vehicle","Class"}
ExportView(detector_trip+"|", "FFB", direct+"detector_trip1.bin",selected_flds,)
scheck=strct.length
CloseView(detector_trip)
endMacro

//
// Export Vehicle ID and Category 
//
Macro "Export VehCate"

direct="L:\\Port(UCTC)\\output\\data\\"


detector2 = OpenTable("detector2", "FFB", {direct+"detector2.bin"})
strct = GetTableStructure(detector2)
selected_flds={"Vehicle","Class"}
ExportView(detector2+"|", "FFB", direct+"detector9.bin",selected_flds,)
scheck=strct.length
CloseView(detector2)
endMacro

Macro "Export Traj"

direct="L:\\Port(UCTC)\\output\\19\\"


trajectory = OpenTable("trajectory", "FFB", {direct+"trajectory.bin"})
strct = GetTableStructure(trajectory)
selected_flds={"ID"}
ExportView(trajectory+"|", "FFB", direct+"trajectory1.bin",selected_flds,)
scheck=strct.length
CloseView(trajectory)
endMacro