
Macro "GetSegmentDir_info"


	ptr2 = OpenFile("L:\\Test(Arterial)\\sensor_list.txt", "r")
	road_info = ReadArray(ptr2)
	CloseFile(ptr2)
	
	fptr = OpenFile("L:\\Test(Arterial)\\output\\data\\segment_sensor_list.txt", "w")
	            
	dim segment_ids[road_info.length,3]
	for i=1 to road_info.length do	
	
		sensor_info=GetSensorInfo(S2I(road_info[i]))
		segment_ids[i][1]=sensor_info[1].Segment //segment id
		segment_ids[i][2]=sensor_info[1].Direction //segment id
		segment_ids[i][3]=S2I(road_info[i])      //sensor id
		
		
		line=Format(sensor_info[1].Segment, "*")+ "," + Format(S2I(road_info[i]), "*")+ "," + Format(sensor_info[1].Direction, "*")
		WriteLine(fptr, line)
    
	
	end


	size=segment_ids.length
				           
     CloseFile(fptr)            
                
				
endMacro