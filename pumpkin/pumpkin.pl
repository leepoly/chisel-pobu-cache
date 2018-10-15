#!/usr/bin/perl -w

use v5.10;
use strict;
use File::Find;
use File::Copy;
use POSIX;

our %pumpkin_path_hash;
our %pumpkin_parameter_hash;

# task name hash
our %full_test_info_hash;
our %unit_test_info_hash;

# task queue
our %full_test_queue_hash;
our %unit_test_queue_hash;
our @x64_test_queue;

###################  main logic ####################

&pumpkin_init();
&cmd_parsing();

foreach my $test_name (@x64_test_queue)
{
    &task_begin($test_name, 'full_test', 'x64');
}

foreach my $test_name (keys %unit_test_queue_hash)
{
    &task_begin($test_name, 'unit_test', 'arm64', $unit_test_queue_hash{$test_name});
}

foreach my $test_name (keys %full_test_queue_hash)
{
    &task_begin($test_name, 'full_test', 'arm64');
}

say "\n";
say " ******* Developed by Pobu - huangbowen\@ict.ac.cn";
say "\n";

#################### major subrountines ###############

sub pumpkin_init
{
    say "\n";
    say " ******* Pumpkin auto worker script v1.63";
    say "\n";

    %pumpkin_parameter_hash =
    (
        #'device'                        => 'xc7z020clg400-1',
        'device'                        => 'xc7v2000tfhg1761-1',
        'default_test_scale'            => 'unit_test',
        'default_test_arch'             => 'arm64',
        'default_test_mode'             => 'post-implementation',
        'default_test_type'             => 'timing',
        'default_test_dump'             => 'off',
        'default_cycle_time'            => 8, # counting in nano second

        'waveform_filename'             => 'sim_waves.vcd',
        'autogen_constr_filename'       => 'auto_constraints.xdc',
        'sim_log_filename'              => 'sim.log',
        'synth_log_filename'            => 'synth.log',
        'impl_log_filename'             => 'impl.log',
        'timing_rpt_filename'           => 'timing.log',
        'util_rpt_filename'             => 'util.log',
        'report_dir'                    => 'report',

        'sim_config_filename' 		    => 'sim_config.h',

        'c_x64_compiler'                => 'gcc',
        'cpp_x64_compiler'              => 'g++',
        'c_arm_compiler'                => 'aarch64-linux-gnu-gcc',
        'cpp_arm_compiler'              => 'aarch64-linux-gnu-g++',
        'arm_objdump'                   => 'aarch64-linux-gnu-objdump',
        'compilation_output_filename'   => 'sim',

        'src_rtl_ext_format'            => qr/(\.v)$|(\.h)$/,
        'src_verify_ext_format'         => qr/(\.cpp)$|(\.h)$|(\.c)$/,

        'running_on_mac'                => '0'
    );

    $pumpkin_path_hash{'pumpkin_root_dir'}             = getcwd;
    $pumpkin_path_hash{'src_rtl_dir'}                  = "$pumpkin_path_hash{'pumpkin_root_dir'}/rtl";
    $pumpkin_path_hash{'src_verify_dir'}               = "$pumpkin_path_hash{'pumpkin_root_dir'}/verify";
    $pumpkin_path_hash{'working_temp_dir'}             = "$pumpkin_path_hash{'pumpkin_root_dir'}/working_temp";
    $pumpkin_path_hash{'assist_script_dir'}            = "$pumpkin_path_hash{'src_verify_dir'}/assist_script";
    $pumpkin_path_hash{'full_test_dir'}                = "$pumpkin_path_hash{'src_verify_dir'}/full_test";
    $pumpkin_path_hash{'unit_test_dir'}                = "$pumpkin_path_hash{'src_verify_dir'}/unit_test";
    $pumpkin_path_hash{'unit_test_mem_image_dir'}      = "$pumpkin_path_hash{'src_verify_dir'}/unit_test/mem_image";
    $pumpkin_path_hash{'unit_test_config_path'}        = "$pumpkin_path_hash{'unit_test_dir'}/unit.cfg";
    $pumpkin_path_hash{'vivado_wrapper_path'}          = "$pumpkin_path_hash{'assist_script_dir'}/vivado_wrapper.tcl";
    $pumpkin_path_hash{'constr_generator_path'}        = "$pumpkin_path_hash{'assist_script_dir'}/auto_constr.pl";
    $pumpkin_path_hash{'device_constr_dir'}            = "$pumpkin_path_hash{'assist_script_dir'}/device";

    &test_name_enumerate('full_test');
    &test_name_enumerate('unit_test');

    # integrity checking
    foreach my $key (keys %pumpkin_path_hash)
    {
        if($key eq 'working_temp_dir')
        {
            mkdir $pumpkin_path_hash{$key};
        }
        else
        {
            die "path invalid - $pumpkin_path_hash{$key}"
            if !-e $pumpkin_path_hash{$key};
        }
    }

    foreach my $test_name (keys %unit_test_info_hash)
    {
        die "the test sources dir of $test_name doesn't exist at $unit_test_info_hash{$test_name}{'test_src_dir'}"
        if !-e $unit_test_info_hash{$test_name}{'test_src_dir'}
    }

    if(`uname -a` =~ 'Darwin')
    {
        # running on mac will bypass the vivado support
        $pumpkin_parameter_hash{'running_on_mac'} = 1;
        say "[warning-script] Mac OS is detected, will bypass vivado";
    }

    say "[info-script] integrity checking pass";
}

