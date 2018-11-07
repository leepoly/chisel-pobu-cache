### 介绍

这是用Chisel翻译的破布师兄的unified_cache代码，用于对比verilog和chisel。

### prerequisite
- python
- perl(>=5.24)
- vivado 2017 or later
- sbt

### 用法

1. 配置git

`git submodule init`

`git submodule update --remote`

2. 修改pumpkin脚本
注：脚本用于修改配置文件符合ict服务器的配置；如果不在ict网络中，请忽略脚本修改，改为自己配置perl和vivado版本及路径
需要修改的地方有`/pumpkin/pumpkin.pl` `/pumpkin/verify/assist_scripts/vivado_wrapper.tcl` `/pumpkin/verify/assist_scripts/auto_constr.pl`

`python launch.py init`

3. 直接综合verilog原版cache

`python launch.py verilog`

4. 或生成chisel版本的cache并综合

`python launch.py chisel`

