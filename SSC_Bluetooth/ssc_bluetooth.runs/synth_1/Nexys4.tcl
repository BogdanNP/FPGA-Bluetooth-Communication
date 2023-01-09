# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.cache/wt} [current_project]
set_property parent.project_path {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {e:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/new/math_package.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/new/i2c.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/new/TemperatureBroadcast.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/new/FrequencyDivider.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/new/DecToAsciiConverter.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/sources_1/imports/Nexys4/displ7seg.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/new/HexToDecimalConverter.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/new/temp_sensor.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/sources_1/imports/Nexys4/mpg.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/sources_1/new/UCC.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/sources_1/new/UART_rx.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/sources_1/new/UART_tx.vhd}
  {E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/sources_1/imports/sources_1/new/Nexys4.vhd}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/constrs_1/imports/Nexys4/Nexys4DDR_Master.xdc}}
set_property used_in_implementation false [get_files {{E:/OneDrive - Technical University of Cluj-Napoca/ANUL III/SSC/Proiect/SSC_Bluetooth/ssc_bluetooth.srcs/constrs_1/imports/Nexys4/Nexys4DDR_Master.xdc}}]


synth_design -top Nexys4 -part xc7a100tcsg324-1


write_checkpoint -force -noxdef Nexys4.dcp

catch { report_utilization -file Nexys4_utilization_synth.rpt -pb Nexys4_utilization_synth.pb }