sub cmd_parsing
{
    say '[info-script] parsing arguments ...';

    if(@ARGV < 1)
    {
        die '[error-script] no enough parameters for the pumpkin script';
    }

    my $test_scale     = $pumpkin_parameter_hash{'default_test_scale'};
    my $test_arch      = $pumpkin_parameter_hash{'default_test_arch'};
    my $test_mode      = $pumpkin_parameter_hash{'default_test_mode'};
    my $test_type      = $pumpkin_parameter_hash{'default_test_type'};
    my $test_dump      = $pumpkin_parameter_hash{'default_test_dump'};

        foreach my $current_arg (@ARGV)
        {
            my $test_name = is_test_name_matched($current_arg, $test_scale);

            if($test_name)
            {
                if($test_arch =~ 'arm')
                {
                    if($test_mode eq 'behavioral' and ($test_type eq 'none' or $test_type eq 'timing'))
                    {
                        die "[error-script] either test_mode($test_mode) or test_type($test_type) option is not correct !";
                    }
                    else
                    {
                        my $target_queue_ref = $test_scale =~ 'full' ?
                                                \%full_test_queue_hash:
                                                \%unit_test_queue_hash;

                        ${$target_queue_ref}{$test_name}=
                        {
                            'mode'           => $test_mode,
                            'type'           => $test_type,
                            'dump'           => $test_dump,
                            'test_src_dir'   => $unit_test_info_hash{$test_name}{'test_src_dir'},
                            'topmodule_test' => $unit_test_info_hash{$test_name}{'topmodule_test'},
                            'topmodule_src'  => $unit_test_info_hash{$test_name}{'topmodule_src'}
                        }
                    }
                }
                else
                {
                    push @x64_test_queue, $test_name;
                }
            }
            elsif($current_arg =~ /-clean/)
            {
                say "[info-script] cleaning working temp dir ...\n";

                `rm -irf $pumpkin_path_hash{'working_temp_dir'}/*`
                if -e $pumpkin_path_hash{'working_temp_dir'};
            }
            elsif($current_arg =~ /-(?<scale>full|unit)/)
            {
                $test_scale = $+{scale}."_test";
            }
            elsif($current_arg =~ /-(?<arch>arm64|armv8|x64|x86)/i)
            {
                $test_arch = $+{arch};
            }
            elsif( '-behavioral' =~ $current_arg
                or '-synthesis' =~ $current_arg
                or '-implementation' =~ $current_arg)
            {
                $current_arg =~ /-(?<mode>\w+)/i;
                $test_mode = 'behavioral' =~ $+{mode} ?
                                'behavioral':
                                        (
                                            'post-synthesis' =~ $+{mode} ?
                                            'post-synthesis':
                                            'post-implementation'
                                        );
            }
            elsif($current_arg =~ /-sim_(?<type>func|time|none)/i)
            {
                $test_type = 'functional' =~ $+{type} ? 'functional' : ('time' =~ $+{type} ? 'timing' : 'none');
            }
            elsif($current_arg =~ /-dump/i)
            {
                $test_dump = 'on';
            }
            else
            {
                die "[error-script] unknown parameters $current_arg";
            }
        }
}

