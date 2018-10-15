#!/usr/bin/perl -w

use v5.10;
use strict;
use Data::Dumper;
use POSIX;

# this script will parse the top rtl module along with the specified device constraints file,
# and then generate constraints for the specified test.

#########################################  Main ###########################################################

our %parameter_value_hash;
our %port_width_hash;
our %pin_hash;
our %rtl_info_hash;
our %device_info_hash;

if(@ARGV < 6)
{
    die '[error-script] no enough parameters for the RTL port parser script';
}

&script_init();
our($project_name, $topmodule, $cycle_time, $vivado_log_file_path, $device_constr_path, $autogen_constr_file_path, $rtl_filelist_string) = @ARGV;
our @rtl_filelist = split /\s+/, $rtl_filelist_string;
&vivado_log_parse($vivado_log_file_path);

my $successful_match = 0;
foreach my $rtl_file_path (@rtl_filelist)
{
    my $content = &find_topmodule_rtl_file($topmodule, $rtl_file_path);
    if($content ne '')
    {
        verilog_port_width_calc($content);
        $successful_match = 1;
        last;
    }
}
die "[error-script] fail to find matched module for $topmodule" if $successful_match == 0;

&output_xdc_generate($autogen_constr_file_path, $device_constr_path, &device_constr_parse($device_constr_path));

#########################################  sub routine  #################################################

sub script_init
{
    %rtl_info_hash =
    ();

    %device_info_hash =
    (
        'xc7z010clg400-1' =>
        {
            'clk_in' => 'L16'
        },

        'xc7z020clg400-1' =>
        {
            'clk_in' => 'K17'
        },

        'xc7vx690tffg1761-1' =>
        {
            'clk_in' => 'AK34'
        },

        'xc7v2000tfhg1761-1' =>
        {
            'clk_in' => 'AK34'
        },

        'xczu2eg-sfva625-1-e' =>
        {
            'clk_in' => 'C4'
        }
    )
}

sub find_topmodule_rtl_file
{
    my ($topmodule, $file_path) = @_;
    die "[error-script] fail to open $file_path" if !open rtl_handle, "<$file_path";

    my $content;

    while(my $line = <rtl_handle>)
    {
        $content .= $line;
    };

    close rtl_handle;

    $content =~ s/\/\/ .* \n//mgx;       # delete single line comments
    $content =~ s/\n/ /g;                # delete new lines
    $content =~ s/\/\* .* \*\/ / /gx;    # delete multiple line comments

    $content =~ /module \s* $topmodule \s* (?<parameter_info>\#\(.*?\))? \s* \( (?<port_info>.*?) \s* \)\; /ix
                ? return $+{parameter_info}." ".$+{port_info} : return '';
}

# find parameters and corresponding values in vivado log
sub vivado_log_parse
{
    my ($vivado_log_filename) = @_;

    die "[error-script] fail to open $vivado_log_filename"
    if !open log_handle, "<$vivado_log_filename";

    say "[info-script] parsing $vivado_log_filename";

    while(my $line = <log_handle>)
    {
        if($line =~ /\s+ Parameter \s+ (?<parameter>\w+) \s+ bound \s+ to\: \s+ (?<value>[0-9]+) \s+ \- \s+ type/ix)
        {
            $parameter_value_hash{$+{parameter}} = $+{value};
        }
    };
    close log_handle;
}

sub find_matched_parameter_value_pair
{
    my ($width_exp) = @_;
    while($width_exp =~ / (?<parameter_to_be_resolved>[A-Za-z_]+) /x)
    {
        my $matched_parameter = '';
        my $parameter_to_be_resolved = $+{parameter_to_be_resolved};
        foreach my $parameter (keys %parameter_value_hash)
        {
            if($parameter_to_be_resolved eq $parameter)
            {
                    $matched_parameter = $parameter;
            }
        }
        die "[error-script] unable to find matched parameter for $parameter_to_be_resolved, dumping the parameter_value_hash - ",
        Dumper(\%parameter_value_hash) if $matched_parameter eq '';

        $width_exp =~ s/$matched_parameter/$parameter_value_hash{$matched_parameter}/gx if $matched_parameter ne '';
    }
    return $width_exp;
}

sub verilog_port_width_calc
{
    my ($content) = @_;

    # extract verilog port names and corresponding width info
    while ($content =~ / \s+ (input|output) \s* (?:reg|wire)? \s* (?: \[ (?<width_exp>[^\]]+) \] )? \s* (?<port>\w+) \s* (?:,|\); )/gx)
    {
        my $width_exp = $+{width_exp} // '';
        my $port = $+{port};

        if(defined $+{width_exp})
        {
            foreach my $macro (keys %{$rtl_info_hash{$project_name}})
            {
                while($width_exp =~ /$macro/)
                {
                    my $matched_macro = $macro;
                    $width_exp =~ s/$matched_macro/$rtl_info_hash{$project_name}{$macro}/gx;
                }
            }

            $width_exp = &find_matched_parameter_value_pair($width_exp);

            my ($width_upper_exp, $width_lower_exp) = split ':', $width_exp;
            my $width_upper = &postfix_exp_evaluate(&infix_exp_to_postfix_exp($width_upper_exp));
            my $width_lower = &postfix_exp_evaluate(&infix_exp_to_postfix_exp($width_lower_exp));

            $port_width_hash{$port} = $width_upper - $width_lower + 1;
        }
        else
        {
            $port_width_hash{$port} = 1;
        }
    }

    die "[error-script] the hash array port_width_hash is empty" if (scalar keys %port_width_hash) == 0;
}

