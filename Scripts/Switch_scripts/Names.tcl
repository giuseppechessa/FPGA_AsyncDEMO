set INPORTNAMES [dict create "NORD" {mySwitch/genblk1[0].IPMS} \
"WEST" {mySwitch/genblk1[1].IPMS} \
"SUD" {mySwitch/genblk1[2].IPMS} \
"EST" {mySwitch/genblk1[3].IPMS} \
"LOC" {mySwitch/genblk2[0].IPMS}]

set OUTPORTNAMES [dict create "NORD" {mySwitch/genblk3[0].OPMS} \
"WEST" {mySwitch/genblk3[1].OPMS} \
"SUD" {mySwitch/genblk3[2].OPMS} \
"EST" {mySwitch/genblk3[3].OPMS} \
"LOC" {mySwitch/genblk4[0].OPMS}]