sub task_begin
{
    my ($test_name, $test_scale, $test_arch, $test_options_ref)     = @_;
    my $build_dir = "$pumpkin_path_hash{'working_temp_dir'}/" . "${test_scale}_" . "$test_name";

    if(-e $build_dir)
    {
        system("rm -irf $build_dir");
    }
    &create_dir($build_dir);

    if($test_scale =~ 'full_test')
    {
        my $compiler_cmd                = $test_arch =~ 'arm' ?
                                            $pumpkin_parameter_hash{'cpp_arm_compiler'}:
                                            $pumpkin_parameter_hash{'cpp_x64_compiler'};

        my $compilation_flags           = " -O3 -Wall -g";
        my $compilation_log_path        = "$build_dir/compilation.log";
        my @filelist;

        my $elf_filename = "$build_dir/$test_name";
        find(sub{generic_files_collect($pumpkin_parameter_hash{'src_verify_ext_format'}, \@filelist);},
            "$pumpkin_path_hash{'src_verify_dir'}/$test_scale/$test_name");

        $compiler_cmd .= " @filelist -o $elf_filename".$compilation_flags;
        $compiler_cmd .= ' -Dx64' if !($test_arch =~ 'arm');
        $compiler_cmd .= " 2>> $compilation_log_path";

        say "[info-script] starting compilation for $test_name";
        &compilation_wrapper($compilation_log_path, $compiler_cmd, @filelist);

        #my $dumper_path = &arm_dumper_build();
        #&arm_dumper_run($dumper_path, $elf_filename, $build_dir);
        say "$elf_filename";
        system "$elf_filename;";
    }

    # unit test
    elsif($test_scale =~ 'unit_test')
    {
        my @rtl_filelist; my @testbench_filelist;
        my $test_src_dir = ${$test_options_ref}{'test_src_dir'};

        find(sub{generic_files_collect($pumpkin_parameter_hash{'src_rtl_ext_format'}, \@rtl_filelist);},
            "$pumpkin_path_hash{'pumpkin_root_dir'}/rtl");
        find(sub{generic_files_collect($pumpkin_parameter_hash{'src_rtl_ext_format'}, \@testbench_filelist);},
            $test_src_dir);

        my $test_mode                   = ${$test_options_ref}{'mode'};
        my $test_type                   = ${$test_options_ref}{'type'};
        my $test_dump                   = ${$test_options_ref}{'dump'};
        my $topmodule_test              = ${$test_options_ref}{'topmodule_test'};
        my $topmodule_src               = ${$test_options_ref}{'topmodule_src'};

        my $constr_generator_path       = $pumpkin_path_hash{'constr_generator_path'};
        my $device_constr_path          = "$pumpkin_path_hash{'device_constr_dir'}/$pumpkin_parameter_hash{'device'}.txt";
        my $final_constr_path           = "$build_dir/$pumpkin_parameter_hash{'autogen_constr_filename'}";

        my $cycle_time                  = $pumpkin_parameter_hash{'default_cycle_time'};

        die "[error-script] the device file for $pumpkin_parameter_hash{'device'} doesn't exist" if !-e $device_constr_path;

        my $report_dir = "$build_dir/$pumpkin_parameter_hash{'report_dir'}";
        &create_dir($report_dir);

        my $timing_rpt_path = "$report_dir/$pumpkin_parameter_hash{'timing_rpt_filename'}";
        my $util_rpt_path   = "$report_dir/$pumpkin_parameter_hash{'util_rpt_filename'}";
        my $waveform_path   = "$report_dir/$pumpkin_parameter_hash{'waveform_filename'}";

        # invoke vivado for linux
        if($pumpkin_parameter_hash{'running_on_mac'} == 0)
        {
            my $sim_config_path = &create_sim_config_file();
            push @rtl_filelist, $sim_config_path;

            my ($sim_log_path, $synth_log_path, $impl_log_path) =
            &vivado_wrapper(
                    $test_name,
                    $waveform_path, $timing_rpt_path, $util_rpt_path,
                    $constr_generator_path, $device_constr_path, $final_constr_path,
                    "$pumpkin_parameter_hash{'device'}", $cycle_time,
                    $topmodule_test, $topmodule_src, $test_mode, $test_type, $test_dump,
                    $build_dir, (@rtl_filelist, @testbench_filelist));

            # copy back the logs
            `cp $synth_log_path $report_dir/$pumpkin_parameter_hash{synth_log_filename}` if -e $synth_log_path;
            `cp $impl_log_path  $report_dir/$pumpkin_parameter_hash{impl_log_filename}`  if -e $impl_log_path;
            `cp $sim_log_path   $report_dir/$pumpkin_parameter_hash{sim_log_filename}`   if -e $sim_log_path;

            if($test_mode eq 'post-synthesis' or $test_mode eq 'post-implementation')
            {
                if(&check_timing($timing_rpt_path) eq 'pass')
                {
                    say "\n[info-script] timing constraints for ".(1/$cycle_time*1000)."MHz (${cycle_time}ns) is met";
                }
                else
                {
                    say "\n[critical-warning-script] timing constraints for ".(1/$cycle_time*1000)."MHz (${cycle_time}ns) is NOT met";
                }
            }
        }
        # invoke icarus for mac
        else
        {
            chdir $build_dir;
            $pumpkin_parameter_hash{'waveform_filename'} = "sim_waves.fst";
            $waveform_path = "$build_dir/$pumpkin_parameter_hash{'waveform_filename'}";

            my $sim_config_path = &create_sim_config_file();
            push @rtl_filelist, $sim_config_path;

            say "[info-script] invoking icarus compiler ...";

            my $icarus_cmd = "iverilog -o $build_dir/$pumpkin_parameter_hash{'compilation_output_filename'} -s $topmodule_test"
                         ." -I$pumpkin_path_hash{'src_rtl_dir'}/definitions";
               $icarus_cmd .= " -DDUMP" if $test_dump eq 'on';
               $icarus_cmd .= " @rtl_filelist @testbench_filelist";
            #say "[info-script] icarus cmd is - $icarus_cmd";
            system $icarus_cmd;

            if(-e "$build_dir/$pumpkin_parameter_hash{'compilation_output_filename'}")
            {
                say "[info-script] invoking icarus simulator ...";
                system "vvp $build_dir/$pumpkin_parameter_hash{'compilation_output_filename'} IVERILOG_DUMPER=fst -fst";
            }
            else
            {
                die "[error-script] unable to find the output executable file of icarus compilers";
            }
        }

        if($test_dump eq 'on')
        {
            die "[error-script] the waveform file $waveform_path does not exist" if !-e $waveform_path;
            say "[info-script] the waveform file is $waveform_path";

            if($pumpkin_parameter_hash{'running_on_mac'} == 0)
            {
                system "gtkwave --optimize -c 4 -f $waveform_path";
            }
            else
            {
                system "gtkwave $waveform_path";
            }
        }
    }
    else
    {
        die "[error-script] the input test_scale var $test_scale is wrong";
    }
}

