import sys, getopt
import os

# print str(sys.argv)

if len(sys.argv) < 2:
	print('try \'python launch.py chisel\' to generate the chisel code and run synthesis')
	print('try \'python launch.py verilog\' to copy original verilog code and run synthesis')
elif (sys.argv[1] == 'chisel'):
	os.system('sbt \'runMain cacheDriver\'')
	os.system('rm ./pumpkin/rtl/common/basic_storage/*.v')
	os.system('rm ./pumpkin/rtl/common/advanced_logic/priority_arbiter.v')
	os.system('rm ./pumpkin/rtl/unified_cache/unified_cache_bank.v')

	os.system('cp ./src/main/scala/unified_cache.v ./pumpkin/rtl/unified_cache/unified_cache.v')
	os.system('cp ./true_unified_cache.v ./pumpkin/rtl/unified_cache/true_unified_cache.v')
	os.chdir('./pumpkin')
	os.system('./pumpkin.pl -unit unified_cache')
elif (sys.argv[1] == 'verilog'):
	os.system('rm ./pumpkin/rtl/unified_cache/true_unified_cache.v')
	os.system('cp -r ./verilog_src/* ./pumpkin/rtl/')
	os.chdir('./pumpkin')
	os.system('./pumpkin.pl -unit unified_cache')

else:
	print('try \'python launch.py chisel\' to generate the chisel code and run synthesis')
	print('try \'python launch.py verilog\' to copy original verilog code and run synthesis')
