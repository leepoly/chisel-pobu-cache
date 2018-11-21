### ����

������Chisel������Ʋ�ʦ�ֵ�unified_cache���룬���ڶԱ�verilog��chisel��



### �����ļ���˵��

|               | Verilog������Դ                                              | Chisel������Դ                                      | ������                          |
| ------------- | ------------------------------------------------------------ | --------------------------------------------------- | ------------------------------- |
| `����1.0.xls` | ʮ�·��Ʋ�ʦ�ֵ�cache                                        | ������䷭��                                        | ��ȫһ��                        |
| `����3.1.xls` | ��ֹ11.16�ŵ�cache����Ҫ�ı䣺fifo�洢��Ԫ������FF������lutram�� | ������䷭�룬��bram��lutram����Chisel��SyncMemԭ�� | ����ȫһ�£�cache���Ե㲿��ͨ�� |
| `����4.0.xls` | ͬ��                                                         | ram, arbiter,fifo����Chisel����Ӧԭ��ʵ��           | ����ȫһ�£�cache���Ե㲻��ͨ�� |



### prerequisite

- python
- perl(>=5.24)
- vivado 2017 or later
- sbt with chisel installed



### �÷�

1. ����git

`git submodule init`

`git submodule update --remote`



2. �޸�pumpkin�ű�
  `python launch.py init`



3. ֱ���ۺ�verilogԭ��cache

`python launch.py verilog`



4. ������chisel�汾��cache���ۺ�

`python launch.py chisel`