sub vivado_wrapper
{
    my (
            $test_name,

            $waveform_path,
            $timing_rpt_path,
            $util_rpt_path,

            $constr_generator_path,
            $device_constr_path,
            $final_constr_path,

            $device_name,
            $cycle_time,

            $topmodule_test,
            $topmodule_src,
            $test_mode,
            $test_type,
            $test_dump,

            $build_dir, @combined_filelist
    ) = @_;

    # prepare log dir and file pathes
    my $sim_dirname_mode    = 'behavioral' =~ $test_mode ? 'behav' : ( 'post-synthesis' =~ $test_mode ? 'synth' : 'impl');
    my $sim_dirname_type    = 'behavioral' =~ $test_mode ? '' : 'functional' =~ $test_type ? 'func/' : 'timing/';
    my $sim_dir             = "$build_dir/${test_name}.sim/sim_1/$sim_dirname_mode/"."$sim_dirname_type";

    my $sim_log_path   = $sim_dir.'simulate.log';
    my $synth_log_path = "$build_dir/${test_name}.runs/synth_run/runme.log";
    my $impl_log_path  = "$build_dir/${test_name}.runs/impl_run/runme.log";

    chdir $build_dir;
    my $vivado_cmd = "vivado -mode batch -source $pumpkin_path_hash{'vivado_wrapper_path'}";
        $vivado_cmd .= " -tclargs $test_name";
        $vivado_cmd .= " $waveform_path $timing_rpt_path $util_rpt_path $synth_log_path";
        $vivado_cmd .= " $constr_generator_path $device_constr_path $final_constr_path";
        $vivado_cmd .= " $device_name $cycle_time";
        $vivado_cmd .= " $topmodule_test $topmodule_src $test_mode $test_type $test_dump";
        $vivado_cmd .= " @combined_filelist";

    #say "[info-script] the vivado cmd line is - $vivado_cmd";
    say "[info-script] invoking vivado ...";
    say "[info-script] vivado cmd is - $vivado_cmd";

    # invoke vivado
    system $vivado_cmd;

    return ($sim_log_path, $synth_log_path, $impl_log_path);
}

