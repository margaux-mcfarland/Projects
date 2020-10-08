function bin_num = Voltage2Bin(min_voltage, max_voltage, bits, V)

   range = max_voltage - min_voltage;
   LSB = range/2^bits;
   
   bin_num = int32(V/LSB);
end
