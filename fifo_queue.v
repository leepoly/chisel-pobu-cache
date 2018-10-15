module fifo_queue( // @[:@3.2]
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
  reg  issue_ack_out_reg; // @[fifo_queue.scala 26:40:@8.4]
  reg [31:0] _RAND_0;
  reg [79:0] request_out_reg; // @[fifo_queue.scala 27:38:@9.4]
  reg [95:0] _RAND_1;
  reg  request_valid_out_reg; // @[fifo_queue.scala 28:44:@10.4]
  reg [31:0] _RAND_2;
  reg [1:0] write_ptr; // @[fifo_queue.scala 36:32:@13.4]
  reg [31:0] _RAND_3;
  reg [1:0] read_ptr; // @[fifo_queue.scala 37:31:@14.4]
  reg [31:0] _RAND_4;
  reg [79:0] entry_vec_0; // @[fifo_queue.scala 39:32:@20.4]
  reg [95:0] _RAND_5;
  reg [79:0] entry_vec_1; // @[fifo_queue.scala 39:32:@20.4]
  reg [95:0] _RAND_6;
  reg [79:0] entry_vec_2; // @[fifo_queue.scala 39:32:@20.4]
  reg [95:0] _RAND_7;
  reg [79:0] entry_vec_3; // @[fifo_queue.scala 39:32:@20.4]
  reg [95:0] _RAND_8;
  reg  entry_valid_vec_0; // @[fifo_queue.scala 40:38:@26.4]
  reg [31:0] _RAND_9;
  reg  entry_valid_vec_1; // @[fifo_queue.scala 40:38:@26.4]
  reg [31:0] _RAND_10;
  reg  entry_valid_vec_2; // @[fifo_queue.scala 40:38:@26.4]
  reg [31:0] _RAND_11;
  reg  entry_valid_vec_3; // @[fifo_queue.scala 40:38:@26.4]
  reg [31:0] _RAND_12;
  wire [1:0] _T_133; // @[fifo_queue.scala 43:43:@27.4]
  wire [1:0] _T_134; // @[fifo_queue.scala 43:43:@28.4]
  wire [3:0] _T_135; // @[fifo_queue.scala 43:43:@29.4]
  wire [3:0] _T_136; // @[fifo_queue.scala 43:50:@30.4]
  wire [3:0] _T_143; // @[fifo_queue.scala 44:56:@37.4]
  wire  _T_146; // @[fifo_queue.scala 49:42:@40.4]
  wire  _T_147; // @[fifo_queue.scala 49:77:@41.4]
  wire  _T_149; // @[fifo_queue.scala 49:107:@42.4]
  wire  _T_150; // @[fifo_queue.scala 49:94:@43.4]
  wire  _T_151; // @[fifo_queue.scala 49:58:@44.4]
  wire  _T_152; // @[fifo_queue.scala 49:124:@45.4]
  wire  _T_153; // @[fifo_queue.scala 49:122:@46.4]
  wire  _T_154; // @[fifo_queue.scala 49:143:@47.4]
  wire  _T_156; // @[fifo_queue.scala 49:178:@48.4]
  wire  write_qualified_0; // @[fifo_queue.scala 49:165:@49.4]
  wire  _T_158; // @[fifo_queue.scala 50:40:@51.4]
  wire  _T_159; // @[fifo_queue.scala 50:57:@52.4]
  wire  _T_160; // @[fifo_queue.scala 50:75:@53.4]
  wire  read_qualified_0; // @[fifo_queue.scala 50:98:@55.4]
  wire  _T_169; // @[fifo_queue.scala 56:59:@65.6]
  wire [79:0] _GEN_0; // @[fifo_queue.scala 63:75:@78.10]
  wire  _GEN_1; // @[fifo_queue.scala 63:75:@78.10]
  wire [79:0] _GEN_2; // @[fifo_queue.scala 60:67:@72.8]
  wire  _GEN_3; // @[fifo_queue.scala 60:67:@72.8]
  wire [79:0] _GEN_4; // @[fifo_queue.scala 56:90:@66.6]
  wire  _GEN_5; // @[fifo_queue.scala 56:90:@66.6]
  wire [79:0] _GEN_6; // @[fifo_queue.scala 52:37:@58.4]
  wire  _GEN_7; // @[fifo_queue.scala 52:37:@58.4]
  wire  _T_179; // @[fifo_queue.scala 49:107:@90.4]
  wire  _T_180; // @[fifo_queue.scala 49:94:@91.4]
  wire  _T_181; // @[fifo_queue.scala 49:58:@92.4]
  wire  _T_183; // @[fifo_queue.scala 49:122:@94.4]
  wire  _T_184; // @[fifo_queue.scala 49:143:@95.4]
  wire  _T_186; // @[fifo_queue.scala 49:178:@96.4]
  wire  write_qualified_1; // @[fifo_queue.scala 49:165:@97.4]
  wire  _T_190; // @[fifo_queue.scala 50:75:@101.4]
  wire  read_qualified_1; // @[fifo_queue.scala 50:98:@103.4]
  wire  _T_199; // @[fifo_queue.scala 56:59:@113.6]
  wire [79:0] _GEN_8; // @[fifo_queue.scala 63:75:@126.10]
  wire  _GEN_9; // @[fifo_queue.scala 63:75:@126.10]
  wire [79:0] _GEN_10; // @[fifo_queue.scala 60:67:@120.8]
  wire  _GEN_11; // @[fifo_queue.scala 60:67:@120.8]
  wire [79:0] _GEN_12; // @[fifo_queue.scala 56:90:@114.6]
  wire  _GEN_13; // @[fifo_queue.scala 56:90:@114.6]
  wire [79:0] _GEN_14; // @[fifo_queue.scala 52:37:@106.4]
  wire  _GEN_15; // @[fifo_queue.scala 52:37:@106.4]
  wire  _T_209; // @[fifo_queue.scala 49:107:@138.4]
  wire  _T_210; // @[fifo_queue.scala 49:94:@139.4]
  wire  _T_211; // @[fifo_queue.scala 49:58:@140.4]
  wire  _T_213; // @[fifo_queue.scala 49:122:@142.4]
  wire  _T_214; // @[fifo_queue.scala 49:143:@143.4]
  wire  _T_216; // @[fifo_queue.scala 49:178:@144.4]
  wire  write_qualified_2; // @[fifo_queue.scala 49:165:@145.4]
  wire  _T_220; // @[fifo_queue.scala 50:75:@149.4]
  wire  read_qualified_2; // @[fifo_queue.scala 50:98:@151.4]
  wire  _T_229; // @[fifo_queue.scala 56:59:@161.6]
  wire [79:0] _GEN_16; // @[fifo_queue.scala 63:75:@174.10]
  wire  _GEN_17; // @[fifo_queue.scala 63:75:@174.10]
  wire [79:0] _GEN_18; // @[fifo_queue.scala 60:67:@168.8]
  wire  _GEN_19; // @[fifo_queue.scala 60:67:@168.8]
  wire [79:0] _GEN_20; // @[fifo_queue.scala 56:90:@162.6]
  wire  _GEN_21; // @[fifo_queue.scala 56:90:@162.6]
  wire [79:0] _GEN_22; // @[fifo_queue.scala 52:37:@154.4]
  wire  _GEN_23; // @[fifo_queue.scala 52:37:@154.4]
  wire  _T_239; // @[fifo_queue.scala 49:107:@186.4]
  wire  _T_240; // @[fifo_queue.scala 49:94:@187.4]
  wire  _T_241; // @[fifo_queue.scala 49:58:@188.4]
  wire  _T_243; // @[fifo_queue.scala 49:122:@190.4]
  wire  _T_244; // @[fifo_queue.scala 49:143:@191.4]
  wire  _T_246; // @[fifo_queue.scala 49:178:@192.4]
  wire  write_qualified_3; // @[fifo_queue.scala 49:165:@193.4]
  wire  _T_250; // @[fifo_queue.scala 50:75:@197.4]
  wire  read_qualified_3; // @[fifo_queue.scala 50:98:@199.4]
  wire  _T_259; // @[fifo_queue.scala 56:59:@209.6]
  wire [79:0] _GEN_24; // @[fifo_queue.scala 63:75:@222.10]
  wire  _GEN_25; // @[fifo_queue.scala 63:75:@222.10]
  wire [79:0] _GEN_26; // @[fifo_queue.scala 60:67:@216.8]
  wire  _GEN_27; // @[fifo_queue.scala 60:67:@216.8]
  wire [79:0] _GEN_28; // @[fifo_queue.scala 56:90:@210.6]
  wire  _GEN_29; // @[fifo_queue.scala 56:90:@210.6]
  wire [79:0] _GEN_30; // @[fifo_queue.scala 52:37:@202.4]
  wire  _GEN_31; // @[fifo_queue.scala 52:37:@202.4]
  wire [1:0] _T_272; // @[fifo_queue.scala 82:39:@241.6]
  wire [1:0] _T_273; // @[fifo_queue.scala 82:39:@242.6]
  wire [3:0] _T_274; // @[fifo_queue.scala 82:39:@243.6]
  wire  _T_276; // @[fifo_queue.scala 82:46:@244.6]
  wire [2:0] _T_280; // @[fifo_queue.scala 84:77:@246.8]
  wire [2:0] _T_281; // @[fifo_queue.scala 84:77:@247.8]
  wire [1:0] _T_282; // @[fifo_queue.scala 84:77:@248.8]
  wire [3:0] _T_283; // @[fifo_queue.scala 84:49:@249.8]
  wire [3:0] _GEN_55; // @[fifo_queue.scala 84:41:@250.8]
  wire  _T_284; // @[fifo_queue.scala 84:41:@250.8]
  wire [2:0] _T_287; // @[fifo_queue.scala 87:56:@255.10]
  wire [1:0] _T_288; // @[fifo_queue.scala 87:56:@256.10]
  wire [1:0] _GEN_32; // @[fifo_queue.scala 84:85:@251.8]
  wire [1:0] _GEN_33; // @[fifo_queue.scala 82:51:@245.6]
  wire [1:0] _T_291; // @[fifo_queue.scala 96:38:@265.6]
  wire [1:0] _T_292; // @[fifo_queue.scala 96:38:@266.6]
  wire [3:0] _T_293; // @[fifo_queue.scala 96:38:@267.6]
  wire  _T_295; // @[fifo_queue.scala 96:45:@268.6]
  wire [3:0] _GEN_56; // @[fifo_queue.scala 97:40:@274.8]
  wire  _T_303; // @[fifo_queue.scala 97:40:@274.8]
  wire [2:0] _T_306; // @[fifo_queue.scala 100:54:@279.10]
  wire [1:0] _T_307; // @[fifo_queue.scala 100:54:@280.10]
  wire [1:0] _GEN_35; // @[fifo_queue.scala 97:84:@275.8]
  wire  _GEN_37; // @[fifo_queue.scala 104:56:@287.8]
  wire  _GEN_38; // @[fifo_queue.scala 104:56:@287.8]
  wire  _GEN_39; // @[fifo_queue.scala 104:56:@287.8]
  wire [79:0] _GEN_41; // @[fifo_queue.scala 106:41:@290.10]
  wire [79:0] _GEN_42; // @[fifo_queue.scala 106:41:@290.10]
  wire [79:0] _GEN_43; // @[fifo_queue.scala 106:41:@290.10]
  wire [79:0] _GEN_45; // @[fifo_queue.scala 104:64:@288.8]
  wire [1:0] _GEN_47; // @[fifo_queue.scala 96:50:@269.6]
  wire [79:0] _GEN_48; // @[fifo_queue.scala 96:50:@269.6]
  wire  _GEN_49; // @[fifo_queue.scala 96:50:@269.6]
  wire [1:0] _GEN_50; // @[fifo_queue.scala 75:29:@233.4]
  wire  _GEN_51; // @[fifo_queue.scala 75:29:@233.4]
  wire [1:0] _GEN_52; // @[fifo_queue.scala 75:29:@233.4]
  wire [79:0] _GEN_53; // @[fifo_queue.scala 75:29:@233.4]
  wire  _GEN_54; // @[fifo_queue.scala 75:29:@233.4]
  assign _T_133 = {entry_valid_vec_1,entry_valid_vec_0}; // @[fifo_queue.scala 43:43:@27.4]
  assign _T_134 = {entry_valid_vec_3,entry_valid_vec_2}; // @[fifo_queue.scala 43:43:@28.4]
  assign _T_135 = {_T_134,_T_133}; // @[fifo_queue.scala 43:43:@29.4]
  assign _T_136 = ~ _T_135; // @[fifo_queue.scala 43:50:@30.4]
  assign _T_143 = ~ _T_136; // @[fifo_queue.scala 44:56:@37.4]
  assign _T_146 = ~ io_is_full_out; // @[fifo_queue.scala 49:42:@40.4]
  assign _T_147 = io_issue_ack_in & io_is_full_out; // @[fifo_queue.scala 49:77:@41.4]
  assign _T_149 = 2'h0 == read_ptr; // @[fifo_queue.scala 49:107:@42.4]
  assign _T_150 = _T_147 & _T_149; // @[fifo_queue.scala 49:94:@43.4]
  assign _T_151 = _T_146 | _T_150; // @[fifo_queue.scala 49:58:@44.4]
  assign _T_152 = ~ issue_ack_out_reg; // @[fifo_queue.scala 49:124:@45.4]
  assign _T_153 = _T_151 & _T_152; // @[fifo_queue.scala 49:122:@46.4]
  assign _T_154 = _T_153 & io_request_valid_in; // @[fifo_queue.scala 49:143:@47.4]
  assign _T_156 = 2'h0 == write_ptr; // @[fifo_queue.scala 49:178:@48.4]
  assign write_qualified_0 = _T_154 & _T_156; // @[fifo_queue.scala 49:165:@49.4]
  assign _T_158 = ~ io_is_empty_out; // @[fifo_queue.scala 50:40:@51.4]
  assign _T_159 = _T_158 & io_issue_ack_in; // @[fifo_queue.scala 50:57:@52.4]
  assign _T_160 = _T_159 & entry_valid_vec_0; // @[fifo_queue.scala 50:75:@53.4]
  assign read_qualified_0 = _T_160 & _T_149; // @[fifo_queue.scala 50:98:@55.4]
  assign _T_169 = write_qualified_0 & read_qualified_0; // @[fifo_queue.scala 56:59:@65.6]
  assign _GEN_0 = write_qualified_0 ? io_request_in : entry_vec_0; // @[fifo_queue.scala 63:75:@78.10]
  assign _GEN_1 = write_qualified_0 ? 1'h1 : entry_valid_vec_0; // @[fifo_queue.scala 63:75:@78.10]
  assign _GEN_2 = read_qualified_0 ? 80'h0 : _GEN_0; // @[fifo_queue.scala 60:67:@72.8]
  assign _GEN_3 = read_qualified_0 ? 1'h0 : _GEN_1; // @[fifo_queue.scala 60:67:@72.8]
  assign _GEN_4 = _T_169 ? io_request_in : _GEN_2; // @[fifo_queue.scala 56:90:@66.6]
  assign _GEN_5 = _T_169 ? 1'h1 : _GEN_3; // @[fifo_queue.scala 56:90:@66.6]
  assign _GEN_6 = reset ? 80'h0 : _GEN_4; // @[fifo_queue.scala 52:37:@58.4]
  assign _GEN_7 = reset ? 1'h0 : _GEN_5; // @[fifo_queue.scala 52:37:@58.4]
  assign _T_179 = 2'h1 == read_ptr; // @[fifo_queue.scala 49:107:@90.4]
  assign _T_180 = _T_147 & _T_179; // @[fifo_queue.scala 49:94:@91.4]
  assign _T_181 = _T_146 | _T_180; // @[fifo_queue.scala 49:58:@92.4]
  assign _T_183 = _T_181 & _T_152; // @[fifo_queue.scala 49:122:@94.4]
  assign _T_184 = _T_183 & io_request_valid_in; // @[fifo_queue.scala 49:143:@95.4]
  assign _T_186 = 2'h1 == write_ptr; // @[fifo_queue.scala 49:178:@96.4]
  assign write_qualified_1 = _T_184 & _T_186; // @[fifo_queue.scala 49:165:@97.4]
  assign _T_190 = _T_159 & entry_valid_vec_1; // @[fifo_queue.scala 50:75:@101.4]
  assign read_qualified_1 = _T_190 & _T_179; // @[fifo_queue.scala 50:98:@103.4]
  assign _T_199 = write_qualified_1 & read_qualified_1; // @[fifo_queue.scala 56:59:@113.6]
  assign _GEN_8 = write_qualified_1 ? io_request_in : entry_vec_1; // @[fifo_queue.scala 63:75:@126.10]
  assign _GEN_9 = write_qualified_1 ? 1'h1 : entry_valid_vec_1; // @[fifo_queue.scala 63:75:@126.10]
  assign _GEN_10 = read_qualified_1 ? 80'h0 : _GEN_8; // @[fifo_queue.scala 60:67:@120.8]
  assign _GEN_11 = read_qualified_1 ? 1'h0 : _GEN_9; // @[fifo_queue.scala 60:67:@120.8]
  assign _GEN_12 = _T_199 ? io_request_in : _GEN_10; // @[fifo_queue.scala 56:90:@114.6]
  assign _GEN_13 = _T_199 ? 1'h1 : _GEN_11; // @[fifo_queue.scala 56:90:@114.6]
  assign _GEN_14 = reset ? 80'h0 : _GEN_12; // @[fifo_queue.scala 52:37:@106.4]
  assign _GEN_15 = reset ? 1'h0 : _GEN_13; // @[fifo_queue.scala 52:37:@106.4]
  assign _T_209 = 2'h2 == read_ptr; // @[fifo_queue.scala 49:107:@138.4]
  assign _T_210 = _T_147 & _T_209; // @[fifo_queue.scala 49:94:@139.4]
  assign _T_211 = _T_146 | _T_210; // @[fifo_queue.scala 49:58:@140.4]
  assign _T_213 = _T_211 & _T_152; // @[fifo_queue.scala 49:122:@142.4]
  assign _T_214 = _T_213 & io_request_valid_in; // @[fifo_queue.scala 49:143:@143.4]
  assign _T_216 = 2'h2 == write_ptr; // @[fifo_queue.scala 49:178:@144.4]
  assign write_qualified_2 = _T_214 & _T_216; // @[fifo_queue.scala 49:165:@145.4]
  assign _T_220 = _T_159 & entry_valid_vec_2; // @[fifo_queue.scala 50:75:@149.4]
  assign read_qualified_2 = _T_220 & _T_209; // @[fifo_queue.scala 50:98:@151.4]
  assign _T_229 = write_qualified_2 & read_qualified_2; // @[fifo_queue.scala 56:59:@161.6]
  assign _GEN_16 = write_qualified_2 ? io_request_in : entry_vec_2; // @[fifo_queue.scala 63:75:@174.10]
  assign _GEN_17 = write_qualified_2 ? 1'h1 : entry_valid_vec_2; // @[fifo_queue.scala 63:75:@174.10]
  assign _GEN_18 = read_qualified_2 ? 80'h0 : _GEN_16; // @[fifo_queue.scala 60:67:@168.8]
  assign _GEN_19 = read_qualified_2 ? 1'h0 : _GEN_17; // @[fifo_queue.scala 60:67:@168.8]
  assign _GEN_20 = _T_229 ? io_request_in : _GEN_18; // @[fifo_queue.scala 56:90:@162.6]
  assign _GEN_21 = _T_229 ? 1'h1 : _GEN_19; // @[fifo_queue.scala 56:90:@162.6]
  assign _GEN_22 = reset ? 80'h0 : _GEN_20; // @[fifo_queue.scala 52:37:@154.4]
  assign _GEN_23 = reset ? 1'h0 : _GEN_21; // @[fifo_queue.scala 52:37:@154.4]
  assign _T_239 = 2'h3 == read_ptr; // @[fifo_queue.scala 49:107:@186.4]
  assign _T_240 = _T_147 & _T_239; // @[fifo_queue.scala 49:94:@187.4]
  assign _T_241 = _T_146 | _T_240; // @[fifo_queue.scala 49:58:@188.4]
  assign _T_243 = _T_241 & _T_152; // @[fifo_queue.scala 49:122:@190.4]
  assign _T_244 = _T_243 & io_request_valid_in; // @[fifo_queue.scala 49:143:@191.4]
  assign _T_246 = 2'h3 == write_ptr; // @[fifo_queue.scala 49:178:@192.4]
  assign write_qualified_3 = _T_244 & _T_246; // @[fifo_queue.scala 49:165:@193.4]
  assign _T_250 = _T_159 & entry_valid_vec_3; // @[fifo_queue.scala 50:75:@197.4]
  assign read_qualified_3 = _T_250 & _T_239; // @[fifo_queue.scala 50:98:@199.4]
  assign _T_259 = write_qualified_3 & read_qualified_3; // @[fifo_queue.scala 56:59:@209.6]
  assign _GEN_24 = write_qualified_3 ? io_request_in : entry_vec_3; // @[fifo_queue.scala 63:75:@222.10]
  assign _GEN_25 = write_qualified_3 ? 1'h1 : entry_valid_vec_3; // @[fifo_queue.scala 63:75:@222.10]
  assign _GEN_26 = read_qualified_3 ? 80'h0 : _GEN_24; // @[fifo_queue.scala 60:67:@216.8]
  assign _GEN_27 = read_qualified_3 ? 1'h0 : _GEN_25; // @[fifo_queue.scala 60:67:@216.8]
  assign _GEN_28 = _T_259 ? io_request_in : _GEN_26; // @[fifo_queue.scala 56:90:@210.6]
  assign _GEN_29 = _T_259 ? 1'h1 : _GEN_27; // @[fifo_queue.scala 56:90:@210.6]
  assign _GEN_30 = reset ? 80'h0 : _GEN_28; // @[fifo_queue.scala 52:37:@202.4]
  assign _GEN_31 = reset ? 1'h0 : _GEN_29; // @[fifo_queue.scala 52:37:@202.4]
  assign _T_272 = {write_qualified_1,write_qualified_0}; // @[fifo_queue.scala 82:39:@241.6]
  assign _T_273 = {write_qualified_3,write_qualified_2}; // @[fifo_queue.scala 82:39:@242.6]
  assign _T_274 = {_T_273,_T_272}; // @[fifo_queue.scala 82:39:@243.6]
  assign _T_276 = _T_274 != 4'h0; // @[fifo_queue.scala 82:46:@244.6]
  assign _T_280 = 2'h2 - 2'h1; // @[fifo_queue.scala 84:77:@246.8]
  assign _T_281 = $unsigned(_T_280); // @[fifo_queue.scala 84:77:@247.8]
  assign _T_282 = _T_281[1:0]; // @[fifo_queue.scala 84:77:@248.8]
  assign _T_283 = 4'h1 << _T_282; // @[fifo_queue.scala 84:49:@249.8]
  assign _GEN_55 = {{2'd0}, write_ptr}; // @[fifo_queue.scala 84:41:@250.8]
  assign _T_284 = _GEN_55 == _T_283; // @[fifo_queue.scala 84:41:@250.8]
  assign _T_287 = write_ptr + 2'h1; // @[fifo_queue.scala 87:56:@255.10]
  assign _T_288 = _T_287[1:0]; // @[fifo_queue.scala 87:56:@256.10]
  assign _GEN_32 = _T_284 ? 2'h0 : _T_288; // @[fifo_queue.scala 84:85:@251.8]
  assign _GEN_33 = _T_276 ? _GEN_32 : write_ptr; // @[fifo_queue.scala 82:51:@245.6]
  assign _T_291 = {read_qualified_1,read_qualified_0}; // @[fifo_queue.scala 96:38:@265.6]
  assign _T_292 = {read_qualified_3,read_qualified_2}; // @[fifo_queue.scala 96:38:@266.6]
  assign _T_293 = {_T_292,_T_291}; // @[fifo_queue.scala 96:38:@267.6]
  assign _T_295 = _T_293 != 4'h0; // @[fifo_queue.scala 96:45:@268.6]
  assign _GEN_56 = {{2'd0}, read_ptr}; // @[fifo_queue.scala 97:40:@274.8]
  assign _T_303 = _GEN_56 == _T_283; // @[fifo_queue.scala 97:40:@274.8]
  assign _T_306 = read_ptr + 2'h1; // @[fifo_queue.scala 100:54:@279.10]
  assign _T_307 = _T_306[1:0]; // @[fifo_queue.scala 100:54:@280.10]
  assign _GEN_35 = _T_303 ? 2'h0 : _T_307; // @[fifo_queue.scala 97:84:@275.8]
  assign _GEN_37 = 2'h1 == read_ptr ? entry_valid_vec_1 : entry_valid_vec_0; // @[fifo_queue.scala 104:56:@287.8]
  assign _GEN_38 = 2'h2 == read_ptr ? entry_valid_vec_2 : _GEN_37; // @[fifo_queue.scala 104:56:@287.8]
  assign _GEN_39 = 2'h3 == read_ptr ? entry_valid_vec_3 : _GEN_38; // @[fifo_queue.scala 104:56:@287.8]
  assign _GEN_41 = 2'h1 == read_ptr ? entry_vec_1 : entry_vec_0; // @[fifo_queue.scala 106:41:@290.10]
  assign _GEN_42 = 2'h2 == read_ptr ? entry_vec_2 : _GEN_41; // @[fifo_queue.scala 106:41:@290.10]
  assign _GEN_43 = 2'h3 == read_ptr ? entry_vec_3 : _GEN_42; // @[fifo_queue.scala 106:41:@290.10]
  assign _GEN_45 = _GEN_39 ? _GEN_43 : 80'h0; // @[fifo_queue.scala 104:64:@288.8]
  assign _GEN_47 = _T_295 ? _GEN_35 : read_ptr; // @[fifo_queue.scala 96:50:@269.6]
  assign _GEN_48 = _T_295 ? 80'h0 : _GEN_45; // @[fifo_queue.scala 96:50:@269.6]
  assign _GEN_49 = _T_295 ? 1'h0 : _GEN_39; // @[fifo_queue.scala 96:50:@269.6]
  assign _GEN_50 = reset ? 2'h0 : _GEN_33; // @[fifo_queue.scala 75:29:@233.4]
  assign _GEN_51 = reset ? 1'h0 : _T_276; // @[fifo_queue.scala 75:29:@233.4]
  assign _GEN_52 = reset ? 2'h0 : _GEN_47; // @[fifo_queue.scala 75:29:@233.4]
  assign _GEN_53 = reset ? 80'h0 : _GEN_48; // @[fifo_queue.scala 75:29:@233.4]
  assign _GEN_54 = reset ? 1'h0 : _GEN_49; // @[fifo_queue.scala 75:29:@233.4]
  assign io_is_empty_out = _T_143 == 4'h0; // @[fifo_queue.scala 44:25:@39.4]
  assign io_is_full_out = _T_136 == 4'h0; // @[fifo_queue.scala 43:24:@32.4]
  assign io_issue_ack_out = issue_ack_out_reg; // @[fifo_queue.scala 115:26:@299.4]
  assign io_request_out = request_out_reg; // @[fifo_queue.scala 116:24:@300.4]
  assign io_request_valid_out = request_valid_out_reg; // @[fifo_queue.scala 117:30:@301.4]
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