sub check_timing
{
    my ($timing_rpt_path) = @_;

    die "[error-script] fail to open $timing_rpt_path"
    if !open log_handle, "<$timing_rpt_path";

    while(my $current_line = <log_handle>)
    {
        if($current_line =~ 'All user specified timing constraints are met.')
        {
            return 'pass';
        }
    }

    return 'failed';
}

sub arm_dumper_build
{
    my @filelist;                   #stores all of the src files of dumper
    my $src_dir                     = "$pumpkin_path_hash{'src_verify_dir'}/elf_dumper";
    my $elf_dir                     = "$pumpkin_path_hash{'working_temp_dir'}/arm_dumper";
    &create_dir("$elf_dir");

    my $compilation_log_path   		= "$elf_dir/compilation.log";
    my $dumper_path            		= "$elf_dir/dumper";

    if(!-e $dumper_path)
    {
        say '[info-script] finding the source files of arm dumper ...';
        find(sub{generic_files_collect($pumpkin_parameter_hash{'src_verify_ext_format'}, \@filelist);}, $src_dir);

        my $compiler_cmd = "$pumpkin_parameter_hash{'cpp_x64_compiler'} @filelist -o $dumper_path 2>>$compilation_log_path";

        say '[info-script] starting the compilation of arm dumper ...';
        &compilation_wrapper($compilation_log_path, $compiler_cmd, @filelist);
    }
    else
    {
        say '[info-script] the arm dumper already exists ...';
    }

    return $dumper_path;
}

sub arm_dumper_run
{
    my ($dumper_path, $elf_to_dump, $dump_dir) = @_;

    my $dump_bin_filename         = "$dump_dir/arm.bin";
    my $dump_addr_filename        = "$dump_dir/load_addr_arm.h";
    my $dump_run_log_filename     = "$dump_dir/arm_dumper_run.log";

    say "[info-script] starting to dump $elf_to_dump ...";
    `$dumper_path $elf_to_dump $dump_bin_filename $dump_addr_filename > $dump_run_log_filename`;

    #collect instruction statistics
    say "[info-script] starting to collect the instruction statistics of $elf_to_dump ...";
    my @objdump_output = split(/\n/,`$pumpkin_parameter_hash{'arm_objdump'} -d $elf_to_dump`);
    my %static_instruction;

    die "[error-script] fail to open $dump_run_log_filename"
    if !open log_handle, ">$dump_run_log_filename";

    foreach my $current_line (@objdump_output)
    {
        if($current_line =~ / (^[\s]+) ([a-z0-9:]+) ([\s]+) ([a-z0-9]+) ([\s]+) (?<inst>[^\s]+) /gx)
        {
            my $current_instruction = $+{inst};
            !exists $static_instruction{$current_instruction} ?
            $static_instruction{$current_instruction} = 1 :
            $static_instruction{$current_instruction} += 1;
        }
    }

    print log_handle "\n";

    foreach $_ (sort keys %static_instruction)
    {
        printf log_handle "%10s %10d\n", $_, $static_instruction{$_};
    }

    close log_handle;
}

sub is_test_name_matched
{
    my ($arg_name, $test_scale) = @_;

    my @test_name = $test_scale =~ 'full' ? keys %full_test_info_hash : keys %unit_test_info_hash;
    foreach my $current_name (@test_name)
    {
        next unless $current_name =~ $arg_name;
        return $current_name;
    }
    return '';
}

