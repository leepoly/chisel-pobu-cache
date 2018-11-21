### 介绍

这是用Chisel翻译的破布师兄的unified_cache代码，用于对比verilog和chisel。



### 评测文件的说明

|               | Verilog数据来源                                              | Chisel数据来源                                      | 功能性                          |
| ------------- | ------------------------------------------------------------ | --------------------------------------------------- | ------------------------------- |
| `评测1.0.xls` | 十月份破布师兄的cache                                        | 逐行语句翻译                                        | 完全一致                        |
| `评测3.1.xls` | 截止11.16号的cache（主要改变：fifo存储单元不再用FF，而是lutram） | 逐行语句翻译，但bram和lutram用了Chisel的SyncMem原语 | 不完全一致，cache测试点部分通过 |
| `评测4.0.xls` | 同上                                                         | ram, arbiter,fifo均用Chisel的相应原语实现           | 不完全一致，cache测试点不能通过 |



### prerequisite

- python
- perl(>=5.24)
- vivado 2017 or later
- sbt with chisel installed



### 用法

1. 配置git

`git submodule init`

`git submodule update --remote`



2. 修改pumpkin脚本
  `python launch.py init`



3. 直接综合verilog原版cache

`python launch.py verilog`



4. 或生成chisel版本的cache并综合

`python launch.py chisel`

