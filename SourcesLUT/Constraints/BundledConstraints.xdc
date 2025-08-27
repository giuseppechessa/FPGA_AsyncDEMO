

#Puts max_delay constrain in mySwitch/genblk1[0].IPMS
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/*.Data_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I1] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[0].IPMS/PRC/*.RouteAnd/I0] 0.000





#Puts max_delay constrain in mySwitch/genblk1[1].IPMS
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/*.Data_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*.RouteAnd/I1] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[1].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[1].IPMS/PRC/*.RouteAnd/I0] 0.000





#Puts max_delay constrain in mySwitch/genblk1[2].IPMS
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/*.Data_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*.RouteAnd/I1] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[2].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[2].IPMS/PRC/*.RouteAnd/I0] 0.000





#Puts max_delay constrain in mySwitch/genblk1[3].IPMS
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/*.Data_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*.RouteAnd/I1] 0.000
set_max_delay -from [get_pins mySwitch/genblk1[3].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk1[3].IPMS/PRC/*.RouteAnd/I0] 0.000





#Puts max_delay constrain in mySwitch/genblk2[0].IPMS
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/*.Data_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*.RouteAnd/I1] 0.000
set_max_delay -from [get_pins mySwitch/genblk2[0].IPMS/input_pipe/req_latch/Q] -to [get_pins mySwitch/genblk2[0].IPMS/PRC/*.RouteAnd/I0] 0.000





#Puts max_delay constrain in mySwitch/genblk3[0].OPMS
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[0].OPMS/output_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[0].OPMS/output_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[0].OPMS/*.LatchBarrier/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/*.LatchBarrier/Q] -to [get_pins mySwitch/genblk3[0].OPMS/output_pipe/req_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[0].OPMS/output_pipe/*.Data_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[0].OPMS/*.Tailpassed_up_o_reg[*]/C] -to [get_pins mySwitch/genblk3[0].OPMS/*.LatchBarrier/GE] 0.000





#Puts max_delay constrain in mySwitch/genblk3[1].OPMS
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[1].OPMS/output_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[1].OPMS/output_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[1].OPMS/*.LatchBarrier/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/*.LatchBarrier/Q] -to [get_pins mySwitch/genblk3[1].OPMS/output_pipe/req_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[1].OPMS/output_pipe/*.Data_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[1].OPMS/*.Tailpassed_up_o_reg[*]/C] -to [get_pins mySwitch/genblk3[1].OPMS/*.LatchBarrier/GE] 0.000





#Puts max_delay constrain in mySwitch/genblk3[2].OPMS
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[2].OPMS/output_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[2].OPMS/output_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[2].OPMS/*.LatchBarrier/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/*.LatchBarrier/Q] -to [get_pins mySwitch/genblk3[2].OPMS/output_pipe/req_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[2].OPMS/output_pipe/*.Data_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[2].OPMS/*.Tailpassed_up_o_reg[*]/C] -to [get_pins mySwitch/genblk3[2].OPMS/*.LatchBarrier/GE] 0.000





#Puts max_delay constrain in mySwitch/genblk3[3].OPMS
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[3].OPMS/output_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk3[3].OPMS/output_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[3].OPMS/*.LatchBarrier/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/*.LatchBarrier/Q] -to [get_pins mySwitch/genblk3[3].OPMS/output_pipe/req_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk3[3].OPMS/output_pipe/*.Data_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk3[3].OPMS/*.Tailpassed_up_o_reg[*]/C] -to [get_pins mySwitch/genblk3[3].OPMS/*.LatchBarrier/GE] 0.000





#Puts max_delay constrain in mySwitch/genblk4[0].OPMS
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk4[0].OPMS/output_pipe/*.Data_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/output_pipe/req_latch/Q] -to [get_pins mySwitch/genblk4[0].OPMS/output_pipe/req_latch/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk4[0].OPMS/*.LatchBarrier/GE] 0.000
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/*.LatchBarrier/Q] -to [get_pins mySwitch/genblk4[0].OPMS/output_pipe/req_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/OPM_Mutex/*.Mutex_not/O] -to [get_pins mySwitch/genblk4[0].OPMS/output_pipe/*.Data_latch/D] 0.000
set_max_delay -from [get_pins mySwitch/genblk4[0].OPMS/*.Tailpassed_up_o_reg[*]/C] -to [get_pins mySwitch/genblk4[0].OPMS/*.LatchBarrier/GE] 0.000



