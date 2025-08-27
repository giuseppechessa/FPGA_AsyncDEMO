

#Puts closure time max_delay
set_max_delay -from [get_pins Stadio_1/req_latch/G] -to [get_pins Stadio_1/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins Stadio_1/req_latch/G] -to [get_pins Stadio_1/req_latch/GE] 0.000





#Puts closure time max_delay
set_max_delay -from [get_pins Stadio_3/req_latch/G] -to [get_pins Stadio_3/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins Stadio_3/req_latch/G] -to [get_pins Stadio_3/req_latch/GE] 0.000





#Puts closure time max_delay
set_max_delay -from [get_pins genblk1[0].Stadio_2/req_latch/G] -to [get_pins genblk1[0].Stadio_2/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins genblk1[0].Stadio_2/req_latch/G] -to [get_pins genblk1[0].Stadio_2/req_latch/GE] 0.000



