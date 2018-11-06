module fifo_queue_chisel( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  output        io_is_empty_out, // @[:@6.4]
  output        io_is_full_out, // @[:@6.4]
  input  [79:0] io_request_in, // @[:@6.4]
  input         io_request_valid_in, // @[:@6.4]
  output        io_issue_ack_out, // @[:@6.4]
  output [79:0] io_request_out, // @[:@6.4]
  output        io_request_valid_out, // @[:@6.4]
  input         io_issue_ack_in // @[:@6.4]
);
  reg  issue_ack_out_reg; // @[fifo_queue_chisel.scala 27:40:@8.4]
  reg [31:0] _RAND_0;
  reg [79:0] request_out_reg; // @[fifo_queue_chisel.scala 28:38:@9.4]
  reg [95:0] _RAND_1;
  reg  request_valid_out_reg; // @[fifo_queue_chisel.scala 29:44:@10.4]
  reg [31:0] _RAND_2;
  reg [1:0] write_ptr; // @[fifo_queue_chisel.scala 37:32:@13.4]
  reg [31:0] _RAND_3;
  reg [1:0] read_ptr; // @[fifo_queue_chisel.scala 38:31:@14.4]
  reg [31:0] _RAND_4;
  reg [79:0] entry_vec_0; // @[fifo_queue_chisel.scala 40:32:@20.4]
  reg [95:0] _RAND_5;
  reg [79:0] entry_vec_1; // @[fifo_queue_chisel.scala 40:32:@20.4]
  reg [95:0] _RAND_6;
  reg [79:0] entry_vec_2; // @[fifo_queue_chisel.scala 40:32:@20.4]
  reg [95:0] _RAND_7;
  reg [79:0] entry_vec_3; // @[fifo_queue_chisel.scala 40:32:@20.4]
  reg [95:0] _RAND_8;
  reg  entry_valid_vec_0; // @[fifo_queue_chisel.scala 41:38:@26.4]
  reg [31:0] _RAND_9;
  reg  entry_valid_vec_1; // @[fifo_queue_chisel.scala 41:38:@26.4]
  reg [31:0] _RAND_10;
  reg  entry_valid_vec_2; // @[fifo_queue_chisel.scala 41:38:@26.4]
  reg [31:0] _RAND_11;
  reg  entry_valid_vec_3; // @[fifo_queue_chisel.scala 41:38:@26.4]
  reg [31:0] _RAND_12;
  wire [1:0] _T_133; // @[fifo_queue_chisel.scala 44:43:@27.4]
  wire [1:0] _T_134; // @[fifo_queue_chisel.scala 44:43:@28.4]
  wire [3:0] _T_135; // @[fifo_queue_chisel.scala 44:43:@29.4]
  wire [3:0] _T_136; // @[fifo_queue_chisel.scala 44:50:@30.4]
  wire [3:0] _T_143; // @[fifo_queue_chisel.scala 45:56:@37.4]
  wire  _T_146; // @[fifo_queue_chisel.scala 50:42:@40.4]
  wire  _T_147; // @[fifo_queue_chisel.scala 50:77:@41.4]
  wire  _T_149; // @[fifo_queue_chisel.scala 50:107:@42.4]
  wire  _T_150; // @[fifo_queue_chisel.scala 50:94:@43.4]
  wire  _T_151; // @[fifo_queue_chisel.scala 50:58:@44.4]
  wire  _T_152; // @[fifo_queue_chisel.scala 50:124:@45.4]
  wire  _T_153; // @[fifo_queue_chisel.scala 50:122:@46.4]
  wire  _T_154; // @[fifo_queue_chisel.scala 50:143:@47.4]
  wire  _T_156; // @[fifo_queue_chisel.scala 50:178:@48.4]
  wire  write_qualified_0; // @[fifo_queue_chisel.scala 50:165:@49.4]
  wire  _T_158; // @[fifo_queue_chisel.scala 51:40:@51.4]
  wire  _T_159; // @[fifo_queue_chisel.scala 51:57:@52.4]
  wire  _T_160; // @[fifo_queue_chisel.scala 51:75:@53.4]
  wire  read_qualified_0; // @[fifo_queue_chisel.scala 51:98:@55.4]
  wire  _T_169; // @[fifo_queue_chisel.scala 57:59:@65.6]
  wire [79:0] _GEN_0; // @[fifo_queue_chisel.scala 64:75:@78.10]
  wire  _GEN_1; // @[fifo_queue_chisel.scala 64:75:@78.10]
  wire [79:0] _GEN_2; // @[fifo_queue_chisel.scala 61:67:@72.8]
  wire  _GEN_3; // @[fifo_queue_chisel.scala 61:67:@72.8]
  wire [79:0] _GEN_4; // @[fifo_queue_chisel.scala 57:90:@66.6]
  wire  _GEN_5; // @[fifo_queue_chisel.scala 57:90:@66.6]
  wire [79:0] _GEN_6; // @[fifo_queue_chisel.scala 53:37:@58.4]
  wire  _GEN_7; // @[fifo_queue_chisel.scala 53:37:@58.4]
  wire  _T_179; // @[fifo_queue_chisel.scala 50:107:@90.4]
  wire  _T_180; // @[fifo_queue_chisel.scala 50:94:@91.4]
  wire  _T_181; // @[fifo_queue_chisel.scala 50:58:@92.4]
  wire  _T_183; // @[fifo_queue_chisel.scala 50:122:@94.4]
  wire  _T_184; // @[fifo_queue_chisel.scala 50:143:@95.4]
  wire  _T_186; // @[fifo_queue_chisel.scala 50:178:@96.4]
  wire  write_qualified_1; // @[fifo_queue_chisel.scala 50:165:@97.4]
  wire  _T_190; // @[fifo_queue_chisel.scala 51:75:@101.4]
  wire  read_qualified_1; // @[fifo_queue_chisel.scala 51:98:@103.4]
  wire  _T_199; // @[fifo_queue_chisel.scala 57:59:@113.6]
  wire [79:0] _GEN_8; // @[fifo_queue_chisel.scala 64:75:@126.10]
  wire  _GEN_9; // @[fifo_queue_chisel.scala 64:75:@126.10]
  wire [79:0] _GEN_10; // @[fifo_queue_chisel.scala 61:67:@120.8]
  wire  _GEN_11; // @[fifo_queue_chisel.scala 61:67:@120.8]
  wire [79:0] _GEN_12; // @[fifo_queue_chisel.scala 57:90:@114.6]
  wire  _GEN_13; // @[fifo_queue_chisel.scala 57:90:@114.6]
  wire [79:0] _GEN_14; // @[fifo_queue_chisel.scala 53:37:@106.4]
  wire  _GEN_15; // @[fifo_queue_chisel.scala 53:37:@106.4]
  wire  _T_209; // @[fifo_queue_chisel.scala 50:107:@138.4]
  wire  _T_210; // @[fifo_queue_chisel.scala 50:94:@139.4]
  wire  _T_211; // @[fifo_queue_chisel.scala 50:58:@140.4]
  wire  _T_213; // @[fifo_queue_chisel.scala 50:122:@142.4]
  wire  _T_214; // @[fifo_queue_chisel.scala 50:143:@143.4]
  wire  _T_216; // @[fifo_queue_chisel.scala 50:178:@144.4]
  wire  write_qualified_2; // @[fifo_queue_chisel.scala 50:165:@145.4]
  wire  _T_220; // @[fifo_queue_chisel.scala 51:75:@149.4]
  wire  read_qualified_2; // @[fifo_queue_chisel.scala 51:98:@151.4]
  wire  _T_229; // @[fifo_queue_chisel.scala 57:59:@161.6]
  wire [79:0] _GEN_16; // @[fifo_queue_chisel.scala 64:75:@174.10]
  wire  _GEN_17; // @[fifo_queue_chisel.scala 64:75:@174.10]
  wire [79:0] _GEN_18; // @[fifo_queue_chisel.scala 61:67:@168.8]
  wire  _GEN_19; // @[fifo_queue_chisel.scala 61:67:@168.8]
  wire [79:0] _GEN_20; // @[fifo_queue_chisel.scala 57:90:@162.6]
  wire  _GEN_21; // @[fifo_queue_chisel.scala 57:90:@162.6]
  wire [79:0] _GEN_22; // @[fifo_queue_chisel.scala 53:37:@154.4]
  wire  _GEN_23; // @[fifo_queue_chisel.scala 53:37:@154.4]
  wire  _T_239; // @[fifo_queue_chisel.scala 50:107:@186.4]
  wire  _T_240; // @[fifo_queue_chisel.scala 50:94:@187.4]
  wire  _T_241; // @[fifo_queue_chisel.scala 50:58:@188.4]
  wire  _T_243; // @[fifo_queue_chisel.scala 50:122:@190.4]
  wire  _T_244; // @[fifo_queue_chisel.scala 50:143:@191.4]
  wire  _T_246; // @[fifo_queue_chisel.scala 50:178:@192.4]
  wire  write_qualified_3; // @[fifo_queue_chisel.scala 50:165:@193.4]
  wire  _T_250; // @[fifo_queue_chisel.scala 51:75:@197.4]
  wire  read_qualified_3; // @[fifo_queue_chisel.scala 51:98:@199.4]
  wire  _T_259; // @[fifo_queue_chisel.scala 57:59:@209.6]
  wire [79:0] _GEN_24; // @[fifo_queue_chisel.scala 64:75:@222.10]
  wire  _GEN_25; // @[fifo_queue_chisel.scala 64:75:@222.10]
  wire [79:0] _GEN_26; // @[fifo_queue_chisel.scala 61:67:@216.8]
  wire  _GEN_27; // @[fifo_queue_chisel.scala 61:67:@216.8]
  wire [79:0] _GEN_28; // @[fifo_queue_chisel.scala 57:90:@210.6]
  wire  _GEN_29; // @[fifo_queue_chisel.scala 57:90:@210.6]
  wire [79:0] _GEN_30; // @[fifo_queue_chisel.scala 53:37:@202.4]
  wire  _GEN_31; // @[fifo_queue_chisel.scala 53:37:@202.4]
  wire [1:0] _T_272; // @[fifo_queue_chisel.scala 83:39:@241.6]
  wire [1:0] _T_273; // @[fifo_queue_chisel.scala 83:39:@242.6]
  wire [3:0] _T_274; // @[fifo_queue_chisel.scala 83:39:@243.6]
  wire  _T_276; // @[fifo_queue_chisel.scala 83:46:@244.6]
  wire [3:0] _T_279; // @[fifo_queue_chisel.scala 85:50:@246.8]
  wire [4:0] _T_281; // @[fifo_queue_chisel.scala 85:79:@247.8]
  wire [4:0] _T_282; // @[fifo_queue_chisel.scala 85:79:@248.8]
  wire [3:0] _T_283; // @[fifo_queue_chisel.scala 85:79:@249.8]
  wire [3:0] _GEN_55; // @[fifo_queue_chisel.scala 85:41:@250.8]
  wire  _T_284; // @[fifo_queue_chisel.scala 85:41:@250.8]
  wire [2:0] _T_287; // @[fifo_queue_chisel.scala 88:56:@255.10]
  wire [1:0] _T_288; // @[fifo_queue_chisel.scala 88:56:@256.10]
  wire [1:0] _GEN_32; // @[fifo_queue_chisel.scala 85:87:@251.8]
  wire [1:0] _GEN_33; // @[fifo_queue_chisel.scala 83:51:@245.6]
  wire [1:0] _T_291; // @[fifo_queue_chisel.scala 97:38:@265.6]
  wire [1:0] _T_292; // @[fifo_queue_chisel.scala 97:38:@266.6]
  wire [3:0] _T_293; // @[fifo_queue_chisel.scala 97:38:@267.6]
  wire  _T_295; // @[fifo_queue_chisel.scala 97:45:@268.6]
  wire [3:0] _GEN_56; // @[fifo_queue_chisel.scala 98:40:@274.8]
  wire  _T_303; // @[fifo_queue_chisel.scala 98:40:@274.8]
  wire [2:0] _T_306; // @[fifo_queue_chisel.scala 101:54:@279.10]
  wire [1:0] _T_307; // @[fifo_queue_chisel.scala 101:54:@280.10]
  wire [1:0] _GEN_35; // @[fifo_queue_chisel.scala 98:86:@275.8]
  wire  _GEN_37; // @[fifo_queue_chisel.scala 105:56:@287.8]
  wire  _GEN_38; // @[fifo_queue_chisel.scala 105:56:@287.8]
  wire  _GEN_39; // @[fifo_queue_chisel.scala 105:56:@287.8]
  wire [79:0] _GEN_41; // @[fifo_queue_chisel.scala 107:41:@290.10]
  wire [79:0] _GEN_42; // @[fifo_queue_chisel.scala 107:41:@290.10]
  wire [79:0] _GEN_43; // @[fifo_queue_chisel.scala 107:41:@290.10]
  wire [79:0] _GEN_45; // @[fifo_queue_chisel.scala 105:64:@288.8]
  wire [1:0] _GEN_47; // @[fifo_queue_chisel.scala 97:50:@269.6]
  wire [79:0] _GEN_48; // @[fifo_queue_chisel.scala 97:50:@269.6]
  wire  _GEN_49; // @[fifo_queue_chisel.scala 97:50:@269.6]
  wire [1:0] _GEN_50; // @[fifo_queue_chisel.scala 76:29:@233.4]
  wire  _GEN_51; // @[fifo_queue_chisel.scala 76:29:@233.4]
  wire [1:0] _GEN_52; // @[fifo_queue_chisel.scala 76:29:@233.4]
  wire [79:0] _GEN_53; // @[fifo_queue_chisel.scala 76:29:@233.4]
  wire  _GEN_54; // @[fifo_queue_chisel.scala 76:29:@233.4]
  assign _T_133 = {entry_valid_vec_1,entry_valid_vec_0}; // @[fifo_queue_chisel.scala 44:43:@27.4]
  assign _T_134 = {entry_valid_vec_3,entry_valid_vec_2}; // @[fifo_queue_chisel.scala 44:43:@28.4]
  assign _T_135 = {_T_134,_T_133}; // @[fifo_queue_chisel.scala 44:43:@29.4]
  assign _T_136 = ~ _T_135; // @[fifo_queue_chisel.scala 44:50:@30.4]
  assign _T_143 = ~ _T_136; // @[fifo_queue_chisel.scala 45:56:@37.4]
  assign _T_146 = ~ io_is_full_out; // @[fifo_queue_chisel.scala 50:42:@40.4]
  assign _T_147 = io_issue_ack_in & io_is_full_out; // @[fifo_queue_chisel.scala 50:77:@41.4]
  assign _T_149 = 2'h0 == read_ptr; // @[fifo_queue_chisel.scala 50:107:@42.4]
  assign _T_150 = _T_147 & _T_149; // @[fifo_queue_chisel.scala 50:94:@43.4]
  assign _T_151 = _T_146 | _T_150; // @[fifo_queue_chisel.scala 50:58:@44.4]
  assign _T_152 = ~ issue_ack_out_reg; // @[fifo_queue_chisel.scala 50:124:@45.4]
  assign _T_153 = _T_151 & _T_152; // @[fifo_queue_chisel.scala 50:122:@46.4]
  assign _T_154 = _T_153 & io_request_valid_in; // @[fifo_queue_chisel.scala 50:143:@47.4]
  assign _T_156 = 2'h0 == write_ptr; // @[fifo_queue_chisel.scala 50:178:@48.4]
  assign write_qualified_0 = _T_154 & _T_156; // @[fifo_queue_chisel.scala 50:165:@49.4]
  assign _T_158 = ~ io_is_empty_out; // @[fifo_queue_chisel.scala 51:40:@51.4]
  assign _T_159 = _T_158 & io_issue_ack_in; // @[fifo_queue_chisel.scala 51:57:@52.4]
  assign _T_160 = _T_159 & entry_valid_vec_0; // @[fifo_queue_chisel.scala 51:75:@53.4]
  assign read_qualified_0 = _T_160 & _T_149; // @[fifo_queue_chisel.scala 51:98:@55.4]
  assign _T_169 = write_qualified_0 & read_qualified_0; // @[fifo_queue_chisel.scala 57:59:@65.6]
  assign _GEN_0 = write_qualified_0 ? io_request_in : entry_vec_0; // @[fifo_queue_chisel.scala 64:75:@78.10]
  assign _GEN_1 = write_qualified_0 ? 1'h1 : entry_valid_vec_0; // @[fifo_queue_chisel.scala 64:75:@78.10]
  assign _GEN_2 = read_qualified_0 ? 80'h0 : _GEN_0; // @[fifo_queue_chisel.scala 61:67:@72.8]
  assign _GEN_3 = read_qualified_0 ? 1'h0 : _GEN_1; // @[fifo_queue_chisel.scala 61:67:@72.8]
  assign _GEN_4 = _T_169 ? io_request_in : _GEN_2; // @[fifo_queue_chisel.scala 57:90:@66.6]
  assign _GEN_5 = _T_169 ? 1'h1 : _GEN_3; // @[fifo_queue_chisel.scala 57:90:@66.6]
  assign _GEN_6 = reset ? 80'h0 : _GEN_4; // @[fifo_queue_chisel.scala 53:37:@58.4]
  assign _GEN_7 = reset ? 1'h0 : _GEN_5; // @[fifo_queue_chisel.scala 53:37:@58.4]
  assign _T_179 = 2'h1 == read_ptr; // @[fifo_queue_chisel.scala 50:107:@90.4]
  assign _T_180 = _T_147 & _T_179; // @[fifo_queue_chisel.scala 50:94:@91.4]
  assign _T_181 = _T_146 | _T_180; // @[fifo_queue_chisel.scala 50:58:@92.4]
  assign _T_183 = _T_181 & _T_152; // @[fifo_queue_chisel.scala 50:122:@94.4]
  assign _T_184 = _T_183 & io_request_valid_in; // @[fifo_queue_chisel.scala 50:143:@95.4]
  assign _T_186 = 2'h1 == write_ptr; // @[fifo_queue_chisel.scala 50:178:@96.4]
  assign write_qualified_1 = _T_184 & _T_186; // @[fifo_queue_chisel.scala 50:165:@97.4]
  assign _T_190 = _T_159 & entry_valid_vec_1; // @[fifo_queue_chisel.scala 51:75:@101.4]
  assign read_qualified_1 = _T_190 & _T_179; // @[fifo_queue_chisel.scala 51:98:@103.4]
  assign _T_199 = write_qualified_1 & read_qualified_1; // @[fifo_queue_chisel.scala 57:59:@113.6]
  assign _GEN_8 = write_qualified_1 ? io_request_in : entry_vec_1; // @[fifo_queue_chisel.scala 64:75:@126.10]
  assign _GEN_9 = write_qualified_1 ? 1'h1 : entry_valid_vec_1; // @[fifo_queue_chisel.scala 64:75:@126.10]
  assign _GEN_10 = read_qualified_1 ? 80'h0 : _GEN_8; // @[fifo_queue_chisel.scala 61:67:@120.8]
  assign _GEN_11 = read_qualified_1 ? 1'h0 : _GEN_9; // @[fifo_queue_chisel.scala 61:67:@120.8]
  assign _GEN_12 = _T_199 ? io_request_in : _GEN_10; // @[fifo_queue_chisel.scala 57:90:@114.6]
  assign _GEN_13 = _T_199 ? 1'h1 : _GEN_11; // @[fifo_queue_chisel.scala 57:90:@114.6]
  assign _GEN_14 = reset ? 80'h0 : _GEN_12; // @[fifo_queue_chisel.scala 53:37:@106.4]
  assign _GEN_15 = reset ? 1'h0 : _GEN_13; // @[fifo_queue_chisel.scala 53:37:@106.4]
  assign _T_209 = 2'h2 == read_ptr; // @[fifo_queue_chisel.scala 50:107:@138.4]
  assign _T_210 = _T_147 & _T_209; // @[fifo_queue_chisel.scala 50:94:@139.4]
  assign _T_211 = _T_146 | _T_210; // @[fifo_queue_chisel.scala 50:58:@140.4]
  assign _T_213 = _T_211 & _T_152; // @[fifo_queue_chisel.scala 50:122:@142.4]
  assign _T_214 = _T_213 & io_request_valid_in; // @[fifo_queue_chisel.scala 50:143:@143.4]
  assign _T_216 = 2'h2 == write_ptr; // @[fifo_queue_chisel.scala 50:178:@144.4]
  assign write_qualified_2 = _T_214 & _T_216; // @[fifo_queue_chisel.scala 50:165:@145.4]
  assign _T_220 = _T_159 & entry_valid_vec_2; // @[fifo_queue_chisel.scala 51:75:@149.4]
  assign read_qualified_2 = _T_220 & _T_209; // @[fifo_queue_chisel.scala 51:98:@151.4]
  assign _T_229 = write_qualified_2 & read_qualified_2; // @[fifo_queue_chisel.scala 57:59:@161.6]
  assign _GEN_16 = write_qualified_2 ? io_request_in : entry_vec_2; // @[fifo_queue_chisel.scala 64:75:@174.10]
  assign _GEN_17 = write_qualified_2 ? 1'h1 : entry_valid_vec_2; // @[fifo_queue_chisel.scala 64:75:@174.10]
  assign _GEN_18 = read_qualified_2 ? 80'h0 : _GEN_16; // @[fifo_queue_chisel.scala 61:67:@168.8]
  assign _GEN_19 = read_qualified_2 ? 1'h0 : _GEN_17; // @[fifo_queue_chisel.scala 61:67:@168.8]
  assign _GEN_20 = _T_229 ? io_request_in : _GEN_18; // @[fifo_queue_chisel.scala 57:90:@162.6]
  assign _GEN_21 = _T_229 ? 1'h1 : _GEN_19; // @[fifo_queue_chisel.scala 57:90:@162.6]
  assign _GEN_22 = reset ? 80'h0 : _GEN_20; // @[fifo_queue_chisel.scala 53:37:@154.4]
  assign _GEN_23 = reset ? 1'h0 : _GEN_21; // @[fifo_queue_chisel.scala 53:37:@154.4]
  assign _T_239 = 2'h3 == read_ptr; // @[fifo_queue_chisel.scala 50:107:@186.4]
  assign _T_240 = _T_147 & _T_239; // @[fifo_queue_chisel.scala 50:94:@187.4]
  assign _T_241 = _T_146 | _T_240; // @[fifo_queue_chisel.scala 50:58:@188.4]
  assign _T_243 = _T_241 & _T_152; // @[fifo_queue_chisel.scala 50:122:@190.4]
  assign _T_244 = _T_243 & io_request_valid_in; // @[fifo_queue_chisel.scala 50:143:@191.4]
  assign _T_246 = 2'h3 == write_ptr; // @[fifo_queue_chisel.scala 50:178:@192.4]
  assign write_qualified_3 = _T_244 & _T_246; // @[fifo_queue_chisel.scala 50:165:@193.4]
  assign _T_250 = _T_159 & entry_valid_vec_3; // @[fifo_queue_chisel.scala 51:75:@197.4]
  assign read_qualified_3 = _T_250 & _T_239; // @[fifo_queue_chisel.scala 51:98:@199.4]
  assign _T_259 = write_qualified_3 & read_qualified_3; // @[fifo_queue_chisel.scala 57:59:@209.6]
  assign _GEN_24 = write_qualified_3 ? io_request_in : entry_vec_3; // @[fifo_queue_chisel.scala 64:75:@222.10]
  assign _GEN_25 = write_qualified_3 ? 1'h1 : entry_valid_vec_3; // @[fifo_queue_chisel.scala 64:75:@222.10]
  assign _GEN_26 = read_qualified_3 ? 80'h0 : _GEN_24; // @[fifo_queue_chisel.scala 61:67:@216.8]
  assign _GEN_27 = read_qualified_3 ? 1'h0 : _GEN_25; // @[fifo_queue_chisel.scala 61:67:@216.8]
  assign _GEN_28 = _T_259 ? io_request_in : _GEN_26; // @[fifo_queue_chisel.scala 57:90:@210.6]
  assign _GEN_29 = _T_259 ? 1'h1 : _GEN_27; // @[fifo_queue_chisel.scala 57:90:@210.6]
  assign _GEN_30 = reset ? 80'h0 : _GEN_28; // @[fifo_queue_chisel.scala 53:37:@202.4]
  assign _GEN_31 = reset ? 1'h0 : _GEN_29; // @[fifo_queue_chisel.scala 53:37:@202.4]
  assign _T_272 = {write_qualified_1,write_qualified_0}; // @[fifo_queue_chisel.scala 83:39:@241.6]
  assign _T_273 = {write_qualified_3,write_qualified_2}; // @[fifo_queue_chisel.scala 83:39:@242.6]
  assign _T_274 = {_T_273,_T_272}; // @[fifo_queue_chisel.scala 83:39:@243.6]
  assign _T_276 = _T_274 != 4'h0; // @[fifo_queue_chisel.scala 83:46:@244.6]
  assign _T_279 = 4'h1 << 2'h2; // @[fifo_queue_chisel.scala 85:50:@246.8]
  assign _T_281 = _T_279 - 4'h1; // @[fifo_queue_chisel.scala 85:79:@247.8]
  assign _T_282 = $unsigned(_T_281); // @[fifo_queue_chisel.scala 85:79:@248.8]
  assign _T_283 = _T_282[3:0]; // @[fifo_queue_chisel.scala 85:79:@249.8]
  assign _GEN_55 = {{2'd0}, write_ptr}; // @[fifo_queue_chisel.scala 85:41:@250.8]
  assign _T_284 = _GEN_55 == _T_283; // @[fifo_queue_chisel.scala 85:41:@250.8]
  assign _T_287 = write_ptr + 2'h1; // @[fifo_queue_chisel.scala 88:56:@255.10]
  assign _T_288 = _T_287[1:0]; // @[fifo_queue_chisel.scala 88:56:@256.10]
  assign _GEN_32 = _T_284 ? 2'h0 : _T_288; // @[fifo_queue_chisel.scala 85:87:@251.8]
  assign _GEN_33 = _T_276 ? _GEN_32 : write_ptr; // @[fifo_queue_chisel.scala 83:51:@245.6]
  assign _T_291 = {read_qualified_1,read_qualified_0}; // @[fifo_queue_chisel.scala 97:38:@265.6]
  assign _T_292 = {read_qualified_3,read_qualified_2}; // @[fifo_queue_chisel.scala 97:38:@266.6]
  assign _T_293 = {_T_292,_T_291}; // @[fifo_queue_chisel.scala 97:38:@267.6]
  assign _T_295 = _T_293 != 4'h0; // @[fifo_queue_chisel.scala 97:45:@268.6]
  assign _GEN_56 = {{2'd0}, read_ptr}; // @[fifo_queue_chisel.scala 98:40:@274.8]
  assign _T_303 = _GEN_56 == _T_283; // @[fifo_queue_chisel.scala 98:40:@274.8]
  assign _T_306 = read_ptr + 2'h1; // @[fifo_queue_chisel.scala 101:54:@279.10]
  assign _T_307 = _T_306[1:0]; // @[fifo_queue_chisel.scala 101:54:@280.10]
  assign _GEN_35 = _T_303 ? 2'h0 : _T_307; // @[fifo_queue_chisel.scala 98:86:@275.8]
  assign _GEN_37 = 2'h1 == read_ptr ? entry_valid_vec_1 : entry_valid_vec_0; // @[fifo_queue_chisel.scala 105:56:@287.8]
  assign _GEN_38 = 2'h2 == read_ptr ? entry_valid_vec_2 : _GEN_37; // @[fifo_queue_chisel.scala 105:56:@287.8]
  assign _GEN_39 = 2'h3 == read_ptr ? entry_valid_vec_3 : _GEN_38; // @[fifo_queue_chisel.scala 105:56:@287.8]
  assign _GEN_41 = 2'h1 == read_ptr ? entry_vec_1 : entry_vec_0; // @[fifo_queue_chisel.scala 107:41:@290.10]
  assign _GEN_42 = 2'h2 == read_ptr ? entry_vec_2 : _GEN_41; // @[fifo_queue_chisel.scala 107:41:@290.10]
  assign _GEN_43 = 2'h3 == read_ptr ? entry_vec_3 : _GEN_42; // @[fifo_queue_chisel.scala 107:41:@290.10]
  assign _GEN_45 = _GEN_39 ? _GEN_43 : 80'h0; // @[fifo_queue_chisel.scala 105:64:@288.8]
  assign _GEN_47 = _T_295 ? _GEN_35 : read_ptr; // @[fifo_queue_chisel.scala 97:50:@269.6]
  assign _GEN_48 = _T_295 ? 80'h0 : _GEN_45; // @[fifo_queue_chisel.scala 97:50:@269.6]
  assign _GEN_49 = _T_295 ? 1'h0 : _GEN_39; // @[fifo_queue_chisel.scala 97:50:@269.6]
  assign _GEN_50 = reset ? 2'h0 : _GEN_33; // @[fifo_queue_chisel.scala 76:29:@233.4]
  assign _GEN_51 = reset ? 1'h0 : _T_276; // @[fifo_queue_chisel.scala 76:29:@233.4]
  assign _GEN_52 = reset ? 2'h0 : _GEN_47; // @[fifo_queue_chisel.scala 76:29:@233.4]
  assign _GEN_53 = reset ? 80'h0 : _GEN_48; // @[fifo_queue_chisel.scala 76:29:@233.4]
  assign _GEN_54 = reset ? 1'h0 : _GEN_49; // @[fifo_queue_chisel.scala 76:29:@233.4]
  assign io_is_empty_out = _T_143 == 4'h0; // @[fifo_queue_chisel.scala 45:25:@39.4]
  assign io_is_full_out = _T_136 == 4'h0; // @[fifo_queue_chisel.scala 44:24:@32.4]
  assign io_issue_ack_out = issue_ack_out_reg; // @[fifo_queue_chisel.scala 116:26:@299.4]
  assign io_request_out = request_out_reg; // @[fifo_queue_chisel.scala 117:24:@300.4]
  assign io_request_valid_out = request_valid_out_reg; // @[fifo_queue_chisel.scala 118:30:@301.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  issue_ack_out_reg = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {3{`RANDOM}};
  request_out_reg = _RAND_1[79:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  request_valid_out_reg = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  write_ptr = _RAND_3[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  read_ptr = _RAND_4[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {3{`RANDOM}};
  entry_vec_0 = _RAND_5[79:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {3{`RANDOM}};
  entry_vec_1 = _RAND_6[79:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {3{`RANDOM}};
  entry_vec_2 = _RAND_7[79:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {3{`RANDOM}};
  entry_vec_3 = _RAND_8[79:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  entry_valid_vec_0 = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  entry_valid_vec_1 = _RAND_10[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  entry_valid_vec_2 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  entry_valid_vec_3 = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      issue_ack_out_reg <= 1'h0;
    end else begin
      if (reset) begin
        issue_ack_out_reg <= 1'h0;
      end else begin
        issue_ack_out_reg <= _T_276;
      end
    end
    if (reset) begin
      request_out_reg <= 80'h0;
    end else begin
      if (reset) begin
        request_out_reg <= 80'h0;
      end else begin
        if (_T_295) begin
          request_out_reg <= 80'h0;
        end else begin
          if (_GEN_39) begin
            if (2'h3 == read_ptr) begin
              request_out_reg <= entry_vec_3;
            end else begin
              if (2'h2 == read_ptr) begin
                request_out_reg <= entry_vec_2;
              end else begin
                if (2'h1 == read_ptr) begin
                  request_out_reg <= entry_vec_1;
                end else begin
                  request_out_reg <= entry_vec_0;
                end
              end
            end
          end else begin
            request_out_reg <= 80'h0;
          end
        end
      end
    end
    if (reset) begin
      request_valid_out_reg <= 1'h0;
    end else begin
      if (reset) begin
        request_valid_out_reg <= 1'h0;
      end else begin
        if (_T_295) begin
          request_valid_out_reg <= 1'h0;
        end else begin
          if (2'h3 == read_ptr) begin
            request_valid_out_reg <= entry_valid_vec_3;
          end else begin
            if (2'h2 == read_ptr) begin
              request_valid_out_reg <= entry_valid_vec_2;
            end else begin
              if (2'h1 == read_ptr) begin
                request_valid_out_reg <= entry_valid_vec_1;
              end else begin
                request_valid_out_reg <= entry_valid_vec_0;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      write_ptr <= 2'h0;
    end else begin
      if (reset) begin
        write_ptr <= 2'h0;
      end else begin
        if (_T_276) begin
          if (_T_284) begin
            write_ptr <= 2'h0;
          end else begin
            write_ptr <= _T_288;
          end
        end
      end
    end
    if (reset) begin
      read_ptr <= 2'h0;
    end else begin
      if (reset) begin
        read_ptr <= 2'h0;
      end else begin
        if (_T_295) begin
          if (_T_303) begin
            read_ptr <= 2'h0;
          end else begin
            read_ptr <= _T_307;
          end
        end
      end
    end
    if (reset) begin
      entry_vec_0 <= 80'h0;
    end else begin
      if (reset) begin
        entry_vec_0 <= 80'h0;
      end else begin
        if (_T_169) begin
          entry_vec_0 <= io_request_in;
        end else begin
          if (read_qualified_0) begin
            entry_vec_0 <= 80'h0;
          end else begin
            if (write_qualified_0) begin
              entry_vec_0 <= io_request_in;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_vec_1 <= 80'h0;
    end else begin
      if (reset) begin
        entry_vec_1 <= 80'h0;
      end else begin
        if (_T_199) begin
          entry_vec_1 <= io_request_in;
        end else begin
          if (read_qualified_1) begin
            entry_vec_1 <= 80'h0;
          end else begin
            if (write_qualified_1) begin
              entry_vec_1 <= io_request_in;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_vec_2 <= 80'h0;
    end else begin
      if (reset) begin
        entry_vec_2 <= 80'h0;
      end else begin
        if (_T_229) begin
          entry_vec_2 <= io_request_in;
        end else begin
          if (read_qualified_2) begin
            entry_vec_2 <= 80'h0;
          end else begin
            if (write_qualified_2) begin
              entry_vec_2 <= io_request_in;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_vec_3 <= 80'h0;
    end else begin
      if (reset) begin
        entry_vec_3 <= 80'h0;
      end else begin
        if (_T_259) begin
          entry_vec_3 <= io_request_in;
        end else begin
          if (read_qualified_3) begin
            entry_vec_3 <= 80'h0;
          end else begin
            if (write_qualified_3) begin
              entry_vec_3 <= io_request_in;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_valid_vec_0 <= 1'h0;
    end else begin
      if (reset) begin
        entry_valid_vec_0 <= 1'h0;
      end else begin
        if (_T_169) begin
          entry_valid_vec_0 <= 1'h1;
        end else begin
          if (read_qualified_0) begin
            entry_valid_vec_0 <= 1'h0;
          end else begin
            if (write_qualified_0) begin
              entry_valid_vec_0 <= 1'h1;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_valid_vec_1 <= 1'h0;
    end else begin
      if (reset) begin
        entry_valid_vec_1 <= 1'h0;
      end else begin
        if (_T_199) begin
          entry_valid_vec_1 <= 1'h1;
        end else begin
          if (read_qualified_1) begin
            entry_valid_vec_1 <= 1'h0;
          end else begin
            if (write_qualified_1) begin
              entry_valid_vec_1 <= 1'h1;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_valid_vec_2 <= 1'h0;
    end else begin
      if (reset) begin
        entry_valid_vec_2 <= 1'h0;
      end else begin
        if (_T_229) begin
          entry_valid_vec_2 <= 1'h1;
        end else begin
          if (read_qualified_2) begin
            entry_valid_vec_2 <= 1'h0;
          end else begin
            if (write_qualified_2) begin
              entry_valid_vec_2 <= 1'h1;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_valid_vec_3 <= 1'h0;
    end else begin
      if (reset) begin
        entry_valid_vec_3 <= 1'h0;
      end else begin
        if (_T_259) begin
          entry_valid_vec_3 <= 1'h1;
        end else begin
          if (read_qualified_3) begin
            entry_valid_vec_3 <= 1'h0;
          end else begin
            if (write_qualified_3) begin
              entry_valid_vec_3 <= 1'h1;
            end
          end
        end
      end
    end
  end
endmodule
module fifo_queue_chisel_2( // @[:@603.2]
  input         clock, // @[:@604.4]
  input         reset, // @[:@605.4]
  output        io_is_empty_out, // @[:@606.4]
  output        io_is_full_out, // @[:@606.4]
  input  [80:0] io_request_in, // @[:@606.4]
  input         io_request_valid_in, // @[:@606.4]
  output        io_issue_ack_out, // @[:@606.4]
  output [80:0] io_request_out, // @[:@606.4]
  output        io_request_valid_out, // @[:@606.4]
  input         io_issue_ack_in // @[:@606.4]
);
  reg  issue_ack_out_reg; // @[fifo_queue_chisel.scala 27:40:@608.4]
  reg [31:0] _RAND_0;
  reg [80:0] request_out_reg; // @[fifo_queue_chisel.scala 28:38:@609.4]
  reg [95:0] _RAND_1;
  reg  request_valid_out_reg; // @[fifo_queue_chisel.scala 29:44:@610.4]
  reg [31:0] _RAND_2;
  reg  write_ptr; // @[fifo_queue_chisel.scala 37:32:@613.4]
  reg [31:0] _RAND_3;
  reg  read_ptr; // @[fifo_queue_chisel.scala 38:31:@614.4]
  reg [31:0] _RAND_4;
  reg [80:0] entry_vec_0; // @[fifo_queue_chisel.scala 40:32:@618.4]
  reg [95:0] _RAND_5;
  reg [80:0] entry_vec_1; // @[fifo_queue_chisel.scala 40:32:@618.4]
  reg [95:0] _RAND_6;
  reg  entry_valid_vec_0; // @[fifo_queue_chisel.scala 41:38:@622.4]
  reg [31:0] _RAND_7;
  reg  entry_valid_vec_1; // @[fifo_queue_chisel.scala 41:38:@622.4]
  reg [31:0] _RAND_8;
  wire [1:0] _T_101; // @[fifo_queue_chisel.scala 44:43:@623.4]
  wire [1:0] _T_102; // @[fifo_queue_chisel.scala 44:50:@624.4]
  wire [1:0] _T_107; // @[fifo_queue_chisel.scala 45:56:@629.4]
  wire  _T_110; // @[fifo_queue_chisel.scala 50:42:@632.4]
  wire  _T_111; // @[fifo_queue_chisel.scala 50:77:@633.4]
  wire  _T_113; // @[fifo_queue_chisel.scala 50:107:@634.4]
  wire  _T_114; // @[fifo_queue_chisel.scala 50:94:@635.4]
  wire  _T_115; // @[fifo_queue_chisel.scala 50:58:@636.4]
  wire  _T_116; // @[fifo_queue_chisel.scala 50:124:@637.4]
  wire  _T_117; // @[fifo_queue_chisel.scala 50:122:@638.4]
  wire  _T_118; // @[fifo_queue_chisel.scala 50:143:@639.4]
  wire  _T_120; // @[fifo_queue_chisel.scala 50:178:@640.4]
  wire  write_qualified_0; // @[fifo_queue_chisel.scala 50:165:@641.4]
  wire  _T_122; // @[fifo_queue_chisel.scala 51:40:@643.4]
  wire  _T_123; // @[fifo_queue_chisel.scala 51:57:@644.4]
  wire  _T_124; // @[fifo_queue_chisel.scala 51:75:@645.4]
  wire  read_qualified_0; // @[fifo_queue_chisel.scala 51:98:@647.4]
  wire  _T_133; // @[fifo_queue_chisel.scala 57:59:@657.6]
  wire [80:0] _GEN_0; // @[fifo_queue_chisel.scala 64:75:@670.10]
  wire  _GEN_1; // @[fifo_queue_chisel.scala 64:75:@670.10]
  wire [80:0] _GEN_2; // @[fifo_queue_chisel.scala 61:67:@664.8]
  wire  _GEN_3; // @[fifo_queue_chisel.scala 61:67:@664.8]
  wire [80:0] _GEN_4; // @[fifo_queue_chisel.scala 57:90:@658.6]
  wire  _GEN_5; // @[fifo_queue_chisel.scala 57:90:@658.6]
  wire [80:0] _GEN_6; // @[fifo_queue_chisel.scala 53:37:@650.4]
  wire  _GEN_7; // @[fifo_queue_chisel.scala 53:37:@650.4]
  wire  _T_144; // @[fifo_queue_chisel.scala 50:94:@683.4]
  wire  _T_145; // @[fifo_queue_chisel.scala 50:58:@684.4]
  wire  _T_147; // @[fifo_queue_chisel.scala 50:122:@686.4]
  wire  _T_148; // @[fifo_queue_chisel.scala 50:143:@687.4]
  wire  write_qualified_1; // @[fifo_queue_chisel.scala 50:165:@689.4]
  wire  _T_154; // @[fifo_queue_chisel.scala 51:75:@693.4]
  wire  read_qualified_1; // @[fifo_queue_chisel.scala 51:98:@695.4]
  wire  _T_163; // @[fifo_queue_chisel.scala 57:59:@705.6]
  wire [80:0] _GEN_8; // @[fifo_queue_chisel.scala 64:75:@718.10]
  wire  _GEN_9; // @[fifo_queue_chisel.scala 64:75:@718.10]
  wire [80:0] _GEN_10; // @[fifo_queue_chisel.scala 61:67:@712.8]
  wire  _GEN_11; // @[fifo_queue_chisel.scala 61:67:@712.8]
  wire [80:0] _GEN_12; // @[fifo_queue_chisel.scala 57:90:@706.6]
  wire  _GEN_13; // @[fifo_queue_chisel.scala 57:90:@706.6]
  wire [80:0] _GEN_14; // @[fifo_queue_chisel.scala 53:37:@698.4]
  wire  _GEN_15; // @[fifo_queue_chisel.scala 53:37:@698.4]
  wire [1:0] _T_176; // @[fifo_queue_chisel.scala 83:39:@737.6]
  wire  _T_178; // @[fifo_queue_chisel.scala 83:46:@738.6]
  wire [1:0] _T_181; // @[fifo_queue_chisel.scala 85:50:@740.8]
  wire [2:0] _T_183; // @[fifo_queue_chisel.scala 85:79:@741.8]
  wire [2:0] _T_184; // @[fifo_queue_chisel.scala 85:79:@742.8]
  wire [1:0] _T_185; // @[fifo_queue_chisel.scala 85:79:@743.8]
  wire [1:0] _GEN_35; // @[fifo_queue_chisel.scala 85:41:@744.8]
  wire  _T_186; // @[fifo_queue_chisel.scala 85:41:@744.8]
  wire [1:0] _T_189; // @[fifo_queue_chisel.scala 88:56:@749.10]
  wire  _T_190; // @[fifo_queue_chisel.scala 88:56:@750.10]
  wire  _GEN_16; // @[fifo_queue_chisel.scala 85:87:@745.8]
  wire  _GEN_17; // @[fifo_queue_chisel.scala 83:51:@739.6]
  wire [1:0] _T_193; // @[fifo_queue_chisel.scala 97:38:@759.6]
  wire  _T_195; // @[fifo_queue_chisel.scala 97:45:@760.6]
  wire [1:0] _GEN_36; // @[fifo_queue_chisel.scala 98:40:@766.8]
  wire  _T_203; // @[fifo_queue_chisel.scala 98:40:@766.8]
  wire [1:0] _T_206; // @[fifo_queue_chisel.scala 101:54:@771.10]
  wire  _T_207; // @[fifo_queue_chisel.scala 101:54:@772.10]
  wire  _GEN_19; // @[fifo_queue_chisel.scala 98:86:@767.8]
  wire  _GEN_21; // @[fifo_queue_chisel.scala 105:56:@779.8]
  wire [80:0] _GEN_23; // @[fifo_queue_chisel.scala 107:41:@782.10]
  wire [80:0] _GEN_25; // @[fifo_queue_chisel.scala 105:64:@780.8]
  wire  _GEN_27; // @[fifo_queue_chisel.scala 97:50:@761.6]
  wire [80:0] _GEN_28; // @[fifo_queue_chisel.scala 97:50:@761.6]
  wire  _GEN_29; // @[fifo_queue_chisel.scala 97:50:@761.6]
  wire  _GEN_30; // @[fifo_queue_chisel.scala 76:29:@729.4]
  wire  _GEN_31; // @[fifo_queue_chisel.scala 76:29:@729.4]
  wire  _GEN_32; // @[fifo_queue_chisel.scala 76:29:@729.4]
  wire [80:0] _GEN_33; // @[fifo_queue_chisel.scala 76:29:@729.4]
  wire  _GEN_34; // @[fifo_queue_chisel.scala 76:29:@729.4]
  assign _T_101 = {entry_valid_vec_1,entry_valid_vec_0}; // @[fifo_queue_chisel.scala 44:43:@623.4]
  assign _T_102 = ~ _T_101; // @[fifo_queue_chisel.scala 44:50:@624.4]
  assign _T_107 = ~ _T_102; // @[fifo_queue_chisel.scala 45:56:@629.4]
  assign _T_110 = ~ io_is_full_out; // @[fifo_queue_chisel.scala 50:42:@632.4]
  assign _T_111 = io_issue_ack_in & io_is_full_out; // @[fifo_queue_chisel.scala 50:77:@633.4]
  assign _T_113 = 1'h0 == read_ptr; // @[fifo_queue_chisel.scala 50:107:@634.4]
  assign _T_114 = _T_111 & _T_113; // @[fifo_queue_chisel.scala 50:94:@635.4]
  assign _T_115 = _T_110 | _T_114; // @[fifo_queue_chisel.scala 50:58:@636.4]
  assign _T_116 = ~ issue_ack_out_reg; // @[fifo_queue_chisel.scala 50:124:@637.4]
  assign _T_117 = _T_115 & _T_116; // @[fifo_queue_chisel.scala 50:122:@638.4]
  assign _T_118 = _T_117 & io_request_valid_in; // @[fifo_queue_chisel.scala 50:143:@639.4]
  assign _T_120 = 1'h0 == write_ptr; // @[fifo_queue_chisel.scala 50:178:@640.4]
  assign write_qualified_0 = _T_118 & _T_120; // @[fifo_queue_chisel.scala 50:165:@641.4]
  assign _T_122 = ~ io_is_empty_out; // @[fifo_queue_chisel.scala 51:40:@643.4]
  assign _T_123 = _T_122 & io_issue_ack_in; // @[fifo_queue_chisel.scala 51:57:@644.4]
  assign _T_124 = _T_123 & entry_valid_vec_0; // @[fifo_queue_chisel.scala 51:75:@645.4]
  assign read_qualified_0 = _T_124 & _T_113; // @[fifo_queue_chisel.scala 51:98:@647.4]
  assign _T_133 = write_qualified_0 & read_qualified_0; // @[fifo_queue_chisel.scala 57:59:@657.6]
  assign _GEN_0 = write_qualified_0 ? io_request_in : entry_vec_0; // @[fifo_queue_chisel.scala 64:75:@670.10]
  assign _GEN_1 = write_qualified_0 ? 1'h1 : entry_valid_vec_0; // @[fifo_queue_chisel.scala 64:75:@670.10]
  assign _GEN_2 = read_qualified_0 ? 81'h0 : _GEN_0; // @[fifo_queue_chisel.scala 61:67:@664.8]
  assign _GEN_3 = read_qualified_0 ? 1'h0 : _GEN_1; // @[fifo_queue_chisel.scala 61:67:@664.8]
  assign _GEN_4 = _T_133 ? io_request_in : _GEN_2; // @[fifo_queue_chisel.scala 57:90:@658.6]
  assign _GEN_5 = _T_133 ? 1'h1 : _GEN_3; // @[fifo_queue_chisel.scala 57:90:@658.6]
  assign _GEN_6 = reset ? 81'h0 : _GEN_4; // @[fifo_queue_chisel.scala 53:37:@650.4]
  assign _GEN_7 = reset ? 1'h0 : _GEN_5; // @[fifo_queue_chisel.scala 53:37:@650.4]
  assign _T_144 = _T_111 & read_ptr; // @[fifo_queue_chisel.scala 50:94:@683.4]
  assign _T_145 = _T_110 | _T_144; // @[fifo_queue_chisel.scala 50:58:@684.4]
  assign _T_147 = _T_145 & _T_116; // @[fifo_queue_chisel.scala 50:122:@686.4]
  assign _T_148 = _T_147 & io_request_valid_in; // @[fifo_queue_chisel.scala 50:143:@687.4]
  assign write_qualified_1 = _T_148 & write_ptr; // @[fifo_queue_chisel.scala 50:165:@689.4]
  assign _T_154 = _T_123 & entry_valid_vec_1; // @[fifo_queue_chisel.scala 51:75:@693.4]
  assign read_qualified_1 = _T_154 & read_ptr; // @[fifo_queue_chisel.scala 51:98:@695.4]
  assign _T_163 = write_qualified_1 & read_qualified_1; // @[fifo_queue_chisel.scala 57:59:@705.6]
  assign _GEN_8 = write_qualified_1 ? io_request_in : entry_vec_1; // @[fifo_queue_chisel.scala 64:75:@718.10]
  assign _GEN_9 = write_qualified_1 ? 1'h1 : entry_valid_vec_1; // @[fifo_queue_chisel.scala 64:75:@718.10]
  assign _GEN_10 = read_qualified_1 ? 81'h0 : _GEN_8; // @[fifo_queue_chisel.scala 61:67:@712.8]
  assign _GEN_11 = read_qualified_1 ? 1'h0 : _GEN_9; // @[fifo_queue_chisel.scala 61:67:@712.8]
  assign _GEN_12 = _T_163 ? io_request_in : _GEN_10; // @[fifo_queue_chisel.scala 57:90:@706.6]
  assign _GEN_13 = _T_163 ? 1'h1 : _GEN_11; // @[fifo_queue_chisel.scala 57:90:@706.6]
  assign _GEN_14 = reset ? 81'h0 : _GEN_12; // @[fifo_queue_chisel.scala 53:37:@698.4]
  assign _GEN_15 = reset ? 1'h0 : _GEN_13; // @[fifo_queue_chisel.scala 53:37:@698.4]
  assign _T_176 = {write_qualified_1,write_qualified_0}; // @[fifo_queue_chisel.scala 83:39:@737.6]
  assign _T_178 = _T_176 != 2'h0; // @[fifo_queue_chisel.scala 83:46:@738.6]
  assign _T_181 = 2'h1 << 1'h1; // @[fifo_queue_chisel.scala 85:50:@740.8]
  assign _T_183 = _T_181 - 2'h1; // @[fifo_queue_chisel.scala 85:79:@741.8]
  assign _T_184 = $unsigned(_T_183); // @[fifo_queue_chisel.scala 85:79:@742.8]
  assign _T_185 = _T_184[1:0]; // @[fifo_queue_chisel.scala 85:79:@743.8]
  assign _GEN_35 = {{1'd0}, write_ptr}; // @[fifo_queue_chisel.scala 85:41:@744.8]
  assign _T_186 = _GEN_35 == _T_185; // @[fifo_queue_chisel.scala 85:41:@744.8]
  assign _T_189 = write_ptr + 1'h1; // @[fifo_queue_chisel.scala 88:56:@749.10]
  assign _T_190 = _T_189[0:0]; // @[fifo_queue_chisel.scala 88:56:@750.10]
  assign _GEN_16 = _T_186 ? 1'h0 : _T_190; // @[fifo_queue_chisel.scala 85:87:@745.8]
  assign _GEN_17 = _T_178 ? _GEN_16 : write_ptr; // @[fifo_queue_chisel.scala 83:51:@739.6]
  assign _T_193 = {read_qualified_1,read_qualified_0}; // @[fifo_queue_chisel.scala 97:38:@759.6]
  assign _T_195 = _T_193 != 2'h0; // @[fifo_queue_chisel.scala 97:45:@760.6]
  assign _GEN_36 = {{1'd0}, read_ptr}; // @[fifo_queue_chisel.scala 98:40:@766.8]
  assign _T_203 = _GEN_36 == _T_185; // @[fifo_queue_chisel.scala 98:40:@766.8]
  assign _T_206 = read_ptr + 1'h1; // @[fifo_queue_chisel.scala 101:54:@771.10]
  assign _T_207 = _T_206[0:0]; // @[fifo_queue_chisel.scala 101:54:@772.10]
  assign _GEN_19 = _T_203 ? 1'h0 : _T_207; // @[fifo_queue_chisel.scala 98:86:@767.8]
  assign _GEN_21 = read_ptr ? entry_valid_vec_1 : entry_valid_vec_0; // @[fifo_queue_chisel.scala 105:56:@779.8]
  assign _GEN_23 = read_ptr ? entry_vec_1 : entry_vec_0; // @[fifo_queue_chisel.scala 107:41:@782.10]
  assign _GEN_25 = _GEN_21 ? _GEN_23 : 81'h0; // @[fifo_queue_chisel.scala 105:64:@780.8]
  assign _GEN_27 = _T_195 ? _GEN_19 : read_ptr; // @[fifo_queue_chisel.scala 97:50:@761.6]
  assign _GEN_28 = _T_195 ? 81'h0 : _GEN_25; // @[fifo_queue_chisel.scala 97:50:@761.6]
  assign _GEN_29 = _T_195 ? 1'h0 : _GEN_21; // @[fifo_queue_chisel.scala 97:50:@761.6]
  assign _GEN_30 = reset ? 1'h0 : _GEN_17; // @[fifo_queue_chisel.scala 76:29:@729.4]
  assign _GEN_31 = reset ? 1'h0 : _T_178; // @[fifo_queue_chisel.scala 76:29:@729.4]
  assign _GEN_32 = reset ? 1'h0 : _GEN_27; // @[fifo_queue_chisel.scala 76:29:@729.4]
  assign _GEN_33 = reset ? 81'h0 : _GEN_28; // @[fifo_queue_chisel.scala 76:29:@729.4]
  assign _GEN_34 = reset ? 1'h0 : _GEN_29; // @[fifo_queue_chisel.scala 76:29:@729.4]
  assign io_is_empty_out = _T_107 == 2'h0; // @[fifo_queue_chisel.scala 45:25:@631.4]
  assign io_is_full_out = _T_102 == 2'h0; // @[fifo_queue_chisel.scala 44:24:@626.4]
  assign io_issue_ack_out = issue_ack_out_reg; // @[fifo_queue_chisel.scala 116:26:@791.4]
  assign io_request_out = request_out_reg; // @[fifo_queue_chisel.scala 117:24:@792.4]
  assign io_request_valid_out = request_valid_out_reg; // @[fifo_queue_chisel.scala 118:30:@793.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  issue_ack_out_reg = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {3{`RANDOM}};
  request_out_reg = _RAND_1[80:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  request_valid_out_reg = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  write_ptr = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  read_ptr = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {3{`RANDOM}};
  entry_vec_0 = _RAND_5[80:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {3{`RANDOM}};
  entry_vec_1 = _RAND_6[80:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  entry_valid_vec_0 = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  entry_valid_vec_1 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      issue_ack_out_reg <= 1'h0;
    end else begin
      if (reset) begin
        issue_ack_out_reg <= 1'h0;
      end else begin
        issue_ack_out_reg <= _T_178;
      end
    end
    if (reset) begin
      request_out_reg <= 81'h0;
    end else begin
      if (reset) begin
        request_out_reg <= 81'h0;
      end else begin
        if (_T_195) begin
          request_out_reg <= 81'h0;
        end else begin
          if (_GEN_21) begin
            if (read_ptr) begin
              request_out_reg <= entry_vec_1;
            end else begin
              request_out_reg <= entry_vec_0;
            end
          end else begin
            request_out_reg <= 81'h0;
          end
        end
      end
    end
    if (reset) begin
      request_valid_out_reg <= 1'h0;
    end else begin
      if (reset) begin
        request_valid_out_reg <= 1'h0;
      end else begin
        if (_T_195) begin
          request_valid_out_reg <= 1'h0;
        end else begin
          if (read_ptr) begin
            request_valid_out_reg <= entry_valid_vec_1;
          end else begin
            request_valid_out_reg <= entry_valid_vec_0;
          end
        end
      end
    end
    if (reset) begin
      write_ptr <= 1'h0;
    end else begin
      if (reset) begin
        write_ptr <= 1'h0;
      end else begin
        if (_T_178) begin
          if (_T_186) begin
            write_ptr <= 1'h0;
          end else begin
            write_ptr <= _T_190;
          end
        end
      end
    end
    if (reset) begin
      read_ptr <= 1'h0;
    end else begin
      if (reset) begin
        read_ptr <= 1'h0;
      end else begin
        if (_T_195) begin
          if (_T_203) begin
            read_ptr <= 1'h0;
          end else begin
            read_ptr <= _T_207;
          end
        end
      end
    end
    if (reset) begin
      entry_vec_0 <= 81'h0;
    end else begin
      if (reset) begin
        entry_vec_0 <= 81'h0;
      end else begin
        if (_T_133) begin
          entry_vec_0 <= io_request_in;
        end else begin
          if (read_qualified_0) begin
            entry_vec_0 <= 81'h0;
          end else begin
            if (write_qualified_0) begin
              entry_vec_0 <= io_request_in;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_vec_1 <= 81'h0;
    end else begin
      if (reset) begin
        entry_vec_1 <= 81'h0;
      end else begin
        if (_T_163) begin
          entry_vec_1 <= io_request_in;
        end else begin
          if (read_qualified_1) begin
            entry_vec_1 <= 81'h0;
          end else begin
            if (write_qualified_1) begin
              entry_vec_1 <= io_request_in;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_valid_vec_0 <= 1'h0;
    end else begin
      if (reset) begin
        entry_valid_vec_0 <= 1'h0;
      end else begin
        if (_T_133) begin
          entry_valid_vec_0 <= 1'h1;
        end else begin
          if (read_qualified_0) begin
            entry_valid_vec_0 <= 1'h0;
          end else begin
            if (write_qualified_0) begin
              entry_valid_vec_0 <= 1'h1;
            end
          end
        end
      end
    end
    if (reset) begin
      entry_valid_vec_1 <= 1'h0;
    end else begin
      if (reset) begin
        entry_valid_vec_1 <= 1'h0;
      end else begin
        if (_T_163) begin
          entry_valid_vec_1 <= 1'h1;
        end else begin
          if (read_qualified_1) begin
            entry_valid_vec_1 <= 1'h0;
          end else begin
            if (write_qualified_1) begin
              entry_valid_vec_1 <= 1'h1;
            end
          end
        end
      end
    end
  end
endmodule
module priority_arbiter_chisel( // @[:@987.2]
  input          clock, // @[:@988.4]
  input          reset, // @[:@989.4]
  input  [159:0] io_request_flatted_in, // @[:@990.4]
  input  [1:0]   io_request_valid_flatted_in, // @[:@990.4]
  input  [1:0]   io_request_critical_flatted_in, // @[:@990.4]
  output [1:0]   io_issue_ack_out, // @[:@990.4]
  output [79:0]  io_request_out, // @[:@990.4]
  output         io_request_valid_out, // @[:@990.4]
  input          io_issue_ack_in // @[:@990.4]
);
  wire  fifo_queue_chisel_clock; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire  fifo_queue_chisel_reset; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire  fifo_queue_chisel_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire  fifo_queue_chisel_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire [80:0] fifo_queue_chisel_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire  fifo_queue_chisel_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire  fifo_queue_chisel_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire [80:0] fifo_queue_chisel_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire  fifo_queue_chisel_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire  fifo_queue_chisel_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@1003.4]
  wire  fifo_queue_chisel_1_clock; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire  fifo_queue_chisel_1_reset; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire  fifo_queue_chisel_1_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire  fifo_queue_chisel_1_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire [80:0] fifo_queue_chisel_1_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire  fifo_queue_chisel_1_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire  fifo_queue_chisel_1_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire [80:0] fifo_queue_chisel_1_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire  fifo_queue_chisel_1_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  wire  fifo_queue_chisel_1_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@1021.4]
  reg [79:0] request_out_reg; // @[priority_arbiter_chisel.scala 45:38:@992.4]
  reg [95:0] _RAND_0;
  reg  request_valid_out_reg; // @[priority_arbiter_chisel.scala 46:44:@993.4]
  reg [31:0] _RAND_1;
  wire [79:0] request_packed_in_0; // @[priority_arbiter_chisel.scala 59:74:@1001.4]
  wire  _T_73; // @[priority_arbiter_chisel.scala 66:82:@1007.4]
  wire  request_critical_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 70:107:@1013.4]
  wire [79:0] request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 71:97:@1015.4]
  wire [79:0] request_packed_in_1; // @[priority_arbiter_chisel.scala 59:74:@1019.4]
  wire  _T_79; // @[priority_arbiter_chisel.scala 66:82:@1025.4]
  wire  request_critical_flatted_from_request_queue_1; // @[priority_arbiter_chisel.scala 70:107:@1031.4]
  wire [79:0] request_packed_from_request_queue_1; // @[priority_arbiter_chisel.scala 71:97:@1033.4]
  wire [1:0] _T_85; // @[priority_arbiter_chisel.scala 78:79:@1038.4]
  wire  request_queue_full_1; // @[priority_arbiter_chisel.scala 55:38:@999.4 priority_arbiter_chisel.scala 65:51:@1024.4]
  wire  request_queue_full_0; // @[priority_arbiter_chisel.scala 55:38:@999.4 priority_arbiter_chisel.scala 65:51:@1006.4]
  wire [1:0] _T_86; // @[priority_arbiter_chisel.scala 78:107:@1039.4]
  wire [1:0] request_critical_final; // @[priority_arbiter_chisel.scala 78:86:@1040.4]
  reg  last_send_index; // @[priority_arbiter_chisel.scala 79:38:@1042.4]
  reg [31:0] _RAND_2;
  wire  request_valid_flatted_from_request_queue_1; // @[priority_arbiter_chisel.scala 54:60:@998.4 priority_arbiter_chisel.scala 73:73:@1035.4]
  wire  request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 54:60:@998.4 priority_arbiter_chisel.scala 73:73:@1017.4]
  wire [1:0] _T_92; // @[priority_arbiter_chisel.scala 84:87:@1045.4]
  wire [1:0] _T_94; // @[priority_arbiter_chisel.scala 84:114:@1046.4]
  wire  _T_95; // @[priority_arbiter_chisel.scala 84:114:@1047.4]
  wire [1:0] _T_96; // @[priority_arbiter_chisel.scala 84:94:@1048.4]
  wire [1:0] _GEN_34; // @[priority_arbiter_chisel.scala 85:148:@1050.4]
  wire [2:0] _T_99; // @[priority_arbiter_chisel.scala 85:148:@1050.4]
  wire [2:0] _T_100; // @[priority_arbiter_chisel.scala 85:148:@1051.4]
  wire [1:0] _T_101; // @[priority_arbiter_chisel.scala 85:148:@1052.4]
  wire [2:0] _T_103; // @[priority_arbiter_chisel.scala 85:166:@1053.4]
  wire [2:0] _T_104; // @[priority_arbiter_chisel.scala 85:166:@1054.4]
  wire [1:0] _T_105; // @[priority_arbiter_chisel.scala 85:166:@1055.4]
  wire [4:0] _GEN_35; // @[priority_arbiter_chisel.scala 85:130:@1056.4]
  wire [4:0] _T_106; // @[priority_arbiter_chisel.scala 85:130:@1056.4]
  wire [4:0] _GEN_36; // @[priority_arbiter_chisel.scala 84:122:@1057.4]
  wire [4:0] _T_107; // @[priority_arbiter_chisel.scala 84:122:@1057.4]
  wire [1:0] _T_111; // @[priority_arbiter_chisel.scala 86:72:@1061.4]
  wire [4:0] _GEN_38; // @[priority_arbiter_chisel.scala 87:108:@1068.4]
  wire [4:0] _T_120; // @[priority_arbiter_chisel.scala 87:108:@1068.4]
  wire [4:0] _GEN_39; // @[priority_arbiter_chisel.scala 86:100:@1069.4]
  wire [4:0] _T_121; // @[priority_arbiter_chisel.scala 86:100:@1069.4]
  wire [1:0] request_valid_flatted_shift_left; // @[priority_arbiter_chisel.scala 82:52:@1043.4 priority_arbiter_chisel.scala 84:42:@1058.4]
  wire  _T_125; // @[priority_arbiter_chisel.scala 94:55:@1074.4]
  wire [1:0] _T_130; // @[priority_arbiter_chisel.scala 95:68:@1078.6]
  wire  _T_131; // @[priority_arbiter_chisel.scala 95:68:@1079.6]
  wire [1:0] _GEN_40; // @[priority_arbiter_chisel.scala 96:89:@1086.8]
  wire [1:0] _GEN_1; // @[priority_arbiter_chisel.scala 94:75:@1075.4]
  wire  _T_150; // @[priority_arbiter_chisel.scala 94:55:@1099.4]
  wire  _T_153; // @[priority_arbiter_chisel.scala 95:47:@1102.6]
  wire [1:0] _T_155; // @[priority_arbiter_chisel.scala 95:68:@1103.6]
  wire  _T_156; // @[priority_arbiter_chisel.scala 95:68:@1104.6]
  wire [1:0] _GEN_41; // @[priority_arbiter_chisel.scala 96:89:@1111.8]
  wire [1:0] _GEN_3; // @[priority_arbiter_chisel.scala 94:75:@1100.4]
  wire [1:0] request_critical_flatted_shift_left; // @[priority_arbiter_chisel.scala 83:55:@1044.4 priority_arbiter_chisel.scala 86:45:@1070.4]
  wire  _T_178; // @[priority_arbiter_chisel.scala 108:58:@1127.4]
  wire  _T_180; // @[priority_arbiter_chisel.scala 108:80:@1129.4]
  wire [1:0] _GEN_5; // @[priority_arbiter_chisel.scala 108:138:@1130.4]
  wire  _T_205; // @[priority_arbiter_chisel.scala 108:58:@1154.4]
  wire  _T_207; // @[priority_arbiter_chisel.scala 108:80:@1156.4]
  wire [1:0] _GEN_7; // @[priority_arbiter_chisel.scala 108:138:@1157.4]
  wire  valid_sel; // @[:@1071.4 :@1072.4 priority_arbiter_chisel.scala 91:19:@1073.4 priority_arbiter_chisel.scala 96:43:@1089.8 priority_arbiter_chisel.scala 98:43:@1096.8 priority_arbiter_chisel.scala 96:43:@1114.8 priority_arbiter_chisel.scala 98:43:@1121.8]
  wire  critical_sel; // @[:@1124.4 :@1125.4 priority_arbiter_chisel.scala 105:22:@1126.4 priority_arbiter_chisel.scala 110:46:@1144.8 priority_arbiter_chisel.scala 112:46:@1151.8 priority_arbiter_chisel.scala 110:46:@1171.8 priority_arbiter_chisel.scala 112:46:@1178.8]
  wire  _T_263; // @[priority_arbiter_chisel.scala 136:59:@1211.4]
  wire  _T_278; // @[priority_arbiter_chisel.scala 149:40:@1236.6]
  wire  _T_279; // @[priority_arbiter_chisel.scala 149:68:@1237.6]
  wire  _T_280; // @[priority_arbiter_chisel.scala 149:65:@1238.6]
  wire [1:0] _T_282; // @[priority_arbiter_chisel.scala 150:46:@1241.8]
  wire  _T_283; // @[priority_arbiter_chisel.scala 150:46:@1242.8]
  wire  _GEN_15; // @[priority_arbiter_chisel.scala 150:61:@1243.8]
  wire  _T_285; // @[priority_arbiter_chisel.scala 150:61:@1243.8]
  wire  _T_286; // @[priority_arbiter_chisel.scala 151:49:@1244.8]
  wire  _T_287; // @[priority_arbiter_chisel.scala 151:69:@1245.8]
  wire  _T_289; // @[priority_arbiter_chisel.scala 151:95:@1247.8]
  wire  _T_290; // @[priority_arbiter_chisel.scala 150:118:@1248.8]
  wire [79:0] _GEN_17; // @[priority_arbiter_chisel.scala 152:41:@1251.10]
  wire  _T_295; // @[priority_arbiter_chisel.scala 156:46:@1256.10]
  wire  _T_296; // @[priority_arbiter_chisel.scala 156:66:@1257.10]
  wire  _T_298; // @[priority_arbiter_chisel.scala 156:92:@1259.10]
  wire  _GEN_19; // @[priority_arbiter_chisel.scala 155:83:@1260.10]
  wire  _T_299; // @[priority_arbiter_chisel.scala 155:83:@1260.10]
  wire [79:0] _GEN_21; // @[priority_arbiter_chisel.scala 157:41:@1263.12]
  wire [79:0] _GEN_22; // @[priority_arbiter_chisel.scala 156:129:@1262.10]
  wire  _GEN_24; // @[priority_arbiter_chisel.scala 156:129:@1262.10]
  wire [79:0] _GEN_25; // @[priority_arbiter_chisel.scala 151:132:@1250.8]
  wire  _GEN_26; // @[priority_arbiter_chisel.scala 151:132:@1250.8]
  wire  _GEN_27; // @[priority_arbiter_chisel.scala 151:132:@1250.8]
  wire [79:0] _GEN_28; // @[priority_arbiter_chisel.scala 149:101:@1240.6]
  wire  _GEN_29; // @[priority_arbiter_chisel.scala 149:101:@1240.6]
  wire  _GEN_30; // @[priority_arbiter_chisel.scala 149:101:@1240.6]
  wire [79:0] _GEN_31; // @[priority_arbiter_chisel.scala 145:29:@1230.4]
  wire  _GEN_32; // @[priority_arbiter_chisel.scala 145:29:@1230.4]
  wire  _GEN_33; // @[priority_arbiter_chisel.scala 145:29:@1230.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter_chisel.scala 47:37:@994.4 priority_arbiter_chisel.scala 68:50:@1030.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter_chisel.scala 47:37:@994.4 priority_arbiter_chisel.scala 68:50:@1012.4]
  fifo_queue_chisel_2 fifo_queue_chisel ( // @[priority_arbiter_chisel.scala 61:43:@1003.4]
    .clock(fifo_queue_chisel_clock),
    .reset(fifo_queue_chisel_reset),
    .io_is_empty_out(fifo_queue_chisel_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_io_is_full_out),
    .io_request_in(fifo_queue_chisel_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_1 ( // @[priority_arbiter_chisel.scala 61:43:@1021.4]
    .clock(fifo_queue_chisel_1_clock),
    .reset(fifo_queue_chisel_1_reset),
    .io_is_empty_out(fifo_queue_chisel_1_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_1_io_is_full_out),
    .io_request_in(fifo_queue_chisel_1_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_1_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_1_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_1_io_issue_ack_in)
  );
  assign request_packed_in_0 = io_request_flatted_in[79:0]; // @[priority_arbiter_chisel.scala 59:74:@1001.4]
  assign _T_73 = io_request_critical_flatted_in[0]; // @[priority_arbiter_chisel.scala 66:82:@1007.4]
  assign request_critical_flatted_from_request_queue_0 = fifo_queue_chisel_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@1013.4]
  assign request_packed_from_request_queue_0 = fifo_queue_chisel_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@1015.4]
  assign request_packed_in_1 = io_request_flatted_in[159:80]; // @[priority_arbiter_chisel.scala 59:74:@1019.4]
  assign _T_79 = io_request_critical_flatted_in[1]; // @[priority_arbiter_chisel.scala 66:82:@1025.4]
  assign request_critical_flatted_from_request_queue_1 = fifo_queue_chisel_1_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@1031.4]
  assign request_packed_from_request_queue_1 = fifo_queue_chisel_1_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@1033.4]
  assign _T_85 = {request_critical_flatted_from_request_queue_1,request_critical_flatted_from_request_queue_0}; // @[priority_arbiter_chisel.scala 78:79:@1038.4]
  assign request_queue_full_1 = fifo_queue_chisel_1_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@999.4 priority_arbiter_chisel.scala 65:51:@1024.4]
  assign request_queue_full_0 = fifo_queue_chisel_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@999.4 priority_arbiter_chisel.scala 65:51:@1006.4]
  assign _T_86 = {request_queue_full_1,request_queue_full_0}; // @[priority_arbiter_chisel.scala 78:107:@1039.4]
  assign request_critical_final = _T_85 | _T_86; // @[priority_arbiter_chisel.scala 78:86:@1040.4]
  assign request_valid_flatted_from_request_queue_1 = fifo_queue_chisel_1_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@998.4 priority_arbiter_chisel.scala 73:73:@1035.4]
  assign request_valid_flatted_from_request_queue_0 = fifo_queue_chisel_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@998.4 priority_arbiter_chisel.scala 73:73:@1017.4]
  assign _T_92 = {request_valid_flatted_from_request_queue_1,request_valid_flatted_from_request_queue_0}; // @[priority_arbiter_chisel.scala 84:87:@1045.4]
  assign _T_94 = last_send_index + 1'h1; // @[priority_arbiter_chisel.scala 84:114:@1046.4]
  assign _T_95 = _T_94[0:0]; // @[priority_arbiter_chisel.scala 84:114:@1047.4]
  assign _T_96 = _T_92 >> _T_95; // @[priority_arbiter_chisel.scala 84:94:@1048.4]
  assign _GEN_34 = {{1'd0}, last_send_index}; // @[priority_arbiter_chisel.scala 85:148:@1050.4]
  assign _T_99 = 2'h2 - _GEN_34; // @[priority_arbiter_chisel.scala 85:148:@1050.4]
  assign _T_100 = $unsigned(_T_99); // @[priority_arbiter_chisel.scala 85:148:@1051.4]
  assign _T_101 = _T_100[1:0]; // @[priority_arbiter_chisel.scala 85:148:@1052.4]
  assign _T_103 = _T_101 - 2'h1; // @[priority_arbiter_chisel.scala 85:166:@1053.4]
  assign _T_104 = $unsigned(_T_103); // @[priority_arbiter_chisel.scala 85:166:@1054.4]
  assign _T_105 = _T_104[1:0]; // @[priority_arbiter_chisel.scala 85:166:@1055.4]
  assign _GEN_35 = {{3'd0}, _T_92}; // @[priority_arbiter_chisel.scala 85:130:@1056.4]
  assign _T_106 = _GEN_35 << _T_105; // @[priority_arbiter_chisel.scala 85:130:@1056.4]
  assign _GEN_36 = {{3'd0}, _T_96}; // @[priority_arbiter_chisel.scala 84:122:@1057.4]
  assign _T_107 = _GEN_36 | _T_106; // @[priority_arbiter_chisel.scala 84:122:@1057.4]
  assign _T_111 = request_critical_final >> _T_95; // @[priority_arbiter_chisel.scala 86:72:@1061.4]
  assign _GEN_38 = {{3'd0}, request_critical_final}; // @[priority_arbiter_chisel.scala 87:108:@1068.4]
  assign _T_120 = _GEN_38 << _T_105; // @[priority_arbiter_chisel.scala 87:108:@1068.4]
  assign _GEN_39 = {{3'd0}, _T_111}; // @[priority_arbiter_chisel.scala 86:100:@1069.4]
  assign _T_121 = _GEN_39 | _T_120; // @[priority_arbiter_chisel.scala 86:100:@1069.4]
  assign request_valid_flatted_shift_left = _T_107[1:0]; // @[priority_arbiter_chisel.scala 82:52:@1043.4 priority_arbiter_chisel.scala 84:42:@1058.4]
  assign _T_125 = request_valid_flatted_shift_left[1]; // @[priority_arbiter_chisel.scala 94:55:@1074.4]
  assign _T_130 = _T_95 + 1'h1; // @[priority_arbiter_chisel.scala 95:68:@1078.6]
  assign _T_131 = _T_130[0:0]; // @[priority_arbiter_chisel.scala 95:68:@1079.6]
  assign _GEN_40 = {{1'd0}, _T_131}; // @[priority_arbiter_chisel.scala 96:89:@1086.8]
  assign _GEN_1 = _T_125 ? _GEN_40 : 2'h0; // @[priority_arbiter_chisel.scala 94:75:@1075.4]
  assign _T_150 = request_valid_flatted_shift_left[0]; // @[priority_arbiter_chisel.scala 94:55:@1099.4]
  assign _T_153 = _GEN_34[0:0]; // @[priority_arbiter_chisel.scala 95:47:@1102.6]
  assign _T_155 = _T_153 + 1'h1; // @[priority_arbiter_chisel.scala 95:68:@1103.6]
  assign _T_156 = _T_155[0:0]; // @[priority_arbiter_chisel.scala 95:68:@1104.6]
  assign _GEN_41 = {{1'd0}, _T_156}; // @[priority_arbiter_chisel.scala 96:89:@1111.8]
  assign _GEN_3 = _T_150 ? _GEN_41 : _GEN_1; // @[priority_arbiter_chisel.scala 94:75:@1100.4]
  assign request_critical_flatted_shift_left = _T_121[1:0]; // @[priority_arbiter_chisel.scala 83:55:@1044.4 priority_arbiter_chisel.scala 86:45:@1070.4]
  assign _T_178 = request_critical_flatted_shift_left[1]; // @[priority_arbiter_chisel.scala 108:58:@1127.4]
  assign _T_180 = _T_178 & _T_125; // @[priority_arbiter_chisel.scala 108:80:@1129.4]
  assign _GEN_5 = _T_180 ? _GEN_40 : 2'h0; // @[priority_arbiter_chisel.scala 108:138:@1130.4]
  assign _T_205 = request_critical_flatted_shift_left[0]; // @[priority_arbiter_chisel.scala 108:58:@1154.4]
  assign _T_207 = _T_205 & _T_150; // @[priority_arbiter_chisel.scala 108:80:@1156.4]
  assign _GEN_7 = _T_207 ? _GEN_41 : _GEN_5; // @[priority_arbiter_chisel.scala 108:138:@1157.4]
  assign valid_sel = _GEN_3[0]; // @[:@1071.4 :@1072.4 priority_arbiter_chisel.scala 91:19:@1073.4 priority_arbiter_chisel.scala 96:43:@1089.8 priority_arbiter_chisel.scala 98:43:@1096.8 priority_arbiter_chisel.scala 96:43:@1114.8 priority_arbiter_chisel.scala 98:43:@1121.8]
  assign critical_sel = _GEN_7[0]; // @[:@1124.4 :@1125.4 priority_arbiter_chisel.scala 105:22:@1126.4 priority_arbiter_chisel.scala 110:46:@1144.8 priority_arbiter_chisel.scala 112:46:@1151.8 priority_arbiter_chisel.scala 110:46:@1171.8 priority_arbiter_chisel.scala 112:46:@1178.8]
  assign _T_263 = last_send_index == 1'h0; // @[priority_arbiter_chisel.scala 136:59:@1211.4]
  assign _T_278 = io_issue_ack_in & request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:40:@1236.6]
  assign _T_279 = ~ request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:68:@1237.6]
  assign _T_280 = _T_278 | _T_279; // @[priority_arbiter_chisel.scala 149:65:@1238.6]
  assign _T_282 = request_critical_final >> critical_sel; // @[priority_arbiter_chisel.scala 150:46:@1241.8]
  assign _T_283 = _T_282[0]; // @[priority_arbiter_chisel.scala 150:46:@1242.8]
  assign _GEN_15 = critical_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 150:61:@1243.8]
  assign _T_285 = _T_283 & _GEN_15; // @[priority_arbiter_chisel.scala 150:61:@1243.8]
  assign _T_286 = critical_sel != last_send_index; // @[priority_arbiter_chisel.scala 151:49:@1244.8]
  assign _T_287 = _T_286 & request_valid_out_reg; // @[priority_arbiter_chisel.scala 151:69:@1245.8]
  assign _T_289 = _T_287 | _T_279; // @[priority_arbiter_chisel.scala 151:95:@1247.8]
  assign _T_290 = _T_285 & _T_289; // @[priority_arbiter_chisel.scala 150:118:@1248.8]
  assign _GEN_17 = critical_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 152:41:@1251.10]
  assign _T_295 = valid_sel != last_send_index; // @[priority_arbiter_chisel.scala 156:46:@1256.10]
  assign _T_296 = _T_295 & request_valid_out_reg; // @[priority_arbiter_chisel.scala 156:66:@1257.10]
  assign _T_298 = _T_296 | _T_279; // @[priority_arbiter_chisel.scala 156:92:@1259.10]
  assign _GEN_19 = valid_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 155:83:@1260.10]
  assign _T_299 = _GEN_19 & _T_298; // @[priority_arbiter_chisel.scala 155:83:@1260.10]
  assign _GEN_21 = valid_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 157:41:@1263.12]
  assign _GEN_22 = _T_299 ? _GEN_21 : 80'h0; // @[priority_arbiter_chisel.scala 156:129:@1262.10]
  assign _GEN_24 = _T_299 ? valid_sel : last_send_index; // @[priority_arbiter_chisel.scala 156:129:@1262.10]
  assign _GEN_25 = _T_290 ? _GEN_17 : _GEN_22; // @[priority_arbiter_chisel.scala 151:132:@1250.8]
  assign _GEN_26 = _T_290 ? 1'h1 : _T_299; // @[priority_arbiter_chisel.scala 151:132:@1250.8]
  assign _GEN_27 = _T_290 ? critical_sel : _GEN_24; // @[priority_arbiter_chisel.scala 151:132:@1250.8]
  assign _GEN_28 = _T_280 ? _GEN_25 : request_out_reg; // @[priority_arbiter_chisel.scala 149:101:@1240.6]
  assign _GEN_29 = _T_280 ? _GEN_26 : request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:101:@1240.6]
  assign _GEN_30 = _T_280 ? _GEN_27 : last_send_index; // @[priority_arbiter_chisel.scala 149:101:@1240.6]
  assign _GEN_31 = reset ? 80'h0 : _GEN_28; // @[priority_arbiter_chisel.scala 145:29:@1230.4]
  assign _GEN_32 = reset ? 1'h0 : _GEN_29; // @[priority_arbiter_chisel.scala 145:29:@1230.4]
  assign _GEN_33 = reset ? 1'h0 : _GEN_30; // @[priority_arbiter_chisel.scala 145:29:@1230.4]
  assign issue_ack_out_vec_1 = fifo_queue_chisel_1_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@994.4 priority_arbiter_chisel.scala 68:50:@1030.4]
  assign issue_ack_out_vec_0 = fifo_queue_chisel_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@994.4 priority_arbiter_chisel.scala 68:50:@1012.4]
  assign io_issue_ack_out = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter_chisel.scala 174:26:@1281.4]
  assign io_request_out = request_out_reg; // @[priority_arbiter_chisel.scala 172:24:@1278.4]
  assign io_request_valid_out = request_valid_out_reg; // @[priority_arbiter_chisel.scala 173:30:@1279.4]
  assign fifo_queue_chisel_clock = clock; // @[:@1004.4]
  assign fifo_queue_chisel_reset = reset; // @[:@1005.4]
  assign fifo_queue_chisel_io_request_in = {_T_73,request_packed_in_0}; // @[priority_arbiter_chisel.scala 66:45:@1009.4]
  assign fifo_queue_chisel_io_request_valid_in = io_request_valid_flatted_in[0]; // @[priority_arbiter_chisel.scala 67:51:@1011.4]
  assign fifo_queue_chisel_io_issue_ack_in = io_issue_ack_in & _T_263; // @[priority_arbiter_chisel.scala 74:47:@1018.4]
  assign fifo_queue_chisel_1_clock = clock; // @[:@1022.4]
  assign fifo_queue_chisel_1_reset = reset; // @[:@1023.4]
  assign fifo_queue_chisel_1_io_request_in = {_T_79,request_packed_in_1}; // @[priority_arbiter_chisel.scala 66:45:@1027.4]
  assign fifo_queue_chisel_1_io_request_valid_in = io_request_valid_flatted_in[1]; // @[priority_arbiter_chisel.scala 67:51:@1029.4]
  assign fifo_queue_chisel_1_io_issue_ack_in = io_issue_ack_in & last_send_index; // @[priority_arbiter_chisel.scala 74:47:@1036.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {3{`RANDOM}};
  request_out_reg = _RAND_0[79:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  request_valid_out_reg = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  last_send_index = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      request_out_reg <= 80'h0;
    end else begin
      if (reset) begin
        request_out_reg <= 80'h0;
      end else begin
        if (_T_280) begin
          if (_T_290) begin
            if (critical_sel) begin
              request_out_reg <= request_packed_from_request_queue_1;
            end else begin
              request_out_reg <= request_packed_from_request_queue_0;
            end
          end else begin
            if (_T_299) begin
              if (valid_sel) begin
                request_out_reg <= request_packed_from_request_queue_1;
              end else begin
                request_out_reg <= request_packed_from_request_queue_0;
              end
            end else begin
              request_out_reg <= 80'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      request_valid_out_reg <= 1'h0;
    end else begin
      if (reset) begin
        request_valid_out_reg <= 1'h0;
      end else begin
        if (_T_280) begin
          if (_T_290) begin
            request_valid_out_reg <= 1'h1;
          end else begin
            request_valid_out_reg <= _T_299;
          end
        end
      end
    end
    if (reset) begin
      last_send_index <= 1'h0;
    end else begin
      if (reset) begin
        last_send_index <= 1'h0;
      end else begin
        if (_T_280) begin
          if (_T_290) begin
            last_send_index <= critical_sel;
          end else begin
            if (_T_299) begin
              last_send_index <= valid_sel;
            end
          end
        end
      end
    end
  end
endmodule
module unified_cache_bank( // @[:@1283.2]
  input          clock, // @[:@1284.4]
  input          reset, // @[:@1285.4]
  input  [159:0] io_input_request_flatted_in, // @[:@1286.4]
  input  [1:0]   io_input_request_valid_flatted_in, // @[:@1286.4]
  input  [1:0]   io_input_request_critical_flatted_in, // @[:@1286.4]
  output [1:0]   io_input_request_ack_out, // @[:@1286.4]
  input  [79:0]  io_fetched_request_in, // @[:@1286.4]
  input          io_fetched_request_valid_in, // @[:@1286.4]
  output         io_fetch_ack_out, // @[:@1286.4]
  output [79:0]  io_miss_request_out, // @[:@1286.4]
  output         io_miss_request_valid_out, // @[:@1286.4]
  input          io_miss_request_ack_in, // @[:@1286.4]
  output [79:0]  io_return_request_out, // @[:@1286.4]
  output         io_return_request_valid_out, // @[:@1286.4]
  input          io_return_request_ack_in // @[:@1286.4]
);
  wire  priority_arbiter_chisel_clock; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire  priority_arbiter_chisel_reset; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [159:0] priority_arbiter_chisel_io_request_flatted_in; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [1:0] priority_arbiter_chisel_io_request_valid_flatted_in; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [1:0] priority_arbiter_chisel_io_request_critical_flatted_in; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [1:0] priority_arbiter_chisel_io_issue_ack_out; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [79:0] priority_arbiter_chisel_io_request_out; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire  priority_arbiter_chisel_io_request_valid_out; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire  priority_arbiter_chisel_io_issue_ack_in; // @[unified_cache_bank.scala 48:36:@1288.4]
  priority_arbiter_chisel priority_arbiter_chisel ( // @[unified_cache_bank.scala 48:36:@1288.4]
    .clock(priority_arbiter_chisel_clock),
    .reset(priority_arbiter_chisel_reset),
    .io_request_flatted_in(priority_arbiter_chisel_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_chisel_io_request_valid_flatted_in),
    .io_request_critical_flatted_in(priority_arbiter_chisel_io_request_critical_flatted_in),
    .io_issue_ack_out(priority_arbiter_chisel_io_issue_ack_out),
    .io_request_out(priority_arbiter_chisel_io_request_out),
    .io_request_valid_out(priority_arbiter_chisel_io_request_valid_out),
    .io_issue_ack_in(priority_arbiter_chisel_io_issue_ack_in)
  );
  assign io_input_request_ack_out = priority_arbiter_chisel_io_issue_ack_out; // @[unified_cache_bank.scala 56:34:@1294.4]
  assign io_fetch_ack_out = io_return_request_ack_in; // @[unified_cache_bank.scala 64:26:@1301.4]
  assign io_miss_request_out = priority_arbiter_chisel_io_request_out; // @[unified_cache_bank.scala 57:29:@1295.4]
  assign io_miss_request_valid_out = priority_arbiter_chisel_io_request_valid_out; // @[unified_cache_bank.scala 58:35:@1296.4]
  assign io_return_request_out = io_fetched_request_in; // @[unified_cache_bank.scala 62:31:@1299.4]
  assign io_return_request_valid_out = io_fetched_request_valid_in; // @[unified_cache_bank.scala 63:37:@1300.4]
  assign priority_arbiter_chisel_clock = clock; // @[:@1289.4]
  assign priority_arbiter_chisel_reset = reset; // @[:@1290.4]
  assign priority_arbiter_chisel_io_request_flatted_in = io_input_request_flatted_in; // @[unified_cache_bank.scala 53:50:@1291.4]
  assign priority_arbiter_chisel_io_request_valid_flatted_in = io_input_request_valid_flatted_in; // @[unified_cache_bank.scala 54:56:@1292.4]
  assign priority_arbiter_chisel_io_request_critical_flatted_in = io_input_request_critical_flatted_in; // @[unified_cache_bank.scala 55:59:@1293.4]
  assign priority_arbiter_chisel_io_issue_ack_in = io_miss_request_ack_in; // @[unified_cache_bank.scala 59:44:@1297.4]
endmodule
module priority_arbiter_chisel_4( // @[:@4955.2]
  input          clock, // @[:@4956.4]
  input          reset, // @[:@4957.4]
  input  [639:0] io_request_flatted_in, // @[:@4958.4]
  input  [7:0]   io_request_valid_flatted_in, // @[:@4958.4]
  output [7:0]   io_issue_ack_out, // @[:@4958.4]
  output [79:0]  io_request_out, // @[:@4958.4]
  input          io_issue_ack_in // @[:@4958.4]
);
  wire  fifo_queue_chisel_clock; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire  fifo_queue_chisel_reset; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire  fifo_queue_chisel_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire  fifo_queue_chisel_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire [80:0] fifo_queue_chisel_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire  fifo_queue_chisel_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire  fifo_queue_chisel_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire [80:0] fifo_queue_chisel_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire  fifo_queue_chisel_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire  fifo_queue_chisel_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@4971.4]
  wire  fifo_queue_chisel_1_clock; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire  fifo_queue_chisel_1_reset; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire  fifo_queue_chisel_1_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire  fifo_queue_chisel_1_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire [80:0] fifo_queue_chisel_1_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire  fifo_queue_chisel_1_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire  fifo_queue_chisel_1_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire [80:0] fifo_queue_chisel_1_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire  fifo_queue_chisel_1_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire  fifo_queue_chisel_1_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@4989.4]
  wire  fifo_queue_chisel_2_clock; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire  fifo_queue_chisel_2_reset; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire  fifo_queue_chisel_2_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire  fifo_queue_chisel_2_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire [80:0] fifo_queue_chisel_2_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire  fifo_queue_chisel_2_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire  fifo_queue_chisel_2_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire [80:0] fifo_queue_chisel_2_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire  fifo_queue_chisel_2_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire  fifo_queue_chisel_2_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@5007.4]
  wire  fifo_queue_chisel_3_clock; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire  fifo_queue_chisel_3_reset; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire  fifo_queue_chisel_3_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire  fifo_queue_chisel_3_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire [80:0] fifo_queue_chisel_3_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire  fifo_queue_chisel_3_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire  fifo_queue_chisel_3_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire [80:0] fifo_queue_chisel_3_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire  fifo_queue_chisel_3_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire  fifo_queue_chisel_3_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@5025.4]
  wire  fifo_queue_chisel_4_clock; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire  fifo_queue_chisel_4_reset; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire  fifo_queue_chisel_4_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire  fifo_queue_chisel_4_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire [80:0] fifo_queue_chisel_4_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire  fifo_queue_chisel_4_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire  fifo_queue_chisel_4_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire [80:0] fifo_queue_chisel_4_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire  fifo_queue_chisel_4_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire  fifo_queue_chisel_4_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@5043.4]
  wire  fifo_queue_chisel_5_clock; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire  fifo_queue_chisel_5_reset; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire  fifo_queue_chisel_5_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire  fifo_queue_chisel_5_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire [80:0] fifo_queue_chisel_5_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire  fifo_queue_chisel_5_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire  fifo_queue_chisel_5_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire [80:0] fifo_queue_chisel_5_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire  fifo_queue_chisel_5_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire  fifo_queue_chisel_5_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@5061.4]
  wire  fifo_queue_chisel_6_clock; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire  fifo_queue_chisel_6_reset; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire  fifo_queue_chisel_6_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire  fifo_queue_chisel_6_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire [80:0] fifo_queue_chisel_6_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire  fifo_queue_chisel_6_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire  fifo_queue_chisel_6_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire [80:0] fifo_queue_chisel_6_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire  fifo_queue_chisel_6_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire  fifo_queue_chisel_6_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@5079.4]
  wire  fifo_queue_chisel_7_clock; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire  fifo_queue_chisel_7_reset; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire  fifo_queue_chisel_7_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire  fifo_queue_chisel_7_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire [80:0] fifo_queue_chisel_7_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire  fifo_queue_chisel_7_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire  fifo_queue_chisel_7_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire [80:0] fifo_queue_chisel_7_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire  fifo_queue_chisel_7_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  wire  fifo_queue_chisel_7_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@5097.4]
  reg [79:0] request_out_reg; // @[priority_arbiter_chisel.scala 45:38:@4960.4]
  reg [95:0] _RAND_0;
  reg  request_valid_out_reg; // @[priority_arbiter_chisel.scala 46:44:@4961.4]
  reg [31:0] _RAND_1;
  wire [79:0] request_packed_in_0; // @[priority_arbiter_chisel.scala 59:74:@4969.4]
  wire  request_critical_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 70:107:@4981.4]
  wire [79:0] request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 71:97:@4983.4]
  wire [79:0] request_packed_in_1; // @[priority_arbiter_chisel.scala 59:74:@4987.4]
  wire  request_critical_flatted_from_request_queue_1; // @[priority_arbiter_chisel.scala 70:107:@4999.4]
  wire [79:0] request_packed_from_request_queue_1; // @[priority_arbiter_chisel.scala 71:97:@5001.4]
  wire [79:0] request_packed_in_2; // @[priority_arbiter_chisel.scala 59:74:@5005.4]
  wire  request_critical_flatted_from_request_queue_2; // @[priority_arbiter_chisel.scala 70:107:@5017.4]
  wire [79:0] request_packed_from_request_queue_2; // @[priority_arbiter_chisel.scala 71:97:@5019.4]
  wire [79:0] request_packed_in_3; // @[priority_arbiter_chisel.scala 59:74:@5023.4]
  wire  request_critical_flatted_from_request_queue_3; // @[priority_arbiter_chisel.scala 70:107:@5035.4]
  wire [79:0] request_packed_from_request_queue_3; // @[priority_arbiter_chisel.scala 71:97:@5037.4]
  wire [79:0] request_packed_in_4; // @[priority_arbiter_chisel.scala 59:74:@5041.4]
  wire  request_critical_flatted_from_request_queue_4; // @[priority_arbiter_chisel.scala 70:107:@5053.4]
  wire [79:0] request_packed_from_request_queue_4; // @[priority_arbiter_chisel.scala 71:97:@5055.4]
  wire [79:0] request_packed_in_5; // @[priority_arbiter_chisel.scala 59:74:@5059.4]
  wire  request_critical_flatted_from_request_queue_5; // @[priority_arbiter_chisel.scala 70:107:@5071.4]
  wire [79:0] request_packed_from_request_queue_5; // @[priority_arbiter_chisel.scala 71:97:@5073.4]
  wire [79:0] request_packed_in_6; // @[priority_arbiter_chisel.scala 59:74:@5077.4]
  wire  request_critical_flatted_from_request_queue_6; // @[priority_arbiter_chisel.scala 70:107:@5089.4]
  wire [79:0] request_packed_from_request_queue_6; // @[priority_arbiter_chisel.scala 71:97:@5091.4]
  wire [79:0] request_packed_in_7; // @[priority_arbiter_chisel.scala 59:74:@5095.4]
  wire  request_critical_flatted_from_request_queue_7; // @[priority_arbiter_chisel.scala 70:107:@5107.4]
  wire [79:0] request_packed_from_request_queue_7; // @[priority_arbiter_chisel.scala 71:97:@5109.4]
  wire [1:0] _T_163; // @[priority_arbiter_chisel.scala 78:79:@5114.4]
  wire [1:0] _T_164; // @[priority_arbiter_chisel.scala 78:79:@5115.4]
  wire [3:0] _T_165; // @[priority_arbiter_chisel.scala 78:79:@5116.4]
  wire [1:0] _T_166; // @[priority_arbiter_chisel.scala 78:79:@5117.4]
  wire [1:0] _T_167; // @[priority_arbiter_chisel.scala 78:79:@5118.4]
  wire [3:0] _T_168; // @[priority_arbiter_chisel.scala 78:79:@5119.4]
  wire [7:0] _T_169; // @[priority_arbiter_chisel.scala 78:79:@5120.4]
  wire  request_queue_full_1; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@4992.4]
  wire  request_queue_full_0; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@4974.4]
  wire [1:0] _T_170; // @[priority_arbiter_chisel.scala 78:107:@5121.4]
  wire  request_queue_full_3; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5028.4]
  wire  request_queue_full_2; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5010.4]
  wire [1:0] _T_171; // @[priority_arbiter_chisel.scala 78:107:@5122.4]
  wire [3:0] _T_172; // @[priority_arbiter_chisel.scala 78:107:@5123.4]
  wire  request_queue_full_5; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5064.4]
  wire  request_queue_full_4; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5046.4]
  wire [1:0] _T_173; // @[priority_arbiter_chisel.scala 78:107:@5124.4]
  wire  request_queue_full_7; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5100.4]
  wire  request_queue_full_6; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5082.4]
  wire [1:0] _T_174; // @[priority_arbiter_chisel.scala 78:107:@5125.4]
  wire [3:0] _T_175; // @[priority_arbiter_chisel.scala 78:107:@5126.4]
  wire [7:0] _T_176; // @[priority_arbiter_chisel.scala 78:107:@5127.4]
  wire [7:0] request_critical_final; // @[priority_arbiter_chisel.scala 78:86:@5128.4]
  reg [2:0] last_send_index; // @[priority_arbiter_chisel.scala 79:38:@5130.4]
  reg [31:0] _RAND_2;
  wire  request_valid_flatted_from_request_queue_1; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5003.4]
  wire  request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@4985.4]
  wire [1:0] _T_182; // @[priority_arbiter_chisel.scala 84:87:@5133.4]
  wire  request_valid_flatted_from_request_queue_3; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5039.4]
  wire  request_valid_flatted_from_request_queue_2; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5021.4]
  wire [1:0] _T_183; // @[priority_arbiter_chisel.scala 84:87:@5134.4]
  wire [3:0] _T_184; // @[priority_arbiter_chisel.scala 84:87:@5135.4]
  wire  request_valid_flatted_from_request_queue_5; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5075.4]
  wire  request_valid_flatted_from_request_queue_4; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5057.4]
  wire [1:0] _T_185; // @[priority_arbiter_chisel.scala 84:87:@5136.4]
  wire  request_valid_flatted_from_request_queue_7; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5111.4]
  wire  request_valid_flatted_from_request_queue_6; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5093.4]
  wire [1:0] _T_186; // @[priority_arbiter_chisel.scala 84:87:@5137.4]
  wire [3:0] _T_187; // @[priority_arbiter_chisel.scala 84:87:@5138.4]
  wire [7:0] _T_188; // @[priority_arbiter_chisel.scala 84:87:@5139.4]
  wire [3:0] _T_190; // @[priority_arbiter_chisel.scala 84:114:@5140.4]
  wire [2:0] _T_191; // @[priority_arbiter_chisel.scala 84:114:@5141.4]
  wire [7:0] _T_192; // @[priority_arbiter_chisel.scala 84:94:@5142.4]
  wire [3:0] _GEN_100; // @[priority_arbiter_chisel.scala 85:148:@5150.4]
  wire [4:0] _T_201; // @[priority_arbiter_chisel.scala 85:148:@5150.4]
  wire [4:0] _T_202; // @[priority_arbiter_chisel.scala 85:148:@5151.4]
  wire [3:0] _T_203; // @[priority_arbiter_chisel.scala 85:148:@5152.4]
  wire [4:0] _T_205; // @[priority_arbiter_chisel.scala 85:166:@5153.4]
  wire [4:0] _T_206; // @[priority_arbiter_chisel.scala 85:166:@5154.4]
  wire [3:0] _T_207; // @[priority_arbiter_chisel.scala 85:166:@5155.4]
  wire [22:0] _GEN_101; // @[priority_arbiter_chisel.scala 85:130:@5156.4]
  wire [22:0] _T_208; // @[priority_arbiter_chisel.scala 85:130:@5156.4]
  wire [22:0] _GEN_102; // @[priority_arbiter_chisel.scala 84:122:@5157.4]
  wire [22:0] _T_209; // @[priority_arbiter_chisel.scala 84:122:@5157.4]
  wire [7:0] _T_213; // @[priority_arbiter_chisel.scala 86:72:@5161.4]
  wire [22:0] _GEN_104; // @[priority_arbiter_chisel.scala 87:108:@5168.4]
  wire [22:0] _T_222; // @[priority_arbiter_chisel.scala 87:108:@5168.4]
  wire [22:0] _GEN_105; // @[priority_arbiter_chisel.scala 86:100:@5169.4]
  wire [22:0] _T_223; // @[priority_arbiter_chisel.scala 86:100:@5169.4]
  wire [7:0] request_valid_flatted_shift_left; // @[priority_arbiter_chisel.scala 82:52:@5131.4 priority_arbiter_chisel.scala 84:42:@5158.4]
  wire  _T_227; // @[priority_arbiter_chisel.scala 94:55:@5174.4]
  wire [3:0] _T_229; // @[priority_arbiter_chisel.scala 95:47:@5176.6]
  wire [2:0] _T_230; // @[priority_arbiter_chisel.scala 95:47:@5177.6]
  wire [3:0] _T_232; // @[priority_arbiter_chisel.scala 95:68:@5178.6]
  wire [2:0] _T_233; // @[priority_arbiter_chisel.scala 95:68:@5179.6]
  wire [3:0] _GEN_106; // @[priority_arbiter_chisel.scala 96:89:@5186.8]
  wire [3:0] _GEN_1; // @[priority_arbiter_chisel.scala 94:75:@5175.4]
  wire  _T_252; // @[priority_arbiter_chisel.scala 94:55:@5199.4]
  wire [3:0] _T_254; // @[priority_arbiter_chisel.scala 95:47:@5201.6]
  wire [2:0] _T_255; // @[priority_arbiter_chisel.scala 95:47:@5202.6]
  wire [3:0] _T_257; // @[priority_arbiter_chisel.scala 95:68:@5203.6]
  wire [2:0] _T_258; // @[priority_arbiter_chisel.scala 95:68:@5204.6]
  wire [3:0] _GEN_107; // @[priority_arbiter_chisel.scala 96:89:@5211.8]
  wire [3:0] _GEN_3; // @[priority_arbiter_chisel.scala 94:75:@5200.4]
  wire  _T_277; // @[priority_arbiter_chisel.scala 94:55:@5224.4]
  wire [3:0] _T_279; // @[priority_arbiter_chisel.scala 95:47:@5226.6]
  wire [2:0] _T_280; // @[priority_arbiter_chisel.scala 95:47:@5227.6]
  wire [3:0] _T_282; // @[priority_arbiter_chisel.scala 95:68:@5228.6]
  wire [2:0] _T_283; // @[priority_arbiter_chisel.scala 95:68:@5229.6]
  wire [3:0] _GEN_108; // @[priority_arbiter_chisel.scala 96:89:@5236.8]
  wire [3:0] _GEN_5; // @[priority_arbiter_chisel.scala 94:75:@5225.4]
  wire  _T_302; // @[priority_arbiter_chisel.scala 94:55:@5249.4]
  wire [3:0] _T_304; // @[priority_arbiter_chisel.scala 95:47:@5251.6]
  wire [2:0] _T_305; // @[priority_arbiter_chisel.scala 95:47:@5252.6]
  wire [3:0] _T_307; // @[priority_arbiter_chisel.scala 95:68:@5253.6]
  wire [2:0] _T_308; // @[priority_arbiter_chisel.scala 95:68:@5254.6]
  wire [3:0] _GEN_109; // @[priority_arbiter_chisel.scala 96:89:@5261.8]
  wire [3:0] _GEN_7; // @[priority_arbiter_chisel.scala 94:75:@5250.4]
  wire  _T_327; // @[priority_arbiter_chisel.scala 94:55:@5274.4]
  wire [3:0] _T_329; // @[priority_arbiter_chisel.scala 95:47:@5276.6]
  wire [2:0] _T_330; // @[priority_arbiter_chisel.scala 95:47:@5277.6]
  wire [3:0] _T_332; // @[priority_arbiter_chisel.scala 95:68:@5278.6]
  wire [2:0] _T_333; // @[priority_arbiter_chisel.scala 95:68:@5279.6]
  wire [3:0] _GEN_110; // @[priority_arbiter_chisel.scala 96:89:@5286.8]
  wire [3:0] _GEN_9; // @[priority_arbiter_chisel.scala 94:75:@5275.4]
  wire  _T_352; // @[priority_arbiter_chisel.scala 94:55:@5299.4]
  wire [3:0] _T_354; // @[priority_arbiter_chisel.scala 95:47:@5301.6]
  wire [2:0] _T_355; // @[priority_arbiter_chisel.scala 95:47:@5302.6]
  wire [3:0] _T_357; // @[priority_arbiter_chisel.scala 95:68:@5303.6]
  wire [2:0] _T_358; // @[priority_arbiter_chisel.scala 95:68:@5304.6]
  wire [3:0] _GEN_111; // @[priority_arbiter_chisel.scala 96:89:@5311.8]
  wire [3:0] _GEN_11; // @[priority_arbiter_chisel.scala 94:75:@5300.4]
  wire  _T_377; // @[priority_arbiter_chisel.scala 94:55:@5324.4]
  wire [3:0] _T_382; // @[priority_arbiter_chisel.scala 95:68:@5328.6]
  wire [2:0] _T_383; // @[priority_arbiter_chisel.scala 95:68:@5329.6]
  wire [3:0] _GEN_112; // @[priority_arbiter_chisel.scala 96:89:@5336.8]
  wire [3:0] _GEN_13; // @[priority_arbiter_chisel.scala 94:75:@5325.4]
  wire  _T_402; // @[priority_arbiter_chisel.scala 94:55:@5349.4]
  wire [2:0] _T_405; // @[priority_arbiter_chisel.scala 95:47:@5352.6]
  wire [3:0] _T_407; // @[priority_arbiter_chisel.scala 95:68:@5353.6]
  wire [2:0] _T_408; // @[priority_arbiter_chisel.scala 95:68:@5354.6]
  wire [3:0] _GEN_113; // @[priority_arbiter_chisel.scala 96:89:@5361.8]
  wire [3:0] _GEN_15; // @[priority_arbiter_chisel.scala 94:75:@5350.4]
  wire [7:0] request_critical_flatted_shift_left; // @[priority_arbiter_chisel.scala 83:55:@5132.4 priority_arbiter_chisel.scala 86:45:@5170.4]
  wire  _T_430; // @[priority_arbiter_chisel.scala 108:58:@5377.4]
  wire  _T_432; // @[priority_arbiter_chisel.scala 108:80:@5379.4]
  wire [3:0] _GEN_17; // @[priority_arbiter_chisel.scala 108:138:@5380.4]
  wire  _T_457; // @[priority_arbiter_chisel.scala 108:58:@5404.4]
  wire  _T_459; // @[priority_arbiter_chisel.scala 108:80:@5406.4]
  wire [3:0] _GEN_19; // @[priority_arbiter_chisel.scala 108:138:@5407.4]
  wire  _T_484; // @[priority_arbiter_chisel.scala 108:58:@5431.4]
  wire  _T_486; // @[priority_arbiter_chisel.scala 108:80:@5433.4]
  wire [3:0] _GEN_21; // @[priority_arbiter_chisel.scala 108:138:@5434.4]
  wire  _T_511; // @[priority_arbiter_chisel.scala 108:58:@5458.4]
  wire  _T_513; // @[priority_arbiter_chisel.scala 108:80:@5460.4]
  wire [3:0] _GEN_23; // @[priority_arbiter_chisel.scala 108:138:@5461.4]
  wire  _T_538; // @[priority_arbiter_chisel.scala 108:58:@5485.4]
  wire  _T_540; // @[priority_arbiter_chisel.scala 108:80:@5487.4]
  wire [3:0] _GEN_25; // @[priority_arbiter_chisel.scala 108:138:@5488.4]
  wire  _T_565; // @[priority_arbiter_chisel.scala 108:58:@5512.4]
  wire  _T_567; // @[priority_arbiter_chisel.scala 108:80:@5514.4]
  wire [3:0] _GEN_27; // @[priority_arbiter_chisel.scala 108:138:@5515.4]
  wire  _T_592; // @[priority_arbiter_chisel.scala 108:58:@5539.4]
  wire  _T_594; // @[priority_arbiter_chisel.scala 108:80:@5541.4]
  wire [3:0] _GEN_29; // @[priority_arbiter_chisel.scala 108:138:@5542.4]
  wire  _T_619; // @[priority_arbiter_chisel.scala 108:58:@5566.4]
  wire  _T_621; // @[priority_arbiter_chisel.scala 108:80:@5568.4]
  wire [3:0] _GEN_31; // @[priority_arbiter_chisel.scala 108:138:@5569.4]
  wire [2:0] valid_sel; // @[:@5171.4 :@5172.4 priority_arbiter_chisel.scala 91:19:@5173.4 priority_arbiter_chisel.scala 96:43:@5189.8 priority_arbiter_chisel.scala 98:43:@5196.8 priority_arbiter_chisel.scala 96:43:@5214.8 priority_arbiter_chisel.scala 98:43:@5221.8 priority_arbiter_chisel.scala 96:43:@5239.8 priority_arbiter_chisel.scala 98:43:@5246.8 priority_arbiter_chisel.scala 96:43:@5264.8 priority_arbiter_chisel.scala 98:43:@5271.8 priority_arbiter_chisel.scala 96:43:@5289.8 priority_arbiter_chisel.scala 98:43:@5296.8 priority_arbiter_chisel.scala 96:43:@5314.8 priority_arbiter_chisel.scala 98:43:@5321.8 priority_arbiter_chisel.scala 96:43:@5339.8 priority_arbiter_chisel.scala 98:43:@5346.8 priority_arbiter_chisel.scala 96:43:@5364.8 priority_arbiter_chisel.scala 98:43:@5371.8]
  wire [2:0] critical_sel; // @[:@5374.4 :@5375.4 priority_arbiter_chisel.scala 105:22:@5376.4 priority_arbiter_chisel.scala 110:46:@5394.8 priority_arbiter_chisel.scala 112:46:@5401.8 priority_arbiter_chisel.scala 110:46:@5421.8 priority_arbiter_chisel.scala 112:46:@5428.8 priority_arbiter_chisel.scala 110:46:@5448.8 priority_arbiter_chisel.scala 112:46:@5455.8 priority_arbiter_chisel.scala 110:46:@5475.8 priority_arbiter_chisel.scala 112:46:@5482.8 priority_arbiter_chisel.scala 110:46:@5502.8 priority_arbiter_chisel.scala 112:46:@5509.8 priority_arbiter_chisel.scala 110:46:@5529.8 priority_arbiter_chisel.scala 112:46:@5536.8 priority_arbiter_chisel.scala 110:46:@5556.8 priority_arbiter_chisel.scala 112:46:@5563.8 priority_arbiter_chisel.scala 110:46:@5583.8 priority_arbiter_chisel.scala 112:46:@5590.8]
  wire  _T_737; // @[priority_arbiter_chisel.scala 136:59:@5707.4]
  wire  _T_743; // @[priority_arbiter_chisel.scala 136:59:@5716.4]
  wire  _T_749; // @[priority_arbiter_chisel.scala 136:59:@5725.4]
  wire  _T_755; // @[priority_arbiter_chisel.scala 136:59:@5734.4]
  wire  _T_761; // @[priority_arbiter_chisel.scala 136:59:@5743.4]
  wire  _T_767; // @[priority_arbiter_chisel.scala 136:59:@5752.4]
  wire  _T_773; // @[priority_arbiter_chisel.scala 136:59:@5761.4]
  wire  _T_779; // @[priority_arbiter_chisel.scala 136:59:@5770.4]
  wire  _T_788; // @[priority_arbiter_chisel.scala 149:40:@5786.6]
  wire  _T_789; // @[priority_arbiter_chisel.scala 149:68:@5787.6]
  wire  _T_790; // @[priority_arbiter_chisel.scala 149:65:@5788.6]
  wire [7:0] _T_792; // @[priority_arbiter_chisel.scala 150:46:@5791.8]
  wire  _T_793; // @[priority_arbiter_chisel.scala 150:46:@5792.8]
  wire  _GEN_57; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  wire  _GEN_58; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  wire  _GEN_59; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  wire  _GEN_60; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  wire  _GEN_61; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  wire  _GEN_62; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  wire  _GEN_63; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  wire  _T_795; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  wire  _T_796; // @[priority_arbiter_chisel.scala 151:49:@5794.8]
  wire  _T_797; // @[priority_arbiter_chisel.scala 151:69:@5795.8]
  wire  _T_799; // @[priority_arbiter_chisel.scala 151:95:@5797.8]
  wire  _T_800; // @[priority_arbiter_chisel.scala 150:118:@5798.8]
  wire [79:0] _GEN_65; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  wire [79:0] _GEN_66; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  wire [79:0] _GEN_67; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  wire [79:0] _GEN_68; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  wire [79:0] _GEN_69; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  wire [79:0] _GEN_70; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  wire [79:0] _GEN_71; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  wire  _T_805; // @[priority_arbiter_chisel.scala 156:46:@5806.10]
  wire  _T_806; // @[priority_arbiter_chisel.scala 156:66:@5807.10]
  wire  _T_808; // @[priority_arbiter_chisel.scala 156:92:@5809.10]
  wire  _GEN_73; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  wire  _GEN_74; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  wire  _GEN_75; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  wire  _GEN_76; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  wire  _GEN_77; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  wire  _GEN_78; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  wire  _GEN_79; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  wire  _T_809; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  wire [79:0] _GEN_81; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  wire [79:0] _GEN_82; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  wire [79:0] _GEN_83; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  wire [79:0] _GEN_84; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  wire [79:0] _GEN_85; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  wire [79:0] _GEN_86; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  wire [79:0] _GEN_87; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  wire [79:0] _GEN_88; // @[priority_arbiter_chisel.scala 156:129:@5812.10]
  wire [2:0] _GEN_90; // @[priority_arbiter_chisel.scala 156:129:@5812.10]
  wire [79:0] _GEN_91; // @[priority_arbiter_chisel.scala 151:132:@5800.8]
  wire  _GEN_92; // @[priority_arbiter_chisel.scala 151:132:@5800.8]
  wire [2:0] _GEN_93; // @[priority_arbiter_chisel.scala 151:132:@5800.8]
  wire [79:0] _GEN_94; // @[priority_arbiter_chisel.scala 149:101:@5790.6]
  wire  _GEN_95; // @[priority_arbiter_chisel.scala 149:101:@5790.6]
  wire [2:0] _GEN_96; // @[priority_arbiter_chisel.scala 149:101:@5790.6]
  wire [79:0] _GEN_97; // @[priority_arbiter_chisel.scala 145:29:@5780.4]
  wire  _GEN_98; // @[priority_arbiter_chisel.scala 145:29:@5780.4]
  wire [2:0] _GEN_99; // @[priority_arbiter_chisel.scala 145:29:@5780.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@4998.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@4980.4]
  wire [1:0] _T_815; // @[priority_arbiter_chisel.scala 174:47:@5830.4]
  wire  issue_ack_out_vec_3; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5034.4]
  wire  issue_ack_out_vec_2; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5016.4]
  wire [1:0] _T_816; // @[priority_arbiter_chisel.scala 174:47:@5831.4]
  wire [3:0] _T_817; // @[priority_arbiter_chisel.scala 174:47:@5832.4]
  wire  issue_ack_out_vec_5; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5070.4]
  wire  issue_ack_out_vec_4; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5052.4]
  wire [1:0] _T_818; // @[priority_arbiter_chisel.scala 174:47:@5833.4]
  wire  issue_ack_out_vec_7; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5106.4]
  wire  issue_ack_out_vec_6; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5088.4]
  wire [1:0] _T_819; // @[priority_arbiter_chisel.scala 174:47:@5834.4]
  wire [3:0] _T_820; // @[priority_arbiter_chisel.scala 174:47:@5835.4]
  fifo_queue_chisel_2 fifo_queue_chisel ( // @[priority_arbiter_chisel.scala 61:43:@4971.4]
    .clock(fifo_queue_chisel_clock),
    .reset(fifo_queue_chisel_reset),
    .io_is_empty_out(fifo_queue_chisel_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_io_is_full_out),
    .io_request_in(fifo_queue_chisel_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_1 ( // @[priority_arbiter_chisel.scala 61:43:@4989.4]
    .clock(fifo_queue_chisel_1_clock),
    .reset(fifo_queue_chisel_1_reset),
    .io_is_empty_out(fifo_queue_chisel_1_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_1_io_is_full_out),
    .io_request_in(fifo_queue_chisel_1_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_1_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_1_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_1_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_2 ( // @[priority_arbiter_chisel.scala 61:43:@5007.4]
    .clock(fifo_queue_chisel_2_clock),
    .reset(fifo_queue_chisel_2_reset),
    .io_is_empty_out(fifo_queue_chisel_2_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_2_io_is_full_out),
    .io_request_in(fifo_queue_chisel_2_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_2_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_2_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_2_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_2_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_2_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_3 ( // @[priority_arbiter_chisel.scala 61:43:@5025.4]
    .clock(fifo_queue_chisel_3_clock),
    .reset(fifo_queue_chisel_3_reset),
    .io_is_empty_out(fifo_queue_chisel_3_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_3_io_is_full_out),
    .io_request_in(fifo_queue_chisel_3_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_3_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_3_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_3_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_3_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_3_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_4 ( // @[priority_arbiter_chisel.scala 61:43:@5043.4]
    .clock(fifo_queue_chisel_4_clock),
    .reset(fifo_queue_chisel_4_reset),
    .io_is_empty_out(fifo_queue_chisel_4_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_4_io_is_full_out),
    .io_request_in(fifo_queue_chisel_4_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_4_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_4_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_4_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_4_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_4_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_5 ( // @[priority_arbiter_chisel.scala 61:43:@5061.4]
    .clock(fifo_queue_chisel_5_clock),
    .reset(fifo_queue_chisel_5_reset),
    .io_is_empty_out(fifo_queue_chisel_5_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_5_io_is_full_out),
    .io_request_in(fifo_queue_chisel_5_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_5_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_5_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_5_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_5_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_5_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_6 ( // @[priority_arbiter_chisel.scala 61:43:@5079.4]
    .clock(fifo_queue_chisel_6_clock),
    .reset(fifo_queue_chisel_6_reset),
    .io_is_empty_out(fifo_queue_chisel_6_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_6_io_is_full_out),
    .io_request_in(fifo_queue_chisel_6_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_6_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_6_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_6_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_6_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_6_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_7 ( // @[priority_arbiter_chisel.scala 61:43:@5097.4]
    .clock(fifo_queue_chisel_7_clock),
    .reset(fifo_queue_chisel_7_reset),
    .io_is_empty_out(fifo_queue_chisel_7_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_7_io_is_full_out),
    .io_request_in(fifo_queue_chisel_7_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_7_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_7_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_7_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_7_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_7_io_issue_ack_in)
  );
  assign request_packed_in_0 = io_request_flatted_in[79:0]; // @[priority_arbiter_chisel.scala 59:74:@4969.4]
  assign request_critical_flatted_from_request_queue_0 = fifo_queue_chisel_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@4981.4]
  assign request_packed_from_request_queue_0 = fifo_queue_chisel_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@4983.4]
  assign request_packed_in_1 = io_request_flatted_in[159:80]; // @[priority_arbiter_chisel.scala 59:74:@4987.4]
  assign request_critical_flatted_from_request_queue_1 = fifo_queue_chisel_1_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@4999.4]
  assign request_packed_from_request_queue_1 = fifo_queue_chisel_1_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@5001.4]
  assign request_packed_in_2 = io_request_flatted_in[239:160]; // @[priority_arbiter_chisel.scala 59:74:@5005.4]
  assign request_critical_flatted_from_request_queue_2 = fifo_queue_chisel_2_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@5017.4]
  assign request_packed_from_request_queue_2 = fifo_queue_chisel_2_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@5019.4]
  assign request_packed_in_3 = io_request_flatted_in[319:240]; // @[priority_arbiter_chisel.scala 59:74:@5023.4]
  assign request_critical_flatted_from_request_queue_3 = fifo_queue_chisel_3_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@5035.4]
  assign request_packed_from_request_queue_3 = fifo_queue_chisel_3_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@5037.4]
  assign request_packed_in_4 = io_request_flatted_in[399:320]; // @[priority_arbiter_chisel.scala 59:74:@5041.4]
  assign request_critical_flatted_from_request_queue_4 = fifo_queue_chisel_4_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@5053.4]
  assign request_packed_from_request_queue_4 = fifo_queue_chisel_4_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@5055.4]
  assign request_packed_in_5 = io_request_flatted_in[479:400]; // @[priority_arbiter_chisel.scala 59:74:@5059.4]
  assign request_critical_flatted_from_request_queue_5 = fifo_queue_chisel_5_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@5071.4]
  assign request_packed_from_request_queue_5 = fifo_queue_chisel_5_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@5073.4]
  assign request_packed_in_6 = io_request_flatted_in[559:480]; // @[priority_arbiter_chisel.scala 59:74:@5077.4]
  assign request_critical_flatted_from_request_queue_6 = fifo_queue_chisel_6_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@5089.4]
  assign request_packed_from_request_queue_6 = fifo_queue_chisel_6_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@5091.4]
  assign request_packed_in_7 = io_request_flatted_in[639:560]; // @[priority_arbiter_chisel.scala 59:74:@5095.4]
  assign request_critical_flatted_from_request_queue_7 = fifo_queue_chisel_7_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@5107.4]
  assign request_packed_from_request_queue_7 = fifo_queue_chisel_7_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@5109.4]
  assign _T_163 = {request_critical_flatted_from_request_queue_1,request_critical_flatted_from_request_queue_0}; // @[priority_arbiter_chisel.scala 78:79:@5114.4]
  assign _T_164 = {request_critical_flatted_from_request_queue_3,request_critical_flatted_from_request_queue_2}; // @[priority_arbiter_chisel.scala 78:79:@5115.4]
  assign _T_165 = {_T_164,_T_163}; // @[priority_arbiter_chisel.scala 78:79:@5116.4]
  assign _T_166 = {request_critical_flatted_from_request_queue_5,request_critical_flatted_from_request_queue_4}; // @[priority_arbiter_chisel.scala 78:79:@5117.4]
  assign _T_167 = {request_critical_flatted_from_request_queue_7,request_critical_flatted_from_request_queue_6}; // @[priority_arbiter_chisel.scala 78:79:@5118.4]
  assign _T_168 = {_T_167,_T_166}; // @[priority_arbiter_chisel.scala 78:79:@5119.4]
  assign _T_169 = {_T_168,_T_165}; // @[priority_arbiter_chisel.scala 78:79:@5120.4]
  assign request_queue_full_1 = fifo_queue_chisel_1_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@4992.4]
  assign request_queue_full_0 = fifo_queue_chisel_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@4974.4]
  assign _T_170 = {request_queue_full_1,request_queue_full_0}; // @[priority_arbiter_chisel.scala 78:107:@5121.4]
  assign request_queue_full_3 = fifo_queue_chisel_3_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5028.4]
  assign request_queue_full_2 = fifo_queue_chisel_2_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5010.4]
  assign _T_171 = {request_queue_full_3,request_queue_full_2}; // @[priority_arbiter_chisel.scala 78:107:@5122.4]
  assign _T_172 = {_T_171,_T_170}; // @[priority_arbiter_chisel.scala 78:107:@5123.4]
  assign request_queue_full_5 = fifo_queue_chisel_5_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5064.4]
  assign request_queue_full_4 = fifo_queue_chisel_4_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5046.4]
  assign _T_173 = {request_queue_full_5,request_queue_full_4}; // @[priority_arbiter_chisel.scala 78:107:@5124.4]
  assign request_queue_full_7 = fifo_queue_chisel_7_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5100.4]
  assign request_queue_full_6 = fifo_queue_chisel_6_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@4967.4 priority_arbiter_chisel.scala 65:51:@5082.4]
  assign _T_174 = {request_queue_full_7,request_queue_full_6}; // @[priority_arbiter_chisel.scala 78:107:@5125.4]
  assign _T_175 = {_T_174,_T_173}; // @[priority_arbiter_chisel.scala 78:107:@5126.4]
  assign _T_176 = {_T_175,_T_172}; // @[priority_arbiter_chisel.scala 78:107:@5127.4]
  assign request_critical_final = _T_169 | _T_176; // @[priority_arbiter_chisel.scala 78:86:@5128.4]
  assign request_valid_flatted_from_request_queue_1 = fifo_queue_chisel_1_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5003.4]
  assign request_valid_flatted_from_request_queue_0 = fifo_queue_chisel_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@4985.4]
  assign _T_182 = {request_valid_flatted_from_request_queue_1,request_valid_flatted_from_request_queue_0}; // @[priority_arbiter_chisel.scala 84:87:@5133.4]
  assign request_valid_flatted_from_request_queue_3 = fifo_queue_chisel_3_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5039.4]
  assign request_valid_flatted_from_request_queue_2 = fifo_queue_chisel_2_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5021.4]
  assign _T_183 = {request_valid_flatted_from_request_queue_3,request_valid_flatted_from_request_queue_2}; // @[priority_arbiter_chisel.scala 84:87:@5134.4]
  assign _T_184 = {_T_183,_T_182}; // @[priority_arbiter_chisel.scala 84:87:@5135.4]
  assign request_valid_flatted_from_request_queue_5 = fifo_queue_chisel_5_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5075.4]
  assign request_valid_flatted_from_request_queue_4 = fifo_queue_chisel_4_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5057.4]
  assign _T_185 = {request_valid_flatted_from_request_queue_5,request_valid_flatted_from_request_queue_4}; // @[priority_arbiter_chisel.scala 84:87:@5136.4]
  assign request_valid_flatted_from_request_queue_7 = fifo_queue_chisel_7_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5111.4]
  assign request_valid_flatted_from_request_queue_6 = fifo_queue_chisel_6_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@4966.4 priority_arbiter_chisel.scala 73:73:@5093.4]
  assign _T_186 = {request_valid_flatted_from_request_queue_7,request_valid_flatted_from_request_queue_6}; // @[priority_arbiter_chisel.scala 84:87:@5137.4]
  assign _T_187 = {_T_186,_T_185}; // @[priority_arbiter_chisel.scala 84:87:@5138.4]
  assign _T_188 = {_T_187,_T_184}; // @[priority_arbiter_chisel.scala 84:87:@5139.4]
  assign _T_190 = last_send_index + 3'h1; // @[priority_arbiter_chisel.scala 84:114:@5140.4]
  assign _T_191 = _T_190[2:0]; // @[priority_arbiter_chisel.scala 84:114:@5141.4]
  assign _T_192 = _T_188 >> _T_191; // @[priority_arbiter_chisel.scala 84:94:@5142.4]
  assign _GEN_100 = {{1'd0}, last_send_index}; // @[priority_arbiter_chisel.scala 85:148:@5150.4]
  assign _T_201 = 4'h8 - _GEN_100; // @[priority_arbiter_chisel.scala 85:148:@5150.4]
  assign _T_202 = $unsigned(_T_201); // @[priority_arbiter_chisel.scala 85:148:@5151.4]
  assign _T_203 = _T_202[3:0]; // @[priority_arbiter_chisel.scala 85:148:@5152.4]
  assign _T_205 = _T_203 - 4'h1; // @[priority_arbiter_chisel.scala 85:166:@5153.4]
  assign _T_206 = $unsigned(_T_205); // @[priority_arbiter_chisel.scala 85:166:@5154.4]
  assign _T_207 = _T_206[3:0]; // @[priority_arbiter_chisel.scala 85:166:@5155.4]
  assign _GEN_101 = {{15'd0}, _T_188}; // @[priority_arbiter_chisel.scala 85:130:@5156.4]
  assign _T_208 = _GEN_101 << _T_207; // @[priority_arbiter_chisel.scala 85:130:@5156.4]
  assign _GEN_102 = {{15'd0}, _T_192}; // @[priority_arbiter_chisel.scala 84:122:@5157.4]
  assign _T_209 = _GEN_102 | _T_208; // @[priority_arbiter_chisel.scala 84:122:@5157.4]
  assign _T_213 = request_critical_final >> _T_191; // @[priority_arbiter_chisel.scala 86:72:@5161.4]
  assign _GEN_104 = {{15'd0}, request_critical_final}; // @[priority_arbiter_chisel.scala 87:108:@5168.4]
  assign _T_222 = _GEN_104 << _T_207; // @[priority_arbiter_chisel.scala 87:108:@5168.4]
  assign _GEN_105 = {{15'd0}, _T_213}; // @[priority_arbiter_chisel.scala 86:100:@5169.4]
  assign _T_223 = _GEN_105 | _T_222; // @[priority_arbiter_chisel.scala 86:100:@5169.4]
  assign request_valid_flatted_shift_left = _T_209[7:0]; // @[priority_arbiter_chisel.scala 82:52:@5131.4 priority_arbiter_chisel.scala 84:42:@5158.4]
  assign _T_227 = request_valid_flatted_shift_left[7]; // @[priority_arbiter_chisel.scala 94:55:@5174.4]
  assign _T_229 = last_send_index + 3'h7; // @[priority_arbiter_chisel.scala 95:47:@5176.6]
  assign _T_230 = _T_229[2:0]; // @[priority_arbiter_chisel.scala 95:47:@5177.6]
  assign _T_232 = _T_230 + 3'h1; // @[priority_arbiter_chisel.scala 95:68:@5178.6]
  assign _T_233 = _T_232[2:0]; // @[priority_arbiter_chisel.scala 95:68:@5179.6]
  assign _GEN_106 = {{1'd0}, _T_233}; // @[priority_arbiter_chisel.scala 96:89:@5186.8]
  assign _GEN_1 = _T_227 ? _GEN_106 : 4'h0; // @[priority_arbiter_chisel.scala 94:75:@5175.4]
  assign _T_252 = request_valid_flatted_shift_left[6]; // @[priority_arbiter_chisel.scala 94:55:@5199.4]
  assign _T_254 = last_send_index + 3'h6; // @[priority_arbiter_chisel.scala 95:47:@5201.6]
  assign _T_255 = _T_254[2:0]; // @[priority_arbiter_chisel.scala 95:47:@5202.6]
  assign _T_257 = _T_255 + 3'h1; // @[priority_arbiter_chisel.scala 95:68:@5203.6]
  assign _T_258 = _T_257[2:0]; // @[priority_arbiter_chisel.scala 95:68:@5204.6]
  assign _GEN_107 = {{1'd0}, _T_258}; // @[priority_arbiter_chisel.scala 96:89:@5211.8]
  assign _GEN_3 = _T_252 ? _GEN_107 : _GEN_1; // @[priority_arbiter_chisel.scala 94:75:@5200.4]
  assign _T_277 = request_valid_flatted_shift_left[5]; // @[priority_arbiter_chisel.scala 94:55:@5224.4]
  assign _T_279 = last_send_index + 3'h5; // @[priority_arbiter_chisel.scala 95:47:@5226.6]
  assign _T_280 = _T_279[2:0]; // @[priority_arbiter_chisel.scala 95:47:@5227.6]
  assign _T_282 = _T_280 + 3'h1; // @[priority_arbiter_chisel.scala 95:68:@5228.6]
  assign _T_283 = _T_282[2:0]; // @[priority_arbiter_chisel.scala 95:68:@5229.6]
  assign _GEN_108 = {{1'd0}, _T_283}; // @[priority_arbiter_chisel.scala 96:89:@5236.8]
  assign _GEN_5 = _T_277 ? _GEN_108 : _GEN_3; // @[priority_arbiter_chisel.scala 94:75:@5225.4]
  assign _T_302 = request_valid_flatted_shift_left[4]; // @[priority_arbiter_chisel.scala 94:55:@5249.4]
  assign _T_304 = last_send_index + 3'h4; // @[priority_arbiter_chisel.scala 95:47:@5251.6]
  assign _T_305 = _T_304[2:0]; // @[priority_arbiter_chisel.scala 95:47:@5252.6]
  assign _T_307 = _T_305 + 3'h1; // @[priority_arbiter_chisel.scala 95:68:@5253.6]
  assign _T_308 = _T_307[2:0]; // @[priority_arbiter_chisel.scala 95:68:@5254.6]
  assign _GEN_109 = {{1'd0}, _T_308}; // @[priority_arbiter_chisel.scala 96:89:@5261.8]
  assign _GEN_7 = _T_302 ? _GEN_109 : _GEN_5; // @[priority_arbiter_chisel.scala 94:75:@5250.4]
  assign _T_327 = request_valid_flatted_shift_left[3]; // @[priority_arbiter_chisel.scala 94:55:@5274.4]
  assign _T_329 = last_send_index + 3'h3; // @[priority_arbiter_chisel.scala 95:47:@5276.6]
  assign _T_330 = _T_329[2:0]; // @[priority_arbiter_chisel.scala 95:47:@5277.6]
  assign _T_332 = _T_330 + 3'h1; // @[priority_arbiter_chisel.scala 95:68:@5278.6]
  assign _T_333 = _T_332[2:0]; // @[priority_arbiter_chisel.scala 95:68:@5279.6]
  assign _GEN_110 = {{1'd0}, _T_333}; // @[priority_arbiter_chisel.scala 96:89:@5286.8]
  assign _GEN_9 = _T_327 ? _GEN_110 : _GEN_7; // @[priority_arbiter_chisel.scala 94:75:@5275.4]
  assign _T_352 = request_valid_flatted_shift_left[2]; // @[priority_arbiter_chisel.scala 94:55:@5299.4]
  assign _T_354 = last_send_index + 3'h2; // @[priority_arbiter_chisel.scala 95:47:@5301.6]
  assign _T_355 = _T_354[2:0]; // @[priority_arbiter_chisel.scala 95:47:@5302.6]
  assign _T_357 = _T_355 + 3'h1; // @[priority_arbiter_chisel.scala 95:68:@5303.6]
  assign _T_358 = _T_357[2:0]; // @[priority_arbiter_chisel.scala 95:68:@5304.6]
  assign _GEN_111 = {{1'd0}, _T_358}; // @[priority_arbiter_chisel.scala 96:89:@5311.8]
  assign _GEN_11 = _T_352 ? _GEN_111 : _GEN_9; // @[priority_arbiter_chisel.scala 94:75:@5300.4]
  assign _T_377 = request_valid_flatted_shift_left[1]; // @[priority_arbiter_chisel.scala 94:55:@5324.4]
  assign _T_382 = _T_191 + 3'h1; // @[priority_arbiter_chisel.scala 95:68:@5328.6]
  assign _T_383 = _T_382[2:0]; // @[priority_arbiter_chisel.scala 95:68:@5329.6]
  assign _GEN_112 = {{1'd0}, _T_383}; // @[priority_arbiter_chisel.scala 96:89:@5336.8]
  assign _GEN_13 = _T_377 ? _GEN_112 : _GEN_11; // @[priority_arbiter_chisel.scala 94:75:@5325.4]
  assign _T_402 = request_valid_flatted_shift_left[0]; // @[priority_arbiter_chisel.scala 94:55:@5349.4]
  assign _T_405 = _GEN_100[2:0]; // @[priority_arbiter_chisel.scala 95:47:@5352.6]
  assign _T_407 = _T_405 + 3'h1; // @[priority_arbiter_chisel.scala 95:68:@5353.6]
  assign _T_408 = _T_407[2:0]; // @[priority_arbiter_chisel.scala 95:68:@5354.6]
  assign _GEN_113 = {{1'd0}, _T_408}; // @[priority_arbiter_chisel.scala 96:89:@5361.8]
  assign _GEN_15 = _T_402 ? _GEN_113 : _GEN_13; // @[priority_arbiter_chisel.scala 94:75:@5350.4]
  assign request_critical_flatted_shift_left = _T_223[7:0]; // @[priority_arbiter_chisel.scala 83:55:@5132.4 priority_arbiter_chisel.scala 86:45:@5170.4]
  assign _T_430 = request_critical_flatted_shift_left[7]; // @[priority_arbiter_chisel.scala 108:58:@5377.4]
  assign _T_432 = _T_430 & _T_227; // @[priority_arbiter_chisel.scala 108:80:@5379.4]
  assign _GEN_17 = _T_432 ? _GEN_106 : 4'h0; // @[priority_arbiter_chisel.scala 108:138:@5380.4]
  assign _T_457 = request_critical_flatted_shift_left[6]; // @[priority_arbiter_chisel.scala 108:58:@5404.4]
  assign _T_459 = _T_457 & _T_252; // @[priority_arbiter_chisel.scala 108:80:@5406.4]
  assign _GEN_19 = _T_459 ? _GEN_107 : _GEN_17; // @[priority_arbiter_chisel.scala 108:138:@5407.4]
  assign _T_484 = request_critical_flatted_shift_left[5]; // @[priority_arbiter_chisel.scala 108:58:@5431.4]
  assign _T_486 = _T_484 & _T_277; // @[priority_arbiter_chisel.scala 108:80:@5433.4]
  assign _GEN_21 = _T_486 ? _GEN_108 : _GEN_19; // @[priority_arbiter_chisel.scala 108:138:@5434.4]
  assign _T_511 = request_critical_flatted_shift_left[4]; // @[priority_arbiter_chisel.scala 108:58:@5458.4]
  assign _T_513 = _T_511 & _T_302; // @[priority_arbiter_chisel.scala 108:80:@5460.4]
  assign _GEN_23 = _T_513 ? _GEN_109 : _GEN_21; // @[priority_arbiter_chisel.scala 108:138:@5461.4]
  assign _T_538 = request_critical_flatted_shift_left[3]; // @[priority_arbiter_chisel.scala 108:58:@5485.4]
  assign _T_540 = _T_538 & _T_327; // @[priority_arbiter_chisel.scala 108:80:@5487.4]
  assign _GEN_25 = _T_540 ? _GEN_110 : _GEN_23; // @[priority_arbiter_chisel.scala 108:138:@5488.4]
  assign _T_565 = request_critical_flatted_shift_left[2]; // @[priority_arbiter_chisel.scala 108:58:@5512.4]
  assign _T_567 = _T_565 & _T_352; // @[priority_arbiter_chisel.scala 108:80:@5514.4]
  assign _GEN_27 = _T_567 ? _GEN_111 : _GEN_25; // @[priority_arbiter_chisel.scala 108:138:@5515.4]
  assign _T_592 = request_critical_flatted_shift_left[1]; // @[priority_arbiter_chisel.scala 108:58:@5539.4]
  assign _T_594 = _T_592 & _T_377; // @[priority_arbiter_chisel.scala 108:80:@5541.4]
  assign _GEN_29 = _T_594 ? _GEN_112 : _GEN_27; // @[priority_arbiter_chisel.scala 108:138:@5542.4]
  assign _T_619 = request_critical_flatted_shift_left[0]; // @[priority_arbiter_chisel.scala 108:58:@5566.4]
  assign _T_621 = _T_619 & _T_402; // @[priority_arbiter_chisel.scala 108:80:@5568.4]
  assign _GEN_31 = _T_621 ? _GEN_113 : _GEN_29; // @[priority_arbiter_chisel.scala 108:138:@5569.4]
  assign valid_sel = _GEN_15[2:0]; // @[:@5171.4 :@5172.4 priority_arbiter_chisel.scala 91:19:@5173.4 priority_arbiter_chisel.scala 96:43:@5189.8 priority_arbiter_chisel.scala 98:43:@5196.8 priority_arbiter_chisel.scala 96:43:@5214.8 priority_arbiter_chisel.scala 98:43:@5221.8 priority_arbiter_chisel.scala 96:43:@5239.8 priority_arbiter_chisel.scala 98:43:@5246.8 priority_arbiter_chisel.scala 96:43:@5264.8 priority_arbiter_chisel.scala 98:43:@5271.8 priority_arbiter_chisel.scala 96:43:@5289.8 priority_arbiter_chisel.scala 98:43:@5296.8 priority_arbiter_chisel.scala 96:43:@5314.8 priority_arbiter_chisel.scala 98:43:@5321.8 priority_arbiter_chisel.scala 96:43:@5339.8 priority_arbiter_chisel.scala 98:43:@5346.8 priority_arbiter_chisel.scala 96:43:@5364.8 priority_arbiter_chisel.scala 98:43:@5371.8]
  assign critical_sel = _GEN_31[2:0]; // @[:@5374.4 :@5375.4 priority_arbiter_chisel.scala 105:22:@5376.4 priority_arbiter_chisel.scala 110:46:@5394.8 priority_arbiter_chisel.scala 112:46:@5401.8 priority_arbiter_chisel.scala 110:46:@5421.8 priority_arbiter_chisel.scala 112:46:@5428.8 priority_arbiter_chisel.scala 110:46:@5448.8 priority_arbiter_chisel.scala 112:46:@5455.8 priority_arbiter_chisel.scala 110:46:@5475.8 priority_arbiter_chisel.scala 112:46:@5482.8 priority_arbiter_chisel.scala 110:46:@5502.8 priority_arbiter_chisel.scala 112:46:@5509.8 priority_arbiter_chisel.scala 110:46:@5529.8 priority_arbiter_chisel.scala 112:46:@5536.8 priority_arbiter_chisel.scala 110:46:@5556.8 priority_arbiter_chisel.scala 112:46:@5563.8 priority_arbiter_chisel.scala 110:46:@5583.8 priority_arbiter_chisel.scala 112:46:@5590.8]
  assign _T_737 = last_send_index == 3'h0; // @[priority_arbiter_chisel.scala 136:59:@5707.4]
  assign _T_743 = last_send_index == 3'h1; // @[priority_arbiter_chisel.scala 136:59:@5716.4]
  assign _T_749 = last_send_index == 3'h2; // @[priority_arbiter_chisel.scala 136:59:@5725.4]
  assign _T_755 = last_send_index == 3'h3; // @[priority_arbiter_chisel.scala 136:59:@5734.4]
  assign _T_761 = last_send_index == 3'h4; // @[priority_arbiter_chisel.scala 136:59:@5743.4]
  assign _T_767 = last_send_index == 3'h5; // @[priority_arbiter_chisel.scala 136:59:@5752.4]
  assign _T_773 = last_send_index == 3'h6; // @[priority_arbiter_chisel.scala 136:59:@5761.4]
  assign _T_779 = last_send_index == 3'h7; // @[priority_arbiter_chisel.scala 136:59:@5770.4]
  assign _T_788 = io_issue_ack_in & request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:40:@5786.6]
  assign _T_789 = ~ request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:68:@5787.6]
  assign _T_790 = _T_788 | _T_789; // @[priority_arbiter_chisel.scala 149:65:@5788.6]
  assign _T_792 = request_critical_final >> critical_sel; // @[priority_arbiter_chisel.scala 150:46:@5791.8]
  assign _T_793 = _T_792[0]; // @[priority_arbiter_chisel.scala 150:46:@5792.8]
  assign _GEN_57 = 3'h1 == critical_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  assign _GEN_58 = 3'h2 == critical_sel ? request_valid_flatted_from_request_queue_2 : _GEN_57; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  assign _GEN_59 = 3'h3 == critical_sel ? request_valid_flatted_from_request_queue_3 : _GEN_58; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  assign _GEN_60 = 3'h4 == critical_sel ? request_valid_flatted_from_request_queue_4 : _GEN_59; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  assign _GEN_61 = 3'h5 == critical_sel ? request_valid_flatted_from_request_queue_5 : _GEN_60; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  assign _GEN_62 = 3'h6 == critical_sel ? request_valid_flatted_from_request_queue_6 : _GEN_61; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  assign _GEN_63 = 3'h7 == critical_sel ? request_valid_flatted_from_request_queue_7 : _GEN_62; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  assign _T_795 = _T_793 & _GEN_63; // @[priority_arbiter_chisel.scala 150:61:@5793.8]
  assign _T_796 = critical_sel != last_send_index; // @[priority_arbiter_chisel.scala 151:49:@5794.8]
  assign _T_797 = _T_796 & request_valid_out_reg; // @[priority_arbiter_chisel.scala 151:69:@5795.8]
  assign _T_799 = _T_797 | _T_789; // @[priority_arbiter_chisel.scala 151:95:@5797.8]
  assign _T_800 = _T_795 & _T_799; // @[priority_arbiter_chisel.scala 150:118:@5798.8]
  assign _GEN_65 = 3'h1 == critical_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  assign _GEN_66 = 3'h2 == critical_sel ? request_packed_from_request_queue_2 : _GEN_65; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  assign _GEN_67 = 3'h3 == critical_sel ? request_packed_from_request_queue_3 : _GEN_66; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  assign _GEN_68 = 3'h4 == critical_sel ? request_packed_from_request_queue_4 : _GEN_67; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  assign _GEN_69 = 3'h5 == critical_sel ? request_packed_from_request_queue_5 : _GEN_68; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  assign _GEN_70 = 3'h6 == critical_sel ? request_packed_from_request_queue_6 : _GEN_69; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  assign _GEN_71 = 3'h7 == critical_sel ? request_packed_from_request_queue_7 : _GEN_70; // @[priority_arbiter_chisel.scala 152:41:@5801.10]
  assign _T_805 = valid_sel != last_send_index; // @[priority_arbiter_chisel.scala 156:46:@5806.10]
  assign _T_806 = _T_805 & request_valid_out_reg; // @[priority_arbiter_chisel.scala 156:66:@5807.10]
  assign _T_808 = _T_806 | _T_789; // @[priority_arbiter_chisel.scala 156:92:@5809.10]
  assign _GEN_73 = 3'h1 == valid_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  assign _GEN_74 = 3'h2 == valid_sel ? request_valid_flatted_from_request_queue_2 : _GEN_73; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  assign _GEN_75 = 3'h3 == valid_sel ? request_valid_flatted_from_request_queue_3 : _GEN_74; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  assign _GEN_76 = 3'h4 == valid_sel ? request_valid_flatted_from_request_queue_4 : _GEN_75; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  assign _GEN_77 = 3'h5 == valid_sel ? request_valid_flatted_from_request_queue_5 : _GEN_76; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  assign _GEN_78 = 3'h6 == valid_sel ? request_valid_flatted_from_request_queue_6 : _GEN_77; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  assign _GEN_79 = 3'h7 == valid_sel ? request_valid_flatted_from_request_queue_7 : _GEN_78; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  assign _T_809 = _GEN_79 & _T_808; // @[priority_arbiter_chisel.scala 155:83:@5810.10]
  assign _GEN_81 = 3'h1 == valid_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  assign _GEN_82 = 3'h2 == valid_sel ? request_packed_from_request_queue_2 : _GEN_81; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  assign _GEN_83 = 3'h3 == valid_sel ? request_packed_from_request_queue_3 : _GEN_82; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  assign _GEN_84 = 3'h4 == valid_sel ? request_packed_from_request_queue_4 : _GEN_83; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  assign _GEN_85 = 3'h5 == valid_sel ? request_packed_from_request_queue_5 : _GEN_84; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  assign _GEN_86 = 3'h6 == valid_sel ? request_packed_from_request_queue_6 : _GEN_85; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  assign _GEN_87 = 3'h7 == valid_sel ? request_packed_from_request_queue_7 : _GEN_86; // @[priority_arbiter_chisel.scala 157:41:@5813.12]
  assign _GEN_88 = _T_809 ? _GEN_87 : 80'h0; // @[priority_arbiter_chisel.scala 156:129:@5812.10]
  assign _GEN_90 = _T_809 ? valid_sel : last_send_index; // @[priority_arbiter_chisel.scala 156:129:@5812.10]
  assign _GEN_91 = _T_800 ? _GEN_71 : _GEN_88; // @[priority_arbiter_chisel.scala 151:132:@5800.8]
  assign _GEN_92 = _T_800 ? 1'h1 : _T_809; // @[priority_arbiter_chisel.scala 151:132:@5800.8]
  assign _GEN_93 = _T_800 ? critical_sel : _GEN_90; // @[priority_arbiter_chisel.scala 151:132:@5800.8]
  assign _GEN_94 = _T_790 ? _GEN_91 : request_out_reg; // @[priority_arbiter_chisel.scala 149:101:@5790.6]
  assign _GEN_95 = _T_790 ? _GEN_92 : request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:101:@5790.6]
  assign _GEN_96 = _T_790 ? _GEN_93 : last_send_index; // @[priority_arbiter_chisel.scala 149:101:@5790.6]
  assign _GEN_97 = reset ? 80'h0 : _GEN_94; // @[priority_arbiter_chisel.scala 145:29:@5780.4]
  assign _GEN_98 = reset ? 1'h0 : _GEN_95; // @[priority_arbiter_chisel.scala 145:29:@5780.4]
  assign _GEN_99 = reset ? 3'h0 : _GEN_96; // @[priority_arbiter_chisel.scala 145:29:@5780.4]
  assign issue_ack_out_vec_1 = fifo_queue_chisel_1_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@4998.4]
  assign issue_ack_out_vec_0 = fifo_queue_chisel_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@4980.4]
  assign _T_815 = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter_chisel.scala 174:47:@5830.4]
  assign issue_ack_out_vec_3 = fifo_queue_chisel_3_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5034.4]
  assign issue_ack_out_vec_2 = fifo_queue_chisel_2_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5016.4]
  assign _T_816 = {issue_ack_out_vec_3,issue_ack_out_vec_2}; // @[priority_arbiter_chisel.scala 174:47:@5831.4]
  assign _T_817 = {_T_816,_T_815}; // @[priority_arbiter_chisel.scala 174:47:@5832.4]
  assign issue_ack_out_vec_5 = fifo_queue_chisel_5_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5070.4]
  assign issue_ack_out_vec_4 = fifo_queue_chisel_4_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5052.4]
  assign _T_818 = {issue_ack_out_vec_5,issue_ack_out_vec_4}; // @[priority_arbiter_chisel.scala 174:47:@5833.4]
  assign issue_ack_out_vec_7 = fifo_queue_chisel_7_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5106.4]
  assign issue_ack_out_vec_6 = fifo_queue_chisel_6_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@4962.4 priority_arbiter_chisel.scala 68:50:@5088.4]
  assign _T_819 = {issue_ack_out_vec_7,issue_ack_out_vec_6}; // @[priority_arbiter_chisel.scala 174:47:@5834.4]
  assign _T_820 = {_T_819,_T_818}; // @[priority_arbiter_chisel.scala 174:47:@5835.4]
  assign io_issue_ack_out = {_T_820,_T_817}; // @[priority_arbiter_chisel.scala 174:26:@5837.4]
  assign io_request_out = request_out_reg; // @[priority_arbiter_chisel.scala 172:24:@5828.4]
  assign fifo_queue_chisel_clock = clock; // @[:@4972.4]
  assign fifo_queue_chisel_reset = reset; // @[:@4973.4]
  assign fifo_queue_chisel_io_request_in = {1'h0,request_packed_in_0}; // @[priority_arbiter_chisel.scala 66:45:@4977.4]
  assign fifo_queue_chisel_io_request_valid_in = io_request_valid_flatted_in[0]; // @[priority_arbiter_chisel.scala 67:51:@4979.4]
  assign fifo_queue_chisel_io_issue_ack_in = io_issue_ack_in & _T_737; // @[priority_arbiter_chisel.scala 74:47:@4986.4]
  assign fifo_queue_chisel_1_clock = clock; // @[:@4990.4]
  assign fifo_queue_chisel_1_reset = reset; // @[:@4991.4]
  assign fifo_queue_chisel_1_io_request_in = {1'h0,request_packed_in_1}; // @[priority_arbiter_chisel.scala 66:45:@4995.4]
  assign fifo_queue_chisel_1_io_request_valid_in = io_request_valid_flatted_in[1]; // @[priority_arbiter_chisel.scala 67:51:@4997.4]
  assign fifo_queue_chisel_1_io_issue_ack_in = io_issue_ack_in & _T_743; // @[priority_arbiter_chisel.scala 74:47:@5004.4]
  assign fifo_queue_chisel_2_clock = clock; // @[:@5008.4]
  assign fifo_queue_chisel_2_reset = reset; // @[:@5009.4]
  assign fifo_queue_chisel_2_io_request_in = {1'h0,request_packed_in_2}; // @[priority_arbiter_chisel.scala 66:45:@5013.4]
  assign fifo_queue_chisel_2_io_request_valid_in = io_request_valid_flatted_in[2]; // @[priority_arbiter_chisel.scala 67:51:@5015.4]
  assign fifo_queue_chisel_2_io_issue_ack_in = io_issue_ack_in & _T_749; // @[priority_arbiter_chisel.scala 74:47:@5022.4]
  assign fifo_queue_chisel_3_clock = clock; // @[:@5026.4]
  assign fifo_queue_chisel_3_reset = reset; // @[:@5027.4]
  assign fifo_queue_chisel_3_io_request_in = {1'h0,request_packed_in_3}; // @[priority_arbiter_chisel.scala 66:45:@5031.4]
  assign fifo_queue_chisel_3_io_request_valid_in = io_request_valid_flatted_in[3]; // @[priority_arbiter_chisel.scala 67:51:@5033.4]
  assign fifo_queue_chisel_3_io_issue_ack_in = io_issue_ack_in & _T_755; // @[priority_arbiter_chisel.scala 74:47:@5040.4]
  assign fifo_queue_chisel_4_clock = clock; // @[:@5044.4]
  assign fifo_queue_chisel_4_reset = reset; // @[:@5045.4]
  assign fifo_queue_chisel_4_io_request_in = {1'h0,request_packed_in_4}; // @[priority_arbiter_chisel.scala 66:45:@5049.4]
  assign fifo_queue_chisel_4_io_request_valid_in = io_request_valid_flatted_in[4]; // @[priority_arbiter_chisel.scala 67:51:@5051.4]
  assign fifo_queue_chisel_4_io_issue_ack_in = io_issue_ack_in & _T_761; // @[priority_arbiter_chisel.scala 74:47:@5058.4]
  assign fifo_queue_chisel_5_clock = clock; // @[:@5062.4]
  assign fifo_queue_chisel_5_reset = reset; // @[:@5063.4]
  assign fifo_queue_chisel_5_io_request_in = {1'h0,request_packed_in_5}; // @[priority_arbiter_chisel.scala 66:45:@5067.4]
  assign fifo_queue_chisel_5_io_request_valid_in = io_request_valid_flatted_in[5]; // @[priority_arbiter_chisel.scala 67:51:@5069.4]
  assign fifo_queue_chisel_5_io_issue_ack_in = io_issue_ack_in & _T_767; // @[priority_arbiter_chisel.scala 74:47:@5076.4]
  assign fifo_queue_chisel_6_clock = clock; // @[:@5080.4]
  assign fifo_queue_chisel_6_reset = reset; // @[:@5081.4]
  assign fifo_queue_chisel_6_io_request_in = {1'h0,request_packed_in_6}; // @[priority_arbiter_chisel.scala 66:45:@5085.4]
  assign fifo_queue_chisel_6_io_request_valid_in = io_request_valid_flatted_in[6]; // @[priority_arbiter_chisel.scala 67:51:@5087.4]
  assign fifo_queue_chisel_6_io_issue_ack_in = io_issue_ack_in & _T_773; // @[priority_arbiter_chisel.scala 74:47:@5094.4]
  assign fifo_queue_chisel_7_clock = clock; // @[:@5098.4]
  assign fifo_queue_chisel_7_reset = reset; // @[:@5099.4]
  assign fifo_queue_chisel_7_io_request_in = {1'h0,request_packed_in_7}; // @[priority_arbiter_chisel.scala 66:45:@5103.4]
  assign fifo_queue_chisel_7_io_request_valid_in = io_request_valid_flatted_in[7]; // @[priority_arbiter_chisel.scala 67:51:@5105.4]
  assign fifo_queue_chisel_7_io_issue_ack_in = io_issue_ack_in & _T_779; // @[priority_arbiter_chisel.scala 74:47:@5112.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {3{`RANDOM}};
  request_out_reg = _RAND_0[79:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  request_valid_out_reg = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  last_send_index = _RAND_2[2:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      request_out_reg <= 80'h0;
    end else begin
      if (reset) begin
        request_out_reg <= 80'h0;
      end else begin
        if (_T_790) begin
          if (_T_800) begin
            if (3'h7 == critical_sel) begin
              request_out_reg <= request_packed_from_request_queue_7;
            end else begin
              if (3'h6 == critical_sel) begin
                request_out_reg <= request_packed_from_request_queue_6;
              end else begin
                if (3'h5 == critical_sel) begin
                  request_out_reg <= request_packed_from_request_queue_5;
                end else begin
                  if (3'h4 == critical_sel) begin
                    request_out_reg <= request_packed_from_request_queue_4;
                  end else begin
                    if (3'h3 == critical_sel) begin
                      request_out_reg <= request_packed_from_request_queue_3;
                    end else begin
                      if (3'h2 == critical_sel) begin
                        request_out_reg <= request_packed_from_request_queue_2;
                      end else begin
                        if (3'h1 == critical_sel) begin
                          request_out_reg <= request_packed_from_request_queue_1;
                        end else begin
                          request_out_reg <= request_packed_from_request_queue_0;
                        end
                      end
                    end
                  end
                end
              end
            end
          end else begin
            if (_T_809) begin
              if (3'h7 == valid_sel) begin
                request_out_reg <= request_packed_from_request_queue_7;
              end else begin
                if (3'h6 == valid_sel) begin
                  request_out_reg <= request_packed_from_request_queue_6;
                end else begin
                  if (3'h5 == valid_sel) begin
                    request_out_reg <= request_packed_from_request_queue_5;
                  end else begin
                    if (3'h4 == valid_sel) begin
                      request_out_reg <= request_packed_from_request_queue_4;
                    end else begin
                      if (3'h3 == valid_sel) begin
                        request_out_reg <= request_packed_from_request_queue_3;
                      end else begin
                        if (3'h2 == valid_sel) begin
                          request_out_reg <= request_packed_from_request_queue_2;
                        end else begin
                          if (3'h1 == valid_sel) begin
                            request_out_reg <= request_packed_from_request_queue_1;
                          end else begin
                            request_out_reg <= request_packed_from_request_queue_0;
                          end
                        end
                      end
                    end
                  end
                end
              end
            end else begin
              request_out_reg <= 80'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      request_valid_out_reg <= 1'h0;
    end else begin
      if (reset) begin
        request_valid_out_reg <= 1'h0;
      end else begin
        if (_T_790) begin
          if (_T_800) begin
            request_valid_out_reg <= 1'h1;
          end else begin
            request_valid_out_reg <= _T_809;
          end
        end
      end
    end
    if (reset) begin
      last_send_index <= 3'h0;
    end else begin
      if (reset) begin
        last_send_index <= 3'h0;
      end else begin
        if (_T_790) begin
          if (_T_800) begin
            last_send_index <= critical_sel;
          end else begin
            if (_T_809) begin
              last_send_index <= valid_sel;
            end
          end
        end
      end
    end
  end
endmodule
module priority_arbiter_chisel_5( // @[:@6607.2]
  input          clock, // @[:@6608.4]
  input          reset, // @[:@6609.4]
  input  [319:0] io_request_flatted_in, // @[:@6610.4]
  input  [3:0]   io_request_valid_flatted_in, // @[:@6610.4]
  output [3:0]   io_issue_ack_out, // @[:@6610.4]
  output [79:0]  io_request_out, // @[:@6610.4]
  input          io_issue_ack_in // @[:@6610.4]
);
  wire  fifo_queue_chisel_clock; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire  fifo_queue_chisel_reset; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire  fifo_queue_chisel_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire  fifo_queue_chisel_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire [80:0] fifo_queue_chisel_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire  fifo_queue_chisel_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire  fifo_queue_chisel_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire [80:0] fifo_queue_chisel_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire  fifo_queue_chisel_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire  fifo_queue_chisel_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@6623.4]
  wire  fifo_queue_chisel_1_clock; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire  fifo_queue_chisel_1_reset; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire  fifo_queue_chisel_1_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire  fifo_queue_chisel_1_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire [80:0] fifo_queue_chisel_1_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire  fifo_queue_chisel_1_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire  fifo_queue_chisel_1_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire [80:0] fifo_queue_chisel_1_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire  fifo_queue_chisel_1_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire  fifo_queue_chisel_1_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@6641.4]
  wire  fifo_queue_chisel_2_clock; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire  fifo_queue_chisel_2_reset; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire  fifo_queue_chisel_2_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire  fifo_queue_chisel_2_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire [80:0] fifo_queue_chisel_2_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire  fifo_queue_chisel_2_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire  fifo_queue_chisel_2_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire [80:0] fifo_queue_chisel_2_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire  fifo_queue_chisel_2_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire  fifo_queue_chisel_2_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@6659.4]
  wire  fifo_queue_chisel_3_clock; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire  fifo_queue_chisel_3_reset; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire  fifo_queue_chisel_3_io_is_empty_out; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire  fifo_queue_chisel_3_io_is_full_out; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire [80:0] fifo_queue_chisel_3_io_request_in; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire  fifo_queue_chisel_3_io_request_valid_in; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire  fifo_queue_chisel_3_io_issue_ack_out; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire [80:0] fifo_queue_chisel_3_io_request_out; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire  fifo_queue_chisel_3_io_request_valid_out; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  wire  fifo_queue_chisel_3_io_issue_ack_in; // @[priority_arbiter_chisel.scala 61:43:@6677.4]
  reg [79:0] request_out_reg; // @[priority_arbiter_chisel.scala 45:38:@6612.4]
  reg [95:0] _RAND_0;
  reg  request_valid_out_reg; // @[priority_arbiter_chisel.scala 46:44:@6613.4]
  reg [31:0] _RAND_1;
  wire [79:0] request_packed_in_0; // @[priority_arbiter_chisel.scala 59:74:@6621.4]
  wire  request_critical_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 70:107:@6633.4]
  wire [79:0] request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 71:97:@6635.4]
  wire [79:0] request_packed_in_1; // @[priority_arbiter_chisel.scala 59:74:@6639.4]
  wire  request_critical_flatted_from_request_queue_1; // @[priority_arbiter_chisel.scala 70:107:@6651.4]
  wire [79:0] request_packed_from_request_queue_1; // @[priority_arbiter_chisel.scala 71:97:@6653.4]
  wire [79:0] request_packed_in_2; // @[priority_arbiter_chisel.scala 59:74:@6657.4]
  wire  request_critical_flatted_from_request_queue_2; // @[priority_arbiter_chisel.scala 70:107:@6669.4]
  wire [79:0] request_packed_from_request_queue_2; // @[priority_arbiter_chisel.scala 71:97:@6671.4]
  wire [79:0] request_packed_in_3; // @[priority_arbiter_chisel.scala 59:74:@6675.4]
  wire  request_critical_flatted_from_request_queue_3; // @[priority_arbiter_chisel.scala 70:107:@6687.4]
  wire [79:0] request_packed_from_request_queue_3; // @[priority_arbiter_chisel.scala 71:97:@6689.4]
  wire [1:0] _T_111; // @[priority_arbiter_chisel.scala 78:79:@6694.4]
  wire [1:0] _T_112; // @[priority_arbiter_chisel.scala 78:79:@6695.4]
  wire [3:0] _T_113; // @[priority_arbiter_chisel.scala 78:79:@6696.4]
  wire  request_queue_full_1; // @[priority_arbiter_chisel.scala 55:38:@6619.4 priority_arbiter_chisel.scala 65:51:@6644.4]
  wire  request_queue_full_0; // @[priority_arbiter_chisel.scala 55:38:@6619.4 priority_arbiter_chisel.scala 65:51:@6626.4]
  wire [1:0] _T_114; // @[priority_arbiter_chisel.scala 78:107:@6697.4]
  wire  request_queue_full_3; // @[priority_arbiter_chisel.scala 55:38:@6619.4 priority_arbiter_chisel.scala 65:51:@6680.4]
  wire  request_queue_full_2; // @[priority_arbiter_chisel.scala 55:38:@6619.4 priority_arbiter_chisel.scala 65:51:@6662.4]
  wire [1:0] _T_115; // @[priority_arbiter_chisel.scala 78:107:@6698.4]
  wire [3:0] _T_116; // @[priority_arbiter_chisel.scala 78:107:@6699.4]
  wire [3:0] request_critical_final; // @[priority_arbiter_chisel.scala 78:86:@6700.4]
  reg [1:0] last_send_index; // @[priority_arbiter_chisel.scala 79:38:@6702.4]
  reg [31:0] _RAND_2;
  wire  request_valid_flatted_from_request_queue_1; // @[priority_arbiter_chisel.scala 54:60:@6618.4 priority_arbiter_chisel.scala 73:73:@6655.4]
  wire  request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 54:60:@6618.4 priority_arbiter_chisel.scala 73:73:@6637.4]
  wire [1:0] _T_122; // @[priority_arbiter_chisel.scala 84:87:@6705.4]
  wire  request_valid_flatted_from_request_queue_3; // @[priority_arbiter_chisel.scala 54:60:@6618.4 priority_arbiter_chisel.scala 73:73:@6691.4]
  wire  request_valid_flatted_from_request_queue_2; // @[priority_arbiter_chisel.scala 54:60:@6618.4 priority_arbiter_chisel.scala 73:73:@6673.4]
  wire [1:0] _T_123; // @[priority_arbiter_chisel.scala 84:87:@6706.4]
  wire [3:0] _T_124; // @[priority_arbiter_chisel.scala 84:87:@6707.4]
  wire [2:0] _T_126; // @[priority_arbiter_chisel.scala 84:114:@6708.4]
  wire [1:0] _T_127; // @[priority_arbiter_chisel.scala 84:114:@6709.4]
  wire [3:0] _T_128; // @[priority_arbiter_chisel.scala 84:94:@6710.4]
  wire [2:0] _GEN_56; // @[priority_arbiter_chisel.scala 85:148:@6714.4]
  wire [3:0] _T_133; // @[priority_arbiter_chisel.scala 85:148:@6714.4]
  wire [3:0] _T_134; // @[priority_arbiter_chisel.scala 85:148:@6715.4]
  wire [2:0] _T_135; // @[priority_arbiter_chisel.scala 85:148:@6716.4]
  wire [3:0] _T_137; // @[priority_arbiter_chisel.scala 85:166:@6717.4]
  wire [3:0] _T_138; // @[priority_arbiter_chisel.scala 85:166:@6718.4]
  wire [2:0] _T_139; // @[priority_arbiter_chisel.scala 85:166:@6719.4]
  wire [10:0] _GEN_57; // @[priority_arbiter_chisel.scala 85:130:@6720.4]
  wire [10:0] _T_140; // @[priority_arbiter_chisel.scala 85:130:@6720.4]
  wire [10:0] _GEN_58; // @[priority_arbiter_chisel.scala 84:122:@6721.4]
  wire [10:0] _T_141; // @[priority_arbiter_chisel.scala 84:122:@6721.4]
  wire [3:0] _T_145; // @[priority_arbiter_chisel.scala 86:72:@6725.4]
  wire [10:0] _GEN_60; // @[priority_arbiter_chisel.scala 87:108:@6732.4]
  wire [10:0] _T_154; // @[priority_arbiter_chisel.scala 87:108:@6732.4]
  wire [10:0] _GEN_61; // @[priority_arbiter_chisel.scala 86:100:@6733.4]
  wire [10:0] _T_155; // @[priority_arbiter_chisel.scala 86:100:@6733.4]
  wire [3:0] request_valid_flatted_shift_left; // @[priority_arbiter_chisel.scala 82:52:@6703.4 priority_arbiter_chisel.scala 84:42:@6722.4]
  wire  _T_159; // @[priority_arbiter_chisel.scala 94:55:@6738.4]
  wire [2:0] _T_161; // @[priority_arbiter_chisel.scala 95:47:@6740.6]
  wire [1:0] _T_162; // @[priority_arbiter_chisel.scala 95:47:@6741.6]
  wire [2:0] _T_164; // @[priority_arbiter_chisel.scala 95:68:@6742.6]
  wire [1:0] _T_165; // @[priority_arbiter_chisel.scala 95:68:@6743.6]
  wire [2:0] _GEN_62; // @[priority_arbiter_chisel.scala 96:89:@6750.8]
  wire [2:0] _GEN_1; // @[priority_arbiter_chisel.scala 94:75:@6739.4]
  wire  _T_184; // @[priority_arbiter_chisel.scala 94:55:@6763.4]
  wire [2:0] _T_186; // @[priority_arbiter_chisel.scala 95:47:@6765.6]
  wire [1:0] _T_187; // @[priority_arbiter_chisel.scala 95:47:@6766.6]
  wire [2:0] _T_189; // @[priority_arbiter_chisel.scala 95:68:@6767.6]
  wire [1:0] _T_190; // @[priority_arbiter_chisel.scala 95:68:@6768.6]
  wire [2:0] _GEN_63; // @[priority_arbiter_chisel.scala 96:89:@6775.8]
  wire [2:0] _GEN_3; // @[priority_arbiter_chisel.scala 94:75:@6764.4]
  wire  _T_209; // @[priority_arbiter_chisel.scala 94:55:@6788.4]
  wire [2:0] _T_214; // @[priority_arbiter_chisel.scala 95:68:@6792.6]
  wire [1:0] _T_215; // @[priority_arbiter_chisel.scala 95:68:@6793.6]
  wire [2:0] _GEN_64; // @[priority_arbiter_chisel.scala 96:89:@6800.8]
  wire [2:0] _GEN_5; // @[priority_arbiter_chisel.scala 94:75:@6789.4]
  wire  _T_234; // @[priority_arbiter_chisel.scala 94:55:@6813.4]
  wire [1:0] _T_237; // @[priority_arbiter_chisel.scala 95:47:@6816.6]
  wire [2:0] _T_239; // @[priority_arbiter_chisel.scala 95:68:@6817.6]
  wire [1:0] _T_240; // @[priority_arbiter_chisel.scala 95:68:@6818.6]
  wire [2:0] _GEN_65; // @[priority_arbiter_chisel.scala 96:89:@6825.8]
  wire [2:0] _GEN_7; // @[priority_arbiter_chisel.scala 94:75:@6814.4]
  wire [3:0] request_critical_flatted_shift_left; // @[priority_arbiter_chisel.scala 83:55:@6704.4 priority_arbiter_chisel.scala 86:45:@6734.4]
  wire  _T_262; // @[priority_arbiter_chisel.scala 108:58:@6841.4]
  wire  _T_264; // @[priority_arbiter_chisel.scala 108:80:@6843.4]
  wire [2:0] _GEN_9; // @[priority_arbiter_chisel.scala 108:138:@6844.4]
  wire  _T_289; // @[priority_arbiter_chisel.scala 108:58:@6868.4]
  wire  _T_291; // @[priority_arbiter_chisel.scala 108:80:@6870.4]
  wire [2:0] _GEN_11; // @[priority_arbiter_chisel.scala 108:138:@6871.4]
  wire  _T_316; // @[priority_arbiter_chisel.scala 108:58:@6895.4]
  wire  _T_318; // @[priority_arbiter_chisel.scala 108:80:@6897.4]
  wire [2:0] _GEN_13; // @[priority_arbiter_chisel.scala 108:138:@6898.4]
  wire  _T_343; // @[priority_arbiter_chisel.scala 108:58:@6922.4]
  wire  _T_345; // @[priority_arbiter_chisel.scala 108:80:@6924.4]
  wire [2:0] _GEN_15; // @[priority_arbiter_chisel.scala 108:138:@6925.4]
  wire [1:0] valid_sel; // @[:@6735.4 :@6736.4 priority_arbiter_chisel.scala 91:19:@6737.4 priority_arbiter_chisel.scala 96:43:@6753.8 priority_arbiter_chisel.scala 98:43:@6760.8 priority_arbiter_chisel.scala 96:43:@6778.8 priority_arbiter_chisel.scala 98:43:@6785.8 priority_arbiter_chisel.scala 96:43:@6803.8 priority_arbiter_chisel.scala 98:43:@6810.8 priority_arbiter_chisel.scala 96:43:@6828.8 priority_arbiter_chisel.scala 98:43:@6835.8]
  wire [1:0] critical_sel; // @[:@6838.4 :@6839.4 priority_arbiter_chisel.scala 105:22:@6840.4 priority_arbiter_chisel.scala 110:46:@6858.8 priority_arbiter_chisel.scala 112:46:@6865.8 priority_arbiter_chisel.scala 110:46:@6885.8 priority_arbiter_chisel.scala 112:46:@6892.8 priority_arbiter_chisel.scala 110:46:@6912.8 priority_arbiter_chisel.scala 112:46:@6919.8 priority_arbiter_chisel.scala 110:46:@6939.8 priority_arbiter_chisel.scala 112:46:@6946.8]
  wire  _T_421; // @[priority_arbiter_chisel.scala 136:59:@7007.4]
  wire  _T_427; // @[priority_arbiter_chisel.scala 136:59:@7016.4]
  wire  _T_433; // @[priority_arbiter_chisel.scala 136:59:@7025.4]
  wire  _T_439; // @[priority_arbiter_chisel.scala 136:59:@7034.4]
  wire  _T_448; // @[priority_arbiter_chisel.scala 149:40:@7050.6]
  wire  _T_449; // @[priority_arbiter_chisel.scala 149:68:@7051.6]
  wire  _T_450; // @[priority_arbiter_chisel.scala 149:65:@7052.6]
  wire [3:0] _T_452; // @[priority_arbiter_chisel.scala 150:46:@7055.8]
  wire  _T_453; // @[priority_arbiter_chisel.scala 150:46:@7056.8]
  wire  _GEN_29; // @[priority_arbiter_chisel.scala 150:61:@7057.8]
  wire  _GEN_30; // @[priority_arbiter_chisel.scala 150:61:@7057.8]
  wire  _GEN_31; // @[priority_arbiter_chisel.scala 150:61:@7057.8]
  wire  _T_455; // @[priority_arbiter_chisel.scala 150:61:@7057.8]
  wire  _T_456; // @[priority_arbiter_chisel.scala 151:49:@7058.8]
  wire  _T_457; // @[priority_arbiter_chisel.scala 151:69:@7059.8]
  wire  _T_459; // @[priority_arbiter_chisel.scala 151:95:@7061.8]
  wire  _T_460; // @[priority_arbiter_chisel.scala 150:118:@7062.8]
  wire [79:0] _GEN_33; // @[priority_arbiter_chisel.scala 152:41:@7065.10]
  wire [79:0] _GEN_34; // @[priority_arbiter_chisel.scala 152:41:@7065.10]
  wire [79:0] _GEN_35; // @[priority_arbiter_chisel.scala 152:41:@7065.10]
  wire  _T_465; // @[priority_arbiter_chisel.scala 156:46:@7070.10]
  wire  _T_466; // @[priority_arbiter_chisel.scala 156:66:@7071.10]
  wire  _T_468; // @[priority_arbiter_chisel.scala 156:92:@7073.10]
  wire  _GEN_37; // @[priority_arbiter_chisel.scala 155:83:@7074.10]
  wire  _GEN_38; // @[priority_arbiter_chisel.scala 155:83:@7074.10]
  wire  _GEN_39; // @[priority_arbiter_chisel.scala 155:83:@7074.10]
  wire  _T_469; // @[priority_arbiter_chisel.scala 155:83:@7074.10]
  wire [79:0] _GEN_41; // @[priority_arbiter_chisel.scala 157:41:@7077.12]
  wire [79:0] _GEN_42; // @[priority_arbiter_chisel.scala 157:41:@7077.12]
  wire [79:0] _GEN_43; // @[priority_arbiter_chisel.scala 157:41:@7077.12]
  wire [79:0] _GEN_44; // @[priority_arbiter_chisel.scala 156:129:@7076.10]
  wire [1:0] _GEN_46; // @[priority_arbiter_chisel.scala 156:129:@7076.10]
  wire [79:0] _GEN_47; // @[priority_arbiter_chisel.scala 151:132:@7064.8]
  wire  _GEN_48; // @[priority_arbiter_chisel.scala 151:132:@7064.8]
  wire [1:0] _GEN_49; // @[priority_arbiter_chisel.scala 151:132:@7064.8]
  wire [79:0] _GEN_50; // @[priority_arbiter_chisel.scala 149:101:@7054.6]
  wire  _GEN_51; // @[priority_arbiter_chisel.scala 149:101:@7054.6]
  wire [1:0] _GEN_52; // @[priority_arbiter_chisel.scala 149:101:@7054.6]
  wire [79:0] _GEN_53; // @[priority_arbiter_chisel.scala 145:29:@7044.4]
  wire  _GEN_54; // @[priority_arbiter_chisel.scala 145:29:@7044.4]
  wire [1:0] _GEN_55; // @[priority_arbiter_chisel.scala 145:29:@7044.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter_chisel.scala 47:37:@6614.4 priority_arbiter_chisel.scala 68:50:@6650.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter_chisel.scala 47:37:@6614.4 priority_arbiter_chisel.scala 68:50:@6632.4]
  wire [1:0] _T_475; // @[priority_arbiter_chisel.scala 174:47:@7094.4]
  wire  issue_ack_out_vec_3; // @[priority_arbiter_chisel.scala 47:37:@6614.4 priority_arbiter_chisel.scala 68:50:@6686.4]
  wire  issue_ack_out_vec_2; // @[priority_arbiter_chisel.scala 47:37:@6614.4 priority_arbiter_chisel.scala 68:50:@6668.4]
  wire [1:0] _T_476; // @[priority_arbiter_chisel.scala 174:47:@7095.4]
  fifo_queue_chisel_2 fifo_queue_chisel ( // @[priority_arbiter_chisel.scala 61:43:@6623.4]
    .clock(fifo_queue_chisel_clock),
    .reset(fifo_queue_chisel_reset),
    .io_is_empty_out(fifo_queue_chisel_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_io_is_full_out),
    .io_request_in(fifo_queue_chisel_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_1 ( // @[priority_arbiter_chisel.scala 61:43:@6641.4]
    .clock(fifo_queue_chisel_1_clock),
    .reset(fifo_queue_chisel_1_reset),
    .io_is_empty_out(fifo_queue_chisel_1_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_1_io_is_full_out),
    .io_request_in(fifo_queue_chisel_1_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_1_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_1_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_1_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_2 ( // @[priority_arbiter_chisel.scala 61:43:@6659.4]
    .clock(fifo_queue_chisel_2_clock),
    .reset(fifo_queue_chisel_2_reset),
    .io_is_empty_out(fifo_queue_chisel_2_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_2_io_is_full_out),
    .io_request_in(fifo_queue_chisel_2_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_2_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_2_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_2_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_2_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_2_io_issue_ack_in)
  );
  fifo_queue_chisel_2 fifo_queue_chisel_3 ( // @[priority_arbiter_chisel.scala 61:43:@6677.4]
    .clock(fifo_queue_chisel_3_clock),
    .reset(fifo_queue_chisel_3_reset),
    .io_is_empty_out(fifo_queue_chisel_3_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_3_io_is_full_out),
    .io_request_in(fifo_queue_chisel_3_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_3_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_3_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_3_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_3_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_3_io_issue_ack_in)
  );
  assign request_packed_in_0 = io_request_flatted_in[79:0]; // @[priority_arbiter_chisel.scala 59:74:@6621.4]
  assign request_critical_flatted_from_request_queue_0 = fifo_queue_chisel_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@6633.4]
  assign request_packed_from_request_queue_0 = fifo_queue_chisel_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@6635.4]
  assign request_packed_in_1 = io_request_flatted_in[159:80]; // @[priority_arbiter_chisel.scala 59:74:@6639.4]
  assign request_critical_flatted_from_request_queue_1 = fifo_queue_chisel_1_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@6651.4]
  assign request_packed_from_request_queue_1 = fifo_queue_chisel_1_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@6653.4]
  assign request_packed_in_2 = io_request_flatted_in[239:160]; // @[priority_arbiter_chisel.scala 59:74:@6657.4]
  assign request_critical_flatted_from_request_queue_2 = fifo_queue_chisel_2_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@6669.4]
  assign request_packed_from_request_queue_2 = fifo_queue_chisel_2_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@6671.4]
  assign request_packed_in_3 = io_request_flatted_in[319:240]; // @[priority_arbiter_chisel.scala 59:74:@6675.4]
  assign request_critical_flatted_from_request_queue_3 = fifo_queue_chisel_3_io_request_out[80]; // @[priority_arbiter_chisel.scala 70:107:@6687.4]
  assign request_packed_from_request_queue_3 = fifo_queue_chisel_3_io_request_out[79:0]; // @[priority_arbiter_chisel.scala 71:97:@6689.4]
  assign _T_111 = {request_critical_flatted_from_request_queue_1,request_critical_flatted_from_request_queue_0}; // @[priority_arbiter_chisel.scala 78:79:@6694.4]
  assign _T_112 = {request_critical_flatted_from_request_queue_3,request_critical_flatted_from_request_queue_2}; // @[priority_arbiter_chisel.scala 78:79:@6695.4]
  assign _T_113 = {_T_112,_T_111}; // @[priority_arbiter_chisel.scala 78:79:@6696.4]
  assign request_queue_full_1 = fifo_queue_chisel_1_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@6619.4 priority_arbiter_chisel.scala 65:51:@6644.4]
  assign request_queue_full_0 = fifo_queue_chisel_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@6619.4 priority_arbiter_chisel.scala 65:51:@6626.4]
  assign _T_114 = {request_queue_full_1,request_queue_full_0}; // @[priority_arbiter_chisel.scala 78:107:@6697.4]
  assign request_queue_full_3 = fifo_queue_chisel_3_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@6619.4 priority_arbiter_chisel.scala 65:51:@6680.4]
  assign request_queue_full_2 = fifo_queue_chisel_2_io_is_full_out; // @[priority_arbiter_chisel.scala 55:38:@6619.4 priority_arbiter_chisel.scala 65:51:@6662.4]
  assign _T_115 = {request_queue_full_3,request_queue_full_2}; // @[priority_arbiter_chisel.scala 78:107:@6698.4]
  assign _T_116 = {_T_115,_T_114}; // @[priority_arbiter_chisel.scala 78:107:@6699.4]
  assign request_critical_final = _T_113 | _T_116; // @[priority_arbiter_chisel.scala 78:86:@6700.4]
  assign request_valid_flatted_from_request_queue_1 = fifo_queue_chisel_1_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@6618.4 priority_arbiter_chisel.scala 73:73:@6655.4]
  assign request_valid_flatted_from_request_queue_0 = fifo_queue_chisel_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@6618.4 priority_arbiter_chisel.scala 73:73:@6637.4]
  assign _T_122 = {request_valid_flatted_from_request_queue_1,request_valid_flatted_from_request_queue_0}; // @[priority_arbiter_chisel.scala 84:87:@6705.4]
  assign request_valid_flatted_from_request_queue_3 = fifo_queue_chisel_3_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@6618.4 priority_arbiter_chisel.scala 73:73:@6691.4]
  assign request_valid_flatted_from_request_queue_2 = fifo_queue_chisel_2_io_request_valid_out; // @[priority_arbiter_chisel.scala 54:60:@6618.4 priority_arbiter_chisel.scala 73:73:@6673.4]
  assign _T_123 = {request_valid_flatted_from_request_queue_3,request_valid_flatted_from_request_queue_2}; // @[priority_arbiter_chisel.scala 84:87:@6706.4]
  assign _T_124 = {_T_123,_T_122}; // @[priority_arbiter_chisel.scala 84:87:@6707.4]
  assign _T_126 = last_send_index + 2'h1; // @[priority_arbiter_chisel.scala 84:114:@6708.4]
  assign _T_127 = _T_126[1:0]; // @[priority_arbiter_chisel.scala 84:114:@6709.4]
  assign _T_128 = _T_124 >> _T_127; // @[priority_arbiter_chisel.scala 84:94:@6710.4]
  assign _GEN_56 = {{1'd0}, last_send_index}; // @[priority_arbiter_chisel.scala 85:148:@6714.4]
  assign _T_133 = 3'h4 - _GEN_56; // @[priority_arbiter_chisel.scala 85:148:@6714.4]
  assign _T_134 = $unsigned(_T_133); // @[priority_arbiter_chisel.scala 85:148:@6715.4]
  assign _T_135 = _T_134[2:0]; // @[priority_arbiter_chisel.scala 85:148:@6716.4]
  assign _T_137 = _T_135 - 3'h1; // @[priority_arbiter_chisel.scala 85:166:@6717.4]
  assign _T_138 = $unsigned(_T_137); // @[priority_arbiter_chisel.scala 85:166:@6718.4]
  assign _T_139 = _T_138[2:0]; // @[priority_arbiter_chisel.scala 85:166:@6719.4]
  assign _GEN_57 = {{7'd0}, _T_124}; // @[priority_arbiter_chisel.scala 85:130:@6720.4]
  assign _T_140 = _GEN_57 << _T_139; // @[priority_arbiter_chisel.scala 85:130:@6720.4]
  assign _GEN_58 = {{7'd0}, _T_128}; // @[priority_arbiter_chisel.scala 84:122:@6721.4]
  assign _T_141 = _GEN_58 | _T_140; // @[priority_arbiter_chisel.scala 84:122:@6721.4]
  assign _T_145 = request_critical_final >> _T_127; // @[priority_arbiter_chisel.scala 86:72:@6725.4]
  assign _GEN_60 = {{7'd0}, request_critical_final}; // @[priority_arbiter_chisel.scala 87:108:@6732.4]
  assign _T_154 = _GEN_60 << _T_139; // @[priority_arbiter_chisel.scala 87:108:@6732.4]
  assign _GEN_61 = {{7'd0}, _T_145}; // @[priority_arbiter_chisel.scala 86:100:@6733.4]
  assign _T_155 = _GEN_61 | _T_154; // @[priority_arbiter_chisel.scala 86:100:@6733.4]
  assign request_valid_flatted_shift_left = _T_141[3:0]; // @[priority_arbiter_chisel.scala 82:52:@6703.4 priority_arbiter_chisel.scala 84:42:@6722.4]
  assign _T_159 = request_valid_flatted_shift_left[3]; // @[priority_arbiter_chisel.scala 94:55:@6738.4]
  assign _T_161 = last_send_index + 2'h3; // @[priority_arbiter_chisel.scala 95:47:@6740.6]
  assign _T_162 = _T_161[1:0]; // @[priority_arbiter_chisel.scala 95:47:@6741.6]
  assign _T_164 = _T_162 + 2'h1; // @[priority_arbiter_chisel.scala 95:68:@6742.6]
  assign _T_165 = _T_164[1:0]; // @[priority_arbiter_chisel.scala 95:68:@6743.6]
  assign _GEN_62 = {{1'd0}, _T_165}; // @[priority_arbiter_chisel.scala 96:89:@6750.8]
  assign _GEN_1 = _T_159 ? _GEN_62 : 3'h0; // @[priority_arbiter_chisel.scala 94:75:@6739.4]
  assign _T_184 = request_valid_flatted_shift_left[2]; // @[priority_arbiter_chisel.scala 94:55:@6763.4]
  assign _T_186 = last_send_index + 2'h2; // @[priority_arbiter_chisel.scala 95:47:@6765.6]
  assign _T_187 = _T_186[1:0]; // @[priority_arbiter_chisel.scala 95:47:@6766.6]
  assign _T_189 = _T_187 + 2'h1; // @[priority_arbiter_chisel.scala 95:68:@6767.6]
  assign _T_190 = _T_189[1:0]; // @[priority_arbiter_chisel.scala 95:68:@6768.6]
  assign _GEN_63 = {{1'd0}, _T_190}; // @[priority_arbiter_chisel.scala 96:89:@6775.8]
  assign _GEN_3 = _T_184 ? _GEN_63 : _GEN_1; // @[priority_arbiter_chisel.scala 94:75:@6764.4]
  assign _T_209 = request_valid_flatted_shift_left[1]; // @[priority_arbiter_chisel.scala 94:55:@6788.4]
  assign _T_214 = _T_127 + 2'h1; // @[priority_arbiter_chisel.scala 95:68:@6792.6]
  assign _T_215 = _T_214[1:0]; // @[priority_arbiter_chisel.scala 95:68:@6793.6]
  assign _GEN_64 = {{1'd0}, _T_215}; // @[priority_arbiter_chisel.scala 96:89:@6800.8]
  assign _GEN_5 = _T_209 ? _GEN_64 : _GEN_3; // @[priority_arbiter_chisel.scala 94:75:@6789.4]
  assign _T_234 = request_valid_flatted_shift_left[0]; // @[priority_arbiter_chisel.scala 94:55:@6813.4]
  assign _T_237 = _GEN_56[1:0]; // @[priority_arbiter_chisel.scala 95:47:@6816.6]
  assign _T_239 = _T_237 + 2'h1; // @[priority_arbiter_chisel.scala 95:68:@6817.6]
  assign _T_240 = _T_239[1:0]; // @[priority_arbiter_chisel.scala 95:68:@6818.6]
  assign _GEN_65 = {{1'd0}, _T_240}; // @[priority_arbiter_chisel.scala 96:89:@6825.8]
  assign _GEN_7 = _T_234 ? _GEN_65 : _GEN_5; // @[priority_arbiter_chisel.scala 94:75:@6814.4]
  assign request_critical_flatted_shift_left = _T_155[3:0]; // @[priority_arbiter_chisel.scala 83:55:@6704.4 priority_arbiter_chisel.scala 86:45:@6734.4]
  assign _T_262 = request_critical_flatted_shift_left[3]; // @[priority_arbiter_chisel.scala 108:58:@6841.4]
  assign _T_264 = _T_262 & _T_159; // @[priority_arbiter_chisel.scala 108:80:@6843.4]
  assign _GEN_9 = _T_264 ? _GEN_62 : 3'h0; // @[priority_arbiter_chisel.scala 108:138:@6844.4]
  assign _T_289 = request_critical_flatted_shift_left[2]; // @[priority_arbiter_chisel.scala 108:58:@6868.4]
  assign _T_291 = _T_289 & _T_184; // @[priority_arbiter_chisel.scala 108:80:@6870.4]
  assign _GEN_11 = _T_291 ? _GEN_63 : _GEN_9; // @[priority_arbiter_chisel.scala 108:138:@6871.4]
  assign _T_316 = request_critical_flatted_shift_left[1]; // @[priority_arbiter_chisel.scala 108:58:@6895.4]
  assign _T_318 = _T_316 & _T_209; // @[priority_arbiter_chisel.scala 108:80:@6897.4]
  assign _GEN_13 = _T_318 ? _GEN_64 : _GEN_11; // @[priority_arbiter_chisel.scala 108:138:@6898.4]
  assign _T_343 = request_critical_flatted_shift_left[0]; // @[priority_arbiter_chisel.scala 108:58:@6922.4]
  assign _T_345 = _T_343 & _T_234; // @[priority_arbiter_chisel.scala 108:80:@6924.4]
  assign _GEN_15 = _T_345 ? _GEN_65 : _GEN_13; // @[priority_arbiter_chisel.scala 108:138:@6925.4]
  assign valid_sel = _GEN_7[1:0]; // @[:@6735.4 :@6736.4 priority_arbiter_chisel.scala 91:19:@6737.4 priority_arbiter_chisel.scala 96:43:@6753.8 priority_arbiter_chisel.scala 98:43:@6760.8 priority_arbiter_chisel.scala 96:43:@6778.8 priority_arbiter_chisel.scala 98:43:@6785.8 priority_arbiter_chisel.scala 96:43:@6803.8 priority_arbiter_chisel.scala 98:43:@6810.8 priority_arbiter_chisel.scala 96:43:@6828.8 priority_arbiter_chisel.scala 98:43:@6835.8]
  assign critical_sel = _GEN_15[1:0]; // @[:@6838.4 :@6839.4 priority_arbiter_chisel.scala 105:22:@6840.4 priority_arbiter_chisel.scala 110:46:@6858.8 priority_arbiter_chisel.scala 112:46:@6865.8 priority_arbiter_chisel.scala 110:46:@6885.8 priority_arbiter_chisel.scala 112:46:@6892.8 priority_arbiter_chisel.scala 110:46:@6912.8 priority_arbiter_chisel.scala 112:46:@6919.8 priority_arbiter_chisel.scala 110:46:@6939.8 priority_arbiter_chisel.scala 112:46:@6946.8]
  assign _T_421 = last_send_index == 2'h0; // @[priority_arbiter_chisel.scala 136:59:@7007.4]
  assign _T_427 = last_send_index == 2'h1; // @[priority_arbiter_chisel.scala 136:59:@7016.4]
  assign _T_433 = last_send_index == 2'h2; // @[priority_arbiter_chisel.scala 136:59:@7025.4]
  assign _T_439 = last_send_index == 2'h3; // @[priority_arbiter_chisel.scala 136:59:@7034.4]
  assign _T_448 = io_issue_ack_in & request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:40:@7050.6]
  assign _T_449 = ~ request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:68:@7051.6]
  assign _T_450 = _T_448 | _T_449; // @[priority_arbiter_chisel.scala 149:65:@7052.6]
  assign _T_452 = request_critical_final >> critical_sel; // @[priority_arbiter_chisel.scala 150:46:@7055.8]
  assign _T_453 = _T_452[0]; // @[priority_arbiter_chisel.scala 150:46:@7056.8]
  assign _GEN_29 = 2'h1 == critical_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 150:61:@7057.8]
  assign _GEN_30 = 2'h2 == critical_sel ? request_valid_flatted_from_request_queue_2 : _GEN_29; // @[priority_arbiter_chisel.scala 150:61:@7057.8]
  assign _GEN_31 = 2'h3 == critical_sel ? request_valid_flatted_from_request_queue_3 : _GEN_30; // @[priority_arbiter_chisel.scala 150:61:@7057.8]
  assign _T_455 = _T_453 & _GEN_31; // @[priority_arbiter_chisel.scala 150:61:@7057.8]
  assign _T_456 = critical_sel != last_send_index; // @[priority_arbiter_chisel.scala 151:49:@7058.8]
  assign _T_457 = _T_456 & request_valid_out_reg; // @[priority_arbiter_chisel.scala 151:69:@7059.8]
  assign _T_459 = _T_457 | _T_449; // @[priority_arbiter_chisel.scala 151:95:@7061.8]
  assign _T_460 = _T_455 & _T_459; // @[priority_arbiter_chisel.scala 150:118:@7062.8]
  assign _GEN_33 = 2'h1 == critical_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 152:41:@7065.10]
  assign _GEN_34 = 2'h2 == critical_sel ? request_packed_from_request_queue_2 : _GEN_33; // @[priority_arbiter_chisel.scala 152:41:@7065.10]
  assign _GEN_35 = 2'h3 == critical_sel ? request_packed_from_request_queue_3 : _GEN_34; // @[priority_arbiter_chisel.scala 152:41:@7065.10]
  assign _T_465 = valid_sel != last_send_index; // @[priority_arbiter_chisel.scala 156:46:@7070.10]
  assign _T_466 = _T_465 & request_valid_out_reg; // @[priority_arbiter_chisel.scala 156:66:@7071.10]
  assign _T_468 = _T_466 | _T_449; // @[priority_arbiter_chisel.scala 156:92:@7073.10]
  assign _GEN_37 = 2'h1 == valid_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter_chisel.scala 155:83:@7074.10]
  assign _GEN_38 = 2'h2 == valid_sel ? request_valid_flatted_from_request_queue_2 : _GEN_37; // @[priority_arbiter_chisel.scala 155:83:@7074.10]
  assign _GEN_39 = 2'h3 == valid_sel ? request_valid_flatted_from_request_queue_3 : _GEN_38; // @[priority_arbiter_chisel.scala 155:83:@7074.10]
  assign _T_469 = _GEN_39 & _T_468; // @[priority_arbiter_chisel.scala 155:83:@7074.10]
  assign _GEN_41 = 2'h1 == valid_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter_chisel.scala 157:41:@7077.12]
  assign _GEN_42 = 2'h2 == valid_sel ? request_packed_from_request_queue_2 : _GEN_41; // @[priority_arbiter_chisel.scala 157:41:@7077.12]
  assign _GEN_43 = 2'h3 == valid_sel ? request_packed_from_request_queue_3 : _GEN_42; // @[priority_arbiter_chisel.scala 157:41:@7077.12]
  assign _GEN_44 = _T_469 ? _GEN_43 : 80'h0; // @[priority_arbiter_chisel.scala 156:129:@7076.10]
  assign _GEN_46 = _T_469 ? valid_sel : last_send_index; // @[priority_arbiter_chisel.scala 156:129:@7076.10]
  assign _GEN_47 = _T_460 ? _GEN_35 : _GEN_44; // @[priority_arbiter_chisel.scala 151:132:@7064.8]
  assign _GEN_48 = _T_460 ? 1'h1 : _T_469; // @[priority_arbiter_chisel.scala 151:132:@7064.8]
  assign _GEN_49 = _T_460 ? critical_sel : _GEN_46; // @[priority_arbiter_chisel.scala 151:132:@7064.8]
  assign _GEN_50 = _T_450 ? _GEN_47 : request_out_reg; // @[priority_arbiter_chisel.scala 149:101:@7054.6]
  assign _GEN_51 = _T_450 ? _GEN_48 : request_valid_out_reg; // @[priority_arbiter_chisel.scala 149:101:@7054.6]
  assign _GEN_52 = _T_450 ? _GEN_49 : last_send_index; // @[priority_arbiter_chisel.scala 149:101:@7054.6]
  assign _GEN_53 = reset ? 80'h0 : _GEN_50; // @[priority_arbiter_chisel.scala 145:29:@7044.4]
  assign _GEN_54 = reset ? 1'h0 : _GEN_51; // @[priority_arbiter_chisel.scala 145:29:@7044.4]
  assign _GEN_55 = reset ? 2'h0 : _GEN_52; // @[priority_arbiter_chisel.scala 145:29:@7044.4]
  assign issue_ack_out_vec_1 = fifo_queue_chisel_1_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@6614.4 priority_arbiter_chisel.scala 68:50:@6650.4]
  assign issue_ack_out_vec_0 = fifo_queue_chisel_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@6614.4 priority_arbiter_chisel.scala 68:50:@6632.4]
  assign _T_475 = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter_chisel.scala 174:47:@7094.4]
  assign issue_ack_out_vec_3 = fifo_queue_chisel_3_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@6614.4 priority_arbiter_chisel.scala 68:50:@6686.4]
  assign issue_ack_out_vec_2 = fifo_queue_chisel_2_io_issue_ack_out; // @[priority_arbiter_chisel.scala 47:37:@6614.4 priority_arbiter_chisel.scala 68:50:@6668.4]
  assign _T_476 = {issue_ack_out_vec_3,issue_ack_out_vec_2}; // @[priority_arbiter_chisel.scala 174:47:@7095.4]
  assign io_issue_ack_out = {_T_476,_T_475}; // @[priority_arbiter_chisel.scala 174:26:@7097.4]
  assign io_request_out = request_out_reg; // @[priority_arbiter_chisel.scala 172:24:@7092.4]
  assign fifo_queue_chisel_clock = clock; // @[:@6624.4]
  assign fifo_queue_chisel_reset = reset; // @[:@6625.4]
  assign fifo_queue_chisel_io_request_in = {1'h1,request_packed_in_0}; // @[priority_arbiter_chisel.scala 66:45:@6629.4]
  assign fifo_queue_chisel_io_request_valid_in = io_request_valid_flatted_in[0]; // @[priority_arbiter_chisel.scala 67:51:@6631.4]
  assign fifo_queue_chisel_io_issue_ack_in = io_issue_ack_in & _T_421; // @[priority_arbiter_chisel.scala 74:47:@6638.4]
  assign fifo_queue_chisel_1_clock = clock; // @[:@6642.4]
  assign fifo_queue_chisel_1_reset = reset; // @[:@6643.4]
  assign fifo_queue_chisel_1_io_request_in = {1'h1,request_packed_in_1}; // @[priority_arbiter_chisel.scala 66:45:@6647.4]
  assign fifo_queue_chisel_1_io_request_valid_in = io_request_valid_flatted_in[1]; // @[priority_arbiter_chisel.scala 67:51:@6649.4]
  assign fifo_queue_chisel_1_io_issue_ack_in = io_issue_ack_in & _T_427; // @[priority_arbiter_chisel.scala 74:47:@6656.4]
  assign fifo_queue_chisel_2_clock = clock; // @[:@6660.4]
  assign fifo_queue_chisel_2_reset = reset; // @[:@6661.4]
  assign fifo_queue_chisel_2_io_request_in = {1'h1,request_packed_in_2}; // @[priority_arbiter_chisel.scala 66:45:@6665.4]
  assign fifo_queue_chisel_2_io_request_valid_in = io_request_valid_flatted_in[2]; // @[priority_arbiter_chisel.scala 67:51:@6667.4]
  assign fifo_queue_chisel_2_io_issue_ack_in = io_issue_ack_in & _T_433; // @[priority_arbiter_chisel.scala 74:47:@6674.4]
  assign fifo_queue_chisel_3_clock = clock; // @[:@6678.4]
  assign fifo_queue_chisel_3_reset = reset; // @[:@6679.4]
  assign fifo_queue_chisel_3_io_request_in = {1'h1,request_packed_in_3}; // @[priority_arbiter_chisel.scala 66:45:@6683.4]
  assign fifo_queue_chisel_3_io_request_valid_in = io_request_valid_flatted_in[3]; // @[priority_arbiter_chisel.scala 67:51:@6685.4]
  assign fifo_queue_chisel_3_io_issue_ack_in = io_issue_ack_in & _T_439; // @[priority_arbiter_chisel.scala 74:47:@6692.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {3{`RANDOM}};
  request_out_reg = _RAND_0[79:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  request_valid_out_reg = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  last_send_index = _RAND_2[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      request_out_reg <= 80'h0;
    end else begin
      if (reset) begin
        request_out_reg <= 80'h0;
      end else begin
        if (_T_450) begin
          if (_T_460) begin
            if (2'h3 == critical_sel) begin
              request_out_reg <= request_packed_from_request_queue_3;
            end else begin
              if (2'h2 == critical_sel) begin
                request_out_reg <= request_packed_from_request_queue_2;
              end else begin
                if (2'h1 == critical_sel) begin
                  request_out_reg <= request_packed_from_request_queue_1;
                end else begin
                  request_out_reg <= request_packed_from_request_queue_0;
                end
              end
            end
          end else begin
            if (_T_469) begin
              if (2'h3 == valid_sel) begin
                request_out_reg <= request_packed_from_request_queue_3;
              end else begin
                if (2'h2 == valid_sel) begin
                  request_out_reg <= request_packed_from_request_queue_2;
                end else begin
                  if (2'h1 == valid_sel) begin
                    request_out_reg <= request_packed_from_request_queue_1;
                  end else begin
                    request_out_reg <= request_packed_from_request_queue_0;
                  end
                end
              end
            end else begin
              request_out_reg <= 80'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      request_valid_out_reg <= 1'h0;
    end else begin
      if (reset) begin
        request_valid_out_reg <= 1'h0;
      end else begin
        if (_T_450) begin
          if (_T_460) begin
            request_valid_out_reg <= 1'h1;
          end else begin
            request_valid_out_reg <= _T_469;
          end
        end
      end
    end
    if (reset) begin
      last_send_index <= 2'h0;
    end else begin
      if (reset) begin
        last_send_index <= 2'h0;
      end else begin
        if (_T_450) begin
          if (_T_460) begin
            last_send_index <= critical_sel;
          end else begin
            if (_T_469) begin
              last_send_index <= valid_sel;
            end
          end
        end
      end
    end
  end
endmodule
module true_unified_cache( // @[:@8359.2]
  input          clock, // @[:@8360.4]
  input          reset, // @[:@8361.4]
  input  [159:0] io_input_packet_flatted_in, // @[:@8362.4]
  output [1:0]   io_input_packet_ack_flatted_out, // @[:@8362.4]
  output [159:0] io_return_packet_flatted_out, // @[:@8362.4]
  input  [1:0]   io_return_packet_ack_flatted_in, // @[:@8362.4]
  input  [79:0]  io_from_mem_packet_in, // @[:@8362.4]
  output         io_from_mem_packet_ack_out, // @[:@8362.4]
  output [79:0]  io_to_mem_packet_out, // @[:@8362.4]
  input          io_to_mem_packet_ack_in // @[:@8362.4]
);
  wire  fifo_queue_chisel_clock; // @[true_unified_cache.scala 156:29:@8373.4]
  wire  fifo_queue_chisel_reset; // @[true_unified_cache.scala 156:29:@8373.4]
  wire  fifo_queue_chisel_io_is_empty_out; // @[true_unified_cache.scala 156:29:@8373.4]
  wire  fifo_queue_chisel_io_is_full_out; // @[true_unified_cache.scala 156:29:@8373.4]
  wire [79:0] fifo_queue_chisel_io_request_in; // @[true_unified_cache.scala 156:29:@8373.4]
  wire  fifo_queue_chisel_io_request_valid_in; // @[true_unified_cache.scala 156:29:@8373.4]
  wire  fifo_queue_chisel_io_issue_ack_out; // @[true_unified_cache.scala 156:29:@8373.4]
  wire [79:0] fifo_queue_chisel_io_request_out; // @[true_unified_cache.scala 156:29:@8373.4]
  wire  fifo_queue_chisel_io_request_valid_out; // @[true_unified_cache.scala 156:29:@8373.4]
  wire  fifo_queue_chisel_io_issue_ack_in; // @[true_unified_cache.scala 156:29:@8373.4]
  wire  fifo_queue_chisel_1_clock; // @[true_unified_cache.scala 156:29:@8388.4]
  wire  fifo_queue_chisel_1_reset; // @[true_unified_cache.scala 156:29:@8388.4]
  wire  fifo_queue_chisel_1_io_is_empty_out; // @[true_unified_cache.scala 156:29:@8388.4]
  wire  fifo_queue_chisel_1_io_is_full_out; // @[true_unified_cache.scala 156:29:@8388.4]
  wire [79:0] fifo_queue_chisel_1_io_request_in; // @[true_unified_cache.scala 156:29:@8388.4]
  wire  fifo_queue_chisel_1_io_request_valid_in; // @[true_unified_cache.scala 156:29:@8388.4]
  wire  fifo_queue_chisel_1_io_issue_ack_out; // @[true_unified_cache.scala 156:29:@8388.4]
  wire [79:0] fifo_queue_chisel_1_io_request_out; // @[true_unified_cache.scala 156:29:@8388.4]
  wire  fifo_queue_chisel_1_io_request_valid_out; // @[true_unified_cache.scala 156:29:@8388.4]
  wire  fifo_queue_chisel_1_io_issue_ack_in; // @[true_unified_cache.scala 156:29:@8388.4]
  wire  unified_cache_bank_clock; // @[true_unified_cache.scala 206:28:@8443.4]
  wire  unified_cache_bank_reset; // @[true_unified_cache.scala 206:28:@8443.4]
  wire [159:0] unified_cache_bank_io_input_request_flatted_in; // @[true_unified_cache.scala 206:28:@8443.4]
  wire [1:0] unified_cache_bank_io_input_request_valid_flatted_in; // @[true_unified_cache.scala 206:28:@8443.4]
  wire [1:0] unified_cache_bank_io_input_request_critical_flatted_in; // @[true_unified_cache.scala 206:28:@8443.4]
  wire [1:0] unified_cache_bank_io_input_request_ack_out; // @[true_unified_cache.scala 206:28:@8443.4]
  wire [79:0] unified_cache_bank_io_fetched_request_in; // @[true_unified_cache.scala 206:28:@8443.4]
  wire  unified_cache_bank_io_fetched_request_valid_in; // @[true_unified_cache.scala 206:28:@8443.4]
  wire  unified_cache_bank_io_fetch_ack_out; // @[true_unified_cache.scala 206:28:@8443.4]
  wire [79:0] unified_cache_bank_io_miss_request_out; // @[true_unified_cache.scala 206:28:@8443.4]
  wire  unified_cache_bank_io_miss_request_valid_out; // @[true_unified_cache.scala 206:28:@8443.4]
  wire  unified_cache_bank_io_miss_request_ack_in; // @[true_unified_cache.scala 206:28:@8443.4]
  wire [79:0] unified_cache_bank_io_return_request_out; // @[true_unified_cache.scala 206:28:@8443.4]
  wire  unified_cache_bank_io_return_request_valid_out; // @[true_unified_cache.scala 206:28:@8443.4]
  wire  unified_cache_bank_io_return_request_ack_in; // @[true_unified_cache.scala 206:28:@8443.4]
  wire  unified_cache_bank_1_clock; // @[true_unified_cache.scala 206:28:@8509.4]
  wire  unified_cache_bank_1_reset; // @[true_unified_cache.scala 206:28:@8509.4]
  wire [159:0] unified_cache_bank_1_io_input_request_flatted_in; // @[true_unified_cache.scala 206:28:@8509.4]
  wire [1:0] unified_cache_bank_1_io_input_request_valid_flatted_in; // @[true_unified_cache.scala 206:28:@8509.4]
  wire [1:0] unified_cache_bank_1_io_input_request_critical_flatted_in; // @[true_unified_cache.scala 206:28:@8509.4]
  wire [1:0] unified_cache_bank_1_io_input_request_ack_out; // @[true_unified_cache.scala 206:28:@8509.4]
  wire [79:0] unified_cache_bank_1_io_fetched_request_in; // @[true_unified_cache.scala 206:28:@8509.4]
  wire  unified_cache_bank_1_io_fetched_request_valid_in; // @[true_unified_cache.scala 206:28:@8509.4]
  wire  unified_cache_bank_1_io_fetch_ack_out; // @[true_unified_cache.scala 206:28:@8509.4]
  wire [79:0] unified_cache_bank_1_io_miss_request_out; // @[true_unified_cache.scala 206:28:@8509.4]
  wire  unified_cache_bank_1_io_miss_request_valid_out; // @[true_unified_cache.scala 206:28:@8509.4]
  wire  unified_cache_bank_1_io_miss_request_ack_in; // @[true_unified_cache.scala 206:28:@8509.4]
  wire [79:0] unified_cache_bank_1_io_return_request_out; // @[true_unified_cache.scala 206:28:@8509.4]
  wire  unified_cache_bank_1_io_return_request_valid_out; // @[true_unified_cache.scala 206:28:@8509.4]
  wire  unified_cache_bank_1_io_return_request_ack_in; // @[true_unified_cache.scala 206:28:@8509.4]
  wire  unified_cache_bank_2_clock; // @[true_unified_cache.scala 206:28:@8575.4]
  wire  unified_cache_bank_2_reset; // @[true_unified_cache.scala 206:28:@8575.4]
  wire [159:0] unified_cache_bank_2_io_input_request_flatted_in; // @[true_unified_cache.scala 206:28:@8575.4]
  wire [1:0] unified_cache_bank_2_io_input_request_valid_flatted_in; // @[true_unified_cache.scala 206:28:@8575.4]
  wire [1:0] unified_cache_bank_2_io_input_request_critical_flatted_in; // @[true_unified_cache.scala 206:28:@8575.4]
  wire [1:0] unified_cache_bank_2_io_input_request_ack_out; // @[true_unified_cache.scala 206:28:@8575.4]
  wire [79:0] unified_cache_bank_2_io_fetched_request_in; // @[true_unified_cache.scala 206:28:@8575.4]
  wire  unified_cache_bank_2_io_fetched_request_valid_in; // @[true_unified_cache.scala 206:28:@8575.4]
  wire  unified_cache_bank_2_io_fetch_ack_out; // @[true_unified_cache.scala 206:28:@8575.4]
  wire [79:0] unified_cache_bank_2_io_miss_request_out; // @[true_unified_cache.scala 206:28:@8575.4]
  wire  unified_cache_bank_2_io_miss_request_valid_out; // @[true_unified_cache.scala 206:28:@8575.4]
  wire  unified_cache_bank_2_io_miss_request_ack_in; // @[true_unified_cache.scala 206:28:@8575.4]
  wire [79:0] unified_cache_bank_2_io_return_request_out; // @[true_unified_cache.scala 206:28:@8575.4]
  wire  unified_cache_bank_2_io_return_request_valid_out; // @[true_unified_cache.scala 206:28:@8575.4]
  wire  unified_cache_bank_2_io_return_request_ack_in; // @[true_unified_cache.scala 206:28:@8575.4]
  wire  unified_cache_bank_3_clock; // @[true_unified_cache.scala 206:28:@8641.4]
  wire  unified_cache_bank_3_reset; // @[true_unified_cache.scala 206:28:@8641.4]
  wire [159:0] unified_cache_bank_3_io_input_request_flatted_in; // @[true_unified_cache.scala 206:28:@8641.4]
  wire [1:0] unified_cache_bank_3_io_input_request_valid_flatted_in; // @[true_unified_cache.scala 206:28:@8641.4]
  wire [1:0] unified_cache_bank_3_io_input_request_critical_flatted_in; // @[true_unified_cache.scala 206:28:@8641.4]
  wire [1:0] unified_cache_bank_3_io_input_request_ack_out; // @[true_unified_cache.scala 206:28:@8641.4]
  wire [79:0] unified_cache_bank_3_io_fetched_request_in; // @[true_unified_cache.scala 206:28:@8641.4]
  wire  unified_cache_bank_3_io_fetched_request_valid_in; // @[true_unified_cache.scala 206:28:@8641.4]
  wire  unified_cache_bank_3_io_fetch_ack_out; // @[true_unified_cache.scala 206:28:@8641.4]
  wire [79:0] unified_cache_bank_3_io_miss_request_out; // @[true_unified_cache.scala 206:28:@8641.4]
  wire  unified_cache_bank_3_io_miss_request_valid_out; // @[true_unified_cache.scala 206:28:@8641.4]
  wire  unified_cache_bank_3_io_miss_request_ack_in; // @[true_unified_cache.scala 206:28:@8641.4]
  wire [79:0] unified_cache_bank_3_io_return_request_out; // @[true_unified_cache.scala 206:28:@8641.4]
  wire  unified_cache_bank_3_io_return_request_valid_out; // @[true_unified_cache.scala 206:28:@8641.4]
  wire  unified_cache_bank_3_io_return_request_ack_in; // @[true_unified_cache.scala 206:28:@8641.4]
  wire  to_mem_arbiter_clock; // @[true_unified_cache.scala 253:30:@8713.4]
  wire  to_mem_arbiter_reset; // @[true_unified_cache.scala 253:30:@8713.4]
  wire [639:0] to_mem_arbiter_io_request_flatted_in; // @[true_unified_cache.scala 253:30:@8713.4]
  wire [7:0] to_mem_arbiter_io_request_valid_flatted_in; // @[true_unified_cache.scala 253:30:@8713.4]
  wire [7:0] to_mem_arbiter_io_issue_ack_out; // @[true_unified_cache.scala 253:30:@8713.4]
  wire [79:0] to_mem_arbiter_io_request_out; // @[true_unified_cache.scala 253:30:@8713.4]
  wire  to_mem_arbiter_io_issue_ack_in; // @[true_unified_cache.scala 253:30:@8713.4]
  wire  priority_arbiter_chisel_clock; // @[true_unified_cache.scala 282:32:@8797.4]
  wire  priority_arbiter_chisel_reset; // @[true_unified_cache.scala 282:32:@8797.4]
  wire [319:0] priority_arbiter_chisel_io_request_flatted_in; // @[true_unified_cache.scala 282:32:@8797.4]
  wire [3:0] priority_arbiter_chisel_io_request_valid_flatted_in; // @[true_unified_cache.scala 282:32:@8797.4]
  wire [3:0] priority_arbiter_chisel_io_issue_ack_out; // @[true_unified_cache.scala 282:32:@8797.4]
  wire [79:0] priority_arbiter_chisel_io_request_out; // @[true_unified_cache.scala 282:32:@8797.4]
  wire  priority_arbiter_chisel_io_issue_ack_in; // @[true_unified_cache.scala 282:32:@8797.4]
  wire  priority_arbiter_chisel_1_clock; // @[true_unified_cache.scala 282:32:@8841.4]
  wire  priority_arbiter_chisel_1_reset; // @[true_unified_cache.scala 282:32:@8841.4]
  wire [319:0] priority_arbiter_chisel_1_io_request_flatted_in; // @[true_unified_cache.scala 282:32:@8841.4]
  wire [3:0] priority_arbiter_chisel_1_io_request_valid_flatted_in; // @[true_unified_cache.scala 282:32:@8841.4]
  wire [3:0] priority_arbiter_chisel_1_io_issue_ack_out; // @[true_unified_cache.scala 282:32:@8841.4]
  wire [79:0] priority_arbiter_chisel_1_io_request_out; // @[true_unified_cache.scala 282:32:@8841.4]
  wire  priority_arbiter_chisel_1_io_issue_ack_in; // @[true_unified_cache.scala 282:32:@8841.4]
  wire [79:0] input_packet_packed_0; // @[true_unified_cache.scala 158:66:@8376.4]
  wire [79:0] input_packet_packed_1; // @[true_unified_cache.scala 158:66:@8391.4]
  wire [79:0] input_packet_to_cache_packed_0; // @[true_unified_cache.scala 146:42:@8368.4 true_unified_cache.scala 163:46:@8383.4]
  wire [31:0] _T_201_0; // @[true_unified_cache.scala 190:31:@8417.4 true_unified_cache.scala 194:35:@8420.4]
  wire [1:0] _T_222; // @[true_unified_cache.scala 195:70:@8421.4]
  wire  _T_224; // @[true_unified_cache.scala 195:147:@8422.4]
  wire  input_packet_valid_to_cache_flatted_0; // @[true_unified_cache.scala 148:49:@8370.4 true_unified_cache.scala 164:53:@8384.4]
  wire  _T_225; // @[true_unified_cache.scala 196:91:@8424.4]
  wire [79:0] input_packet_to_cache_packed_1; // @[true_unified_cache.scala 146:42:@8368.4 true_unified_cache.scala 163:46:@8398.4]
  wire [31:0] _T_201_1; // @[true_unified_cache.scala 190:31:@8417.4 true_unified_cache.scala 194:35:@8426.4]
  wire [1:0] _T_226; // @[true_unified_cache.scala 195:70:@8427.4]
  wire  _T_228; // @[true_unified_cache.scala 195:147:@8428.4]
  wire  input_packet_valid_to_cache_flatted_1; // @[true_unified_cache.scala 148:49:@8370.4 true_unified_cache.scala 164:53:@8399.4]
  wire  _T_229; // @[true_unified_cache.scala 196:91:@8430.4]
  wire [31:0] _T_236; // @[true_unified_cache.scala 202:47:@8435.4]
  wire [1:0] _T_237; // @[true_unified_cache.scala 203:48:@8437.4]
  wire  _T_239; // @[true_unified_cache.scala 203:125:@8438.4]
  wire  _T_240; // @[true_unified_cache.scala 204:52:@8440.4]
  wire  _T_241; // @[true_unified_cache.scala 204:87:@8441.4]
  wire [1:0] _T_242; // @[true_unified_cache.scala 208:32:@8446.4]
  wire  _T_244; // @[true_unified_cache.scala 208:39:@8447.4]
  wire [159:0] _T_245; // @[true_unified_cache.scala 209:79:@8449.6]
  wire  is_input_queue_full_flatted_1; // @[true_unified_cache.scala 145:41:@8367.4 true_unified_cache.scala 159:45:@8393.4]
  wire  is_input_queue_full_flatted_0; // @[true_unified_cache.scala 145:41:@8367.4 true_unified_cache.scala 159:45:@8378.4]
  wire [3:0] miss_request_ack_flatted; // @[true_unified_cache.scala 260:62:@8740.4]
  wire  _T_279; // @[true_unified_cache.scala 195:147:@8488.4]
  wire  _T_280; // @[true_unified_cache.scala 196:91:@8490.4]
  wire  _T_283; // @[true_unified_cache.scala 195:147:@8494.4]
  wire  _T_284; // @[true_unified_cache.scala 196:91:@8496.4]
  wire  _T_294; // @[true_unified_cache.scala 203:125:@8504.4]
  wire  _T_296; // @[true_unified_cache.scala 204:87:@8507.4]
  wire [1:0] _T_297; // @[true_unified_cache.scala 208:32:@8512.4]
  wire  _T_299; // @[true_unified_cache.scala 208:39:@8513.4]
  wire  _T_334; // @[true_unified_cache.scala 195:147:@8554.4]
  wire  _T_335; // @[true_unified_cache.scala 196:91:@8556.4]
  wire  _T_338; // @[true_unified_cache.scala 195:147:@8560.4]
  wire  _T_339; // @[true_unified_cache.scala 196:91:@8562.4]
  wire  _T_349; // @[true_unified_cache.scala 203:125:@8570.4]
  wire  _T_351; // @[true_unified_cache.scala 204:87:@8573.4]
  wire [1:0] _T_352; // @[true_unified_cache.scala 208:32:@8578.4]
  wire  _T_354; // @[true_unified_cache.scala 208:39:@8579.4]
  wire  _T_389; // @[true_unified_cache.scala 195:147:@8620.4]
  wire  _T_390; // @[true_unified_cache.scala 196:91:@8622.4]
  wire  _T_393; // @[true_unified_cache.scala 195:147:@8626.4]
  wire  _T_394; // @[true_unified_cache.scala 196:91:@8628.4]
  wire  _T_404; // @[true_unified_cache.scala 203:125:@8636.4]
  wire  _T_406; // @[true_unified_cache.scala 204:87:@8639.4]
  wire [1:0] _T_407; // @[true_unified_cache.scala 208:32:@8644.4]
  wire  _T_409; // @[true_unified_cache.scala 208:39:@8645.4]
  wire  from_mem_packet_ack_flatted_1; // @[true_unified_cache.scala 173:41:@8404.4 true_unified_cache.scala 225:45:@8534.4]
  wire  from_mem_packet_ack_flatted_0; // @[true_unified_cache.scala 173:41:@8404.4 true_unified_cache.scala 225:45:@8468.4]
  wire [1:0] _T_418; // @[true_unified_cache.scala 244:61:@8681.4]
  wire  from_mem_packet_ack_flatted_3; // @[true_unified_cache.scala 173:41:@8404.4 true_unified_cache.scala 225:45:@8666.4]
  wire  from_mem_packet_ack_flatted_2; // @[true_unified_cache.scala 173:41:@8404.4 true_unified_cache.scala 225:45:@8600.4]
  wire [1:0] _T_419; // @[true_unified_cache.scala 244:61:@8682.4]
  wire [3:0] _T_420; // @[true_unified_cache.scala 244:61:@8683.4]
  wire [1:0] cache_to_input_queue_ack_flatted_0; // @[true_unified_cache.scala 172:46:@8403.4 true_unified_cache.scala 216:50:@8459.4]
  wire  cache_to_input_queue_ack_packed_0_0; // @[true_unified_cache.scala 248:110:@8687.4]
  wire [1:0] cache_to_input_queue_ack_flatted_1; // @[true_unified_cache.scala 172:46:@8403.4 true_unified_cache.scala 216:50:@8525.4]
  wire  cache_to_input_queue_ack_packed_0_1; // @[true_unified_cache.scala 248:110:@8689.4]
  wire [1:0] cache_to_input_queue_ack_flatted_2; // @[true_unified_cache.scala 172:46:@8403.4 true_unified_cache.scala 216:50:@8591.4]
  wire  cache_to_input_queue_ack_packed_0_2; // @[true_unified_cache.scala 248:110:@8691.4]
  wire [1:0] cache_to_input_queue_ack_flatted_3; // @[true_unified_cache.scala 172:46:@8403.4 true_unified_cache.scala 216:50:@8657.4]
  wire  cache_to_input_queue_ack_packed_0_3; // @[true_unified_cache.scala 248:110:@8693.4]
  wire [1:0] _T_505; // @[true_unified_cache.scala 250:96:@8695.4]
  wire [1:0] _T_506; // @[true_unified_cache.scala 250:96:@8696.4]
  wire [3:0] _T_507; // @[true_unified_cache.scala 250:96:@8697.4]
  wire  cache_to_input_queue_ack_packed_1_0; // @[true_unified_cache.scala 248:110:@8700.4]
  wire  cache_to_input_queue_ack_packed_1_1; // @[true_unified_cache.scala 248:110:@8702.4]
  wire  cache_to_input_queue_ack_packed_1_2; // @[true_unified_cache.scala 248:110:@8704.4]
  wire  cache_to_input_queue_ack_packed_1_3; // @[true_unified_cache.scala 248:110:@8706.4]
  wire [1:0] _T_514; // @[true_unified_cache.scala 250:96:@8708.4]
  wire [1:0] _T_515; // @[true_unified_cache.scala 250:96:@8709.4]
  wire [3:0] _T_516; // @[true_unified_cache.scala 250:96:@8710.4]
  wire [79:0] miss_request_flatted_1; // @[true_unified_cache.scala 174:34:@8405.4 true_unified_cache.scala 227:38:@8535.4]
  wire [79:0] miss_request_flatted_0; // @[true_unified_cache.scala 174:34:@8405.4 true_unified_cache.scala 227:38:@8469.4]
  wire [159:0] _T_519; // @[true_unified_cache.scala 257:68:@8716.4]
  wire [79:0] miss_request_flatted_3; // @[true_unified_cache.scala 174:34:@8405.4 true_unified_cache.scala 227:38:@8667.4]
  wire [79:0] miss_request_flatted_2; // @[true_unified_cache.scala 174:34:@8405.4 true_unified_cache.scala 227:38:@8601.4]
  wire [159:0] _T_520; // @[true_unified_cache.scala 257:68:@8717.4]
  wire [319:0] _T_521; // @[true_unified_cache.scala 257:68:@8718.4]
  wire  miss_request_valid_flatted_1; // @[true_unified_cache.scala 175:40:@8406.4 true_unified_cache.scala 228:44:@8536.4]
  wire  miss_request_valid_flatted_0; // @[true_unified_cache.scala 175:40:@8406.4 true_unified_cache.scala 228:44:@8470.4]
  wire [1:0] _T_526; // @[true_unified_cache.scala 258:80:@8724.4]
  wire  miss_request_valid_flatted_3; // @[true_unified_cache.scala 175:40:@8406.4 true_unified_cache.scala 228:44:@8668.4]
  wire  miss_request_valid_flatted_2; // @[true_unified_cache.scala 175:40:@8406.4 true_unified_cache.scala 228:44:@8602.4]
  wire [1:0] _T_527; // @[true_unified_cache.scala 258:80:@8725.4]
  wire [3:0] _T_528; // @[true_unified_cache.scala 258:80:@8726.4]
  wire [3:0] return_request_ack_flatted_0; // @[true_unified_cache.scala 266:40:@8746.4 true_unified_cache.scala 289:44:@8816.4]
  wire  return_request_ack_packed_0_0; // @[true_unified_cache.scala 270:98:@8748.4]
  wire [3:0] return_request_ack_flatted_1; // @[true_unified_cache.scala 266:40:@8746.4 true_unified_cache.scala 289:44:@8860.4]
  wire  return_request_ack_packed_0_1; // @[true_unified_cache.scala 270:98:@8750.4]
  wire [1:0] _T_637; // @[true_unified_cache.scala 272:84:@8752.4]
  wire  return_request_ack_packed_1_0; // @[true_unified_cache.scala 270:98:@8755.4]
  wire  return_request_ack_packed_1_1; // @[true_unified_cache.scala 270:98:@8757.4]
  wire [1:0] _T_642; // @[true_unified_cache.scala 272:84:@8759.4]
  wire  return_request_ack_packed_2_0; // @[true_unified_cache.scala 270:98:@8762.4]
  wire  return_request_ack_packed_2_1; // @[true_unified_cache.scala 270:98:@8764.4]
  wire [1:0] _T_647; // @[true_unified_cache.scala 272:84:@8766.4]
  wire  return_request_ack_packed_3_0; // @[true_unified_cache.scala 270:98:@8769.4]
  wire  return_request_ack_packed_3_1; // @[true_unified_cache.scala 270:98:@8771.4]
  wire [1:0] _T_652; // @[true_unified_cache.scala 272:84:@8773.4]
  wire [79:0] return_request_flatted_0; // @[true_unified_cache.scala 184:36:@8413.4 true_unified_cache.scala 237:40:@8479.4]
  wire [1:0] _T_665; // @[true_unified_cache.scala 278:71:@8777.4]
  wire  _T_667; // @[true_unified_cache.scala 278:164:@8778.4]
  wire  _T_668; // @[true_unified_cache.scala 279:71:@8779.4]
  wire  _T_669; // @[true_unified_cache.scala 278:182:@8780.4]
  wire [79:0] return_request_flatted_1; // @[true_unified_cache.scala 184:36:@8413.4 true_unified_cache.scala 237:40:@8545.4]
  wire [1:0] _T_670; // @[true_unified_cache.scala 278:71:@8782.4]
  wire  _T_672; // @[true_unified_cache.scala 278:164:@8783.4]
  wire  _T_673; // @[true_unified_cache.scala 279:71:@8784.4]
  wire  _T_674; // @[true_unified_cache.scala 278:182:@8785.4]
  wire [79:0] return_request_flatted_2; // @[true_unified_cache.scala 184:36:@8413.4 true_unified_cache.scala 237:40:@8611.4]
  wire [1:0] _T_675; // @[true_unified_cache.scala 278:71:@8787.4]
  wire  _T_677; // @[true_unified_cache.scala 278:164:@8788.4]
  wire  _T_678; // @[true_unified_cache.scala 279:71:@8789.4]
  wire  _T_679; // @[true_unified_cache.scala 278:182:@8790.4]
  wire [79:0] return_request_flatted_3; // @[true_unified_cache.scala 184:36:@8413.4 true_unified_cache.scala 237:40:@8677.4]
  wire [1:0] _T_680; // @[true_unified_cache.scala 278:71:@8792.4]
  wire  _T_682; // @[true_unified_cache.scala 278:164:@8793.4]
  wire  _T_683; // @[true_unified_cache.scala 279:71:@8794.4]
  wire  _T_684; // @[true_unified_cache.scala 278:182:@8795.4]
  wire [159:0] _T_685; // @[true_unified_cache.scala 286:68:@8800.4]
  wire [159:0] _T_686; // @[true_unified_cache.scala 286:68:@8801.4]
  wire  return_request_valid_flatted_1; // @[true_unified_cache.scala 185:42:@8414.4 true_unified_cache.scala 238:46:@8546.4]
  wire  return_request_valid_flatted_0; // @[true_unified_cache.scala 185:42:@8414.4 true_unified_cache.scala 238:46:@8480.4]
  wire [1:0] _T_688; // @[true_unified_cache.scala 287:80:@8804.4]
  wire  return_request_valid_flatted_3; // @[true_unified_cache.scala 185:42:@8414.4 true_unified_cache.scala 238:46:@8678.4]
  wire  return_request_valid_flatted_2; // @[true_unified_cache.scala 185:42:@8414.4 true_unified_cache.scala 238:46:@8612.4]
  wire [1:0] _T_689; // @[true_unified_cache.scala 287:80:@8805.4]
  wire [3:0] _T_690; // @[true_unified_cache.scala 287:80:@8806.4]
  wire [1:0] _T_691; // @[true_unified_cache.scala 287:103:@8807.4]
  wire [1:0] _T_692; // @[true_unified_cache.scala 287:103:@8808.4]
  wire [3:0] _T_693; // @[true_unified_cache.scala 287:103:@8809.4]
  wire  _T_711; // @[true_unified_cache.scala 278:164:@8822.4]
  wire  _T_713; // @[true_unified_cache.scala 278:182:@8824.4]
  wire  _T_716; // @[true_unified_cache.scala 278:164:@8827.4]
  wire  _T_718; // @[true_unified_cache.scala 278:182:@8829.4]
  wire  _T_721; // @[true_unified_cache.scala 278:164:@8832.4]
  wire  _T_723; // @[true_unified_cache.scala 278:182:@8834.4]
  wire  _T_726; // @[true_unified_cache.scala 278:164:@8837.4]
  wire  _T_728; // @[true_unified_cache.scala 278:182:@8839.4]
  wire [1:0] _T_735; // @[true_unified_cache.scala 287:103:@8851.4]
  wire [1:0] _T_736; // @[true_unified_cache.scala 287:103:@8852.4]
  wire [3:0] _T_737; // @[true_unified_cache.scala 287:103:@8853.4]
  wire  input_packet_ack_flatted_out_vec_1; // @[true_unified_cache.scala 141:46:@8364.4 true_unified_cache.scala 162:50:@8397.4]
  wire  input_packet_ack_flatted_out_vec_0; // @[true_unified_cache.scala 141:46:@8364.4 true_unified_cache.scala 162:50:@8382.4]
  wire [79:0] return_packet_flatted_out_vec_1; // @[true_unified_cache.scala 142:43:@8365.4 true_unified_cache.scala 290:47:@8861.4]
  wire [79:0] return_packet_flatted_out_vec_0; // @[true_unified_cache.scala 142:43:@8365.4 true_unified_cache.scala 290:47:@8817.4]
  fifo_queue_chisel fifo_queue_chisel ( // @[true_unified_cache.scala 156:29:@8373.4]
    .clock(fifo_queue_chisel_clock),
    .reset(fifo_queue_chisel_reset),
    .io_is_empty_out(fifo_queue_chisel_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_io_is_full_out),
    .io_request_in(fifo_queue_chisel_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_io_issue_ack_in)
  );
  fifo_queue_chisel fifo_queue_chisel_1 ( // @[true_unified_cache.scala 156:29:@8388.4]
    .clock(fifo_queue_chisel_1_clock),
    .reset(fifo_queue_chisel_1_reset),
    .io_is_empty_out(fifo_queue_chisel_1_io_is_empty_out),
    .io_is_full_out(fifo_queue_chisel_1_io_is_full_out),
    .io_request_in(fifo_queue_chisel_1_io_request_in),
    .io_request_valid_in(fifo_queue_chisel_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_chisel_1_io_issue_ack_out),
    .io_request_out(fifo_queue_chisel_1_io_request_out),
    .io_request_valid_out(fifo_queue_chisel_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_chisel_1_io_issue_ack_in)
  );
  unified_cache_bank unified_cache_bank ( // @[true_unified_cache.scala 206:28:@8443.4]
    .clock(unified_cache_bank_clock),
    .reset(unified_cache_bank_reset),
    .io_input_request_flatted_in(unified_cache_bank_io_input_request_flatted_in),
    .io_input_request_valid_flatted_in(unified_cache_bank_io_input_request_valid_flatted_in),
    .io_input_request_critical_flatted_in(unified_cache_bank_io_input_request_critical_flatted_in),
    .io_input_request_ack_out(unified_cache_bank_io_input_request_ack_out),
    .io_fetched_request_in(unified_cache_bank_io_fetched_request_in),
    .io_fetched_request_valid_in(unified_cache_bank_io_fetched_request_valid_in),
    .io_fetch_ack_out(unified_cache_bank_io_fetch_ack_out),
    .io_miss_request_out(unified_cache_bank_io_miss_request_out),
    .io_miss_request_valid_out(unified_cache_bank_io_miss_request_valid_out),
    .io_miss_request_ack_in(unified_cache_bank_io_miss_request_ack_in),
    .io_return_request_out(unified_cache_bank_io_return_request_out),
    .io_return_request_valid_out(unified_cache_bank_io_return_request_valid_out),
    .io_return_request_ack_in(unified_cache_bank_io_return_request_ack_in)
  );
  unified_cache_bank unified_cache_bank_1 ( // @[true_unified_cache.scala 206:28:@8509.4]
    .clock(unified_cache_bank_1_clock),
    .reset(unified_cache_bank_1_reset),
    .io_input_request_flatted_in(unified_cache_bank_1_io_input_request_flatted_in),
    .io_input_request_valid_flatted_in(unified_cache_bank_1_io_input_request_valid_flatted_in),
    .io_input_request_critical_flatted_in(unified_cache_bank_1_io_input_request_critical_flatted_in),
    .io_input_request_ack_out(unified_cache_bank_1_io_input_request_ack_out),
    .io_fetched_request_in(unified_cache_bank_1_io_fetched_request_in),
    .io_fetched_request_valid_in(unified_cache_bank_1_io_fetched_request_valid_in),
    .io_fetch_ack_out(unified_cache_bank_1_io_fetch_ack_out),
    .io_miss_request_out(unified_cache_bank_1_io_miss_request_out),
    .io_miss_request_valid_out(unified_cache_bank_1_io_miss_request_valid_out),
    .io_miss_request_ack_in(unified_cache_bank_1_io_miss_request_ack_in),
    .io_return_request_out(unified_cache_bank_1_io_return_request_out),
    .io_return_request_valid_out(unified_cache_bank_1_io_return_request_valid_out),
    .io_return_request_ack_in(unified_cache_bank_1_io_return_request_ack_in)
  );
  unified_cache_bank unified_cache_bank_2 ( // @[true_unified_cache.scala 206:28:@8575.4]
    .clock(unified_cache_bank_2_clock),
    .reset(unified_cache_bank_2_reset),
    .io_input_request_flatted_in(unified_cache_bank_2_io_input_request_flatted_in),
    .io_input_request_valid_flatted_in(unified_cache_bank_2_io_input_request_valid_flatted_in),
    .io_input_request_critical_flatted_in(unified_cache_bank_2_io_input_request_critical_flatted_in),
    .io_input_request_ack_out(unified_cache_bank_2_io_input_request_ack_out),
    .io_fetched_request_in(unified_cache_bank_2_io_fetched_request_in),
    .io_fetched_request_valid_in(unified_cache_bank_2_io_fetched_request_valid_in),
    .io_fetch_ack_out(unified_cache_bank_2_io_fetch_ack_out),
    .io_miss_request_out(unified_cache_bank_2_io_miss_request_out),
    .io_miss_request_valid_out(unified_cache_bank_2_io_miss_request_valid_out),
    .io_miss_request_ack_in(unified_cache_bank_2_io_miss_request_ack_in),
    .io_return_request_out(unified_cache_bank_2_io_return_request_out),
    .io_return_request_valid_out(unified_cache_bank_2_io_return_request_valid_out),
    .io_return_request_ack_in(unified_cache_bank_2_io_return_request_ack_in)
  );
  unified_cache_bank unified_cache_bank_3 ( // @[true_unified_cache.scala 206:28:@8641.4]
    .clock(unified_cache_bank_3_clock),
    .reset(unified_cache_bank_3_reset),
    .io_input_request_flatted_in(unified_cache_bank_3_io_input_request_flatted_in),
    .io_input_request_valid_flatted_in(unified_cache_bank_3_io_input_request_valid_flatted_in),
    .io_input_request_critical_flatted_in(unified_cache_bank_3_io_input_request_critical_flatted_in),
    .io_input_request_ack_out(unified_cache_bank_3_io_input_request_ack_out),
    .io_fetched_request_in(unified_cache_bank_3_io_fetched_request_in),
    .io_fetched_request_valid_in(unified_cache_bank_3_io_fetched_request_valid_in),
    .io_fetch_ack_out(unified_cache_bank_3_io_fetch_ack_out),
    .io_miss_request_out(unified_cache_bank_3_io_miss_request_out),
    .io_miss_request_valid_out(unified_cache_bank_3_io_miss_request_valid_out),
    .io_miss_request_ack_in(unified_cache_bank_3_io_miss_request_ack_in),
    .io_return_request_out(unified_cache_bank_3_io_return_request_out),
    .io_return_request_valid_out(unified_cache_bank_3_io_return_request_valid_out),
    .io_return_request_ack_in(unified_cache_bank_3_io_return_request_ack_in)
  );
  priority_arbiter_chisel_4 to_mem_arbiter ( // @[true_unified_cache.scala 253:30:@8713.4]
    .clock(to_mem_arbiter_clock),
    .reset(to_mem_arbiter_reset),
    .io_request_flatted_in(to_mem_arbiter_io_request_flatted_in),
    .io_request_valid_flatted_in(to_mem_arbiter_io_request_valid_flatted_in),
    .io_issue_ack_out(to_mem_arbiter_io_issue_ack_out),
    .io_request_out(to_mem_arbiter_io_request_out),
    .io_issue_ack_in(to_mem_arbiter_io_issue_ack_in)
  );
  priority_arbiter_chisel_5 priority_arbiter_chisel ( // @[true_unified_cache.scala 282:32:@8797.4]
    .clock(priority_arbiter_chisel_clock),
    .reset(priority_arbiter_chisel_reset),
    .io_request_flatted_in(priority_arbiter_chisel_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_chisel_io_request_valid_flatted_in),
    .io_issue_ack_out(priority_arbiter_chisel_io_issue_ack_out),
    .io_request_out(priority_arbiter_chisel_io_request_out),
    .io_issue_ack_in(priority_arbiter_chisel_io_issue_ack_in)
  );
  priority_arbiter_chisel_5 priority_arbiter_chisel_1 ( // @[true_unified_cache.scala 282:32:@8841.4]
    .clock(priority_arbiter_chisel_1_clock),
    .reset(priority_arbiter_chisel_1_reset),
    .io_request_flatted_in(priority_arbiter_chisel_1_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_chisel_1_io_request_valid_flatted_in),
    .io_issue_ack_out(priority_arbiter_chisel_1_io_issue_ack_out),
    .io_request_out(priority_arbiter_chisel_1_io_request_out),
    .io_issue_ack_in(priority_arbiter_chisel_1_io_issue_ack_in)
  );
  assign input_packet_packed_0 = io_input_packet_flatted_in[79:0]; // @[true_unified_cache.scala 158:66:@8376.4]
  assign input_packet_packed_1 = io_input_packet_flatted_in[159:80]; // @[true_unified_cache.scala 158:66:@8391.4]
  assign input_packet_to_cache_packed_0 = fifo_queue_chisel_io_request_out; // @[true_unified_cache.scala 146:42:@8368.4 true_unified_cache.scala 163:46:@8383.4]
  assign _T_201_0 = input_packet_to_cache_packed_0[31:0]; // @[true_unified_cache.scala 190:31:@8417.4 true_unified_cache.scala 194:35:@8420.4]
  assign _T_222 = _T_201_0[3:2]; // @[true_unified_cache.scala 195:70:@8421.4]
  assign _T_224 = _T_222 == 2'h0; // @[true_unified_cache.scala 195:147:@8422.4]
  assign input_packet_valid_to_cache_flatted_0 = fifo_queue_chisel_io_request_valid_out; // @[true_unified_cache.scala 148:49:@8370.4 true_unified_cache.scala 164:53:@8384.4]
  assign _T_225 = input_packet_valid_to_cache_flatted_0 & _T_224; // @[true_unified_cache.scala 196:91:@8424.4]
  assign input_packet_to_cache_packed_1 = fifo_queue_chisel_1_io_request_out; // @[true_unified_cache.scala 146:42:@8368.4 true_unified_cache.scala 163:46:@8398.4]
  assign _T_201_1 = input_packet_to_cache_packed_1[31:0]; // @[true_unified_cache.scala 190:31:@8417.4 true_unified_cache.scala 194:35:@8426.4]
  assign _T_226 = _T_201_1[3:2]; // @[true_unified_cache.scala 195:70:@8427.4]
  assign _T_228 = _T_226 == 2'h0; // @[true_unified_cache.scala 195:147:@8428.4]
  assign input_packet_valid_to_cache_flatted_1 = fifo_queue_chisel_1_io_request_valid_out; // @[true_unified_cache.scala 148:49:@8370.4 true_unified_cache.scala 164:53:@8399.4]
  assign _T_229 = input_packet_valid_to_cache_flatted_1 & _T_228; // @[true_unified_cache.scala 196:91:@8430.4]
  assign _T_236 = io_from_mem_packet_in[31:0]; // @[true_unified_cache.scala 202:47:@8435.4]
  assign _T_237 = _T_236[3:2]; // @[true_unified_cache.scala 203:48:@8437.4]
  assign _T_239 = _T_237 == 2'h0; // @[true_unified_cache.scala 203:125:@8438.4]
  assign _T_240 = io_from_mem_packet_in[77]; // @[true_unified_cache.scala 204:52:@8440.4]
  assign _T_241 = _T_240 & _T_239; // @[true_unified_cache.scala 204:87:@8441.4]
  assign _T_242 = {_T_229,_T_225}; // @[true_unified_cache.scala 208:32:@8446.4]
  assign _T_244 = _T_242 > 2'h0; // @[true_unified_cache.scala 208:39:@8447.4]
  assign _T_245 = {input_packet_to_cache_packed_1,input_packet_to_cache_packed_0}; // @[true_unified_cache.scala 209:79:@8449.6]
  assign is_input_queue_full_flatted_1 = fifo_queue_chisel_1_io_is_full_out; // @[true_unified_cache.scala 145:41:@8367.4 true_unified_cache.scala 159:45:@8393.4]
  assign is_input_queue_full_flatted_0 = fifo_queue_chisel_io_is_full_out; // @[true_unified_cache.scala 145:41:@8367.4 true_unified_cache.scala 159:45:@8378.4]
  assign miss_request_ack_flatted = to_mem_arbiter_io_issue_ack_out[7:4]; // @[true_unified_cache.scala 260:62:@8740.4]
  assign _T_279 = _T_222 == 2'h1; // @[true_unified_cache.scala 195:147:@8488.4]
  assign _T_280 = input_packet_valid_to_cache_flatted_0 & _T_279; // @[true_unified_cache.scala 196:91:@8490.4]
  assign _T_283 = _T_226 == 2'h1; // @[true_unified_cache.scala 195:147:@8494.4]
  assign _T_284 = input_packet_valid_to_cache_flatted_1 & _T_283; // @[true_unified_cache.scala 196:91:@8496.4]
  assign _T_294 = _T_237 == 2'h1; // @[true_unified_cache.scala 203:125:@8504.4]
  assign _T_296 = _T_240 & _T_294; // @[true_unified_cache.scala 204:87:@8507.4]
  assign _T_297 = {_T_284,_T_280}; // @[true_unified_cache.scala 208:32:@8512.4]
  assign _T_299 = _T_297 > 2'h0; // @[true_unified_cache.scala 208:39:@8513.4]
  assign _T_334 = _T_222 == 2'h2; // @[true_unified_cache.scala 195:147:@8554.4]
  assign _T_335 = input_packet_valid_to_cache_flatted_0 & _T_334; // @[true_unified_cache.scala 196:91:@8556.4]
  assign _T_338 = _T_226 == 2'h2; // @[true_unified_cache.scala 195:147:@8560.4]
  assign _T_339 = input_packet_valid_to_cache_flatted_1 & _T_338; // @[true_unified_cache.scala 196:91:@8562.4]
  assign _T_349 = _T_237 == 2'h2; // @[true_unified_cache.scala 203:125:@8570.4]
  assign _T_351 = _T_240 & _T_349; // @[true_unified_cache.scala 204:87:@8573.4]
  assign _T_352 = {_T_339,_T_335}; // @[true_unified_cache.scala 208:32:@8578.4]
  assign _T_354 = _T_352 > 2'h0; // @[true_unified_cache.scala 208:39:@8579.4]
  assign _T_389 = _T_222 == 2'h3; // @[true_unified_cache.scala 195:147:@8620.4]
  assign _T_390 = input_packet_valid_to_cache_flatted_0 & _T_389; // @[true_unified_cache.scala 196:91:@8622.4]
  assign _T_393 = _T_226 == 2'h3; // @[true_unified_cache.scala 195:147:@8626.4]
  assign _T_394 = input_packet_valid_to_cache_flatted_1 & _T_393; // @[true_unified_cache.scala 196:91:@8628.4]
  assign _T_404 = _T_237 == 2'h3; // @[true_unified_cache.scala 203:125:@8636.4]
  assign _T_406 = _T_240 & _T_404; // @[true_unified_cache.scala 204:87:@8639.4]
  assign _T_407 = {_T_394,_T_390}; // @[true_unified_cache.scala 208:32:@8644.4]
  assign _T_409 = _T_407 > 2'h0; // @[true_unified_cache.scala 208:39:@8645.4]
  assign from_mem_packet_ack_flatted_1 = unified_cache_bank_1_io_fetch_ack_out; // @[true_unified_cache.scala 173:41:@8404.4 true_unified_cache.scala 225:45:@8534.4]
  assign from_mem_packet_ack_flatted_0 = unified_cache_bank_io_fetch_ack_out; // @[true_unified_cache.scala 173:41:@8404.4 true_unified_cache.scala 225:45:@8468.4]
  assign _T_418 = {from_mem_packet_ack_flatted_1,from_mem_packet_ack_flatted_0}; // @[true_unified_cache.scala 244:61:@8681.4]
  assign from_mem_packet_ack_flatted_3 = unified_cache_bank_3_io_fetch_ack_out; // @[true_unified_cache.scala 173:41:@8404.4 true_unified_cache.scala 225:45:@8666.4]
  assign from_mem_packet_ack_flatted_2 = unified_cache_bank_2_io_fetch_ack_out; // @[true_unified_cache.scala 173:41:@8404.4 true_unified_cache.scala 225:45:@8600.4]
  assign _T_419 = {from_mem_packet_ack_flatted_3,from_mem_packet_ack_flatted_2}; // @[true_unified_cache.scala 244:61:@8682.4]
  assign _T_420 = {_T_419,_T_418}; // @[true_unified_cache.scala 244:61:@8683.4]
  assign cache_to_input_queue_ack_flatted_0 = unified_cache_bank_io_input_request_ack_out; // @[true_unified_cache.scala 172:46:@8403.4 true_unified_cache.scala 216:50:@8459.4]
  assign cache_to_input_queue_ack_packed_0_0 = cache_to_input_queue_ack_flatted_0[0]; // @[true_unified_cache.scala 248:110:@8687.4]
  assign cache_to_input_queue_ack_flatted_1 = unified_cache_bank_1_io_input_request_ack_out; // @[true_unified_cache.scala 172:46:@8403.4 true_unified_cache.scala 216:50:@8525.4]
  assign cache_to_input_queue_ack_packed_0_1 = cache_to_input_queue_ack_flatted_1[0]; // @[true_unified_cache.scala 248:110:@8689.4]
  assign cache_to_input_queue_ack_flatted_2 = unified_cache_bank_2_io_input_request_ack_out; // @[true_unified_cache.scala 172:46:@8403.4 true_unified_cache.scala 216:50:@8591.4]
  assign cache_to_input_queue_ack_packed_0_2 = cache_to_input_queue_ack_flatted_2[0]; // @[true_unified_cache.scala 248:110:@8691.4]
  assign cache_to_input_queue_ack_flatted_3 = unified_cache_bank_3_io_input_request_ack_out; // @[true_unified_cache.scala 172:46:@8403.4 true_unified_cache.scala 216:50:@8657.4]
  assign cache_to_input_queue_ack_packed_0_3 = cache_to_input_queue_ack_flatted_3[0]; // @[true_unified_cache.scala 248:110:@8693.4]
  assign _T_505 = {cache_to_input_queue_ack_packed_0_1,cache_to_input_queue_ack_packed_0_0}; // @[true_unified_cache.scala 250:96:@8695.4]
  assign _T_506 = {cache_to_input_queue_ack_packed_0_3,cache_to_input_queue_ack_packed_0_2}; // @[true_unified_cache.scala 250:96:@8696.4]
  assign _T_507 = {_T_506,_T_505}; // @[true_unified_cache.scala 250:96:@8697.4]
  assign cache_to_input_queue_ack_packed_1_0 = cache_to_input_queue_ack_flatted_0[1]; // @[true_unified_cache.scala 248:110:@8700.4]
  assign cache_to_input_queue_ack_packed_1_1 = cache_to_input_queue_ack_flatted_1[1]; // @[true_unified_cache.scala 248:110:@8702.4]
  assign cache_to_input_queue_ack_packed_1_2 = cache_to_input_queue_ack_flatted_2[1]; // @[true_unified_cache.scala 248:110:@8704.4]
  assign cache_to_input_queue_ack_packed_1_3 = cache_to_input_queue_ack_flatted_3[1]; // @[true_unified_cache.scala 248:110:@8706.4]
  assign _T_514 = {cache_to_input_queue_ack_packed_1_1,cache_to_input_queue_ack_packed_1_0}; // @[true_unified_cache.scala 250:96:@8708.4]
  assign _T_515 = {cache_to_input_queue_ack_packed_1_3,cache_to_input_queue_ack_packed_1_2}; // @[true_unified_cache.scala 250:96:@8709.4]
  assign _T_516 = {_T_515,_T_514}; // @[true_unified_cache.scala 250:96:@8710.4]
  assign miss_request_flatted_1 = unified_cache_bank_1_io_miss_request_out; // @[true_unified_cache.scala 174:34:@8405.4 true_unified_cache.scala 227:38:@8535.4]
  assign miss_request_flatted_0 = unified_cache_bank_io_miss_request_out; // @[true_unified_cache.scala 174:34:@8405.4 true_unified_cache.scala 227:38:@8469.4]
  assign _T_519 = {miss_request_flatted_1,miss_request_flatted_0}; // @[true_unified_cache.scala 257:68:@8716.4]
  assign miss_request_flatted_3 = unified_cache_bank_3_io_miss_request_out; // @[true_unified_cache.scala 174:34:@8405.4 true_unified_cache.scala 227:38:@8667.4]
  assign miss_request_flatted_2 = unified_cache_bank_2_io_miss_request_out; // @[true_unified_cache.scala 174:34:@8405.4 true_unified_cache.scala 227:38:@8601.4]
  assign _T_520 = {miss_request_flatted_3,miss_request_flatted_2}; // @[true_unified_cache.scala 257:68:@8717.4]
  assign _T_521 = {_T_520,_T_519}; // @[true_unified_cache.scala 257:68:@8718.4]
  assign miss_request_valid_flatted_1 = unified_cache_bank_1_io_miss_request_valid_out; // @[true_unified_cache.scala 175:40:@8406.4 true_unified_cache.scala 228:44:@8536.4]
  assign miss_request_valid_flatted_0 = unified_cache_bank_io_miss_request_valid_out; // @[true_unified_cache.scala 175:40:@8406.4 true_unified_cache.scala 228:44:@8470.4]
  assign _T_526 = {miss_request_valid_flatted_1,miss_request_valid_flatted_0}; // @[true_unified_cache.scala 258:80:@8724.4]
  assign miss_request_valid_flatted_3 = unified_cache_bank_3_io_miss_request_valid_out; // @[true_unified_cache.scala 175:40:@8406.4 true_unified_cache.scala 228:44:@8668.4]
  assign miss_request_valid_flatted_2 = unified_cache_bank_2_io_miss_request_valid_out; // @[true_unified_cache.scala 175:40:@8406.4 true_unified_cache.scala 228:44:@8602.4]
  assign _T_527 = {miss_request_valid_flatted_3,miss_request_valid_flatted_2}; // @[true_unified_cache.scala 258:80:@8725.4]
  assign _T_528 = {_T_527,_T_526}; // @[true_unified_cache.scala 258:80:@8726.4]
  assign return_request_ack_flatted_0 = priority_arbiter_chisel_io_issue_ack_out; // @[true_unified_cache.scala 266:40:@8746.4 true_unified_cache.scala 289:44:@8816.4]
  assign return_request_ack_packed_0_0 = return_request_ack_flatted_0[0]; // @[true_unified_cache.scala 270:98:@8748.4]
  assign return_request_ack_flatted_1 = priority_arbiter_chisel_1_io_issue_ack_out; // @[true_unified_cache.scala 266:40:@8746.4 true_unified_cache.scala 289:44:@8860.4]
  assign return_request_ack_packed_0_1 = return_request_ack_flatted_1[0]; // @[true_unified_cache.scala 270:98:@8750.4]
  assign _T_637 = {return_request_ack_packed_0_1,return_request_ack_packed_0_0}; // @[true_unified_cache.scala 272:84:@8752.4]
  assign return_request_ack_packed_1_0 = return_request_ack_flatted_0[1]; // @[true_unified_cache.scala 270:98:@8755.4]
  assign return_request_ack_packed_1_1 = return_request_ack_flatted_1[1]; // @[true_unified_cache.scala 270:98:@8757.4]
  assign _T_642 = {return_request_ack_packed_1_1,return_request_ack_packed_1_0}; // @[true_unified_cache.scala 272:84:@8759.4]
  assign return_request_ack_packed_2_0 = return_request_ack_flatted_0[2]; // @[true_unified_cache.scala 270:98:@8762.4]
  assign return_request_ack_packed_2_1 = return_request_ack_flatted_1[2]; // @[true_unified_cache.scala 270:98:@8764.4]
  assign _T_647 = {return_request_ack_packed_2_1,return_request_ack_packed_2_0}; // @[true_unified_cache.scala 272:84:@8766.4]
  assign return_request_ack_packed_3_0 = return_request_ack_flatted_0[3]; // @[true_unified_cache.scala 270:98:@8769.4]
  assign return_request_ack_packed_3_1 = return_request_ack_flatted_1[3]; // @[true_unified_cache.scala 270:98:@8771.4]
  assign _T_652 = {return_request_ack_packed_3_1,return_request_ack_packed_3_0}; // @[true_unified_cache.scala 272:84:@8773.4]
  assign return_request_flatted_0 = unified_cache_bank_io_return_request_out; // @[true_unified_cache.scala 184:36:@8413.4 true_unified_cache.scala 237:40:@8479.4]
  assign _T_665 = return_request_flatted_0[73:72]; // @[true_unified_cache.scala 278:71:@8777.4]
  assign _T_667 = _T_665 == 2'h0; // @[true_unified_cache.scala 278:164:@8778.4]
  assign _T_668 = return_request_flatted_0[77]; // @[true_unified_cache.scala 279:71:@8779.4]
  assign _T_669 = _T_667 & _T_668; // @[true_unified_cache.scala 278:182:@8780.4]
  assign return_request_flatted_1 = unified_cache_bank_1_io_return_request_out; // @[true_unified_cache.scala 184:36:@8413.4 true_unified_cache.scala 237:40:@8545.4]
  assign _T_670 = return_request_flatted_1[73:72]; // @[true_unified_cache.scala 278:71:@8782.4]
  assign _T_672 = _T_670 == 2'h0; // @[true_unified_cache.scala 278:164:@8783.4]
  assign _T_673 = return_request_flatted_1[77]; // @[true_unified_cache.scala 279:71:@8784.4]
  assign _T_674 = _T_672 & _T_673; // @[true_unified_cache.scala 278:182:@8785.4]
  assign return_request_flatted_2 = unified_cache_bank_2_io_return_request_out; // @[true_unified_cache.scala 184:36:@8413.4 true_unified_cache.scala 237:40:@8611.4]
  assign _T_675 = return_request_flatted_2[73:72]; // @[true_unified_cache.scala 278:71:@8787.4]
  assign _T_677 = _T_675 == 2'h0; // @[true_unified_cache.scala 278:164:@8788.4]
  assign _T_678 = return_request_flatted_2[77]; // @[true_unified_cache.scala 279:71:@8789.4]
  assign _T_679 = _T_677 & _T_678; // @[true_unified_cache.scala 278:182:@8790.4]
  assign return_request_flatted_3 = unified_cache_bank_3_io_return_request_out; // @[true_unified_cache.scala 184:36:@8413.4 true_unified_cache.scala 237:40:@8677.4]
  assign _T_680 = return_request_flatted_3[73:72]; // @[true_unified_cache.scala 278:71:@8792.4]
  assign _T_682 = _T_680 == 2'h0; // @[true_unified_cache.scala 278:164:@8793.4]
  assign _T_683 = return_request_flatted_3[77]; // @[true_unified_cache.scala 279:71:@8794.4]
  assign _T_684 = _T_682 & _T_683; // @[true_unified_cache.scala 278:182:@8795.4]
  assign _T_685 = {return_request_flatted_1,return_request_flatted_0}; // @[true_unified_cache.scala 286:68:@8800.4]
  assign _T_686 = {return_request_flatted_3,return_request_flatted_2}; // @[true_unified_cache.scala 286:68:@8801.4]
  assign return_request_valid_flatted_1 = unified_cache_bank_1_io_return_request_valid_out; // @[true_unified_cache.scala 185:42:@8414.4 true_unified_cache.scala 238:46:@8546.4]
  assign return_request_valid_flatted_0 = unified_cache_bank_io_return_request_valid_out; // @[true_unified_cache.scala 185:42:@8414.4 true_unified_cache.scala 238:46:@8480.4]
  assign _T_688 = {return_request_valid_flatted_1,return_request_valid_flatted_0}; // @[true_unified_cache.scala 287:80:@8804.4]
  assign return_request_valid_flatted_3 = unified_cache_bank_3_io_return_request_valid_out; // @[true_unified_cache.scala 185:42:@8414.4 true_unified_cache.scala 238:46:@8678.4]
  assign return_request_valid_flatted_2 = unified_cache_bank_2_io_return_request_valid_out; // @[true_unified_cache.scala 185:42:@8414.4 true_unified_cache.scala 238:46:@8612.4]
  assign _T_689 = {return_request_valid_flatted_3,return_request_valid_flatted_2}; // @[true_unified_cache.scala 287:80:@8805.4]
  assign _T_690 = {_T_689,_T_688}; // @[true_unified_cache.scala 287:80:@8806.4]
  assign _T_691 = {_T_674,_T_669}; // @[true_unified_cache.scala 287:103:@8807.4]
  assign _T_692 = {_T_684,_T_679}; // @[true_unified_cache.scala 287:103:@8808.4]
  assign _T_693 = {_T_692,_T_691}; // @[true_unified_cache.scala 287:103:@8809.4]
  assign _T_711 = _T_665 == 2'h1; // @[true_unified_cache.scala 278:164:@8822.4]
  assign _T_713 = _T_711 & _T_668; // @[true_unified_cache.scala 278:182:@8824.4]
  assign _T_716 = _T_670 == 2'h1; // @[true_unified_cache.scala 278:164:@8827.4]
  assign _T_718 = _T_716 & _T_673; // @[true_unified_cache.scala 278:182:@8829.4]
  assign _T_721 = _T_675 == 2'h1; // @[true_unified_cache.scala 278:164:@8832.4]
  assign _T_723 = _T_721 & _T_678; // @[true_unified_cache.scala 278:182:@8834.4]
  assign _T_726 = _T_680 == 2'h1; // @[true_unified_cache.scala 278:164:@8837.4]
  assign _T_728 = _T_726 & _T_683; // @[true_unified_cache.scala 278:182:@8839.4]
  assign _T_735 = {_T_718,_T_713}; // @[true_unified_cache.scala 287:103:@8851.4]
  assign _T_736 = {_T_728,_T_723}; // @[true_unified_cache.scala 287:103:@8852.4]
  assign _T_737 = {_T_736,_T_735}; // @[true_unified_cache.scala 287:103:@8853.4]
  assign input_packet_ack_flatted_out_vec_1 = fifo_queue_chisel_1_io_issue_ack_out; // @[true_unified_cache.scala 141:46:@8364.4 true_unified_cache.scala 162:50:@8397.4]
  assign input_packet_ack_flatted_out_vec_0 = fifo_queue_chisel_io_issue_ack_out; // @[true_unified_cache.scala 141:46:@8364.4 true_unified_cache.scala 162:50:@8382.4]
  assign return_packet_flatted_out_vec_1 = priority_arbiter_chisel_1_io_request_out; // @[true_unified_cache.scala 142:43:@8365.4 true_unified_cache.scala 290:47:@8861.4]
  assign return_packet_flatted_out_vec_0 = priority_arbiter_chisel_io_request_out; // @[true_unified_cache.scala 142:43:@8365.4 true_unified_cache.scala 290:47:@8817.4]
  assign io_input_packet_ack_flatted_out = {input_packet_ack_flatted_out_vec_1,input_packet_ack_flatted_out_vec_0}; // @[true_unified_cache.scala 295:35:@8865.4]
  assign io_return_packet_flatted_out = {return_packet_flatted_out_vec_1,return_packet_flatted_out_vec_0}; // @[true_unified_cache.scala 296:32:@8867.4]
  assign io_from_mem_packet_ack_out = _T_420 != 4'h0; // @[true_unified_cache.scala 244:30:@8685.4]
  assign io_to_mem_packet_out = to_mem_arbiter_io_request_out; // @[true_unified_cache.scala 262:24:@8744.4]
  assign fifo_queue_chisel_clock = clock; // @[:@8374.4]
  assign fifo_queue_chisel_reset = reset; // @[:@8375.4]
  assign fifo_queue_chisel_io_request_in = io_input_packet_flatted_in[79:0]; // @[true_unified_cache.scala 160:31:@8379.4]
  assign fifo_queue_chisel_io_request_valid_in = input_packet_packed_0[77]; // @[true_unified_cache.scala 161:37:@8381.4]
  assign fifo_queue_chisel_io_issue_ack_in = _T_507 != 4'h0; // @[true_unified_cache.scala 165:33:@8385.4]
  assign fifo_queue_chisel_1_clock = clock; // @[:@8389.4]
  assign fifo_queue_chisel_1_reset = reset; // @[:@8390.4]
  assign fifo_queue_chisel_1_io_request_in = io_input_packet_flatted_in[159:80]; // @[true_unified_cache.scala 160:31:@8394.4]
  assign fifo_queue_chisel_1_io_request_valid_in = input_packet_packed_1[77]; // @[true_unified_cache.scala 161:37:@8396.4]
  assign fifo_queue_chisel_1_io_issue_ack_in = _T_516 != 4'h0; // @[true_unified_cache.scala 165:33:@8400.4]
  assign unified_cache_bank_clock = clock; // @[:@8444.4]
  assign unified_cache_bank_reset = reset; // @[:@8445.4]
  assign unified_cache_bank_io_input_request_flatted_in = _T_244 ? _T_245 : 160'h0; // @[true_unified_cache.scala 209:46:@8450.6 true_unified_cache.scala 211:46:@8453.6]
  assign unified_cache_bank_io_input_request_valid_flatted_in = {_T_229,_T_225}; // @[true_unified_cache.scala 214:50:@8456.4]
  assign unified_cache_bank_io_input_request_critical_flatted_in = {is_input_queue_full_flatted_1,is_input_queue_full_flatted_0}; // @[true_unified_cache.scala 215:53:@8458.4]
  assign unified_cache_bank_io_fetched_request_in = _T_241 ? io_from_mem_packet_in : 80'h0; // @[true_unified_cache.scala 219:40:@8462.6 true_unified_cache.scala 221:40:@8465.6]
  assign unified_cache_bank_io_fetched_request_valid_in = _T_240 & _T_239; // @[true_unified_cache.scala 224:44:@8467.4]
  assign unified_cache_bank_io_miss_request_ack_in = miss_request_ack_flatted[0]; // @[true_unified_cache.scala 230:39:@8473.4]
  assign unified_cache_bank_io_return_request_ack_in = _T_637 != 2'h0; // @[true_unified_cache.scala 240:41:@8482.4]
  assign unified_cache_bank_1_clock = clock; // @[:@8510.4]
  assign unified_cache_bank_1_reset = reset; // @[:@8511.4]
  assign unified_cache_bank_1_io_input_request_flatted_in = _T_299 ? _T_245 : 160'h0; // @[true_unified_cache.scala 209:46:@8516.6 true_unified_cache.scala 211:46:@8519.6]
  assign unified_cache_bank_1_io_input_request_valid_flatted_in = {_T_284,_T_280}; // @[true_unified_cache.scala 214:50:@8522.4]
  assign unified_cache_bank_1_io_input_request_critical_flatted_in = {is_input_queue_full_flatted_1,is_input_queue_full_flatted_0}; // @[true_unified_cache.scala 215:53:@8524.4]
  assign unified_cache_bank_1_io_fetched_request_in = _T_296 ? io_from_mem_packet_in : 80'h0; // @[true_unified_cache.scala 219:40:@8528.6 true_unified_cache.scala 221:40:@8531.6]
  assign unified_cache_bank_1_io_fetched_request_valid_in = _T_240 & _T_294; // @[true_unified_cache.scala 224:44:@8533.4]
  assign unified_cache_bank_1_io_miss_request_ack_in = miss_request_ack_flatted[1]; // @[true_unified_cache.scala 230:39:@8539.4]
  assign unified_cache_bank_1_io_return_request_ack_in = _T_642 != 2'h0; // @[true_unified_cache.scala 240:41:@8548.4]
  assign unified_cache_bank_2_clock = clock; // @[:@8576.4]
  assign unified_cache_bank_2_reset = reset; // @[:@8577.4]
  assign unified_cache_bank_2_io_input_request_flatted_in = _T_354 ? _T_245 : 160'h0; // @[true_unified_cache.scala 209:46:@8582.6 true_unified_cache.scala 211:46:@8585.6]
  assign unified_cache_bank_2_io_input_request_valid_flatted_in = {_T_339,_T_335}; // @[true_unified_cache.scala 214:50:@8588.4]
  assign unified_cache_bank_2_io_input_request_critical_flatted_in = {is_input_queue_full_flatted_1,is_input_queue_full_flatted_0}; // @[true_unified_cache.scala 215:53:@8590.4]
  assign unified_cache_bank_2_io_fetched_request_in = _T_351 ? io_from_mem_packet_in : 80'h0; // @[true_unified_cache.scala 219:40:@8594.6 true_unified_cache.scala 221:40:@8597.6]
  assign unified_cache_bank_2_io_fetched_request_valid_in = _T_240 & _T_349; // @[true_unified_cache.scala 224:44:@8599.4]
  assign unified_cache_bank_2_io_miss_request_ack_in = miss_request_ack_flatted[2]; // @[true_unified_cache.scala 230:39:@8605.4]
  assign unified_cache_bank_2_io_return_request_ack_in = _T_647 != 2'h0; // @[true_unified_cache.scala 240:41:@8614.4]
  assign unified_cache_bank_3_clock = clock; // @[:@8642.4]
  assign unified_cache_bank_3_reset = reset; // @[:@8643.4]
  assign unified_cache_bank_3_io_input_request_flatted_in = _T_409 ? _T_245 : 160'h0; // @[true_unified_cache.scala 209:46:@8648.6 true_unified_cache.scala 211:46:@8651.6]
  assign unified_cache_bank_3_io_input_request_valid_flatted_in = {_T_394,_T_390}; // @[true_unified_cache.scala 214:50:@8654.4]
  assign unified_cache_bank_3_io_input_request_critical_flatted_in = {is_input_queue_full_flatted_1,is_input_queue_full_flatted_0}; // @[true_unified_cache.scala 215:53:@8656.4]
  assign unified_cache_bank_3_io_fetched_request_in = _T_406 ? io_from_mem_packet_in : 80'h0; // @[true_unified_cache.scala 219:40:@8660.6 true_unified_cache.scala 221:40:@8663.6]
  assign unified_cache_bank_3_io_fetched_request_valid_in = _T_240 & _T_404; // @[true_unified_cache.scala 224:44:@8665.4]
  assign unified_cache_bank_3_io_miss_request_ack_in = miss_request_ack_flatted[3]; // @[true_unified_cache.scala 230:39:@8671.4]
  assign unified_cache_bank_3_io_return_request_ack_in = _T_652 != 2'h0; // @[true_unified_cache.scala 240:41:@8680.4]
  assign to_mem_arbiter_clock = clock; // @[:@8714.4]
  assign to_mem_arbiter_reset = reset; // @[:@8715.4]
  assign to_mem_arbiter_io_request_flatted_in = {_T_521,320'h0}; // @[true_unified_cache.scala 257:40:@8723.4]
  assign to_mem_arbiter_io_request_valid_flatted_in = {_T_528,4'h0}; // @[true_unified_cache.scala 258:46:@8731.4]
  assign to_mem_arbiter_io_issue_ack_in = io_to_mem_packet_ack_in; // @[true_unified_cache.scala 263:34:@8745.4]
  assign priority_arbiter_chisel_clock = clock; // @[:@8798.4]
  assign priority_arbiter_chisel_reset = reset; // @[:@8799.4]
  assign priority_arbiter_chisel_io_request_flatted_in = {_T_686,_T_685}; // @[true_unified_cache.scala 286:42:@8803.4]
  assign priority_arbiter_chisel_io_request_valid_flatted_in = _T_690 & _T_693; // @[true_unified_cache.scala 287:48:@8811.4]
  assign priority_arbiter_chisel_io_issue_ack_in = io_return_packet_ack_flatted_in[0]; // @[true_unified_cache.scala 291:36:@8819.4]
  assign priority_arbiter_chisel_1_clock = clock; // @[:@8842.4]
  assign priority_arbiter_chisel_1_reset = reset; // @[:@8843.4]
  assign priority_arbiter_chisel_1_io_request_flatted_in = {_T_686,_T_685}; // @[true_unified_cache.scala 286:42:@8847.4]
  assign priority_arbiter_chisel_1_io_request_valid_flatted_in = _T_690 & _T_737; // @[true_unified_cache.scala 287:48:@8855.4]
  assign priority_arbiter_chisel_1_io_issue_ack_in = io_return_packet_ack_flatted_in[1]; // @[true_unified_cache.scala 291:36:@8863.4]
endmodule