sub infix_exp_to_postfix_exp # transform the infix expression to postfix expression, then evaluation
{
    my ($infix_exp)  = @_;
    my $postfix_exp  = '';
    my $num_boundary = ' ';
    my @stack;

    for(my $index = 0; $index < length($infix_exp); $index++)
    {
        my $char = substr($infix_exp,$index,1);

        if($char =~ /[\s]/)
        {
        }
        elsif($char =~ /[\d]/)
        {
            $postfix_exp .= sprintf("%s", $char);
        }
        elsif($char eq '(')
        {
            $postfix_exp .= sprintf("%s", $num_boundary);

            push @stack, $char;
        }
        elsif($char eq ')')
        {
            $postfix_exp .= sprintf("%s", $num_boundary);

            while(my $top = pop @stack)
            {
                $postfix_exp .= sprintf(" %s", $top) if $top ne '(';
                last if $top eq '(';
            }
        }
        elsif($char =~ /[\+\-\*\/]/)
        {
            $postfix_exp .= sprintf("%s", $num_boundary);

            my $lower_priority_op;
            $lower_priority_op = '' if $char eq '+' or $char eq '-';
            $lower_priority_op = '+-' if $char eq '*' or $char eq '/';

            while(my $top = pop @stack)
            {
                if($top eq '(' or index($lower_priority_op, $top) != -1)  # find a lower priority op at the top of the stack
                {
                    push @stack, $top;
                    last;
                }
                $postfix_exp .= sprintf(" %s", $top) if $top ne '(';
            }
            push @stack, $char;
        }
    }

    while(my $top = pop @stack)
    {
        $postfix_exp .= sprintf(" %s", $top);
    }

    return $postfix_exp;
}

sub postfix_exp_evaluate
{
    # starts to evalute the postfix expression

    my ($postfix_exp) = @_;
    my $last_char_is_a_num = 0;
    my $num = 0;
    my @stack;

    for(my $index = 0; $index < length($postfix_exp); $index++)
    {
        my $char = substr($postfix_exp,$index,1);

        if($char =~ /[\d]/)
        {
            $num = $num * 10 + $char;
            $last_char_is_a_num = 1;
        }
        elsif($char =~ /\s/)
        {
            push @stack, $num if $last_char_is_a_num;
            $num = 0;
            $last_char_is_a_num = 0;
        }
        elsif($char =~ /[\+\-\*\/]/)
        {
            my $op2 = pop @stack;
            my $op1 = pop @stack;

            if($char eq '+')
            {
                push @stack, $op1 + $op2;
            }
            elsif($char eq '-')
            {
                push @stack, $op1 - $op2;
            }
            elsif($char eq '*')
            {
                push @stack, $op1 * $op2;
            }
            elsif($char eq '/')
            {
                push @stack, &floor($op1 / $op2);
            }
            $last_char_is_a_num = 0;
        }
    }

    return scalar @stack != 0 ? pop @stack : $num;
}

