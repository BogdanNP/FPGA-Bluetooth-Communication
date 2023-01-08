proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir D:/CTI/An3/SSC_P_sem1/SSC_Bluetooth_GIT/SSC_Bluetooth/SSC_Bluetooth/ssc_bluetooth.cache/wt [current_project]
  set_property parent.project_path D:/CTI/An3/SSC_P_sem1/SSC_Bluetooth_GIT/SSC_Bluetooth/SSC_Bluetooth/ssc_bluetooth.xpr [current_project]
  set_property ip_output_repo D:/CTI/An3/SSC_P_sem1/SSC_Bluetooth_GIT/SSC_Bluetooth/SSC_Bluetooth/ssc_bluetooth.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  add_files -quiet D:/CTI/An3/SSC_P_sem1/SSC_Bluetooth_GIT/SSC_Bluetooth/SSC_Bluetooth/ssc_bluetooth.runs/synth_1/Nexys4.dcp
  read_xdc D:/CTI/An3/SSC_P_sem1/SSC_Bluetooth_GIT/SSC_Bluetooth/SSC_Bluetooth/ssc_bluetooth.srcs/constrs_1/imports/Nexys4/Nexys4DDR_Master.xdc
  link_design -top Nexys4 -part xc7a100tcsg324-1
  write_hwdef -file Nexys4.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force Nexys4_opt.dcp
  catch { report_drc -file Nexys4_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force Nexys4_placed.dcp
  catch { report_io -file Nexys4_io_placed.rpt }
  catch { report_utilization -file Nexys4_utilization_placed.rpt -pb Nexys4_utilization_placed.pb }
  catch { report_control_sets -verbose -file Nexys4_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Nexys4_routed.dcp
  catch { report_drc -file Nexys4_drc_routed.rpt -pb Nexys4_drc_routed.pb -rpx Nexys4_drc_routed.rpx }
  catch { report_methodology -file Nexys4_methodology_drc_routed.rpt -rpx Nexys4_methodology_drc_routed.rpx }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file Nexys4_timing_summary_routed.rpt -rpx Nexys4_timing_summary_routed.rpx }
  catch { report_power -file Nexys4_power_routed.rpt -pb Nexys4_power_summary_routed.pb -rpx Nexys4_power_routed.rpx }
  catch { report_route_status -file Nexys4_route_status.rpt -pb Nexys4_route_status.pb }
  catch { report_clock_utilization -file Nexys4_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force Nexys4_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force Nexys4.mmi }
  write_bitstream -force -no_partial_bitfile Nexys4.bit 
  catch { write_sysdef -hwdef Nexys4.hwdef -bitfile Nexys4.bit -meminfo Nexys4.mmi -file Nexys4.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

