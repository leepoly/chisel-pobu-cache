import sys, getopt
import os

# print str(sys.argv)

def modify_script():
	file = open('./pumpkin/pumpkin.pl')
	output_f = open('./pumpkin/pumpkin_m.pl', 'w+')
	line = file.readline()
	line = line.replace('usr/local/bin/perl', 'usr/bin/perl')
	output_f.write(line + '\n')
	line = file.readline()
	output_f.write(line + '\n')
	line = file.readline()
	line = line.replace('5.26', '5.24')
	output_f.write(line + '\n')
	while line:
		line = file.readline()
		output_f.write(line)
	file.close()
	output_f.close()

	file = open('./pumpkin/verify/assist_script/auto_constr.pl')
	output_f = open('./pumpkin/verify/assist_script/auto_constr_m.pl', 'w+')
	line = file.readline()
	line = line.replace('usr/local/bin/perl', 'usr/bin/perl')
	output_f.write(line)
	line = file.readline()
	output_f.write(line)
	line = file.readline()
	line = line.replace('5.26', '5.24')
	output_f.write(line)
	while line:
		line = file.readline()
		output_f.write(line)
	file.close()
	output_f.close()
	os.system('cp ./pumpkin/verify/assist_script/auto_constr_m.pl ./pumpkin/verify/assist_script/auto_constr.pl')

	file = open('./pumpkin/verify/assist_script/vivado_wrapper.tcl')
	output_f = open('./pumpkin/verify/assist_script/vivado_wrapper_m.tcl', 'w+')
	while 1:
		line = file.readline()
		if not line:
			break
		line = line.replace('2018', '2017')
		output_f.write(line)
	file.close()
	output_f.close()
	os.system('cp ./pumpkin/verify/assist_script/vivado_wrapper_m.tcl ./pumpkin/verify/assist_script/vivado_wrapper.tcl')


if __name__ == "__main__":
	if len(sys.argv) < 2:
		print('try \'python launch.py chisel\' to generate the chisel code and run synthesis')
		print('try \'python launch.py verilog\' to copy original verilog code and run synthesis')
	elif (sys.argv[1] == 'init'):
		print('launch.py: modifying pumpkin script...')
		modify_script()
	elif (sys.argv[1] == 'chisel'):
		print('launch.py: removing existed verilog code...')
		os.system('rm ./pumpkin/rtl/common/basic_storage/*.v')
		os.system('rm ./pumpkin/rtl/common/advanced_logic/priority_arbiter.v')
		os.system('rm ./pumpkin/rtl/unified_cache/unified_cache_bank.v')

		print('launch.py: Compiling scala files...')
		os.system('sbt \'runMain cacheDriver\'')

		print('launch.py: updating pumpkin source code...')
		os.system('cp ./src/main/scala/unified_cache.v ./pumpkin/rtl/unified_cache/unified_cache.v')
		os.system('cp ./true_unified_cache.v ./pumpkin/rtl/unified_cache/true_unified_cache.v')

		print('launch.py: building pumpkin...')
		os.chdir('./pumpkin')
		os.system('perl ./pumpkin_m.pl -unit unified_cache')
	elif (sys.argv[1] == 'verilog'):
		print('launch.py: removing existed scala code...')
		os.system('rm ./pumpkin/rtl/unified_cache/true_unified_cache.v')
		print('launch.py: updating pumpkin source code...')
		os.system('cp -r ./verilog_src/* ./pumpkin/rtl/')
		
		print('launch.py: building pumpkin...')
		os.chdir('./pumpkin')
		os.system('perl ./pumpkin_m.pl -unit unified_cache')

	else:
		print('try \'python launch.py chisel\' to generate the chisel code and run synthesis')
		print('try \'python launch.py verilog\' to copy original verilog code and run synthesis')
