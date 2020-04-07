transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Git/Digital_Design_and_Computer_Architecture/HDL/ex4_19 {D:/Git/Digital_Design_and_Computer_Architecture/HDL/ex4_19/logic_from_2_35.sv}

vlog -sv -work work +incdir+D:/Git/Digital_Design_and_Computer_Architecture/HDL/ex4_19 {D:/Git/Digital_Design_and_Computer_Architecture/HDL/ex4_19/logic_from_2_35_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  logic_from_2_35_tb

add wave *
view structure
view signals
run -all
