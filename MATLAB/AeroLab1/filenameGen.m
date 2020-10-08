 % Experiment Part 1, Variation 1
 % Pitot-Static Probe: Airspeed Pressure Transducer 
 % Static Rings: Water Manometer
 % Group numbers for the desired data
 pt1_var1_groups = {'01', '05', '09', '13'};
 
 for index = 1: (numel(pt1_var1_groups))
 base = "VelocityVoltage_S011_G";
 group = pt1_var1_groups(index);
 ext = ".csv";
 filename = strcat(base, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 % Experiment Part 1, Variation 2
 % Pitot-Static Probe: Water Manometer
 % Static Rings: Airspeed Pressure Transducer
 % Group numbers for the desired data
 pt1_var2_groups = {'03', '07', '11', '15'};
 
 for index = 1: (numel(pt1_var1_groups))
 base = "VelocityVoltage_S011_G";
 group = pt1_var1_groups(index);
 ext = ".csv";
 filename = strcat(base, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 % Experiment Part 2
 % Port 1
 % Group numbers for the desired data
 pt2_port1_sec = 'S011';
 pt2_port1_group = {'01', '03'};
 
 for index = 1:(numel(pt2_port1_group))
 base = "BoundaryLayer_";
 group = pt2_port1_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port1_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 % Experiment Part 2
 % Port 2
 % Group numbers for the desired data
 pt2_port2_sec = 'S012';
 pt2_port2_group = {'01', '03'};
 
 

 for index = 1:(numel(pt2_port2_group))
 base = "BoundaryLayer_";
 group = pt2_port2_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port2_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 % Experiment Part 2
 % Port 3
 % Group numbers for the desired data
 pt2_port3_sec = 'S013';
 pt2_port3_group = {'01', '03'};
 
 for index = 1:(numel(pt2_port3_group))
 base = "BoundaryLayer_";
 group = pt2_port3_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port3_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 % Experiment Part 2
 % Port 4
 % Group numbers for the desired data
 pt2_port4_sec = 'S014';
 pt2_port4_group = {'13', '15'};
 
 for index = 1:(numel(pt2_port4_group))
 base = "BoundaryLayer_";
 group = pt2_port4_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port4_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 

 % Experiment Part 2
 % Port 5
 % Group numbers for the desired data
 pt2_port5_sec = 'S012';
 pt2_port5_group = {'5', '7'};
 
 for index = 1:(numel(pt2_port5_group))
 base = "BoundaryLayer_";
 group = pt2_port5_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port5_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 % Experiment Part 2
 % Port 6
 % Group numbers for the desired data
 pt2_port6_sec = 'S013';
 pt2_port6_group = {'5', '7'};
 
 for index = 1:(numel(pt2_port6_group))
 base = "BoundaryLayer_";
 group = pt2_port6_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port6_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 % Experiment Part 2
 % Port 7
 % Group numbers for the desired data
 pt2_port7_sec = 'S013';
 pt2_port7_group = {'13', '15'};
 
 for index = 1:(numel(pt2_port7_group))
 base = "BoundaryLayer_";
 group = pt2_port7_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port7_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 % Experiment Part 2
 % Port 8
 % Group numbers for the desired data
 pt2_port8_sec = 'S014';
 pt2_port8_group = {'05', '07'};
 
 for index = 1:(numel(pt2_port8_group))
 base = "BoundaryLayer_";
 group = pt2_port8_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port8_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 % Experiment Part 2
 % Port 9
 % Group numbers for the desired data
 pt2_port9_sec = 'S013';
 pt2_port9_group = {'09', '11'};
 
 for index = 1:(numel(pt2_port9_group))
 base = "BoundaryLayer_";
 group = pt2_port9_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port9_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 
 % Experiment Part 2
 % Port 10
 % Group numbers for the desired data
 pt2_port10_sec = 'S014';
 pt2_port10_group = {'9', '11'};
 
 for index = 1:(numel(pt2_port10_group))
 base = "BoundaryLayer_";
 group = pt2_port10_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port10_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
 
 
 % Experiment Part 2
 % Port 11
 % Group numbers for the desired data
 pt2_port11_sec = 'S012';
 pt2_port11_group = {'13', '15'};
 
 for index = 1:(numel(pt2_port11_group))
 base = "BoundaryLayer_";
 group = pt2_port11_group(index);
 fill = "_G";
 ext = ".csv";
 filename = strcat(base, pt2_port11_sec, fill, group, ext);
 %[atmosphPressure,atmosphTemp,diffPres1,diffPres2,xDist,yDist,voltage] = parseFile(filename); 
 end
 