sub device_constr_parse
{
    my ($device_constr_path) = @_;

    die "[error-script] fail to open the package file for ${device_constr_path}, $!"
    if !open package_file_handle, "<${device_constr_path}";

    say "[info-script] reading ${device_constr_path}";

    while(my $line .= <package_file_handle>)
    {
        next if ($line =~ /\A\#/ or $line =~ /\A\-/);

        my $pin = $+{pin} if($line =~ /(?<pin>\w+)\s+/);

=pod
        if($line =~ /(?<pin>\w+)                \s+
                        (?<pin_name>\w+)           \s+
                        (?<memory_byte_group>\w+)  \s+
                        (?<bank>\w+)               \s+
                        (?<vccaux_group>\w+)       \s+
                        (?<super_logic_region>\w+) \s+
                        (?<io_type>\w+)            \s+
                        (?<no_connect>.+)          \s+
                        /ix)
=cut
        # filter out the pins which does not have general purpose I/O support
        if($line =~ /\s+(?<io_type>HP|HR)\s+/)
        {
            $pin_hash{$pin} = 1;
        }
    };

    close package_file_handle;

    return scalar keys %pin_hash
}

sub output_xdc_generate
{
    my ($autogen_constr_file_path, $device_constr_path, $num_pins_device) = @_;

    my $xdc_output_buffer = '';

    my $total_width = 0;
    foreach my $port_name (keys %port_width_hash)
    {
        #say "[info-script] the port $port_name requires ".$port_width_hash{$port_name}." pins";
        $total_width += $port_width_hash{$port_name};
    }
    say "[info-script] the selected design requires $total_width pins in total";
    say "[info-script] the selected fpga device has $num_pins_device general purpose I/O pins in total";
    die "[error-script] no enough num of pins for this device !" if $total_width > $num_pins_device;

    # example
    # set_property package_pin h20 [get_ports {vga_g[4]}];

    foreach my $port_name (sort keys %port_width_hash)
    {
        my $width = $port_width_hash{$port_name};

        if($width == 1)
        {
            $xdc_output_buffer .= sprintf "set_property package_pin %s [get_ports %s]\n",
                                            &pin_allocate($port_name, $device_constr_path), $port_name;

            #$xdc_output_buffer .= sprintf "set_property iostandard $iostandard [get_ports %s]\n\n", $port_name;
        }
        else
        {
            while($width--)
            {
                $xdc_output_buffer .= sprintf "set_property package_pin %s [get_ports {%s[%d]}]\n",
                                                &pin_allocate($port_name, $device_constr_path), $port_name, $width;
                #$xdc_output_buffer .= sprintf "set_property iostandard $iostandard [get_ports {%s[%d]}]\n\n",
                                                #$port_name, $width;
            }
        }
    }

    die "[error-script] fail to open the output constraints file for $autogen_constr_file_path, $!"
    if !open xdc_handle, ">$autogen_constr_file_path";

    foreach my $device (keys %device_info_hash)
    {
        if($device_constr_path =~ $device)
        {
            $xdc_output_buffer .= sprintf("create_clock -period %d -name clk_in -waveform {0 %f} [get_ports clk_in]\n\n",
                            $cycle_time, $cycle_time/2) if !exists $pin_hash{%{$device_info_hash{$device}}{'clk_in'}};
            #$xdc_output_buffer .= sprintf("set_property clock_dedicated_route false [get_nets clk_ibuf]\n\n");
        }
    }

    say "[info-script] the cycle time is ", $cycle_time, " ns";

    printf xdc_handle "%s", $xdc_output_buffer;
    close xdc_handle;
}

sub pin_allocate
{
    my ($port_name, $device_constr_path) = @_;
    my $pin = '';

    foreach my $device (keys %device_info_hash)
    {
        if($device_constr_path =~ $device)
        {
            foreach my $pre_allocated_port (keys %{$device_info_hash{$device}})
            {
                if($port_name eq $pre_allocated_port)
                {
                    $pin = $device_info_hash{$device}{$pre_allocated_port};
                    goto delete_pin;
                }
            }

            # non pre_allocated_port
            my %pre_allocated_pin_port_hash = reverse %{$device_info_hash{$device}};
            foreach my $pin_to_check (keys %pin_hash)
            {
                if(!exists $pre_allocated_pin_port_hash{$pin_to_check})
                {
                    $pin = $pin_to_check;
                    goto delete_pin;
                }
            }
        }
    }

    delete_pin:
    my $result = delete $pin_hash{$pin};
    goto no_pin if !defined $result;
    return $pin;

    no_pin:
    die "[error-script] the pin $pin does not detected or was already assigned";
    &Dumper(\%pin_hash);
}

