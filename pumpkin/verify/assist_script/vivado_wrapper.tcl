#reading sim parameters
set project_name [lindex $argv 0]

set waveform_path [lindex $argv 1]
set timing_rpt_file_path [lindex $argv 2]
set util_rpt_file_path [lindex $argv 3]
set vivado_synth_log_path [lindex $argv 4]

set constr_generator_path [lindex $argv 5]
set device_constraint_path [lindex $argv 6]
set final_constraint_path [lindex $argv 7]

set device [lindex $argv 8]
set cycle_time [lindex $argv 9]

set topmodule_test [lindex $argv 10]
set topmodule_src [lindex $argv 11]
set sim_mode [lindex $argv 12]
set sim_type [lindex $argv 13]
set dumpon [lindex $argv 14]

set parallel_thread 6

#reading file list
set i 15
while {$i < $argc} {
    lappend files [lindex $argv $i]
    incr i 1
}

#setting up the sim project
create_project $project_name . -part $device
set project_dir [file dirname [info script]]

if {[string equal [get_filesets -quiet sources_1] ""]} {
    create_fileset -srcset sources_1
}

if {[string equal [get_filesets -quiet sim_1] ""]} {
    create_fileset -srcset sim_1
}

if {[string equal [get_filesets -quiet constrs_1] ""]} {
    create_fileset -srcset constrs_1
}

add_files -norecurse -fileset sources_1 $files
add_files -norecurse -fileset sim_1 $files

set_property "top" $topmodule_src [get_filesets sources_1]
set_property "top" $topmodule_test [get_filesets sim_1]

# see more details for removed logic, propogated constant, merged instance
set_msg_config -id {[Synth 8-3332]} -limit 1000000
set_msg_config -id {[Synth 8-3333]} -limit 1000000
set_msg_config -id {[Synth 8-3886]} -limit 1000000

#setting up the synthesis and implementation run
if {[string equal -nocase -length 5 $sim_mode "post-"]} {
    create_run -part $device -constrset constrs_1 -flow "Vivado Synthesis 2017" -strategy "Vivado Synthesis Defaults" -verbose -name "synth_run"

    #synthesis
    launch_runs -jobs $parallel_thread -verbose "synth_run"
    wait_on_run "synth_run"
    if {[get_property PROGRESS [get_runs "synth_run"]] != "100%"} {
        error "[error-script] synthesis failed"
    } else {
        exec $constr_generator_path $project_name $topmodule_src $cycle_time $vivado_synth_log_path $device_constraint_path $final_constraint_path $files
        add_files -norecurse -fileset constrs_1 $final_constraint_path
    }

    if {[string equal -nocase $sim_mode "post-implementation"]} {
        create_run -part $device -constrset constrs_1 -flow "Vivado Implementation 2017" -strategy "Vivado Implementation Defaults" -verbose -parent_run "synth_run" -name "impl_run"

        #implementation
        launch_runs -jobs $parallel_thread -verbose "impl_run"
        wait_on_run "impl_run"
        if {[get_property PROGRESS [get_runs "impl_run"]] != "100%"} {
            error "[error-script] implementation failed"
        }

    }

    # open design
    if {[string equal -nocase $sim_mode "post-synthesis"]} {
            open_run -name "synth_design" -verbose "synth_run"
    } elseif {[string equal -nocase $sim_mode "post-implementation"]} {
            open_run -name "impl_design" -verbose "impl_run"
    }

    report_utilization -hierarchical -hierarchical_depth 10000 -verbose -file $util_rpt_file_path
    report_utilization -append -verbose -file $util_rpt_file_path
    report_timing_summary -check_timing_verbose -verbose -warn_on_violation -max_paths 10 -file $timing_rpt_file_path
}

if {[string equal -nocase $sim_type "none"]} {
} else {
        # cancel simulation autorun
        set_property -name {xsim.simulate.runtime} -value {0ns} -objects [get_filesets sim_1]

        # sim
        if {[string equal -nocase -length 5 $sim_mode "post-"]} {
            launch_simulation -simset sim_1 -mode $sim_mode -type $sim_type
        } else {
            launch_simulation -simset sim_1 -mode $sim_mode
        }

        if {[string equal -nocase $dumpon "on"]} {
            # dump vcd
            open_vcd $waveform_path
            start_vcd
            log_vcd
        } else {}

        # run
        run -all

        if {[string equal -nocase $dumpon "on"]} {
            #dump close
            flush_vcd
            close_vcd
        } else {}

        close_sim
    }

#exit
close_project
