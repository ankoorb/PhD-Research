//
// Export Segment ID 
//

Macro "Export SegID"
direct="L:\\Port(UCTC)\\output\\data\\"


Seg = OpenTable("Seg", "FFB", {direct+"Seg.bin"})
strct = GetTableStructure(Seg)
selected_flds={"ID"}
ExportView(Seg+"|", "FFB", direct+"SegID.bin",selected_flds,)
scheck=strct.length
CloseView(Seg)
endMacro



//
// Join two dataset (detector2.bin and Trips.bin) in order to generate segment trajectory for freeway one direction
//

Macro "Join SegTraj"

trajectory = OpenTable("trajectory", "FFB", {"L:\\Port(UCTC)\\output\\PreRamp\\Traj\\trajectory.bin"})
strct = GetTableStructure(trajectory)

SegID = OpenTable("SegID", "FFB", {"L:\\Port(UCTC)\\output\\PreRamp\\Traj\\SegID.bin"})
strct_SegID=GetTableStructure(SegID)

TrajSeg = JoinViews("TrajSeg", "trajectory.Segment", "SegID.ID",)
set_trip={"Vehicle","Time","Sensor","detector2.Class", "Speed", "detector2.OriID", "detector2.DesID", "UserA", "UserB", "Status", "DepTime", "ArrTime","trips.path"}                
ExportView(TrajSeg+"|", "FFB", "L:\\Port(UCTC)\\output\\PreRamp\\Traj\\SegTraj.bin",set_trip,)

//ExportView(TrajSeg+"|", "DBASE", "L:\\Port(UCTC)\\output\\data\\SegTraj.bin",set_trip,)
CloseView(trajectory)
CloseView(SegID)
CloseView(TrajSeg)

endMacro




//
// Join two dataset (trajectory.bin and SegID.bin) in order to generate segment trajectory for freeway one direction 24 Hr Trial
//

Macro "Join TrajSeg"

trajectory = OpenTable("trajectory", "FFB", {"L:\\Port(UCTC)\\output\\data\\trajectory.bin"})
strct = GetTableStructure(trajectory)

SegID = OpenTable("SegID", "FFB", {"L:\\Port(UCTC)\\output\\data\\SegID.bin"})
strct_SegID=GetTableStructure(SegID)

TrajSeg = JoinViews("TrajSeg", "trajectory.Segment", "SegID.ID",)
set_trip={"trajectory.ID","Time","Longitude","Latitude", "trajectory.Segment", "Lane", "Speed", "Acceleration","SegID.ID"}                
ExportView(TrajSeg+"|", "FFB", "L:\\Port(UCTC)\\output\\data\\SegTraj.bin",set_trip,)

//ExportView(TrajSeg+"|", "DBASE", "L:\\Port(UCTC)\\output\\data\\SegTraj.bin",set_trip,)
CloseView(trajectory)
CloseView(SegID)
CloseView(TrajSeg)

endMacro






//
// Export SegTraj files into text format
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
// Export Point Sensor Count 
//

Macro "Export Count"
direct="L:\\Port(UCTC)\\output\\data\\"


count = OpenTable("count", "FFB", {direct+"count.bin"})
strct = GetTableStructure(count)
selected_flds={"Interval","ID","Count"}
ExportView(count+"|", "FFB", direct+"PointCount.bin",selected_flds,)
scheck=strct.length
CloseView(count)
endMacro