sub test_name_enumerate
{
    my ($test_scale) = @_;
    say "[info-script] enumrating the test cases of $test_scale ...";

    # enumerate full test case
    if($test_scale =~ 'full')
    {
        my @src_dir = split(/\n/, `find $pumpkin_path_hash{'src_verify_dir'}/full_test -maxdepth 1 -mindepth 1 -type d`);
        foreach my $current_dir (@src_dir)
        {
            $current_dir =~ s/( ([^\/]*\/)+) ([^\/]*)$/$3/gx;
            $full_test_info_hash{$current_dir} = '1';
        }
    }
    # enumerate unit test case
    elsif($test_scale =~ 'unit')
    {
        die "[error-script] unable to open $pumpkin_path_hash{'unit_test_config_path'}"
        if !open unit_config, "<$pumpkin_path_hash{'unit_test_config_path'}";

        while(my $line = <unit_config>)
        {
            next unless $line =~ / \A! \s+
                                    (?<test_name>\w+)\s+
                                    (?<test_src_dir>[\w|\/]+)\s+
                                    /gx;

            $unit_test_info_hash{$+{test_name}} =
            {
                'test_src_dir'   => "$pumpkin_path_hash{'unit_test_dir'}/".$+{test_src_dir},
                'topmodule_test' => $+{test_name}."_testbench",
                'topmodule_src'  => $+{test_name}
            };
        }

        close unit_config;
    }
    else
    {
        die "[error-script] the specified test_scale $test_scale is wrong";
    }
}

############################# generic subroutines #########################

sub create_sim_config_file
{
    my $sim_config_path = "$pumpkin_path_hash{'src_rtl_dir'}/definitions/"."$pumpkin_parameter_hash{'sim_config_filename'}";
    
    system "cat /dev/null >$sim_config_path" if(-e $sim_config_path);
    #die "[error-script] unable to delete old timing def file $sim_config_path" if -e $sim_config_path;

    die "[error-script] fail to open $sim_config_path"
    if !open config_handle, ">$sim_config_path";

    printf config_handle "`ifndef SIMULATION\n";
    printf config_handle "    `define SIMULATION\n";
    printf config_handle "    `timescale 100ps/100ps\n";
    printf config_handle "    `define FULL_CYCLE_DELAY %d\n",  $pumpkin_parameter_hash{'default_cycle_time'} * 10;
    printf config_handle "    `define HALF_CYCLE_DELAY %d\n",  $pumpkin_parameter_hash{'default_cycle_time'} * 5;
    printf config_handle "    `define MEM_IMAGE_DIR \"%s\"\n", $pumpkin_path_hash{'unit_test_mem_image_dir'};

    if($pumpkin_parameter_hash{'running_on_mac'} == 1)
    {
        printf config_handle "    `define DUMP_FILENAME \"$pumpkin_parameter_hash{'waveform_filename'}\"\n";
    }

    printf config_handle "`else\n";
    printf config_handle "`endif\n";

    close config_handle;

    return $sim_config_path;
}

sub compilation_wrapper
{
    my ($compilation_log_path, $compiler_cmd, @filelist) = @_;

    die "[error-script] fail to open compilation logfile $compilation_log_path"
    if !open log_handle, ">$compilation_log_path";

    printf log_handle "the %d source files are:\n", @filelist+0;
    foreach my $file (@filelist)
    {
        printf log_handle "$file\n";
    }

    printf log_handle "\nthe compiler_cmd:\n";
    printf log_handle "$compiler_cmd\n";

    printf log_handle "\nthe compilation output:\n";
    close log_handle;

    my $compilaton_failed = system($compiler_cmd);
    $compilaton_failed ?
    die "[info-script] compilation error occured, please check $compilation_log_path\n":
    say "[info-script] compilation is successful\n";

    return $compilaton_failed;
}

sub create_dir
{
    my ($dir) = @_;

    mkdir $dir if !-e $dir;
    die "[error-script] unable to create $dir" if !-e $dir;
}

sub generic_files_collect
{
    my ($find_pattern, $filelist_ref) = @_;
    push @{$filelist_ref}, "$File::Find::name" if $File::Find::name =~ $find_pattern;
}
