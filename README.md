#介绍

这是用Chisel翻译的破布师兄的unified_cache代码，用于对比verilog和chisel。

#用法

1. 配置git

`git submodule init`
`git submodule update --remote`

2. 修改pumpkin脚本
`python launch.py init`

3. 直接综合verilog原版cache

`python launch.py verilog`

4. 或生成chisel版本的cache并综合

`python launch.py chisel`

