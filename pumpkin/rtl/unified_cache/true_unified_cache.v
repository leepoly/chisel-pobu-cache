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
module fifo_queue_2( // @[:@603.2]
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
  reg  issue_ack_out_reg; // @[fifo_queue.scala 26:40:@608.4]
  reg [31:0] _RAND_0;
  reg [80:0] request_out_reg; // @[fifo_queue.scala 27:38:@609.4]
  reg [95:0] _RAND_1;
  reg  request_valid_out_reg; // @[fifo_queue.scala 28:44:@610.4]
  reg [31:0] _RAND_2;
  reg  write_ptr; // @[fifo_queue.scala 36:32:@613.4]
  reg [31:0] _RAND_3;
  reg  read_ptr; // @[fifo_queue.scala 37:31:@614.4]
  reg [31:0] _RAND_4;
  reg [80:0] entry_vec_0; // @[fifo_queue.scala 39:32:@618.4]
  reg [95:0] _RAND_5;
  reg [80:0] entry_vec_1; // @[fifo_queue.scala 39:32:@618.4]
  reg [95:0] _RAND_6;
  reg  entry_valid_vec_0; // @[fifo_queue.scala 40:38:@622.4]
  reg [31:0] _RAND_7;
  reg  entry_valid_vec_1; // @[fifo_queue.scala 40:38:@622.4]
  reg [31:0] _RAND_8;
  wire [1:0] _T_101; // @[fifo_queue.scala 43:43:@623.4]
  wire [1:0] _T_102; // @[fifo_queue.scala 43:50:@624.4]
  wire [1:0] _T_107; // @[fifo_queue.scala 44:56:@629.4]
  wire  _T_110; // @[fifo_queue.scala 49:42:@632.4]
  wire  _T_111; // @[fifo_queue.scala 49:77:@633.4]
  wire  _T_113; // @[fifo_queue.scala 49:107:@634.4]
  wire  _T_114; // @[fifo_queue.scala 49:94:@635.4]
  wire  _T_115; // @[fifo_queue.scala 49:58:@636.4]
  wire  _T_116; // @[fifo_queue.scala 49:124:@637.4]
  wire  _T_117; // @[fifo_queue.scala 49:122:@638.4]
  wire  _T_118; // @[fifo_queue.scala 49:143:@639.4]
  wire  _T_120; // @[fifo_queue.scala 49:178:@640.4]
  wire  write_qualified_0; // @[fifo_queue.scala 49:165:@641.4]
  wire  _T_122; // @[fifo_queue.scala 50:40:@643.4]
  wire  _T_123; // @[fifo_queue.scala 50:57:@644.4]
  wire  _T_124; // @[fifo_queue.scala 50:75:@645.4]
  wire  read_qualified_0; // @[fifo_queue.scala 50:98:@647.4]
  wire  _T_133; // @[fifo_queue.scala 56:59:@657.6]
  wire [80:0] _GEN_0; // @[fifo_queue.scala 63:75:@670.10]
  wire  _GEN_1; // @[fifo_queue.scala 63:75:@670.10]
  wire [80:0] _GEN_2; // @[fifo_queue.scala 60:67:@664.8]
  wire  _GEN_3; // @[fifo_queue.scala 60:67:@664.8]
  wire [80:0] _GEN_4; // @[fifo_queue.scala 56:90:@658.6]
  wire  _GEN_5; // @[fifo_queue.scala 56:90:@658.6]
  wire [80:0] _GEN_6; // @[fifo_queue.scala 52:37:@650.4]
  wire  _GEN_7; // @[fifo_queue.scala 52:37:@650.4]
  wire  _T_144; // @[fifo_queue.scala 49:94:@683.4]
  wire  _T_145; // @[fifo_queue.scala 49:58:@684.4]
  wire  _T_147; // @[fifo_queue.scala 49:122:@686.4]
  wire  _T_148; // @[fifo_queue.scala 49:143:@687.4]
  wire  write_qualified_1; // @[fifo_queue.scala 49:165:@689.4]
  wire  _T_154; // @[fifo_queue.scala 50:75:@693.4]
  wire  read_qualified_1; // @[fifo_queue.scala 50:98:@695.4]
  wire  _T_163; // @[fifo_queue.scala 56:59:@705.6]
  wire [80:0] _GEN_8; // @[fifo_queue.scala 63:75:@718.10]
  wire  _GEN_9; // @[fifo_queue.scala 63:75:@718.10]
  wire [80:0] _GEN_10; // @[fifo_queue.scala 60:67:@712.8]
  wire  _GEN_11; // @[fifo_queue.scala 60:67:@712.8]
  wire [80:0] _GEN_12; // @[fifo_queue.scala 56:90:@706.6]
  wire  _GEN_13; // @[fifo_queue.scala 56:90:@706.6]
  wire [80:0] _GEN_14; // @[fifo_queue.scala 52:37:@698.4]
  wire  _GEN_15; // @[fifo_queue.scala 52:37:@698.4]
  wire [1:0] _T_176; // @[fifo_queue.scala 82:39:@737.6]
  wire  _T_178; // @[fifo_queue.scala 82:46:@738.6]
  wire [1:0] _T_182; // @[fifo_queue.scala 84:77:@740.8]
  wire [1:0] _T_183; // @[fifo_queue.scala 84:77:@741.8]
  wire  _T_184; // @[fifo_queue.scala 84:77:@742.8]
  wire [1:0] _T_185; // @[fifo_queue.scala 84:49:@743.8]
  wire [1:0] _GEN_35; // @[fifo_queue.scala 84:41:@744.8]
  wire  _T_186; // @[fifo_queue.scala 84:41:@744.8]
  wire [1:0] _T_189; // @[fifo_queue.scala 87:56:@749.10]
  wire  _T_190; // @[fifo_queue.scala 87:56:@750.10]
  wire  _GEN_16; // @[fifo_queue.scala 84:85:@745.8]
  wire  _GEN_17; // @[fifo_queue.scala 82:51:@739.6]
  wire [1:0] _T_193; // @[fifo_queue.scala 96:38:@759.6]
  wire  _T_195; // @[fifo_queue.scala 96:45:@760.6]
  wire [1:0] _GEN_36; // @[fifo_queue.scala 97:40:@766.8]
  wire  _T_203; // @[fifo_queue.scala 97:40:@766.8]
  wire [1:0] _T_206; // @[fifo_queue.scala 100:54:@771.10]
  wire  _T_207; // @[fifo_queue.scala 100:54:@772.10]
  wire  _GEN_19; // @[fifo_queue.scala 97:84:@767.8]
  wire  _GEN_21; // @[fifo_queue.scala 104:56:@779.8]
  wire [80:0] _GEN_23; // @[fifo_queue.scala 106:41:@782.10]
  wire [80:0] _GEN_25; // @[fifo_queue.scala 104:64:@780.8]
  wire  _GEN_27; // @[fifo_queue.scala 96:50:@761.6]
  wire [80:0] _GEN_28; // @[fifo_queue.scala 96:50:@761.6]
  wire  _GEN_29; // @[fifo_queue.scala 96:50:@761.6]
  wire  _GEN_30; // @[fifo_queue.scala 75:29:@729.4]
  wire  _GEN_31; // @[fifo_queue.scala 75:29:@729.4]
  wire  _GEN_32; // @[fifo_queue.scala 75:29:@729.4]
  wire [80:0] _GEN_33; // @[fifo_queue.scala 75:29:@729.4]
  wire  _GEN_34; // @[fifo_queue.scala 75:29:@729.4]
  assign _T_101 = {entry_valid_vec_1,entry_valid_vec_0}; // @[fifo_queue.scala 43:43:@623.4]
  assign _T_102 = ~ _T_101; // @[fifo_queue.scala 43:50:@624.4]
  assign _T_107 = ~ _T_102; // @[fifo_queue.scala 44:56:@629.4]
  assign _T_110 = ~ io_is_full_out; // @[fifo_queue.scala 49:42:@632.4]
  assign _T_111 = io_issue_ack_in & io_is_full_out; // @[fifo_queue.scala 49:77:@633.4]
  assign _T_113 = 1'h0 == read_ptr; // @[fifo_queue.scala 49:107:@634.4]
  assign _T_114 = _T_111 & _T_113; // @[fifo_queue.scala 49:94:@635.4]
  assign _T_115 = _T_110 | _T_114; // @[fifo_queue.scala 49:58:@636.4]
  assign _T_116 = ~ issue_ack_out_reg; // @[fifo_queue.scala 49:124:@637.4]
  assign _T_117 = _T_115 & _T_116; // @[fifo_queue.scala 49:122:@638.4]
  assign _T_118 = _T_117 & io_request_valid_in; // @[fifo_queue.scala 49:143:@639.4]
  assign _T_120 = 1'h0 == write_ptr; // @[fifo_queue.scala 49:178:@640.4]
  assign write_qualified_0 = _T_118 & _T_120; // @[fifo_queue.scala 49:165:@641.4]
  assign _T_122 = ~ io_is_empty_out; // @[fifo_queue.scala 50:40:@643.4]
  assign _T_123 = _T_122 & io_issue_ack_in; // @[fifo_queue.scala 50:57:@644.4]
  assign _T_124 = _T_123 & entry_valid_vec_0; // @[fifo_queue.scala 50:75:@645.4]
  assign read_qualified_0 = _T_124 & _T_113; // @[fifo_queue.scala 50:98:@647.4]
  assign _T_133 = write_qualified_0 & read_qualified_0; // @[fifo_queue.scala 56:59:@657.6]
  assign _GEN_0 = write_qualified_0 ? io_request_in : entry_vec_0; // @[fifo_queue.scala 63:75:@670.10]
  assign _GEN_1 = write_qualified_0 ? 1'h1 : entry_valid_vec_0; // @[fifo_queue.scala 63:75:@670.10]
  assign _GEN_2 = read_qualified_0 ? 81'h0 : _GEN_0; // @[fifo_queue.scala 60:67:@664.8]
  assign _GEN_3 = read_qualified_0 ? 1'h0 : _GEN_1; // @[fifo_queue.scala 60:67:@664.8]
  assign _GEN_4 = _T_133 ? io_request_in : _GEN_2; // @[fifo_queue.scala 56:90:@658.6]
  assign _GEN_5 = _T_133 ? 1'h1 : _GEN_3; // @[fifo_queue.scala 56:90:@658.6]
  assign _GEN_6 = reset ? 81'h0 : _GEN_4; // @[fifo_queue.scala 52:37:@650.4]
  assign _GEN_7 = reset ? 1'h0 : _GEN_5; // @[fifo_queue.scala 52:37:@650.4]
  assign _T_144 = _T_111 & read_ptr; // @[fifo_queue.scala 49:94:@683.4]
  assign _T_145 = _T_110 | _T_144; // @[fifo_queue.scala 49:58:@684.4]
  assign _T_147 = _T_145 & _T_116; // @[fifo_queue.scala 49:122:@686.4]
  assign _T_148 = _T_147 & io_request_valid_in; // @[fifo_queue.scala 49:143:@687.4]
  assign write_qualified_1 = _T_148 & write_ptr; // @[fifo_queue.scala 49:165:@689.4]
  assign _T_154 = _T_123 & entry_valid_vec_1; // @[fifo_queue.scala 50:75:@693.4]
  assign read_qualified_1 = _T_154 & read_ptr; // @[fifo_queue.scala 50:98:@695.4]
  assign _T_163 = write_qualified_1 & read_qualified_1; // @[fifo_queue.scala 56:59:@705.6]
  assign _GEN_8 = write_qualified_1 ? io_request_in : entry_vec_1; // @[fifo_queue.scala 63:75:@718.10]
  assign _GEN_9 = write_qualified_1 ? 1'h1 : entry_valid_vec_1; // @[fifo_queue.scala 63:75:@718.10]
  assign _GEN_10 = read_qualified_1 ? 81'h0 : _GEN_8; // @[fifo_queue.scala 60:67:@712.8]
  assign _GEN_11 = read_qualified_1 ? 1'h0 : _GEN_9; // @[fifo_queue.scala 60:67:@712.8]
  assign _GEN_12 = _T_163 ? io_request_in : _GEN_10; // @[fifo_queue.scala 56:90:@706.6]
  assign _GEN_13 = _T_163 ? 1'h1 : _GEN_11; // @[fifo_queue.scala 56:90:@706.6]
  assign _GEN_14 = reset ? 81'h0 : _GEN_12; // @[fifo_queue.scala 52:37:@698.4]
  assign _GEN_15 = reset ? 1'h0 : _GEN_13; // @[fifo_queue.scala 52:37:@698.4]
  assign _T_176 = {write_qualified_1,write_qualified_0}; // @[fifo_queue.scala 82:39:@737.6]
  assign _T_178 = _T_176 != 2'h0; // @[fifo_queue.scala 82:46:@738.6]
  assign _T_182 = 1'h1 - 1'h1; // @[fifo_queue.scala 84:77:@740.8]
  assign _T_183 = $unsigned(_T_182); // @[fifo_queue.scala 84:77:@741.8]
  assign _T_184 = _T_183[0:0]; // @[fifo_queue.scala 84:77:@742.8]
  assign _T_185 = 2'h1 << _T_184; // @[fifo_queue.scala 84:49:@743.8]
  assign _GEN_35 = {{1'd0}, write_ptr}; // @[fifo_queue.scala 84:41:@744.8]
  assign _T_186 = _GEN_35 == _T_185; // @[fifo_queue.scala 84:41:@744.8]
  assign _T_189 = write_ptr + 1'h1; // @[fifo_queue.scala 87:56:@749.10]
  assign _T_190 = _T_189[0:0]; // @[fifo_queue.scala 87:56:@750.10]
  assign _GEN_16 = _T_186 ? 1'h0 : _T_190; // @[fifo_queue.scala 84:85:@745.8]
  assign _GEN_17 = _T_178 ? _GEN_16 : write_ptr; // @[fifo_queue.scala 82:51:@739.6]
  assign _T_193 = {read_qualified_1,read_qualified_0}; // @[fifo_queue.scala 96:38:@759.6]
  assign _T_195 = _T_193 != 2'h0; // @[fifo_queue.scala 96:45:@760.6]
  assign _GEN_36 = {{1'd0}, read_ptr}; // @[fifo_queue.scala 97:40:@766.8]
  assign _T_203 = _GEN_36 == _T_185; // @[fifo_queue.scala 97:40:@766.8]
  assign _T_206 = read_ptr + 1'h1; // @[fifo_queue.scala 100:54:@771.10]
  assign _T_207 = _T_206[0:0]; // @[fifo_queue.scala 100:54:@772.10]
  assign _GEN_19 = _T_203 ? 1'h0 : _T_207; // @[fifo_queue.scala 97:84:@767.8]
  assign _GEN_21 = read_ptr ? entry_valid_vec_1 : entry_valid_vec_0; // @[fifo_queue.scala 104:56:@779.8]
  assign _GEN_23 = read_ptr ? entry_vec_1 : entry_vec_0; // @[fifo_queue.scala 106:41:@782.10]
  assign _GEN_25 = _GEN_21 ? _GEN_23 : 81'h0; // @[fifo_queue.scala 104:64:@780.8]
  assign _GEN_27 = _T_195 ? _GEN_19 : read_ptr; // @[fifo_queue.scala 96:50:@761.6]
  assign _GEN_28 = _T_195 ? 81'h0 : _GEN_25; // @[fifo_queue.scala 96:50:@761.6]
  assign _GEN_29 = _T_195 ? 1'h0 : _GEN_21; // @[fifo_queue.scala 96:50:@761.6]
  assign _GEN_30 = reset ? 1'h0 : _GEN_17; // @[fifo_queue.scala 75:29:@729.4]
  assign _GEN_31 = reset ? 1'h0 : _T_178; // @[fifo_queue.scala 75:29:@729.4]
  assign _GEN_32 = reset ? 1'h0 : _GEN_27; // @[fifo_queue.scala 75:29:@729.4]
  assign _GEN_33 = reset ? 81'h0 : _GEN_28; // @[fifo_queue.scala 75:29:@729.4]
  assign _GEN_34 = reset ? 1'h0 : _GEN_29; // @[fifo_queue.scala 75:29:@729.4]
  assign io_is_empty_out = _T_107 == 2'h0; // @[fifo_queue.scala 44:25:@631.4]
  assign io_is_full_out = _T_102 == 2'h0; // @[fifo_queue.scala 43:24:@626.4]
  assign io_issue_ack_out = issue_ack_out_reg; // @[fifo_queue.scala 115:26:@791.4]
  assign io_request_out = request_out_reg; // @[fifo_queue.scala 116:24:@792.4]
  assign io_request_valid_out = request_valid_out_reg; // @[fifo_queue.scala 117:30:@793.4]
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
module priority_arbiter( // @[:@987.2]
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
  wire  fifo_queue_clock; // @[priority_arbiter.scala 38:43:@1003.4]
  wire  fifo_queue_reset; // @[priority_arbiter.scala 38:43:@1003.4]
  wire  fifo_queue_io_is_empty_out; // @[priority_arbiter.scala 38:43:@1003.4]
  wire  fifo_queue_io_is_full_out; // @[priority_arbiter.scala 38:43:@1003.4]
  wire [80:0] fifo_queue_io_request_in; // @[priority_arbiter.scala 38:43:@1003.4]
  wire  fifo_queue_io_request_valid_in; // @[priority_arbiter.scala 38:43:@1003.4]
  wire  fifo_queue_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@1003.4]
  wire [80:0] fifo_queue_io_request_out; // @[priority_arbiter.scala 38:43:@1003.4]
  wire  fifo_queue_io_request_valid_out; // @[priority_arbiter.scala 38:43:@1003.4]
  wire  fifo_queue_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@1003.4]
  wire  fifo_queue_1_clock; // @[priority_arbiter.scala 38:43:@1021.4]
  wire  fifo_queue_1_reset; // @[priority_arbiter.scala 38:43:@1021.4]
  wire  fifo_queue_1_io_is_empty_out; // @[priority_arbiter.scala 38:43:@1021.4]
  wire  fifo_queue_1_io_is_full_out; // @[priority_arbiter.scala 38:43:@1021.4]
  wire [80:0] fifo_queue_1_io_request_in; // @[priority_arbiter.scala 38:43:@1021.4]
  wire  fifo_queue_1_io_request_valid_in; // @[priority_arbiter.scala 38:43:@1021.4]
  wire  fifo_queue_1_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@1021.4]
  wire [80:0] fifo_queue_1_io_request_out; // @[priority_arbiter.scala 38:43:@1021.4]
  wire  fifo_queue_1_io_request_valid_out; // @[priority_arbiter.scala 38:43:@1021.4]
  wire  fifo_queue_1_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@1021.4]
  reg [79:0] request_out_reg; // @[priority_arbiter.scala 22:38:@992.4]
  reg [95:0] _RAND_0;
  reg  request_valid_out_reg; // @[priority_arbiter.scala 23:44:@993.4]
  reg [31:0] _RAND_1;
  wire [79:0] request_packed_in_0; // @[priority_arbiter.scala 36:74:@1001.4]
  wire  _T_73; // @[priority_arbiter.scala 43:82:@1007.4]
  wire  request_critical_flatted_from_request_queue_0; // @[priority_arbiter.scala 47:107:@1013.4]
  wire [79:0] request_packed_from_request_queue_0; // @[priority_arbiter.scala 48:97:@1015.4]
  wire [79:0] request_packed_in_1; // @[priority_arbiter.scala 36:74:@1019.4]
  wire  _T_79; // @[priority_arbiter.scala 43:82:@1025.4]
  wire  request_critical_flatted_from_request_queue_1; // @[priority_arbiter.scala 47:107:@1031.4]
  wire [79:0] request_packed_from_request_queue_1; // @[priority_arbiter.scala 48:97:@1033.4]
  wire [1:0] _T_85; // @[priority_arbiter.scala 55:79:@1038.4]
  wire  request_queue_full_1; // @[priority_arbiter.scala 32:38:@999.4 priority_arbiter.scala 42:51:@1024.4]
  wire  request_queue_full_0; // @[priority_arbiter.scala 32:38:@999.4 priority_arbiter.scala 42:51:@1006.4]
  wire [1:0] _T_86; // @[priority_arbiter.scala 55:107:@1039.4]
  wire [1:0] request_critical_final; // @[priority_arbiter.scala 55:86:@1040.4]
  reg  last_send_index; // @[priority_arbiter.scala 56:38:@1042.4]
  reg [31:0] _RAND_2;
  wire  request_valid_flatted_from_request_queue_1; // @[priority_arbiter.scala 31:60:@998.4 priority_arbiter.scala 50:73:@1035.4]
  wire  request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 31:60:@998.4 priority_arbiter.scala 50:73:@1017.4]
  wire [1:0] _T_92; // @[priority_arbiter.scala 61:87:@1045.4]
  wire [1:0] _T_94; // @[priority_arbiter.scala 61:113:@1046.4]
  wire  _T_95; // @[priority_arbiter.scala 61:113:@1047.4]
  wire [1:0] _T_96; // @[priority_arbiter.scala 61:94:@1048.4]
  wire [1:0] _GEN_34; // @[priority_arbiter.scala 62:148:@1050.4]
  wire [2:0] _T_99; // @[priority_arbiter.scala 62:148:@1050.4]
  wire [2:0] _T_100; // @[priority_arbiter.scala 62:148:@1051.4]
  wire [1:0] _T_101; // @[priority_arbiter.scala 62:148:@1052.4]
  wire [2:0] _T_103; // @[priority_arbiter.scala 62:166:@1053.4]
  wire [2:0] _T_104; // @[priority_arbiter.scala 62:166:@1054.4]
  wire [1:0] _T_105; // @[priority_arbiter.scala 62:166:@1055.4]
  wire [4:0] _GEN_35; // @[priority_arbiter.scala 62:130:@1056.4]
  wire [4:0] _T_106; // @[priority_arbiter.scala 62:130:@1056.4]
  wire [4:0] _GEN_36; // @[priority_arbiter.scala 61:120:@1057.4]
  wire [4:0] _T_107; // @[priority_arbiter.scala 61:120:@1057.4]
  wire [1:0] _T_111; // @[priority_arbiter.scala 63:72:@1061.4]
  wire [4:0] _GEN_38; // @[priority_arbiter.scala 64:108:@1068.4]
  wire [4:0] _T_120; // @[priority_arbiter.scala 64:108:@1068.4]
  wire [4:0] _GEN_39; // @[priority_arbiter.scala 63:98:@1069.4]
  wire [4:0] _T_121; // @[priority_arbiter.scala 63:98:@1069.4]
  reg  valid_sel; // @[priority_arbiter.scala 67:32:@1071.4]
  reg [31:0] _RAND_3;
  wire [1:0] request_valid_flatted_shift_left; // @[priority_arbiter.scala 59:52:@1043.4 priority_arbiter.scala 61:42:@1058.4]
  wire  _T_125; // @[priority_arbiter.scala 70:55:@1073.4]
  wire [1:0] _T_130; // @[priority_arbiter.scala 71:68:@1077.6]
  wire  _T_131; // @[priority_arbiter.scala 71:68:@1078.6]
  wire [1:0] _GEN_40; // @[priority_arbiter.scala 72:89:@1085.8]
  wire [1:0] _GEN_1; // @[priority_arbiter.scala 70:75:@1074.4]
  wire  _T_150; // @[priority_arbiter.scala 70:55:@1098.4]
  wire  _T_153; // @[priority_arbiter.scala 71:47:@1101.6]
  wire [1:0] _T_155; // @[priority_arbiter.scala 71:68:@1102.6]
  wire  _T_156; // @[priority_arbiter.scala 71:68:@1103.6]
  wire [1:0] _GEN_41; // @[priority_arbiter.scala 72:89:@1110.8]
  wire [1:0] _GEN_3; // @[priority_arbiter.scala 70:75:@1099.4]
  reg  critical_sel; // @[priority_arbiter.scala 79:35:@1123.4]
  reg [31:0] _RAND_4;
  wire [1:0] request_critical_flatted_shift_left; // @[priority_arbiter.scala 60:55:@1044.4 priority_arbiter.scala 63:45:@1070.4]
  wire  _T_178; // @[priority_arbiter.scala 82:58:@1125.4]
  wire  _T_180; // @[priority_arbiter.scala 82:80:@1127.4]
  wire [1:0] _GEN_5; // @[priority_arbiter.scala 82:138:@1128.4]
  wire  _T_205; // @[priority_arbiter.scala 82:58:@1152.4]
  wire  _T_207; // @[priority_arbiter.scala 82:80:@1154.4]
  wire [1:0] _GEN_7; // @[priority_arbiter.scala 82:138:@1155.4]
  wire  _T_263; // @[priority_arbiter.scala 109:59:@1209.4]
  wire  _T_278; // @[priority_arbiter.scala 122:40:@1234.6]
  wire  _T_279; // @[priority_arbiter.scala 122:68:@1235.6]
  wire  _T_280; // @[priority_arbiter.scala 122:65:@1236.6]
  wire [1:0] _T_282; // @[priority_arbiter.scala 123:46:@1239.8]
  wire  _T_283; // @[priority_arbiter.scala 123:46:@1240.8]
  wire  _GEN_15; // @[priority_arbiter.scala 123:61:@1241.8]
  wire  _T_285; // @[priority_arbiter.scala 123:61:@1241.8]
  wire  _T_286; // @[priority_arbiter.scala 124:50:@1242.8]
  wire  _T_287; // @[priority_arbiter.scala 124:70:@1243.8]
  wire  _T_289; // @[priority_arbiter.scala 124:35:@1244.8]
  wire  _T_291; // @[priority_arbiter.scala 124:96:@1246.8]
  wire  _T_292; // @[priority_arbiter.scala 123:118:@1247.8]
  wire [79:0] _GEN_17; // @[priority_arbiter.scala 125:41:@1250.10]
  wire  _T_297; // @[priority_arbiter.scala 129:47:@1255.10]
  wire  _T_298; // @[priority_arbiter.scala 129:67:@1256.10]
  wire  _T_300; // @[priority_arbiter.scala 129:35:@1257.10]
  wire  _T_302; // @[priority_arbiter.scala 129:93:@1259.10]
  wire  _GEN_19; // @[priority_arbiter.scala 128:83:@1260.10]
  wire  _T_303; // @[priority_arbiter.scala 128:83:@1260.10]
  wire [79:0] _GEN_21; // @[priority_arbiter.scala 130:41:@1263.12]
  wire [79:0] _GEN_22; // @[priority_arbiter.scala 129:130:@1262.10]
  wire  _GEN_24; // @[priority_arbiter.scala 129:130:@1262.10]
  wire [79:0] _GEN_25; // @[priority_arbiter.scala 124:133:@1249.8]
  wire  _GEN_26; // @[priority_arbiter.scala 124:133:@1249.8]
  wire  _GEN_27; // @[priority_arbiter.scala 124:133:@1249.8]
  wire [79:0] _GEN_28; // @[priority_arbiter.scala 122:101:@1238.6]
  wire  _GEN_29; // @[priority_arbiter.scala 122:101:@1238.6]
  wire  _GEN_30; // @[priority_arbiter.scala 122:101:@1238.6]
  wire [79:0] _GEN_31; // @[priority_arbiter.scala 118:29:@1228.4]
  wire  _GEN_32; // @[priority_arbiter.scala 118:29:@1228.4]
  wire  _GEN_33; // @[priority_arbiter.scala 118:29:@1228.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter.scala 24:37:@994.4 priority_arbiter.scala 45:50:@1030.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter.scala 24:37:@994.4 priority_arbiter.scala 45:50:@1012.4]
  fifo_queue_2 fifo_queue ( // @[priority_arbiter.scala 38:43:@1003.4]
    .clock(fifo_queue_clock),
    .reset(fifo_queue_reset),
    .io_is_empty_out(fifo_queue_io_is_empty_out),
    .io_is_full_out(fifo_queue_io_is_full_out),
    .io_request_in(fifo_queue_io_request_in),
    .io_request_valid_in(fifo_queue_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_io_issue_ack_out),
    .io_request_out(fifo_queue_io_request_out),
    .io_request_valid_out(fifo_queue_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_1 ( // @[priority_arbiter.scala 38:43:@1021.4]
    .clock(fifo_queue_1_clock),
    .reset(fifo_queue_1_reset),
    .io_is_empty_out(fifo_queue_1_io_is_empty_out),
    .io_is_full_out(fifo_queue_1_io_is_full_out),
    .io_request_in(fifo_queue_1_io_request_in),
    .io_request_valid_in(fifo_queue_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_1_io_issue_ack_out),
    .io_request_out(fifo_queue_1_io_request_out),
    .io_request_valid_out(fifo_queue_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_1_io_issue_ack_in)
  );
  assign request_packed_in_0 = io_request_flatted_in[79:0]; // @[priority_arbiter.scala 36:74:@1001.4]
  assign _T_73 = io_request_critical_flatted_in[0]; // @[priority_arbiter.scala 43:82:@1007.4]
  assign request_critical_flatted_from_request_queue_0 = fifo_queue_io_request_out[80]; // @[priority_arbiter.scala 47:107:@1013.4]
  assign request_packed_from_request_queue_0 = fifo_queue_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@1015.4]
  assign request_packed_in_1 = io_request_flatted_in[159:80]; // @[priority_arbiter.scala 36:74:@1019.4]
  assign _T_79 = io_request_critical_flatted_in[1]; // @[priority_arbiter.scala 43:82:@1025.4]
  assign request_critical_flatted_from_request_queue_1 = fifo_queue_1_io_request_out[80]; // @[priority_arbiter.scala 47:107:@1031.4]
  assign request_packed_from_request_queue_1 = fifo_queue_1_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@1033.4]
  assign _T_85 = {request_critical_flatted_from_request_queue_1,request_critical_flatted_from_request_queue_0}; // @[priority_arbiter.scala 55:79:@1038.4]
  assign request_queue_full_1 = fifo_queue_1_io_is_full_out; // @[priority_arbiter.scala 32:38:@999.4 priority_arbiter.scala 42:51:@1024.4]
  assign request_queue_full_0 = fifo_queue_io_is_full_out; // @[priority_arbiter.scala 32:38:@999.4 priority_arbiter.scala 42:51:@1006.4]
  assign _T_86 = {request_queue_full_1,request_queue_full_0}; // @[priority_arbiter.scala 55:107:@1039.4]
  assign request_critical_final = _T_85 | _T_86; // @[priority_arbiter.scala 55:86:@1040.4]
  assign request_valid_flatted_from_request_queue_1 = fifo_queue_1_io_request_valid_out; // @[priority_arbiter.scala 31:60:@998.4 priority_arbiter.scala 50:73:@1035.4]
  assign request_valid_flatted_from_request_queue_0 = fifo_queue_io_request_valid_out; // @[priority_arbiter.scala 31:60:@998.4 priority_arbiter.scala 50:73:@1017.4]
  assign _T_92 = {request_valid_flatted_from_request_queue_1,request_valid_flatted_from_request_queue_0}; // @[priority_arbiter.scala 61:87:@1045.4]
  assign _T_94 = last_send_index + 1'h1; // @[priority_arbiter.scala 61:113:@1046.4]
  assign _T_95 = _T_94[0:0]; // @[priority_arbiter.scala 61:113:@1047.4]
  assign _T_96 = _T_92 >> _T_95; // @[priority_arbiter.scala 61:94:@1048.4]
  assign _GEN_34 = {{1'd0}, last_send_index}; // @[priority_arbiter.scala 62:148:@1050.4]
  assign _T_99 = 2'h2 - _GEN_34; // @[priority_arbiter.scala 62:148:@1050.4]
  assign _T_100 = $unsigned(_T_99); // @[priority_arbiter.scala 62:148:@1051.4]
  assign _T_101 = _T_100[1:0]; // @[priority_arbiter.scala 62:148:@1052.4]
  assign _T_103 = _T_101 - 2'h1; // @[priority_arbiter.scala 62:166:@1053.4]
  assign _T_104 = $unsigned(_T_103); // @[priority_arbiter.scala 62:166:@1054.4]
  assign _T_105 = _T_104[1:0]; // @[priority_arbiter.scala 62:166:@1055.4]
  assign _GEN_35 = {{3'd0}, _T_92}; // @[priority_arbiter.scala 62:130:@1056.4]
  assign _T_106 = _GEN_35 << _T_105; // @[priority_arbiter.scala 62:130:@1056.4]
  assign _GEN_36 = {{3'd0}, _T_96}; // @[priority_arbiter.scala 61:120:@1057.4]
  assign _T_107 = _GEN_36 | _T_106; // @[priority_arbiter.scala 61:120:@1057.4]
  assign _T_111 = request_critical_final >> _T_95; // @[priority_arbiter.scala 63:72:@1061.4]
  assign _GEN_38 = {{3'd0}, request_critical_final}; // @[priority_arbiter.scala 64:108:@1068.4]
  assign _T_120 = _GEN_38 << _T_105; // @[priority_arbiter.scala 64:108:@1068.4]
  assign _GEN_39 = {{3'd0}, _T_111}; // @[priority_arbiter.scala 63:98:@1069.4]
  assign _T_121 = _GEN_39 | _T_120; // @[priority_arbiter.scala 63:98:@1069.4]
  assign request_valid_flatted_shift_left = _T_107[1:0]; // @[priority_arbiter.scala 59:52:@1043.4 priority_arbiter.scala 61:42:@1058.4]
  assign _T_125 = request_valid_flatted_shift_left[1]; // @[priority_arbiter.scala 70:55:@1073.4]
  assign _T_130 = _T_95 + 1'h1; // @[priority_arbiter.scala 71:68:@1077.6]
  assign _T_131 = _T_130[0:0]; // @[priority_arbiter.scala 71:68:@1078.6]
  assign _GEN_40 = {{1'd0}, _T_131}; // @[priority_arbiter.scala 72:89:@1085.8]
  assign _GEN_1 = _T_125 ? _GEN_40 : 2'h0; // @[priority_arbiter.scala 70:75:@1074.4]
  assign _T_150 = request_valid_flatted_shift_left[0]; // @[priority_arbiter.scala 70:55:@1098.4]
  assign _T_153 = _GEN_34[0:0]; // @[priority_arbiter.scala 71:47:@1101.6]
  assign _T_155 = _T_153 + 1'h1; // @[priority_arbiter.scala 71:68:@1102.6]
  assign _T_156 = _T_155[0:0]; // @[priority_arbiter.scala 71:68:@1103.6]
  assign _GEN_41 = {{1'd0}, _T_156}; // @[priority_arbiter.scala 72:89:@1110.8]
  assign _GEN_3 = _T_150 ? _GEN_41 : _GEN_1; // @[priority_arbiter.scala 70:75:@1099.4]
  assign request_critical_flatted_shift_left = _T_121[1:0]; // @[priority_arbiter.scala 60:55:@1044.4 priority_arbiter.scala 63:45:@1070.4]
  assign _T_178 = request_critical_flatted_shift_left[1]; // @[priority_arbiter.scala 82:58:@1125.4]
  assign _T_180 = _T_178 & _T_125; // @[priority_arbiter.scala 82:80:@1127.4]
  assign _GEN_5 = _T_180 ? _GEN_40 : 2'h0; // @[priority_arbiter.scala 82:138:@1128.4]
  assign _T_205 = request_critical_flatted_shift_left[0]; // @[priority_arbiter.scala 82:58:@1152.4]
  assign _T_207 = _T_205 & _T_150; // @[priority_arbiter.scala 82:80:@1154.4]
  assign _GEN_7 = _T_207 ? _GEN_41 : _GEN_5; // @[priority_arbiter.scala 82:138:@1155.4]
  assign _T_263 = last_send_index == 1'h0; // @[priority_arbiter.scala 109:59:@1209.4]
  assign _T_278 = io_issue_ack_in & request_valid_out_reg; // @[priority_arbiter.scala 122:40:@1234.6]
  assign _T_279 = ~ request_valid_out_reg; // @[priority_arbiter.scala 122:68:@1235.6]
  assign _T_280 = _T_278 | _T_279; // @[priority_arbiter.scala 122:65:@1236.6]
  assign _T_282 = request_critical_final >> critical_sel; // @[priority_arbiter.scala 123:46:@1239.8]
  assign _T_283 = _T_282[0]; // @[priority_arbiter.scala 123:46:@1240.8]
  assign _GEN_15 = critical_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 123:61:@1241.8]
  assign _T_285 = _T_283 & _GEN_15; // @[priority_arbiter.scala 123:61:@1241.8]
  assign _T_286 = critical_sel == last_send_index; // @[priority_arbiter.scala 124:50:@1242.8]
  assign _T_287 = _T_286 & request_valid_out_reg; // @[priority_arbiter.scala 124:70:@1243.8]
  assign _T_289 = _T_287 == 1'h0; // @[priority_arbiter.scala 124:35:@1244.8]
  assign _T_291 = _T_289 | _T_279; // @[priority_arbiter.scala 124:96:@1246.8]
  assign _T_292 = _T_285 & _T_291; // @[priority_arbiter.scala 123:118:@1247.8]
  assign _GEN_17 = critical_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter.scala 125:41:@1250.10]
  assign _T_297 = valid_sel == last_send_index; // @[priority_arbiter.scala 129:47:@1255.10]
  assign _T_298 = _T_297 & request_valid_out_reg; // @[priority_arbiter.scala 129:67:@1256.10]
  assign _T_300 = _T_298 == 1'h0; // @[priority_arbiter.scala 129:35:@1257.10]
  assign _T_302 = _T_300 | _T_279; // @[priority_arbiter.scala 129:93:@1259.10]
  assign _GEN_19 = valid_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 128:83:@1260.10]
  assign _T_303 = _GEN_19 & _T_302; // @[priority_arbiter.scala 128:83:@1260.10]
  assign _GEN_21 = valid_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter.scala 130:41:@1263.12]
  assign _GEN_22 = _T_303 ? _GEN_21 : 80'h0; // @[priority_arbiter.scala 129:130:@1262.10]
  assign _GEN_24 = _T_303 ? valid_sel : last_send_index; // @[priority_arbiter.scala 129:130:@1262.10]
  assign _GEN_25 = _T_292 ? _GEN_17 : _GEN_22; // @[priority_arbiter.scala 124:133:@1249.8]
  assign _GEN_26 = _T_292 ? 1'h1 : _T_303; // @[priority_arbiter.scala 124:133:@1249.8]
  assign _GEN_27 = _T_292 ? critical_sel : _GEN_24; // @[priority_arbiter.scala 124:133:@1249.8]
  assign _GEN_28 = _T_280 ? _GEN_25 : request_out_reg; // @[priority_arbiter.scala 122:101:@1238.6]
  assign _GEN_29 = _T_280 ? _GEN_26 : request_valid_out_reg; // @[priority_arbiter.scala 122:101:@1238.6]
  assign _GEN_30 = _T_280 ? _GEN_27 : last_send_index; // @[priority_arbiter.scala 122:101:@1238.6]
  assign _GEN_31 = reset ? 80'h0 : _GEN_28; // @[priority_arbiter.scala 118:29:@1228.4]
  assign _GEN_32 = reset ? 1'h0 : _GEN_29; // @[priority_arbiter.scala 118:29:@1228.4]
  assign _GEN_33 = reset ? 1'h0 : _GEN_30; // @[priority_arbiter.scala 118:29:@1228.4]
  assign issue_ack_out_vec_1 = fifo_queue_1_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@994.4 priority_arbiter.scala 45:50:@1030.4]
  assign issue_ack_out_vec_0 = fifo_queue_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@994.4 priority_arbiter.scala 45:50:@1012.4]
  assign io_issue_ack_out = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter.scala 147:26:@1281.4]
  assign io_request_out = request_out_reg; // @[priority_arbiter.scala 145:24:@1278.4]
  assign io_request_valid_out = request_valid_out_reg; // @[priority_arbiter.scala 146:30:@1279.4]
  assign fifo_queue_clock = clock; // @[:@1004.4]
  assign fifo_queue_reset = reset; // @[:@1005.4]
  assign fifo_queue_io_request_in = {_T_73,request_packed_in_0}; // @[priority_arbiter.scala 43:45:@1009.4]
  assign fifo_queue_io_request_valid_in = io_request_valid_flatted_in[0]; // @[priority_arbiter.scala 44:51:@1011.4]
  assign fifo_queue_io_issue_ack_in = io_issue_ack_in & _T_263; // @[priority_arbiter.scala 51:47:@1018.4]
  assign fifo_queue_1_clock = clock; // @[:@1022.4]
  assign fifo_queue_1_reset = reset; // @[:@1023.4]
  assign fifo_queue_1_io_request_in = {_T_79,request_packed_in_1}; // @[priority_arbiter.scala 43:45:@1027.4]
  assign fifo_queue_1_io_request_valid_in = io_request_valid_flatted_in[1]; // @[priority_arbiter.scala 44:51:@1029.4]
  assign fifo_queue_1_io_issue_ack_in = io_issue_ack_in & last_send_index; // @[priority_arbiter.scala 51:47:@1036.4]
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
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  valid_sel = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  critical_sel = _RAND_4[0:0];
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
          if (_T_292) begin
            if (critical_sel) begin
              request_out_reg <= request_packed_from_request_queue_1;
            end else begin
              request_out_reg <= request_packed_from_request_queue_0;
            end
          end else begin
            if (_T_303) begin
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
          if (_T_292) begin
            request_valid_out_reg <= 1'h1;
          end else begin
            request_valid_out_reg <= _T_303;
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
          if (_T_292) begin
            last_send_index <= critical_sel;
          end else begin
            if (_T_303) begin
              last_send_index <= valid_sel;
            end
          end
        end
      end
    end
    if (reset) begin
      valid_sel <= 1'h0;
    end else begin
      valid_sel <= _GEN_3[0];
    end
    if (reset) begin
      critical_sel <= 1'h0;
    end else begin
      critical_sel <= _GEN_7[0];
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
  wire  priority_arbiter_clock; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire  priority_arbiter_reset; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [159:0] priority_arbiter_io_request_flatted_in; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [1:0] priority_arbiter_io_request_valid_flatted_in; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [1:0] priority_arbiter_io_request_critical_flatted_in; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [1:0] priority_arbiter_io_issue_ack_out; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire [79:0] priority_arbiter_io_request_out; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire  priority_arbiter_io_request_valid_out; // @[unified_cache_bank.scala 48:36:@1288.4]
  wire  priority_arbiter_io_issue_ack_in; // @[unified_cache_bank.scala 48:36:@1288.4]
  priority_arbiter priority_arbiter ( // @[unified_cache_bank.scala 48:36:@1288.4]
    .clock(priority_arbiter_clock),
    .reset(priority_arbiter_reset),
    .io_request_flatted_in(priority_arbiter_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_io_request_valid_flatted_in),
    .io_request_critical_flatted_in(priority_arbiter_io_request_critical_flatted_in),
    .io_issue_ack_out(priority_arbiter_io_issue_ack_out),
    .io_request_out(priority_arbiter_io_request_out),
    .io_request_valid_out(priority_arbiter_io_request_valid_out),
    .io_issue_ack_in(priority_arbiter_io_issue_ack_in)
  );
  assign io_input_request_ack_out = priority_arbiter_io_issue_ack_out; // @[unified_cache_bank.scala 54:34:@1294.4]
  assign io_fetch_ack_out = io_return_request_ack_in; // @[unified_cache_bank.scala 65:26:@1301.4]
  assign io_miss_request_out = priority_arbiter_io_request_out; // @[unified_cache_bank.scala 55:29:@1295.4]
  assign io_miss_request_valid_out = priority_arbiter_io_request_valid_out; // @[unified_cache_bank.scala 56:35:@1296.4]
  assign io_return_request_out = io_fetched_request_in; // @[unified_cache_bank.scala 63:31:@1299.4]
  assign io_return_request_valid_out = io_fetched_request_valid_in; // @[unified_cache_bank.scala 64:37:@1300.4]
  assign priority_arbiter_clock = clock; // @[:@1289.4]
  assign priority_arbiter_reset = reset; // @[:@1290.4]
  assign priority_arbiter_io_request_flatted_in = io_input_request_flatted_in; // @[unified_cache_bank.scala 51:50:@1291.4]
  assign priority_arbiter_io_request_valid_flatted_in = io_input_request_valid_flatted_in; // @[unified_cache_bank.scala 52:56:@1292.4]
  assign priority_arbiter_io_request_critical_flatted_in = io_input_request_critical_flatted_in; // @[unified_cache_bank.scala 53:59:@1293.4]
  assign priority_arbiter_io_issue_ack_in = io_miss_request_ack_in; // @[unified_cache_bank.scala 57:44:@1297.4]
endmodule
module priority_arbiter_4( // @[:@4955.2]
  input          clock, // @[:@4956.4]
  input          reset, // @[:@4957.4]
  input  [639:0] io_request_flatted_in, // @[:@4958.4]
  input  [7:0]   io_request_valid_flatted_in, // @[:@4958.4]
  output [7:0]   io_issue_ack_out, // @[:@4958.4]
  output [79:0]  io_request_out, // @[:@4958.4]
  input          io_issue_ack_in // @[:@4958.4]
);
  wire  fifo_queue_clock; // @[priority_arbiter.scala 38:43:@4971.4]
  wire  fifo_queue_reset; // @[priority_arbiter.scala 38:43:@4971.4]
  wire  fifo_queue_io_is_empty_out; // @[priority_arbiter.scala 38:43:@4971.4]
  wire  fifo_queue_io_is_full_out; // @[priority_arbiter.scala 38:43:@4971.4]
  wire [80:0] fifo_queue_io_request_in; // @[priority_arbiter.scala 38:43:@4971.4]
  wire  fifo_queue_io_request_valid_in; // @[priority_arbiter.scala 38:43:@4971.4]
  wire  fifo_queue_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@4971.4]
  wire [80:0] fifo_queue_io_request_out; // @[priority_arbiter.scala 38:43:@4971.4]
  wire  fifo_queue_io_request_valid_out; // @[priority_arbiter.scala 38:43:@4971.4]
  wire  fifo_queue_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@4971.4]
  wire  fifo_queue_1_clock; // @[priority_arbiter.scala 38:43:@4989.4]
  wire  fifo_queue_1_reset; // @[priority_arbiter.scala 38:43:@4989.4]
  wire  fifo_queue_1_io_is_empty_out; // @[priority_arbiter.scala 38:43:@4989.4]
  wire  fifo_queue_1_io_is_full_out; // @[priority_arbiter.scala 38:43:@4989.4]
  wire [80:0] fifo_queue_1_io_request_in; // @[priority_arbiter.scala 38:43:@4989.4]
  wire  fifo_queue_1_io_request_valid_in; // @[priority_arbiter.scala 38:43:@4989.4]
  wire  fifo_queue_1_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@4989.4]
  wire [80:0] fifo_queue_1_io_request_out; // @[priority_arbiter.scala 38:43:@4989.4]
  wire  fifo_queue_1_io_request_valid_out; // @[priority_arbiter.scala 38:43:@4989.4]
  wire  fifo_queue_1_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@4989.4]
  wire  fifo_queue_2_clock; // @[priority_arbiter.scala 38:43:@5007.4]
  wire  fifo_queue_2_reset; // @[priority_arbiter.scala 38:43:@5007.4]
  wire  fifo_queue_2_io_is_empty_out; // @[priority_arbiter.scala 38:43:@5007.4]
  wire  fifo_queue_2_io_is_full_out; // @[priority_arbiter.scala 38:43:@5007.4]
  wire [80:0] fifo_queue_2_io_request_in; // @[priority_arbiter.scala 38:43:@5007.4]
  wire  fifo_queue_2_io_request_valid_in; // @[priority_arbiter.scala 38:43:@5007.4]
  wire  fifo_queue_2_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@5007.4]
  wire [80:0] fifo_queue_2_io_request_out; // @[priority_arbiter.scala 38:43:@5007.4]
  wire  fifo_queue_2_io_request_valid_out; // @[priority_arbiter.scala 38:43:@5007.4]
  wire  fifo_queue_2_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@5007.4]
  wire  fifo_queue_3_clock; // @[priority_arbiter.scala 38:43:@5025.4]
  wire  fifo_queue_3_reset; // @[priority_arbiter.scala 38:43:@5025.4]
  wire  fifo_queue_3_io_is_empty_out; // @[priority_arbiter.scala 38:43:@5025.4]
  wire  fifo_queue_3_io_is_full_out; // @[priority_arbiter.scala 38:43:@5025.4]
  wire [80:0] fifo_queue_3_io_request_in; // @[priority_arbiter.scala 38:43:@5025.4]
  wire  fifo_queue_3_io_request_valid_in; // @[priority_arbiter.scala 38:43:@5025.4]
  wire  fifo_queue_3_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@5025.4]
  wire [80:0] fifo_queue_3_io_request_out; // @[priority_arbiter.scala 38:43:@5025.4]
  wire  fifo_queue_3_io_request_valid_out; // @[priority_arbiter.scala 38:43:@5025.4]
  wire  fifo_queue_3_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@5025.4]
  wire  fifo_queue_4_clock; // @[priority_arbiter.scala 38:43:@5043.4]
  wire  fifo_queue_4_reset; // @[priority_arbiter.scala 38:43:@5043.4]
  wire  fifo_queue_4_io_is_empty_out; // @[priority_arbiter.scala 38:43:@5043.4]
  wire  fifo_queue_4_io_is_full_out; // @[priority_arbiter.scala 38:43:@5043.4]
  wire [80:0] fifo_queue_4_io_request_in; // @[priority_arbiter.scala 38:43:@5043.4]
  wire  fifo_queue_4_io_request_valid_in; // @[priority_arbiter.scala 38:43:@5043.4]
  wire  fifo_queue_4_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@5043.4]
  wire [80:0] fifo_queue_4_io_request_out; // @[priority_arbiter.scala 38:43:@5043.4]
  wire  fifo_queue_4_io_request_valid_out; // @[priority_arbiter.scala 38:43:@5043.4]
  wire  fifo_queue_4_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@5043.4]
  wire  fifo_queue_5_clock; // @[priority_arbiter.scala 38:43:@5061.4]
  wire  fifo_queue_5_reset; // @[priority_arbiter.scala 38:43:@5061.4]
  wire  fifo_queue_5_io_is_empty_out; // @[priority_arbiter.scala 38:43:@5061.4]
  wire  fifo_queue_5_io_is_full_out; // @[priority_arbiter.scala 38:43:@5061.4]
  wire [80:0] fifo_queue_5_io_request_in; // @[priority_arbiter.scala 38:43:@5061.4]
  wire  fifo_queue_5_io_request_valid_in; // @[priority_arbiter.scala 38:43:@5061.4]
  wire  fifo_queue_5_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@5061.4]
  wire [80:0] fifo_queue_5_io_request_out; // @[priority_arbiter.scala 38:43:@5061.4]
  wire  fifo_queue_5_io_request_valid_out; // @[priority_arbiter.scala 38:43:@5061.4]
  wire  fifo_queue_5_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@5061.4]
  wire  fifo_queue_6_clock; // @[priority_arbiter.scala 38:43:@5079.4]
  wire  fifo_queue_6_reset; // @[priority_arbiter.scala 38:43:@5079.4]
  wire  fifo_queue_6_io_is_empty_out; // @[priority_arbiter.scala 38:43:@5079.4]
  wire  fifo_queue_6_io_is_full_out; // @[priority_arbiter.scala 38:43:@5079.4]
  wire [80:0] fifo_queue_6_io_request_in; // @[priority_arbiter.scala 38:43:@5079.4]
  wire  fifo_queue_6_io_request_valid_in; // @[priority_arbiter.scala 38:43:@5079.4]
  wire  fifo_queue_6_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@5079.4]
  wire [80:0] fifo_queue_6_io_request_out; // @[priority_arbiter.scala 38:43:@5079.4]
  wire  fifo_queue_6_io_request_valid_out; // @[priority_arbiter.scala 38:43:@5079.4]
  wire  fifo_queue_6_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@5079.4]
  wire  fifo_queue_7_clock; // @[priority_arbiter.scala 38:43:@5097.4]
  wire  fifo_queue_7_reset; // @[priority_arbiter.scala 38:43:@5097.4]
  wire  fifo_queue_7_io_is_empty_out; // @[priority_arbiter.scala 38:43:@5097.4]
  wire  fifo_queue_7_io_is_full_out; // @[priority_arbiter.scala 38:43:@5097.4]
  wire [80:0] fifo_queue_7_io_request_in; // @[priority_arbiter.scala 38:43:@5097.4]
  wire  fifo_queue_7_io_request_valid_in; // @[priority_arbiter.scala 38:43:@5097.4]
  wire  fifo_queue_7_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@5097.4]
  wire [80:0] fifo_queue_7_io_request_out; // @[priority_arbiter.scala 38:43:@5097.4]
  wire  fifo_queue_7_io_request_valid_out; // @[priority_arbiter.scala 38:43:@5097.4]
  wire  fifo_queue_7_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@5097.4]
  reg [79:0] request_out_reg; // @[priority_arbiter.scala 22:38:@4960.4]
  reg [95:0] _RAND_0;
  reg  request_valid_out_reg; // @[priority_arbiter.scala 23:44:@4961.4]
  reg [31:0] _RAND_1;
  wire [79:0] request_packed_in_0; // @[priority_arbiter.scala 36:74:@4969.4]
  wire  request_critical_flatted_from_request_queue_0; // @[priority_arbiter.scala 47:107:@4981.4]
  wire [79:0] request_packed_from_request_queue_0; // @[priority_arbiter.scala 48:97:@4983.4]
  wire [79:0] request_packed_in_1; // @[priority_arbiter.scala 36:74:@4987.4]
  wire  request_critical_flatted_from_request_queue_1; // @[priority_arbiter.scala 47:107:@4999.4]
  wire [79:0] request_packed_from_request_queue_1; // @[priority_arbiter.scala 48:97:@5001.4]
  wire [79:0] request_packed_in_2; // @[priority_arbiter.scala 36:74:@5005.4]
  wire  request_critical_flatted_from_request_queue_2; // @[priority_arbiter.scala 47:107:@5017.4]
  wire [79:0] request_packed_from_request_queue_2; // @[priority_arbiter.scala 48:97:@5019.4]
  wire [79:0] request_packed_in_3; // @[priority_arbiter.scala 36:74:@5023.4]
  wire  request_critical_flatted_from_request_queue_3; // @[priority_arbiter.scala 47:107:@5035.4]
  wire [79:0] request_packed_from_request_queue_3; // @[priority_arbiter.scala 48:97:@5037.4]
  wire [79:0] request_packed_in_4; // @[priority_arbiter.scala 36:74:@5041.4]
  wire  request_critical_flatted_from_request_queue_4; // @[priority_arbiter.scala 47:107:@5053.4]
  wire [79:0] request_packed_from_request_queue_4; // @[priority_arbiter.scala 48:97:@5055.4]
  wire [79:0] request_packed_in_5; // @[priority_arbiter.scala 36:74:@5059.4]
  wire  request_critical_flatted_from_request_queue_5; // @[priority_arbiter.scala 47:107:@5071.4]
  wire [79:0] request_packed_from_request_queue_5; // @[priority_arbiter.scala 48:97:@5073.4]
  wire [79:0] request_packed_in_6; // @[priority_arbiter.scala 36:74:@5077.4]
  wire  request_critical_flatted_from_request_queue_6; // @[priority_arbiter.scala 47:107:@5089.4]
  wire [79:0] request_packed_from_request_queue_6; // @[priority_arbiter.scala 48:97:@5091.4]
  wire [79:0] request_packed_in_7; // @[priority_arbiter.scala 36:74:@5095.4]
  wire  request_critical_flatted_from_request_queue_7; // @[priority_arbiter.scala 47:107:@5107.4]
  wire [79:0] request_packed_from_request_queue_7; // @[priority_arbiter.scala 48:97:@5109.4]
  wire [1:0] _T_163; // @[priority_arbiter.scala 55:79:@5114.4]
  wire [1:0] _T_164; // @[priority_arbiter.scala 55:79:@5115.4]
  wire [3:0] _T_165; // @[priority_arbiter.scala 55:79:@5116.4]
  wire [1:0] _T_166; // @[priority_arbiter.scala 55:79:@5117.4]
  wire [1:0] _T_167; // @[priority_arbiter.scala 55:79:@5118.4]
  wire [3:0] _T_168; // @[priority_arbiter.scala 55:79:@5119.4]
  wire [7:0] _T_169; // @[priority_arbiter.scala 55:79:@5120.4]
  wire  request_queue_full_1; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@4992.4]
  wire  request_queue_full_0; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@4974.4]
  wire [1:0] _T_170; // @[priority_arbiter.scala 55:107:@5121.4]
  wire  request_queue_full_3; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5028.4]
  wire  request_queue_full_2; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5010.4]
  wire [1:0] _T_171; // @[priority_arbiter.scala 55:107:@5122.4]
  wire [3:0] _T_172; // @[priority_arbiter.scala 55:107:@5123.4]
  wire  request_queue_full_5; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5064.4]
  wire  request_queue_full_4; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5046.4]
  wire [1:0] _T_173; // @[priority_arbiter.scala 55:107:@5124.4]
  wire  request_queue_full_7; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5100.4]
  wire  request_queue_full_6; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5082.4]
  wire [1:0] _T_174; // @[priority_arbiter.scala 55:107:@5125.4]
  wire [3:0] _T_175; // @[priority_arbiter.scala 55:107:@5126.4]
  wire [7:0] _T_176; // @[priority_arbiter.scala 55:107:@5127.4]
  wire [7:0] request_critical_final; // @[priority_arbiter.scala 55:86:@5128.4]
  reg [2:0] last_send_index; // @[priority_arbiter.scala 56:38:@5130.4]
  reg [31:0] _RAND_2;
  wire  request_valid_flatted_from_request_queue_1; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5003.4]
  wire  request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@4985.4]
  wire [1:0] _T_182; // @[priority_arbiter.scala 61:87:@5133.4]
  wire  request_valid_flatted_from_request_queue_3; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5039.4]
  wire  request_valid_flatted_from_request_queue_2; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5021.4]
  wire [1:0] _T_183; // @[priority_arbiter.scala 61:87:@5134.4]
  wire [3:0] _T_184; // @[priority_arbiter.scala 61:87:@5135.4]
  wire  request_valid_flatted_from_request_queue_5; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5075.4]
  wire  request_valid_flatted_from_request_queue_4; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5057.4]
  wire [1:0] _T_185; // @[priority_arbiter.scala 61:87:@5136.4]
  wire  request_valid_flatted_from_request_queue_7; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5111.4]
  wire  request_valid_flatted_from_request_queue_6; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5093.4]
  wire [1:0] _T_186; // @[priority_arbiter.scala 61:87:@5137.4]
  wire [3:0] _T_187; // @[priority_arbiter.scala 61:87:@5138.4]
  wire [7:0] _T_188; // @[priority_arbiter.scala 61:87:@5139.4]
  wire [3:0] _T_190; // @[priority_arbiter.scala 61:113:@5140.4]
  wire [2:0] _T_191; // @[priority_arbiter.scala 61:113:@5141.4]
  wire [7:0] _T_192; // @[priority_arbiter.scala 61:94:@5142.4]
  wire [3:0] _GEN_100; // @[priority_arbiter.scala 62:148:@5150.4]
  wire [4:0] _T_201; // @[priority_arbiter.scala 62:148:@5150.4]
  wire [4:0] _T_202; // @[priority_arbiter.scala 62:148:@5151.4]
  wire [3:0] _T_203; // @[priority_arbiter.scala 62:148:@5152.4]
  wire [4:0] _T_205; // @[priority_arbiter.scala 62:166:@5153.4]
  wire [4:0] _T_206; // @[priority_arbiter.scala 62:166:@5154.4]
  wire [3:0] _T_207; // @[priority_arbiter.scala 62:166:@5155.4]
  wire [22:0] _GEN_101; // @[priority_arbiter.scala 62:130:@5156.4]
  wire [22:0] _T_208; // @[priority_arbiter.scala 62:130:@5156.4]
  wire [22:0] _GEN_102; // @[priority_arbiter.scala 61:120:@5157.4]
  wire [22:0] _T_209; // @[priority_arbiter.scala 61:120:@5157.4]
  wire [7:0] _T_213; // @[priority_arbiter.scala 63:72:@5161.4]
  wire [22:0] _GEN_104; // @[priority_arbiter.scala 64:108:@5168.4]
  wire [22:0] _T_222; // @[priority_arbiter.scala 64:108:@5168.4]
  wire [22:0] _GEN_105; // @[priority_arbiter.scala 63:98:@5169.4]
  wire [22:0] _T_223; // @[priority_arbiter.scala 63:98:@5169.4]
  reg [2:0] valid_sel; // @[priority_arbiter.scala 67:32:@5171.4]
  reg [31:0] _RAND_3;
  wire [7:0] request_valid_flatted_shift_left; // @[priority_arbiter.scala 59:52:@5131.4 priority_arbiter.scala 61:42:@5158.4]
  wire  _T_227; // @[priority_arbiter.scala 70:55:@5173.4]
  wire [3:0] _T_229; // @[priority_arbiter.scala 71:47:@5175.6]
  wire [2:0] _T_230; // @[priority_arbiter.scala 71:47:@5176.6]
  wire [3:0] _T_232; // @[priority_arbiter.scala 71:68:@5177.6]
  wire [2:0] _T_233; // @[priority_arbiter.scala 71:68:@5178.6]
  wire [3:0] _GEN_106; // @[priority_arbiter.scala 72:89:@5185.8]
  wire [3:0] _GEN_1; // @[priority_arbiter.scala 70:75:@5174.4]
  wire  _T_252; // @[priority_arbiter.scala 70:55:@5198.4]
  wire [3:0] _T_254; // @[priority_arbiter.scala 71:47:@5200.6]
  wire [2:0] _T_255; // @[priority_arbiter.scala 71:47:@5201.6]
  wire [3:0] _T_257; // @[priority_arbiter.scala 71:68:@5202.6]
  wire [2:0] _T_258; // @[priority_arbiter.scala 71:68:@5203.6]
  wire [3:0] _GEN_107; // @[priority_arbiter.scala 72:89:@5210.8]
  wire [3:0] _GEN_3; // @[priority_arbiter.scala 70:75:@5199.4]
  wire  _T_277; // @[priority_arbiter.scala 70:55:@5223.4]
  wire [3:0] _T_279; // @[priority_arbiter.scala 71:47:@5225.6]
  wire [2:0] _T_280; // @[priority_arbiter.scala 71:47:@5226.6]
  wire [3:0] _T_282; // @[priority_arbiter.scala 71:68:@5227.6]
  wire [2:0] _T_283; // @[priority_arbiter.scala 71:68:@5228.6]
  wire [3:0] _GEN_108; // @[priority_arbiter.scala 72:89:@5235.8]
  wire [3:0] _GEN_5; // @[priority_arbiter.scala 70:75:@5224.4]
  wire  _T_302; // @[priority_arbiter.scala 70:55:@5248.4]
  wire [3:0] _T_304; // @[priority_arbiter.scala 71:47:@5250.6]
  wire [2:0] _T_305; // @[priority_arbiter.scala 71:47:@5251.6]
  wire [3:0] _T_307; // @[priority_arbiter.scala 71:68:@5252.6]
  wire [2:0] _T_308; // @[priority_arbiter.scala 71:68:@5253.6]
  wire [3:0] _GEN_109; // @[priority_arbiter.scala 72:89:@5260.8]
  wire [3:0] _GEN_7; // @[priority_arbiter.scala 70:75:@5249.4]
  wire  _T_327; // @[priority_arbiter.scala 70:55:@5273.4]
  wire [3:0] _T_329; // @[priority_arbiter.scala 71:47:@5275.6]
  wire [2:0] _T_330; // @[priority_arbiter.scala 71:47:@5276.6]
  wire [3:0] _T_332; // @[priority_arbiter.scala 71:68:@5277.6]
  wire [2:0] _T_333; // @[priority_arbiter.scala 71:68:@5278.6]
  wire [3:0] _GEN_110; // @[priority_arbiter.scala 72:89:@5285.8]
  wire [3:0] _GEN_9; // @[priority_arbiter.scala 70:75:@5274.4]
  wire  _T_352; // @[priority_arbiter.scala 70:55:@5298.4]
  wire [3:0] _T_354; // @[priority_arbiter.scala 71:47:@5300.6]
  wire [2:0] _T_355; // @[priority_arbiter.scala 71:47:@5301.6]
  wire [3:0] _T_357; // @[priority_arbiter.scala 71:68:@5302.6]
  wire [2:0] _T_358; // @[priority_arbiter.scala 71:68:@5303.6]
  wire [3:0] _GEN_111; // @[priority_arbiter.scala 72:89:@5310.8]
  wire [3:0] _GEN_11; // @[priority_arbiter.scala 70:75:@5299.4]
  wire  _T_377; // @[priority_arbiter.scala 70:55:@5323.4]
  wire [3:0] _T_382; // @[priority_arbiter.scala 71:68:@5327.6]
  wire [2:0] _T_383; // @[priority_arbiter.scala 71:68:@5328.6]
  wire [3:0] _GEN_112; // @[priority_arbiter.scala 72:89:@5335.8]
  wire [3:0] _GEN_13; // @[priority_arbiter.scala 70:75:@5324.4]
  wire  _T_402; // @[priority_arbiter.scala 70:55:@5348.4]
  wire [2:0] _T_405; // @[priority_arbiter.scala 71:47:@5351.6]
  wire [3:0] _T_407; // @[priority_arbiter.scala 71:68:@5352.6]
  wire [2:0] _T_408; // @[priority_arbiter.scala 71:68:@5353.6]
  wire [3:0] _GEN_113; // @[priority_arbiter.scala 72:89:@5360.8]
  wire [3:0] _GEN_15; // @[priority_arbiter.scala 70:75:@5349.4]
  reg [2:0] critical_sel; // @[priority_arbiter.scala 79:35:@5373.4]
  reg [31:0] _RAND_4;
  wire [7:0] request_critical_flatted_shift_left; // @[priority_arbiter.scala 60:55:@5132.4 priority_arbiter.scala 63:45:@5170.4]
  wire  _T_430; // @[priority_arbiter.scala 82:58:@5375.4]
  wire  _T_432; // @[priority_arbiter.scala 82:80:@5377.4]
  wire [3:0] _GEN_17; // @[priority_arbiter.scala 82:138:@5378.4]
  wire  _T_457; // @[priority_arbiter.scala 82:58:@5402.4]
  wire  _T_459; // @[priority_arbiter.scala 82:80:@5404.4]
  wire [3:0] _GEN_19; // @[priority_arbiter.scala 82:138:@5405.4]
  wire  _T_484; // @[priority_arbiter.scala 82:58:@5429.4]
  wire  _T_486; // @[priority_arbiter.scala 82:80:@5431.4]
  wire [3:0] _GEN_21; // @[priority_arbiter.scala 82:138:@5432.4]
  wire  _T_511; // @[priority_arbiter.scala 82:58:@5456.4]
  wire  _T_513; // @[priority_arbiter.scala 82:80:@5458.4]
  wire [3:0] _GEN_23; // @[priority_arbiter.scala 82:138:@5459.4]
  wire  _T_538; // @[priority_arbiter.scala 82:58:@5483.4]
  wire  _T_540; // @[priority_arbiter.scala 82:80:@5485.4]
  wire [3:0] _GEN_25; // @[priority_arbiter.scala 82:138:@5486.4]
  wire  _T_565; // @[priority_arbiter.scala 82:58:@5510.4]
  wire  _T_567; // @[priority_arbiter.scala 82:80:@5512.4]
  wire [3:0] _GEN_27; // @[priority_arbiter.scala 82:138:@5513.4]
  wire  _T_592; // @[priority_arbiter.scala 82:58:@5537.4]
  wire  _T_594; // @[priority_arbiter.scala 82:80:@5539.4]
  wire [3:0] _GEN_29; // @[priority_arbiter.scala 82:138:@5540.4]
  wire  _T_619; // @[priority_arbiter.scala 82:58:@5564.4]
  wire  _T_621; // @[priority_arbiter.scala 82:80:@5566.4]
  wire [3:0] _GEN_31; // @[priority_arbiter.scala 82:138:@5567.4]
  wire  _T_737; // @[priority_arbiter.scala 109:59:@5705.4]
  wire  _T_743; // @[priority_arbiter.scala 109:59:@5714.4]
  wire  _T_749; // @[priority_arbiter.scala 109:59:@5723.4]
  wire  _T_755; // @[priority_arbiter.scala 109:59:@5732.4]
  wire  _T_761; // @[priority_arbiter.scala 109:59:@5741.4]
  wire  _T_767; // @[priority_arbiter.scala 109:59:@5750.4]
  wire  _T_773; // @[priority_arbiter.scala 109:59:@5759.4]
  wire  _T_779; // @[priority_arbiter.scala 109:59:@5768.4]
  wire  _T_788; // @[priority_arbiter.scala 122:40:@5784.6]
  wire  _T_789; // @[priority_arbiter.scala 122:68:@5785.6]
  wire  _T_790; // @[priority_arbiter.scala 122:65:@5786.6]
  wire [7:0] _T_792; // @[priority_arbiter.scala 123:46:@5789.8]
  wire  _T_793; // @[priority_arbiter.scala 123:46:@5790.8]
  wire  _GEN_57; // @[priority_arbiter.scala 123:61:@5791.8]
  wire  _GEN_58; // @[priority_arbiter.scala 123:61:@5791.8]
  wire  _GEN_59; // @[priority_arbiter.scala 123:61:@5791.8]
  wire  _GEN_60; // @[priority_arbiter.scala 123:61:@5791.8]
  wire  _GEN_61; // @[priority_arbiter.scala 123:61:@5791.8]
  wire  _GEN_62; // @[priority_arbiter.scala 123:61:@5791.8]
  wire  _GEN_63; // @[priority_arbiter.scala 123:61:@5791.8]
  wire  _T_795; // @[priority_arbiter.scala 123:61:@5791.8]
  wire  _T_796; // @[priority_arbiter.scala 124:50:@5792.8]
  wire  _T_797; // @[priority_arbiter.scala 124:70:@5793.8]
  wire  _T_799; // @[priority_arbiter.scala 124:35:@5794.8]
  wire  _T_801; // @[priority_arbiter.scala 124:96:@5796.8]
  wire  _T_802; // @[priority_arbiter.scala 123:118:@5797.8]
  wire [79:0] _GEN_65; // @[priority_arbiter.scala 125:41:@5800.10]
  wire [79:0] _GEN_66; // @[priority_arbiter.scala 125:41:@5800.10]
  wire [79:0] _GEN_67; // @[priority_arbiter.scala 125:41:@5800.10]
  wire [79:0] _GEN_68; // @[priority_arbiter.scala 125:41:@5800.10]
  wire [79:0] _GEN_69; // @[priority_arbiter.scala 125:41:@5800.10]
  wire [79:0] _GEN_70; // @[priority_arbiter.scala 125:41:@5800.10]
  wire [79:0] _GEN_71; // @[priority_arbiter.scala 125:41:@5800.10]
  wire  _T_807; // @[priority_arbiter.scala 129:47:@5805.10]
  wire  _T_808; // @[priority_arbiter.scala 129:67:@5806.10]
  wire  _T_810; // @[priority_arbiter.scala 129:35:@5807.10]
  wire  _T_812; // @[priority_arbiter.scala 129:93:@5809.10]
  wire  _GEN_73; // @[priority_arbiter.scala 128:83:@5810.10]
  wire  _GEN_74; // @[priority_arbiter.scala 128:83:@5810.10]
  wire  _GEN_75; // @[priority_arbiter.scala 128:83:@5810.10]
  wire  _GEN_76; // @[priority_arbiter.scala 128:83:@5810.10]
  wire  _GEN_77; // @[priority_arbiter.scala 128:83:@5810.10]
  wire  _GEN_78; // @[priority_arbiter.scala 128:83:@5810.10]
  wire  _GEN_79; // @[priority_arbiter.scala 128:83:@5810.10]
  wire  _T_813; // @[priority_arbiter.scala 128:83:@5810.10]
  wire [79:0] _GEN_81; // @[priority_arbiter.scala 130:41:@5813.12]
  wire [79:0] _GEN_82; // @[priority_arbiter.scala 130:41:@5813.12]
  wire [79:0] _GEN_83; // @[priority_arbiter.scala 130:41:@5813.12]
  wire [79:0] _GEN_84; // @[priority_arbiter.scala 130:41:@5813.12]
  wire [79:0] _GEN_85; // @[priority_arbiter.scala 130:41:@5813.12]
  wire [79:0] _GEN_86; // @[priority_arbiter.scala 130:41:@5813.12]
  wire [79:0] _GEN_87; // @[priority_arbiter.scala 130:41:@5813.12]
  wire [79:0] _GEN_88; // @[priority_arbiter.scala 129:130:@5812.10]
  wire [2:0] _GEN_90; // @[priority_arbiter.scala 129:130:@5812.10]
  wire [79:0] _GEN_91; // @[priority_arbiter.scala 124:133:@5799.8]
  wire  _GEN_92; // @[priority_arbiter.scala 124:133:@5799.8]
  wire [2:0] _GEN_93; // @[priority_arbiter.scala 124:133:@5799.8]
  wire [79:0] _GEN_94; // @[priority_arbiter.scala 122:101:@5788.6]
  wire  _GEN_95; // @[priority_arbiter.scala 122:101:@5788.6]
  wire [2:0] _GEN_96; // @[priority_arbiter.scala 122:101:@5788.6]
  wire [79:0] _GEN_97; // @[priority_arbiter.scala 118:29:@5778.4]
  wire  _GEN_98; // @[priority_arbiter.scala 118:29:@5778.4]
  wire [2:0] _GEN_99; // @[priority_arbiter.scala 118:29:@5778.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@4998.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@4980.4]
  wire [1:0] _T_819; // @[priority_arbiter.scala 147:47:@5830.4]
  wire  issue_ack_out_vec_3; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5034.4]
  wire  issue_ack_out_vec_2; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5016.4]
  wire [1:0] _T_820; // @[priority_arbiter.scala 147:47:@5831.4]
  wire [3:0] _T_821; // @[priority_arbiter.scala 147:47:@5832.4]
  wire  issue_ack_out_vec_5; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5070.4]
  wire  issue_ack_out_vec_4; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5052.4]
  wire [1:0] _T_822; // @[priority_arbiter.scala 147:47:@5833.4]
  wire  issue_ack_out_vec_7; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5106.4]
  wire  issue_ack_out_vec_6; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5088.4]
  wire [1:0] _T_823; // @[priority_arbiter.scala 147:47:@5834.4]
  wire [3:0] _T_824; // @[priority_arbiter.scala 147:47:@5835.4]
  fifo_queue_2 fifo_queue ( // @[priority_arbiter.scala 38:43:@4971.4]
    .clock(fifo_queue_clock),
    .reset(fifo_queue_reset),
    .io_is_empty_out(fifo_queue_io_is_empty_out),
    .io_is_full_out(fifo_queue_io_is_full_out),
    .io_request_in(fifo_queue_io_request_in),
    .io_request_valid_in(fifo_queue_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_io_issue_ack_out),
    .io_request_out(fifo_queue_io_request_out),
    .io_request_valid_out(fifo_queue_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_1 ( // @[priority_arbiter.scala 38:43:@4989.4]
    .clock(fifo_queue_1_clock),
    .reset(fifo_queue_1_reset),
    .io_is_empty_out(fifo_queue_1_io_is_empty_out),
    .io_is_full_out(fifo_queue_1_io_is_full_out),
    .io_request_in(fifo_queue_1_io_request_in),
    .io_request_valid_in(fifo_queue_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_1_io_issue_ack_out),
    .io_request_out(fifo_queue_1_io_request_out),
    .io_request_valid_out(fifo_queue_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_1_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_2 ( // @[priority_arbiter.scala 38:43:@5007.4]
    .clock(fifo_queue_2_clock),
    .reset(fifo_queue_2_reset),
    .io_is_empty_out(fifo_queue_2_io_is_empty_out),
    .io_is_full_out(fifo_queue_2_io_is_full_out),
    .io_request_in(fifo_queue_2_io_request_in),
    .io_request_valid_in(fifo_queue_2_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_2_io_issue_ack_out),
    .io_request_out(fifo_queue_2_io_request_out),
    .io_request_valid_out(fifo_queue_2_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_2_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_3 ( // @[priority_arbiter.scala 38:43:@5025.4]
    .clock(fifo_queue_3_clock),
    .reset(fifo_queue_3_reset),
    .io_is_empty_out(fifo_queue_3_io_is_empty_out),
    .io_is_full_out(fifo_queue_3_io_is_full_out),
    .io_request_in(fifo_queue_3_io_request_in),
    .io_request_valid_in(fifo_queue_3_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_3_io_issue_ack_out),
    .io_request_out(fifo_queue_3_io_request_out),
    .io_request_valid_out(fifo_queue_3_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_3_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_4 ( // @[priority_arbiter.scala 38:43:@5043.4]
    .clock(fifo_queue_4_clock),
    .reset(fifo_queue_4_reset),
    .io_is_empty_out(fifo_queue_4_io_is_empty_out),
    .io_is_full_out(fifo_queue_4_io_is_full_out),
    .io_request_in(fifo_queue_4_io_request_in),
    .io_request_valid_in(fifo_queue_4_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_4_io_issue_ack_out),
    .io_request_out(fifo_queue_4_io_request_out),
    .io_request_valid_out(fifo_queue_4_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_4_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_5 ( // @[priority_arbiter.scala 38:43:@5061.4]
    .clock(fifo_queue_5_clock),
    .reset(fifo_queue_5_reset),
    .io_is_empty_out(fifo_queue_5_io_is_empty_out),
    .io_is_full_out(fifo_queue_5_io_is_full_out),
    .io_request_in(fifo_queue_5_io_request_in),
    .io_request_valid_in(fifo_queue_5_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_5_io_issue_ack_out),
    .io_request_out(fifo_queue_5_io_request_out),
    .io_request_valid_out(fifo_queue_5_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_5_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_6 ( // @[priority_arbiter.scala 38:43:@5079.4]
    .clock(fifo_queue_6_clock),
    .reset(fifo_queue_6_reset),
    .io_is_empty_out(fifo_queue_6_io_is_empty_out),
    .io_is_full_out(fifo_queue_6_io_is_full_out),
    .io_request_in(fifo_queue_6_io_request_in),
    .io_request_valid_in(fifo_queue_6_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_6_io_issue_ack_out),
    .io_request_out(fifo_queue_6_io_request_out),
    .io_request_valid_out(fifo_queue_6_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_6_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_7 ( // @[priority_arbiter.scala 38:43:@5097.4]
    .clock(fifo_queue_7_clock),
    .reset(fifo_queue_7_reset),
    .io_is_empty_out(fifo_queue_7_io_is_empty_out),
    .io_is_full_out(fifo_queue_7_io_is_full_out),
    .io_request_in(fifo_queue_7_io_request_in),
    .io_request_valid_in(fifo_queue_7_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_7_io_issue_ack_out),
    .io_request_out(fifo_queue_7_io_request_out),
    .io_request_valid_out(fifo_queue_7_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_7_io_issue_ack_in)
  );
  assign request_packed_in_0 = io_request_flatted_in[79:0]; // @[priority_arbiter.scala 36:74:@4969.4]
  assign request_critical_flatted_from_request_queue_0 = fifo_queue_io_request_out[80]; // @[priority_arbiter.scala 47:107:@4981.4]
  assign request_packed_from_request_queue_0 = fifo_queue_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@4983.4]
  assign request_packed_in_1 = io_request_flatted_in[159:80]; // @[priority_arbiter.scala 36:74:@4987.4]
  assign request_critical_flatted_from_request_queue_1 = fifo_queue_1_io_request_out[80]; // @[priority_arbiter.scala 47:107:@4999.4]
  assign request_packed_from_request_queue_1 = fifo_queue_1_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@5001.4]
  assign request_packed_in_2 = io_request_flatted_in[239:160]; // @[priority_arbiter.scala 36:74:@5005.4]
  assign request_critical_flatted_from_request_queue_2 = fifo_queue_2_io_request_out[80]; // @[priority_arbiter.scala 47:107:@5017.4]
  assign request_packed_from_request_queue_2 = fifo_queue_2_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@5019.4]
  assign request_packed_in_3 = io_request_flatted_in[319:240]; // @[priority_arbiter.scala 36:74:@5023.4]
  assign request_critical_flatted_from_request_queue_3 = fifo_queue_3_io_request_out[80]; // @[priority_arbiter.scala 47:107:@5035.4]
  assign request_packed_from_request_queue_3 = fifo_queue_3_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@5037.4]
  assign request_packed_in_4 = io_request_flatted_in[399:320]; // @[priority_arbiter.scala 36:74:@5041.4]
  assign request_critical_flatted_from_request_queue_4 = fifo_queue_4_io_request_out[80]; // @[priority_arbiter.scala 47:107:@5053.4]
  assign request_packed_from_request_queue_4 = fifo_queue_4_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@5055.4]
  assign request_packed_in_5 = io_request_flatted_in[479:400]; // @[priority_arbiter.scala 36:74:@5059.4]
  assign request_critical_flatted_from_request_queue_5 = fifo_queue_5_io_request_out[80]; // @[priority_arbiter.scala 47:107:@5071.4]
  assign request_packed_from_request_queue_5 = fifo_queue_5_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@5073.4]
  assign request_packed_in_6 = io_request_flatted_in[559:480]; // @[priority_arbiter.scala 36:74:@5077.4]
  assign request_critical_flatted_from_request_queue_6 = fifo_queue_6_io_request_out[80]; // @[priority_arbiter.scala 47:107:@5089.4]
  assign request_packed_from_request_queue_6 = fifo_queue_6_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@5091.4]
  assign request_packed_in_7 = io_request_flatted_in[639:560]; // @[priority_arbiter.scala 36:74:@5095.4]
  assign request_critical_flatted_from_request_queue_7 = fifo_queue_7_io_request_out[80]; // @[priority_arbiter.scala 47:107:@5107.4]
  assign request_packed_from_request_queue_7 = fifo_queue_7_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@5109.4]
  assign _T_163 = {request_critical_flatted_from_request_queue_1,request_critical_flatted_from_request_queue_0}; // @[priority_arbiter.scala 55:79:@5114.4]
  assign _T_164 = {request_critical_flatted_from_request_queue_3,request_critical_flatted_from_request_queue_2}; // @[priority_arbiter.scala 55:79:@5115.4]
  assign _T_165 = {_T_164,_T_163}; // @[priority_arbiter.scala 55:79:@5116.4]
  assign _T_166 = {request_critical_flatted_from_request_queue_5,request_critical_flatted_from_request_queue_4}; // @[priority_arbiter.scala 55:79:@5117.4]
  assign _T_167 = {request_critical_flatted_from_request_queue_7,request_critical_flatted_from_request_queue_6}; // @[priority_arbiter.scala 55:79:@5118.4]
  assign _T_168 = {_T_167,_T_166}; // @[priority_arbiter.scala 55:79:@5119.4]
  assign _T_169 = {_T_168,_T_165}; // @[priority_arbiter.scala 55:79:@5120.4]
  assign request_queue_full_1 = fifo_queue_1_io_is_full_out; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@4992.4]
  assign request_queue_full_0 = fifo_queue_io_is_full_out; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@4974.4]
  assign _T_170 = {request_queue_full_1,request_queue_full_0}; // @[priority_arbiter.scala 55:107:@5121.4]
  assign request_queue_full_3 = fifo_queue_3_io_is_full_out; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5028.4]
  assign request_queue_full_2 = fifo_queue_2_io_is_full_out; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5010.4]
  assign _T_171 = {request_queue_full_3,request_queue_full_2}; // @[priority_arbiter.scala 55:107:@5122.4]
  assign _T_172 = {_T_171,_T_170}; // @[priority_arbiter.scala 55:107:@5123.4]
  assign request_queue_full_5 = fifo_queue_5_io_is_full_out; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5064.4]
  assign request_queue_full_4 = fifo_queue_4_io_is_full_out; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5046.4]
  assign _T_173 = {request_queue_full_5,request_queue_full_4}; // @[priority_arbiter.scala 55:107:@5124.4]
  assign request_queue_full_7 = fifo_queue_7_io_is_full_out; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5100.4]
  assign request_queue_full_6 = fifo_queue_6_io_is_full_out; // @[priority_arbiter.scala 32:38:@4967.4 priority_arbiter.scala 42:51:@5082.4]
  assign _T_174 = {request_queue_full_7,request_queue_full_6}; // @[priority_arbiter.scala 55:107:@5125.4]
  assign _T_175 = {_T_174,_T_173}; // @[priority_arbiter.scala 55:107:@5126.4]
  assign _T_176 = {_T_175,_T_172}; // @[priority_arbiter.scala 55:107:@5127.4]
  assign request_critical_final = _T_169 | _T_176; // @[priority_arbiter.scala 55:86:@5128.4]
  assign request_valid_flatted_from_request_queue_1 = fifo_queue_1_io_request_valid_out; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5003.4]
  assign request_valid_flatted_from_request_queue_0 = fifo_queue_io_request_valid_out; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@4985.4]
  assign _T_182 = {request_valid_flatted_from_request_queue_1,request_valid_flatted_from_request_queue_0}; // @[priority_arbiter.scala 61:87:@5133.4]
  assign request_valid_flatted_from_request_queue_3 = fifo_queue_3_io_request_valid_out; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5039.4]
  assign request_valid_flatted_from_request_queue_2 = fifo_queue_2_io_request_valid_out; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5021.4]
  assign _T_183 = {request_valid_flatted_from_request_queue_3,request_valid_flatted_from_request_queue_2}; // @[priority_arbiter.scala 61:87:@5134.4]
  assign _T_184 = {_T_183,_T_182}; // @[priority_arbiter.scala 61:87:@5135.4]
  assign request_valid_flatted_from_request_queue_5 = fifo_queue_5_io_request_valid_out; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5075.4]
  assign request_valid_flatted_from_request_queue_4 = fifo_queue_4_io_request_valid_out; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5057.4]
  assign _T_185 = {request_valid_flatted_from_request_queue_5,request_valid_flatted_from_request_queue_4}; // @[priority_arbiter.scala 61:87:@5136.4]
  assign request_valid_flatted_from_request_queue_7 = fifo_queue_7_io_request_valid_out; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5111.4]
  assign request_valid_flatted_from_request_queue_6 = fifo_queue_6_io_request_valid_out; // @[priority_arbiter.scala 31:60:@4966.4 priority_arbiter.scala 50:73:@5093.4]
  assign _T_186 = {request_valid_flatted_from_request_queue_7,request_valid_flatted_from_request_queue_6}; // @[priority_arbiter.scala 61:87:@5137.4]
  assign _T_187 = {_T_186,_T_185}; // @[priority_arbiter.scala 61:87:@5138.4]
  assign _T_188 = {_T_187,_T_184}; // @[priority_arbiter.scala 61:87:@5139.4]
  assign _T_190 = last_send_index + 3'h1; // @[priority_arbiter.scala 61:113:@5140.4]
  assign _T_191 = _T_190[2:0]; // @[priority_arbiter.scala 61:113:@5141.4]
  assign _T_192 = _T_188 >> _T_191; // @[priority_arbiter.scala 61:94:@5142.4]
  assign _GEN_100 = {{1'd0}, last_send_index}; // @[priority_arbiter.scala 62:148:@5150.4]
  assign _T_201 = 4'h8 - _GEN_100; // @[priority_arbiter.scala 62:148:@5150.4]
  assign _T_202 = $unsigned(_T_201); // @[priority_arbiter.scala 62:148:@5151.4]
  assign _T_203 = _T_202[3:0]; // @[priority_arbiter.scala 62:148:@5152.4]
  assign _T_205 = _T_203 - 4'h1; // @[priority_arbiter.scala 62:166:@5153.4]
  assign _T_206 = $unsigned(_T_205); // @[priority_arbiter.scala 62:166:@5154.4]
  assign _T_207 = _T_206[3:0]; // @[priority_arbiter.scala 62:166:@5155.4]
  assign _GEN_101 = {{15'd0}, _T_188}; // @[priority_arbiter.scala 62:130:@5156.4]
  assign _T_208 = _GEN_101 << _T_207; // @[priority_arbiter.scala 62:130:@5156.4]
  assign _GEN_102 = {{15'd0}, _T_192}; // @[priority_arbiter.scala 61:120:@5157.4]
  assign _T_209 = _GEN_102 | _T_208; // @[priority_arbiter.scala 61:120:@5157.4]
  assign _T_213 = request_critical_final >> _T_191; // @[priority_arbiter.scala 63:72:@5161.4]
  assign _GEN_104 = {{15'd0}, request_critical_final}; // @[priority_arbiter.scala 64:108:@5168.4]
  assign _T_222 = _GEN_104 << _T_207; // @[priority_arbiter.scala 64:108:@5168.4]
  assign _GEN_105 = {{15'd0}, _T_213}; // @[priority_arbiter.scala 63:98:@5169.4]
  assign _T_223 = _GEN_105 | _T_222; // @[priority_arbiter.scala 63:98:@5169.4]
  assign request_valid_flatted_shift_left = _T_209[7:0]; // @[priority_arbiter.scala 59:52:@5131.4 priority_arbiter.scala 61:42:@5158.4]
  assign _T_227 = request_valid_flatted_shift_left[7]; // @[priority_arbiter.scala 70:55:@5173.4]
  assign _T_229 = last_send_index + 3'h7; // @[priority_arbiter.scala 71:47:@5175.6]
  assign _T_230 = _T_229[2:0]; // @[priority_arbiter.scala 71:47:@5176.6]
  assign _T_232 = _T_230 + 3'h1; // @[priority_arbiter.scala 71:68:@5177.6]
  assign _T_233 = _T_232[2:0]; // @[priority_arbiter.scala 71:68:@5178.6]
  assign _GEN_106 = {{1'd0}, _T_233}; // @[priority_arbiter.scala 72:89:@5185.8]
  assign _GEN_1 = _T_227 ? _GEN_106 : 4'h0; // @[priority_arbiter.scala 70:75:@5174.4]
  assign _T_252 = request_valid_flatted_shift_left[6]; // @[priority_arbiter.scala 70:55:@5198.4]
  assign _T_254 = last_send_index + 3'h6; // @[priority_arbiter.scala 71:47:@5200.6]
  assign _T_255 = _T_254[2:0]; // @[priority_arbiter.scala 71:47:@5201.6]
  assign _T_257 = _T_255 + 3'h1; // @[priority_arbiter.scala 71:68:@5202.6]
  assign _T_258 = _T_257[2:0]; // @[priority_arbiter.scala 71:68:@5203.6]
  assign _GEN_107 = {{1'd0}, _T_258}; // @[priority_arbiter.scala 72:89:@5210.8]
  assign _GEN_3 = _T_252 ? _GEN_107 : _GEN_1; // @[priority_arbiter.scala 70:75:@5199.4]
  assign _T_277 = request_valid_flatted_shift_left[5]; // @[priority_arbiter.scala 70:55:@5223.4]
  assign _T_279 = last_send_index + 3'h5; // @[priority_arbiter.scala 71:47:@5225.6]
  assign _T_280 = _T_279[2:0]; // @[priority_arbiter.scala 71:47:@5226.6]
  assign _T_282 = _T_280 + 3'h1; // @[priority_arbiter.scala 71:68:@5227.6]
  assign _T_283 = _T_282[2:0]; // @[priority_arbiter.scala 71:68:@5228.6]
  assign _GEN_108 = {{1'd0}, _T_283}; // @[priority_arbiter.scala 72:89:@5235.8]
  assign _GEN_5 = _T_277 ? _GEN_108 : _GEN_3; // @[priority_arbiter.scala 70:75:@5224.4]
  assign _T_302 = request_valid_flatted_shift_left[4]; // @[priority_arbiter.scala 70:55:@5248.4]
  assign _T_304 = last_send_index + 3'h4; // @[priority_arbiter.scala 71:47:@5250.6]
  assign _T_305 = _T_304[2:0]; // @[priority_arbiter.scala 71:47:@5251.6]
  assign _T_307 = _T_305 + 3'h1; // @[priority_arbiter.scala 71:68:@5252.6]
  assign _T_308 = _T_307[2:0]; // @[priority_arbiter.scala 71:68:@5253.6]
  assign _GEN_109 = {{1'd0}, _T_308}; // @[priority_arbiter.scala 72:89:@5260.8]
  assign _GEN_7 = _T_302 ? _GEN_109 : _GEN_5; // @[priority_arbiter.scala 70:75:@5249.4]
  assign _T_327 = request_valid_flatted_shift_left[3]; // @[priority_arbiter.scala 70:55:@5273.4]
  assign _T_329 = last_send_index + 3'h3; // @[priority_arbiter.scala 71:47:@5275.6]
  assign _T_330 = _T_329[2:0]; // @[priority_arbiter.scala 71:47:@5276.6]
  assign _T_332 = _T_330 + 3'h1; // @[priority_arbiter.scala 71:68:@5277.6]
  assign _T_333 = _T_332[2:0]; // @[priority_arbiter.scala 71:68:@5278.6]
  assign _GEN_110 = {{1'd0}, _T_333}; // @[priority_arbiter.scala 72:89:@5285.8]
  assign _GEN_9 = _T_327 ? _GEN_110 : _GEN_7; // @[priority_arbiter.scala 70:75:@5274.4]
  assign _T_352 = request_valid_flatted_shift_left[2]; // @[priority_arbiter.scala 70:55:@5298.4]
  assign _T_354 = last_send_index + 3'h2; // @[priority_arbiter.scala 71:47:@5300.6]
  assign _T_355 = _T_354[2:0]; // @[priority_arbiter.scala 71:47:@5301.6]
  assign _T_357 = _T_355 + 3'h1; // @[priority_arbiter.scala 71:68:@5302.6]
  assign _T_358 = _T_357[2:0]; // @[priority_arbiter.scala 71:68:@5303.6]
  assign _GEN_111 = {{1'd0}, _T_358}; // @[priority_arbiter.scala 72:89:@5310.8]
  assign _GEN_11 = _T_352 ? _GEN_111 : _GEN_9; // @[priority_arbiter.scala 70:75:@5299.4]
  assign _T_377 = request_valid_flatted_shift_left[1]; // @[priority_arbiter.scala 70:55:@5323.4]
  assign _T_382 = _T_191 + 3'h1; // @[priority_arbiter.scala 71:68:@5327.6]
  assign _T_383 = _T_382[2:0]; // @[priority_arbiter.scala 71:68:@5328.6]
  assign _GEN_112 = {{1'd0}, _T_383}; // @[priority_arbiter.scala 72:89:@5335.8]
  assign _GEN_13 = _T_377 ? _GEN_112 : _GEN_11; // @[priority_arbiter.scala 70:75:@5324.4]
  assign _T_402 = request_valid_flatted_shift_left[0]; // @[priority_arbiter.scala 70:55:@5348.4]
  assign _T_405 = _GEN_100[2:0]; // @[priority_arbiter.scala 71:47:@5351.6]
  assign _T_407 = _T_405 + 3'h1; // @[priority_arbiter.scala 71:68:@5352.6]
  assign _T_408 = _T_407[2:0]; // @[priority_arbiter.scala 71:68:@5353.6]
  assign _GEN_113 = {{1'd0}, _T_408}; // @[priority_arbiter.scala 72:89:@5360.8]
  assign _GEN_15 = _T_402 ? _GEN_113 : _GEN_13; // @[priority_arbiter.scala 70:75:@5349.4]
  assign request_critical_flatted_shift_left = _T_223[7:0]; // @[priority_arbiter.scala 60:55:@5132.4 priority_arbiter.scala 63:45:@5170.4]
  assign _T_430 = request_critical_flatted_shift_left[7]; // @[priority_arbiter.scala 82:58:@5375.4]
  assign _T_432 = _T_430 & _T_227; // @[priority_arbiter.scala 82:80:@5377.4]
  assign _GEN_17 = _T_432 ? _GEN_106 : 4'h0; // @[priority_arbiter.scala 82:138:@5378.4]
  assign _T_457 = request_critical_flatted_shift_left[6]; // @[priority_arbiter.scala 82:58:@5402.4]
  assign _T_459 = _T_457 & _T_252; // @[priority_arbiter.scala 82:80:@5404.4]
  assign _GEN_19 = _T_459 ? _GEN_107 : _GEN_17; // @[priority_arbiter.scala 82:138:@5405.4]
  assign _T_484 = request_critical_flatted_shift_left[5]; // @[priority_arbiter.scala 82:58:@5429.4]
  assign _T_486 = _T_484 & _T_277; // @[priority_arbiter.scala 82:80:@5431.4]
  assign _GEN_21 = _T_486 ? _GEN_108 : _GEN_19; // @[priority_arbiter.scala 82:138:@5432.4]
  assign _T_511 = request_critical_flatted_shift_left[4]; // @[priority_arbiter.scala 82:58:@5456.4]
  assign _T_513 = _T_511 & _T_302; // @[priority_arbiter.scala 82:80:@5458.4]
  assign _GEN_23 = _T_513 ? _GEN_109 : _GEN_21; // @[priority_arbiter.scala 82:138:@5459.4]
  assign _T_538 = request_critical_flatted_shift_left[3]; // @[priority_arbiter.scala 82:58:@5483.4]
  assign _T_540 = _T_538 & _T_327; // @[priority_arbiter.scala 82:80:@5485.4]
  assign _GEN_25 = _T_540 ? _GEN_110 : _GEN_23; // @[priority_arbiter.scala 82:138:@5486.4]
  assign _T_565 = request_critical_flatted_shift_left[2]; // @[priority_arbiter.scala 82:58:@5510.4]
  assign _T_567 = _T_565 & _T_352; // @[priority_arbiter.scala 82:80:@5512.4]
  assign _GEN_27 = _T_567 ? _GEN_111 : _GEN_25; // @[priority_arbiter.scala 82:138:@5513.4]
  assign _T_592 = request_critical_flatted_shift_left[1]; // @[priority_arbiter.scala 82:58:@5537.4]
  assign _T_594 = _T_592 & _T_377; // @[priority_arbiter.scala 82:80:@5539.4]
  assign _GEN_29 = _T_594 ? _GEN_112 : _GEN_27; // @[priority_arbiter.scala 82:138:@5540.4]
  assign _T_619 = request_critical_flatted_shift_left[0]; // @[priority_arbiter.scala 82:58:@5564.4]
  assign _T_621 = _T_619 & _T_402; // @[priority_arbiter.scala 82:80:@5566.4]
  assign _GEN_31 = _T_621 ? _GEN_113 : _GEN_29; // @[priority_arbiter.scala 82:138:@5567.4]
  assign _T_737 = last_send_index == 3'h0; // @[priority_arbiter.scala 109:59:@5705.4]
  assign _T_743 = last_send_index == 3'h1; // @[priority_arbiter.scala 109:59:@5714.4]
  assign _T_749 = last_send_index == 3'h2; // @[priority_arbiter.scala 109:59:@5723.4]
  assign _T_755 = last_send_index == 3'h3; // @[priority_arbiter.scala 109:59:@5732.4]
  assign _T_761 = last_send_index == 3'h4; // @[priority_arbiter.scala 109:59:@5741.4]
  assign _T_767 = last_send_index == 3'h5; // @[priority_arbiter.scala 109:59:@5750.4]
  assign _T_773 = last_send_index == 3'h6; // @[priority_arbiter.scala 109:59:@5759.4]
  assign _T_779 = last_send_index == 3'h7; // @[priority_arbiter.scala 109:59:@5768.4]
  assign _T_788 = io_issue_ack_in & request_valid_out_reg; // @[priority_arbiter.scala 122:40:@5784.6]
  assign _T_789 = ~ request_valid_out_reg; // @[priority_arbiter.scala 122:68:@5785.6]
  assign _T_790 = _T_788 | _T_789; // @[priority_arbiter.scala 122:65:@5786.6]
  assign _T_792 = request_critical_final >> critical_sel; // @[priority_arbiter.scala 123:46:@5789.8]
  assign _T_793 = _T_792[0]; // @[priority_arbiter.scala 123:46:@5790.8]
  assign _GEN_57 = 3'h1 == critical_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 123:61:@5791.8]
  assign _GEN_58 = 3'h2 == critical_sel ? request_valid_flatted_from_request_queue_2 : _GEN_57; // @[priority_arbiter.scala 123:61:@5791.8]
  assign _GEN_59 = 3'h3 == critical_sel ? request_valid_flatted_from_request_queue_3 : _GEN_58; // @[priority_arbiter.scala 123:61:@5791.8]
  assign _GEN_60 = 3'h4 == critical_sel ? request_valid_flatted_from_request_queue_4 : _GEN_59; // @[priority_arbiter.scala 123:61:@5791.8]
  assign _GEN_61 = 3'h5 == critical_sel ? request_valid_flatted_from_request_queue_5 : _GEN_60; // @[priority_arbiter.scala 123:61:@5791.8]
  assign _GEN_62 = 3'h6 == critical_sel ? request_valid_flatted_from_request_queue_6 : _GEN_61; // @[priority_arbiter.scala 123:61:@5791.8]
  assign _GEN_63 = 3'h7 == critical_sel ? request_valid_flatted_from_request_queue_7 : _GEN_62; // @[priority_arbiter.scala 123:61:@5791.8]
  assign _T_795 = _T_793 & _GEN_63; // @[priority_arbiter.scala 123:61:@5791.8]
  assign _T_796 = critical_sel == last_send_index; // @[priority_arbiter.scala 124:50:@5792.8]
  assign _T_797 = _T_796 & request_valid_out_reg; // @[priority_arbiter.scala 124:70:@5793.8]
  assign _T_799 = _T_797 == 1'h0; // @[priority_arbiter.scala 124:35:@5794.8]
  assign _T_801 = _T_799 | _T_789; // @[priority_arbiter.scala 124:96:@5796.8]
  assign _T_802 = _T_795 & _T_801; // @[priority_arbiter.scala 123:118:@5797.8]
  assign _GEN_65 = 3'h1 == critical_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter.scala 125:41:@5800.10]
  assign _GEN_66 = 3'h2 == critical_sel ? request_packed_from_request_queue_2 : _GEN_65; // @[priority_arbiter.scala 125:41:@5800.10]
  assign _GEN_67 = 3'h3 == critical_sel ? request_packed_from_request_queue_3 : _GEN_66; // @[priority_arbiter.scala 125:41:@5800.10]
  assign _GEN_68 = 3'h4 == critical_sel ? request_packed_from_request_queue_4 : _GEN_67; // @[priority_arbiter.scala 125:41:@5800.10]
  assign _GEN_69 = 3'h5 == critical_sel ? request_packed_from_request_queue_5 : _GEN_68; // @[priority_arbiter.scala 125:41:@5800.10]
  assign _GEN_70 = 3'h6 == critical_sel ? request_packed_from_request_queue_6 : _GEN_69; // @[priority_arbiter.scala 125:41:@5800.10]
  assign _GEN_71 = 3'h7 == critical_sel ? request_packed_from_request_queue_7 : _GEN_70; // @[priority_arbiter.scala 125:41:@5800.10]
  assign _T_807 = valid_sel == last_send_index; // @[priority_arbiter.scala 129:47:@5805.10]
  assign _T_808 = _T_807 & request_valid_out_reg; // @[priority_arbiter.scala 129:67:@5806.10]
  assign _T_810 = _T_808 == 1'h0; // @[priority_arbiter.scala 129:35:@5807.10]
  assign _T_812 = _T_810 | _T_789; // @[priority_arbiter.scala 129:93:@5809.10]
  assign _GEN_73 = 3'h1 == valid_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 128:83:@5810.10]
  assign _GEN_74 = 3'h2 == valid_sel ? request_valid_flatted_from_request_queue_2 : _GEN_73; // @[priority_arbiter.scala 128:83:@5810.10]
  assign _GEN_75 = 3'h3 == valid_sel ? request_valid_flatted_from_request_queue_3 : _GEN_74; // @[priority_arbiter.scala 128:83:@5810.10]
  assign _GEN_76 = 3'h4 == valid_sel ? request_valid_flatted_from_request_queue_4 : _GEN_75; // @[priority_arbiter.scala 128:83:@5810.10]
  assign _GEN_77 = 3'h5 == valid_sel ? request_valid_flatted_from_request_queue_5 : _GEN_76; // @[priority_arbiter.scala 128:83:@5810.10]
  assign _GEN_78 = 3'h6 == valid_sel ? request_valid_flatted_from_request_queue_6 : _GEN_77; // @[priority_arbiter.scala 128:83:@5810.10]
  assign _GEN_79 = 3'h7 == valid_sel ? request_valid_flatted_from_request_queue_7 : _GEN_78; // @[priority_arbiter.scala 128:83:@5810.10]
  assign _T_813 = _GEN_79 & _T_812; // @[priority_arbiter.scala 128:83:@5810.10]
  assign _GEN_81 = 3'h1 == valid_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter.scala 130:41:@5813.12]
  assign _GEN_82 = 3'h2 == valid_sel ? request_packed_from_request_queue_2 : _GEN_81; // @[priority_arbiter.scala 130:41:@5813.12]
  assign _GEN_83 = 3'h3 == valid_sel ? request_packed_from_request_queue_3 : _GEN_82; // @[priority_arbiter.scala 130:41:@5813.12]
  assign _GEN_84 = 3'h4 == valid_sel ? request_packed_from_request_queue_4 : _GEN_83; // @[priority_arbiter.scala 130:41:@5813.12]
  assign _GEN_85 = 3'h5 == valid_sel ? request_packed_from_request_queue_5 : _GEN_84; // @[priority_arbiter.scala 130:41:@5813.12]
  assign _GEN_86 = 3'h6 == valid_sel ? request_packed_from_request_queue_6 : _GEN_85; // @[priority_arbiter.scala 130:41:@5813.12]
  assign _GEN_87 = 3'h7 == valid_sel ? request_packed_from_request_queue_7 : _GEN_86; // @[priority_arbiter.scala 130:41:@5813.12]
  assign _GEN_88 = _T_813 ? _GEN_87 : 80'h0; // @[priority_arbiter.scala 129:130:@5812.10]
  assign _GEN_90 = _T_813 ? valid_sel : last_send_index; // @[priority_arbiter.scala 129:130:@5812.10]
  assign _GEN_91 = _T_802 ? _GEN_71 : _GEN_88; // @[priority_arbiter.scala 124:133:@5799.8]
  assign _GEN_92 = _T_802 ? 1'h1 : _T_813; // @[priority_arbiter.scala 124:133:@5799.8]
  assign _GEN_93 = _T_802 ? critical_sel : _GEN_90; // @[priority_arbiter.scala 124:133:@5799.8]
  assign _GEN_94 = _T_790 ? _GEN_91 : request_out_reg; // @[priority_arbiter.scala 122:101:@5788.6]
  assign _GEN_95 = _T_790 ? _GEN_92 : request_valid_out_reg; // @[priority_arbiter.scala 122:101:@5788.6]
  assign _GEN_96 = _T_790 ? _GEN_93 : last_send_index; // @[priority_arbiter.scala 122:101:@5788.6]
  assign _GEN_97 = reset ? 80'h0 : _GEN_94; // @[priority_arbiter.scala 118:29:@5778.4]
  assign _GEN_98 = reset ? 1'h0 : _GEN_95; // @[priority_arbiter.scala 118:29:@5778.4]
  assign _GEN_99 = reset ? 3'h0 : _GEN_96; // @[priority_arbiter.scala 118:29:@5778.4]
  assign issue_ack_out_vec_1 = fifo_queue_1_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@4998.4]
  assign issue_ack_out_vec_0 = fifo_queue_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@4980.4]
  assign _T_819 = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter.scala 147:47:@5830.4]
  assign issue_ack_out_vec_3 = fifo_queue_3_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5034.4]
  assign issue_ack_out_vec_2 = fifo_queue_2_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5016.4]
  assign _T_820 = {issue_ack_out_vec_3,issue_ack_out_vec_2}; // @[priority_arbiter.scala 147:47:@5831.4]
  assign _T_821 = {_T_820,_T_819}; // @[priority_arbiter.scala 147:47:@5832.4]
  assign issue_ack_out_vec_5 = fifo_queue_5_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5070.4]
  assign issue_ack_out_vec_4 = fifo_queue_4_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5052.4]
  assign _T_822 = {issue_ack_out_vec_5,issue_ack_out_vec_4}; // @[priority_arbiter.scala 147:47:@5833.4]
  assign issue_ack_out_vec_7 = fifo_queue_7_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5106.4]
  assign issue_ack_out_vec_6 = fifo_queue_6_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@4962.4 priority_arbiter.scala 45:50:@5088.4]
  assign _T_823 = {issue_ack_out_vec_7,issue_ack_out_vec_6}; // @[priority_arbiter.scala 147:47:@5834.4]
  assign _T_824 = {_T_823,_T_822}; // @[priority_arbiter.scala 147:47:@5835.4]
  assign io_issue_ack_out = {_T_824,_T_821}; // @[priority_arbiter.scala 147:26:@5837.4]
  assign io_request_out = request_out_reg; // @[priority_arbiter.scala 145:24:@5828.4]
  assign fifo_queue_clock = clock; // @[:@4972.4]
  assign fifo_queue_reset = reset; // @[:@4973.4]
  assign fifo_queue_io_request_in = {1'h0,request_packed_in_0}; // @[priority_arbiter.scala 43:45:@4977.4]
  assign fifo_queue_io_request_valid_in = io_request_valid_flatted_in[0]; // @[priority_arbiter.scala 44:51:@4979.4]
  assign fifo_queue_io_issue_ack_in = io_issue_ack_in & _T_737; // @[priority_arbiter.scala 51:47:@4986.4]
  assign fifo_queue_1_clock = clock; // @[:@4990.4]
  assign fifo_queue_1_reset = reset; // @[:@4991.4]
  assign fifo_queue_1_io_request_in = {1'h0,request_packed_in_1}; // @[priority_arbiter.scala 43:45:@4995.4]
  assign fifo_queue_1_io_request_valid_in = io_request_valid_flatted_in[1]; // @[priority_arbiter.scala 44:51:@4997.4]
  assign fifo_queue_1_io_issue_ack_in = io_issue_ack_in & _T_743; // @[priority_arbiter.scala 51:47:@5004.4]
  assign fifo_queue_2_clock = clock; // @[:@5008.4]
  assign fifo_queue_2_reset = reset; // @[:@5009.4]
  assign fifo_queue_2_io_request_in = {1'h0,request_packed_in_2}; // @[priority_arbiter.scala 43:45:@5013.4]
  assign fifo_queue_2_io_request_valid_in = io_request_valid_flatted_in[2]; // @[priority_arbiter.scala 44:51:@5015.4]
  assign fifo_queue_2_io_issue_ack_in = io_issue_ack_in & _T_749; // @[priority_arbiter.scala 51:47:@5022.4]
  assign fifo_queue_3_clock = clock; // @[:@5026.4]
  assign fifo_queue_3_reset = reset; // @[:@5027.4]
  assign fifo_queue_3_io_request_in = {1'h0,request_packed_in_3}; // @[priority_arbiter.scala 43:45:@5031.4]
  assign fifo_queue_3_io_request_valid_in = io_request_valid_flatted_in[3]; // @[priority_arbiter.scala 44:51:@5033.4]
  assign fifo_queue_3_io_issue_ack_in = io_issue_ack_in & _T_755; // @[priority_arbiter.scala 51:47:@5040.4]
  assign fifo_queue_4_clock = clock; // @[:@5044.4]
  assign fifo_queue_4_reset = reset; // @[:@5045.4]
  assign fifo_queue_4_io_request_in = {1'h0,request_packed_in_4}; // @[priority_arbiter.scala 43:45:@5049.4]
  assign fifo_queue_4_io_request_valid_in = io_request_valid_flatted_in[4]; // @[priority_arbiter.scala 44:51:@5051.4]
  assign fifo_queue_4_io_issue_ack_in = io_issue_ack_in & _T_761; // @[priority_arbiter.scala 51:47:@5058.4]
  assign fifo_queue_5_clock = clock; // @[:@5062.4]
  assign fifo_queue_5_reset = reset; // @[:@5063.4]
  assign fifo_queue_5_io_request_in = {1'h0,request_packed_in_5}; // @[priority_arbiter.scala 43:45:@5067.4]
  assign fifo_queue_5_io_request_valid_in = io_request_valid_flatted_in[5]; // @[priority_arbiter.scala 44:51:@5069.4]
  assign fifo_queue_5_io_issue_ack_in = io_issue_ack_in & _T_767; // @[priority_arbiter.scala 51:47:@5076.4]
  assign fifo_queue_6_clock = clock; // @[:@5080.4]
  assign fifo_queue_6_reset = reset; // @[:@5081.4]
  assign fifo_queue_6_io_request_in = {1'h0,request_packed_in_6}; // @[priority_arbiter.scala 43:45:@5085.4]
  assign fifo_queue_6_io_request_valid_in = io_request_valid_flatted_in[6]; // @[priority_arbiter.scala 44:51:@5087.4]
  assign fifo_queue_6_io_issue_ack_in = io_issue_ack_in & _T_773; // @[priority_arbiter.scala 51:47:@5094.4]
  assign fifo_queue_7_clock = clock; // @[:@5098.4]
  assign fifo_queue_7_reset = reset; // @[:@5099.4]
  assign fifo_queue_7_io_request_in = {1'h0,request_packed_in_7}; // @[priority_arbiter.scala 43:45:@5103.4]
  assign fifo_queue_7_io_request_valid_in = io_request_valid_flatted_in[7]; // @[priority_arbiter.scala 44:51:@5105.4]
  assign fifo_queue_7_io_issue_ack_in = io_issue_ack_in & _T_779; // @[priority_arbiter.scala 51:47:@5112.4]
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
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  valid_sel = _RAND_3[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  critical_sel = _RAND_4[2:0];
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
          if (_T_802) begin
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
            if (_T_813) begin
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
          if (_T_802) begin
            request_valid_out_reg <= 1'h1;
          end else begin
            request_valid_out_reg <= _T_813;
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
          if (_T_802) begin
            last_send_index <= critical_sel;
          end else begin
            if (_T_813) begin
              last_send_index <= valid_sel;
            end
          end
        end
      end
    end
    if (reset) begin
      valid_sel <= 3'h0;
    end else begin
      valid_sel <= _GEN_15[2:0];
    end
    if (reset) begin
      critical_sel <= 3'h0;
    end else begin
      critical_sel <= _GEN_31[2:0];
    end
  end
endmodule
module priority_arbiter_5( // @[:@6607.2]
  input          clock, // @[:@6608.4]
  input          reset, // @[:@6609.4]
  input  [319:0] io_request_flatted_in, // @[:@6610.4]
  input  [3:0]   io_request_valid_flatted_in, // @[:@6610.4]
  output [3:0]   io_issue_ack_out, // @[:@6610.4]
  output [79:0]  io_request_out, // @[:@6610.4]
  input          io_issue_ack_in // @[:@6610.4]
);
  wire  fifo_queue_clock; // @[priority_arbiter.scala 38:43:@6623.4]
  wire  fifo_queue_reset; // @[priority_arbiter.scala 38:43:@6623.4]
  wire  fifo_queue_io_is_empty_out; // @[priority_arbiter.scala 38:43:@6623.4]
  wire  fifo_queue_io_is_full_out; // @[priority_arbiter.scala 38:43:@6623.4]
  wire [80:0] fifo_queue_io_request_in; // @[priority_arbiter.scala 38:43:@6623.4]
  wire  fifo_queue_io_request_valid_in; // @[priority_arbiter.scala 38:43:@6623.4]
  wire  fifo_queue_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@6623.4]
  wire [80:0] fifo_queue_io_request_out; // @[priority_arbiter.scala 38:43:@6623.4]
  wire  fifo_queue_io_request_valid_out; // @[priority_arbiter.scala 38:43:@6623.4]
  wire  fifo_queue_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@6623.4]
  wire  fifo_queue_1_clock; // @[priority_arbiter.scala 38:43:@6641.4]
  wire  fifo_queue_1_reset; // @[priority_arbiter.scala 38:43:@6641.4]
  wire  fifo_queue_1_io_is_empty_out; // @[priority_arbiter.scala 38:43:@6641.4]
  wire  fifo_queue_1_io_is_full_out; // @[priority_arbiter.scala 38:43:@6641.4]
  wire [80:0] fifo_queue_1_io_request_in; // @[priority_arbiter.scala 38:43:@6641.4]
  wire  fifo_queue_1_io_request_valid_in; // @[priority_arbiter.scala 38:43:@6641.4]
  wire  fifo_queue_1_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@6641.4]
  wire [80:0] fifo_queue_1_io_request_out; // @[priority_arbiter.scala 38:43:@6641.4]
  wire  fifo_queue_1_io_request_valid_out; // @[priority_arbiter.scala 38:43:@6641.4]
  wire  fifo_queue_1_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@6641.4]
  wire  fifo_queue_2_clock; // @[priority_arbiter.scala 38:43:@6659.4]
  wire  fifo_queue_2_reset; // @[priority_arbiter.scala 38:43:@6659.4]
  wire  fifo_queue_2_io_is_empty_out; // @[priority_arbiter.scala 38:43:@6659.4]
  wire  fifo_queue_2_io_is_full_out; // @[priority_arbiter.scala 38:43:@6659.4]
  wire [80:0] fifo_queue_2_io_request_in; // @[priority_arbiter.scala 38:43:@6659.4]
  wire  fifo_queue_2_io_request_valid_in; // @[priority_arbiter.scala 38:43:@6659.4]
  wire  fifo_queue_2_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@6659.4]
  wire [80:0] fifo_queue_2_io_request_out; // @[priority_arbiter.scala 38:43:@6659.4]
  wire  fifo_queue_2_io_request_valid_out; // @[priority_arbiter.scala 38:43:@6659.4]
  wire  fifo_queue_2_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@6659.4]
  wire  fifo_queue_3_clock; // @[priority_arbiter.scala 38:43:@6677.4]
  wire  fifo_queue_3_reset; // @[priority_arbiter.scala 38:43:@6677.4]
  wire  fifo_queue_3_io_is_empty_out; // @[priority_arbiter.scala 38:43:@6677.4]
  wire  fifo_queue_3_io_is_full_out; // @[priority_arbiter.scala 38:43:@6677.4]
  wire [80:0] fifo_queue_3_io_request_in; // @[priority_arbiter.scala 38:43:@6677.4]
  wire  fifo_queue_3_io_request_valid_in; // @[priority_arbiter.scala 38:43:@6677.4]
  wire  fifo_queue_3_io_issue_ack_out; // @[priority_arbiter.scala 38:43:@6677.4]
  wire [80:0] fifo_queue_3_io_request_out; // @[priority_arbiter.scala 38:43:@6677.4]
  wire  fifo_queue_3_io_request_valid_out; // @[priority_arbiter.scala 38:43:@6677.4]
  wire  fifo_queue_3_io_issue_ack_in; // @[priority_arbiter.scala 38:43:@6677.4]
  reg [79:0] request_out_reg; // @[priority_arbiter.scala 22:38:@6612.4]
  reg [95:0] _RAND_0;
  reg  request_valid_out_reg; // @[priority_arbiter.scala 23:44:@6613.4]
  reg [31:0] _RAND_1;
  wire [79:0] request_packed_in_0; // @[priority_arbiter.scala 36:74:@6621.4]
  wire  request_critical_flatted_from_request_queue_0; // @[priority_arbiter.scala 47:107:@6633.4]
  wire [79:0] request_packed_from_request_queue_0; // @[priority_arbiter.scala 48:97:@6635.4]
  wire [79:0] request_packed_in_1; // @[priority_arbiter.scala 36:74:@6639.4]
  wire  request_critical_flatted_from_request_queue_1; // @[priority_arbiter.scala 47:107:@6651.4]
  wire [79:0] request_packed_from_request_queue_1; // @[priority_arbiter.scala 48:97:@6653.4]
  wire [79:0] request_packed_in_2; // @[priority_arbiter.scala 36:74:@6657.4]
  wire  request_critical_flatted_from_request_queue_2; // @[priority_arbiter.scala 47:107:@6669.4]
  wire [79:0] request_packed_from_request_queue_2; // @[priority_arbiter.scala 48:97:@6671.4]
  wire [79:0] request_packed_in_3; // @[priority_arbiter.scala 36:74:@6675.4]
  wire  request_critical_flatted_from_request_queue_3; // @[priority_arbiter.scala 47:107:@6687.4]
  wire [79:0] request_packed_from_request_queue_3; // @[priority_arbiter.scala 48:97:@6689.4]
  wire [1:0] _T_111; // @[priority_arbiter.scala 55:79:@6694.4]
  wire [1:0] _T_112; // @[priority_arbiter.scala 55:79:@6695.4]
  wire [3:0] _T_113; // @[priority_arbiter.scala 55:79:@6696.4]
  wire  request_queue_full_1; // @[priority_arbiter.scala 32:38:@6619.4 priority_arbiter.scala 42:51:@6644.4]
  wire  request_queue_full_0; // @[priority_arbiter.scala 32:38:@6619.4 priority_arbiter.scala 42:51:@6626.4]
  wire [1:0] _T_114; // @[priority_arbiter.scala 55:107:@6697.4]
  wire  request_queue_full_3; // @[priority_arbiter.scala 32:38:@6619.4 priority_arbiter.scala 42:51:@6680.4]
  wire  request_queue_full_2; // @[priority_arbiter.scala 32:38:@6619.4 priority_arbiter.scala 42:51:@6662.4]
  wire [1:0] _T_115; // @[priority_arbiter.scala 55:107:@6698.4]
  wire [3:0] _T_116; // @[priority_arbiter.scala 55:107:@6699.4]
  wire [3:0] request_critical_final; // @[priority_arbiter.scala 55:86:@6700.4]
  reg [1:0] last_send_index; // @[priority_arbiter.scala 56:38:@6702.4]
  reg [31:0] _RAND_2;
  wire  request_valid_flatted_from_request_queue_1; // @[priority_arbiter.scala 31:60:@6618.4 priority_arbiter.scala 50:73:@6655.4]
  wire  request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 31:60:@6618.4 priority_arbiter.scala 50:73:@6637.4]
  wire [1:0] _T_122; // @[priority_arbiter.scala 61:87:@6705.4]
  wire  request_valid_flatted_from_request_queue_3; // @[priority_arbiter.scala 31:60:@6618.4 priority_arbiter.scala 50:73:@6691.4]
  wire  request_valid_flatted_from_request_queue_2; // @[priority_arbiter.scala 31:60:@6618.4 priority_arbiter.scala 50:73:@6673.4]
  wire [1:0] _T_123; // @[priority_arbiter.scala 61:87:@6706.4]
  wire [3:0] _T_124; // @[priority_arbiter.scala 61:87:@6707.4]
  wire [2:0] _T_126; // @[priority_arbiter.scala 61:113:@6708.4]
  wire [1:0] _T_127; // @[priority_arbiter.scala 61:113:@6709.4]
  wire [3:0] _T_128; // @[priority_arbiter.scala 61:94:@6710.4]
  wire [2:0] _GEN_56; // @[priority_arbiter.scala 62:148:@6714.4]
  wire [3:0] _T_133; // @[priority_arbiter.scala 62:148:@6714.4]
  wire [3:0] _T_134; // @[priority_arbiter.scala 62:148:@6715.4]
  wire [2:0] _T_135; // @[priority_arbiter.scala 62:148:@6716.4]
  wire [3:0] _T_137; // @[priority_arbiter.scala 62:166:@6717.4]
  wire [3:0] _T_138; // @[priority_arbiter.scala 62:166:@6718.4]
  wire [2:0] _T_139; // @[priority_arbiter.scala 62:166:@6719.4]
  wire [10:0] _GEN_57; // @[priority_arbiter.scala 62:130:@6720.4]
  wire [10:0] _T_140; // @[priority_arbiter.scala 62:130:@6720.4]
  wire [10:0] _GEN_58; // @[priority_arbiter.scala 61:120:@6721.4]
  wire [10:0] _T_141; // @[priority_arbiter.scala 61:120:@6721.4]
  wire [3:0] _T_145; // @[priority_arbiter.scala 63:72:@6725.4]
  wire [10:0] _GEN_60; // @[priority_arbiter.scala 64:108:@6732.4]
  wire [10:0] _T_154; // @[priority_arbiter.scala 64:108:@6732.4]
  wire [10:0] _GEN_61; // @[priority_arbiter.scala 63:98:@6733.4]
  wire [10:0] _T_155; // @[priority_arbiter.scala 63:98:@6733.4]
  reg [1:0] valid_sel; // @[priority_arbiter.scala 67:32:@6735.4]
  reg [31:0] _RAND_3;
  wire [3:0] request_valid_flatted_shift_left; // @[priority_arbiter.scala 59:52:@6703.4 priority_arbiter.scala 61:42:@6722.4]
  wire  _T_159; // @[priority_arbiter.scala 70:55:@6737.4]
  wire [2:0] _T_161; // @[priority_arbiter.scala 71:47:@6739.6]
  wire [1:0] _T_162; // @[priority_arbiter.scala 71:47:@6740.6]
  wire [2:0] _T_164; // @[priority_arbiter.scala 71:68:@6741.6]
  wire [1:0] _T_165; // @[priority_arbiter.scala 71:68:@6742.6]
  wire [2:0] _GEN_62; // @[priority_arbiter.scala 72:89:@6749.8]
  wire [2:0] _GEN_1; // @[priority_arbiter.scala 70:75:@6738.4]
  wire  _T_184; // @[priority_arbiter.scala 70:55:@6762.4]
  wire [2:0] _T_186; // @[priority_arbiter.scala 71:47:@6764.6]
  wire [1:0] _T_187; // @[priority_arbiter.scala 71:47:@6765.6]
  wire [2:0] _T_189; // @[priority_arbiter.scala 71:68:@6766.6]
  wire [1:0] _T_190; // @[priority_arbiter.scala 71:68:@6767.6]
  wire [2:0] _GEN_63; // @[priority_arbiter.scala 72:89:@6774.8]
  wire [2:0] _GEN_3; // @[priority_arbiter.scala 70:75:@6763.4]
  wire  _T_209; // @[priority_arbiter.scala 70:55:@6787.4]
  wire [2:0] _T_214; // @[priority_arbiter.scala 71:68:@6791.6]
  wire [1:0] _T_215; // @[priority_arbiter.scala 71:68:@6792.6]
  wire [2:0] _GEN_64; // @[priority_arbiter.scala 72:89:@6799.8]
  wire [2:0] _GEN_5; // @[priority_arbiter.scala 70:75:@6788.4]
  wire  _T_234; // @[priority_arbiter.scala 70:55:@6812.4]
  wire [1:0] _T_237; // @[priority_arbiter.scala 71:47:@6815.6]
  wire [2:0] _T_239; // @[priority_arbiter.scala 71:68:@6816.6]
  wire [1:0] _T_240; // @[priority_arbiter.scala 71:68:@6817.6]
  wire [2:0] _GEN_65; // @[priority_arbiter.scala 72:89:@6824.8]
  wire [2:0] _GEN_7; // @[priority_arbiter.scala 70:75:@6813.4]
  reg [1:0] critical_sel; // @[priority_arbiter.scala 79:35:@6837.4]
  reg [31:0] _RAND_4;
  wire [3:0] request_critical_flatted_shift_left; // @[priority_arbiter.scala 60:55:@6704.4 priority_arbiter.scala 63:45:@6734.4]
  wire  _T_262; // @[priority_arbiter.scala 82:58:@6839.4]
  wire  _T_264; // @[priority_arbiter.scala 82:80:@6841.4]
  wire [2:0] _GEN_9; // @[priority_arbiter.scala 82:138:@6842.4]
  wire  _T_289; // @[priority_arbiter.scala 82:58:@6866.4]
  wire  _T_291; // @[priority_arbiter.scala 82:80:@6868.4]
  wire [2:0] _GEN_11; // @[priority_arbiter.scala 82:138:@6869.4]
  wire  _T_316; // @[priority_arbiter.scala 82:58:@6893.4]
  wire  _T_318; // @[priority_arbiter.scala 82:80:@6895.4]
  wire [2:0] _GEN_13; // @[priority_arbiter.scala 82:138:@6896.4]
  wire  _T_343; // @[priority_arbiter.scala 82:58:@6920.4]
  wire  _T_345; // @[priority_arbiter.scala 82:80:@6922.4]
  wire [2:0] _GEN_15; // @[priority_arbiter.scala 82:138:@6923.4]
  wire  _T_421; // @[priority_arbiter.scala 109:59:@7005.4]
  wire  _T_427; // @[priority_arbiter.scala 109:59:@7014.4]
  wire  _T_433; // @[priority_arbiter.scala 109:59:@7023.4]
  wire  _T_439; // @[priority_arbiter.scala 109:59:@7032.4]
  wire  _T_448; // @[priority_arbiter.scala 122:40:@7048.6]
  wire  _T_449; // @[priority_arbiter.scala 122:68:@7049.6]
  wire  _T_450; // @[priority_arbiter.scala 122:65:@7050.6]
  wire [3:0] _T_452; // @[priority_arbiter.scala 123:46:@7053.8]
  wire  _T_453; // @[priority_arbiter.scala 123:46:@7054.8]
  wire  _GEN_29; // @[priority_arbiter.scala 123:61:@7055.8]
  wire  _GEN_30; // @[priority_arbiter.scala 123:61:@7055.8]
  wire  _GEN_31; // @[priority_arbiter.scala 123:61:@7055.8]
  wire  _T_455; // @[priority_arbiter.scala 123:61:@7055.8]
  wire  _T_456; // @[priority_arbiter.scala 124:50:@7056.8]
  wire  _T_457; // @[priority_arbiter.scala 124:70:@7057.8]
  wire  _T_459; // @[priority_arbiter.scala 124:35:@7058.8]
  wire  _T_461; // @[priority_arbiter.scala 124:96:@7060.8]
  wire  _T_462; // @[priority_arbiter.scala 123:118:@7061.8]
  wire [79:0] _GEN_33; // @[priority_arbiter.scala 125:41:@7064.10]
  wire [79:0] _GEN_34; // @[priority_arbiter.scala 125:41:@7064.10]
  wire [79:0] _GEN_35; // @[priority_arbiter.scala 125:41:@7064.10]
  wire  _T_467; // @[priority_arbiter.scala 129:47:@7069.10]
  wire  _T_468; // @[priority_arbiter.scala 129:67:@7070.10]
  wire  _T_470; // @[priority_arbiter.scala 129:35:@7071.10]
  wire  _T_472; // @[priority_arbiter.scala 129:93:@7073.10]
  wire  _GEN_37; // @[priority_arbiter.scala 128:83:@7074.10]
  wire  _GEN_38; // @[priority_arbiter.scala 128:83:@7074.10]
  wire  _GEN_39; // @[priority_arbiter.scala 128:83:@7074.10]
  wire  _T_473; // @[priority_arbiter.scala 128:83:@7074.10]
  wire [79:0] _GEN_41; // @[priority_arbiter.scala 130:41:@7077.12]
  wire [79:0] _GEN_42; // @[priority_arbiter.scala 130:41:@7077.12]
  wire [79:0] _GEN_43; // @[priority_arbiter.scala 130:41:@7077.12]
  wire [79:0] _GEN_44; // @[priority_arbiter.scala 129:130:@7076.10]
  wire [1:0] _GEN_46; // @[priority_arbiter.scala 129:130:@7076.10]
  wire [79:0] _GEN_47; // @[priority_arbiter.scala 124:133:@7063.8]
  wire  _GEN_48; // @[priority_arbiter.scala 124:133:@7063.8]
  wire [1:0] _GEN_49; // @[priority_arbiter.scala 124:133:@7063.8]
  wire [79:0] _GEN_50; // @[priority_arbiter.scala 122:101:@7052.6]
  wire  _GEN_51; // @[priority_arbiter.scala 122:101:@7052.6]
  wire [1:0] _GEN_52; // @[priority_arbiter.scala 122:101:@7052.6]
  wire [79:0] _GEN_53; // @[priority_arbiter.scala 118:29:@7042.4]
  wire  _GEN_54; // @[priority_arbiter.scala 118:29:@7042.4]
  wire [1:0] _GEN_55; // @[priority_arbiter.scala 118:29:@7042.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter.scala 24:37:@6614.4 priority_arbiter.scala 45:50:@6650.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter.scala 24:37:@6614.4 priority_arbiter.scala 45:50:@6632.4]
  wire [1:0] _T_479; // @[priority_arbiter.scala 147:47:@7094.4]
  wire  issue_ack_out_vec_3; // @[priority_arbiter.scala 24:37:@6614.4 priority_arbiter.scala 45:50:@6686.4]
  wire  issue_ack_out_vec_2; // @[priority_arbiter.scala 24:37:@6614.4 priority_arbiter.scala 45:50:@6668.4]
  wire [1:0] _T_480; // @[priority_arbiter.scala 147:47:@7095.4]
  fifo_queue_2 fifo_queue ( // @[priority_arbiter.scala 38:43:@6623.4]
    .clock(fifo_queue_clock),
    .reset(fifo_queue_reset),
    .io_is_empty_out(fifo_queue_io_is_empty_out),
    .io_is_full_out(fifo_queue_io_is_full_out),
    .io_request_in(fifo_queue_io_request_in),
    .io_request_valid_in(fifo_queue_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_io_issue_ack_out),
    .io_request_out(fifo_queue_io_request_out),
    .io_request_valid_out(fifo_queue_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_1 ( // @[priority_arbiter.scala 38:43:@6641.4]
    .clock(fifo_queue_1_clock),
    .reset(fifo_queue_1_reset),
    .io_is_empty_out(fifo_queue_1_io_is_empty_out),
    .io_is_full_out(fifo_queue_1_io_is_full_out),
    .io_request_in(fifo_queue_1_io_request_in),
    .io_request_valid_in(fifo_queue_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_1_io_issue_ack_out),
    .io_request_out(fifo_queue_1_io_request_out),
    .io_request_valid_out(fifo_queue_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_1_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_2 ( // @[priority_arbiter.scala 38:43:@6659.4]
    .clock(fifo_queue_2_clock),
    .reset(fifo_queue_2_reset),
    .io_is_empty_out(fifo_queue_2_io_is_empty_out),
    .io_is_full_out(fifo_queue_2_io_is_full_out),
    .io_request_in(fifo_queue_2_io_request_in),
    .io_request_valid_in(fifo_queue_2_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_2_io_issue_ack_out),
    .io_request_out(fifo_queue_2_io_request_out),
    .io_request_valid_out(fifo_queue_2_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_2_io_issue_ack_in)
  );
  fifo_queue_2 fifo_queue_3 ( // @[priority_arbiter.scala 38:43:@6677.4]
    .clock(fifo_queue_3_clock),
    .reset(fifo_queue_3_reset),
    .io_is_empty_out(fifo_queue_3_io_is_empty_out),
    .io_is_full_out(fifo_queue_3_io_is_full_out),
    .io_request_in(fifo_queue_3_io_request_in),
    .io_request_valid_in(fifo_queue_3_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_3_io_issue_ack_out),
    .io_request_out(fifo_queue_3_io_request_out),
    .io_request_valid_out(fifo_queue_3_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_3_io_issue_ack_in)
  );
  assign request_packed_in_0 = io_request_flatted_in[79:0]; // @[priority_arbiter.scala 36:74:@6621.4]
  assign request_critical_flatted_from_request_queue_0 = fifo_queue_io_request_out[80]; // @[priority_arbiter.scala 47:107:@6633.4]
  assign request_packed_from_request_queue_0 = fifo_queue_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@6635.4]
  assign request_packed_in_1 = io_request_flatted_in[159:80]; // @[priority_arbiter.scala 36:74:@6639.4]
  assign request_critical_flatted_from_request_queue_1 = fifo_queue_1_io_request_out[80]; // @[priority_arbiter.scala 47:107:@6651.4]
  assign request_packed_from_request_queue_1 = fifo_queue_1_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@6653.4]
  assign request_packed_in_2 = io_request_flatted_in[239:160]; // @[priority_arbiter.scala 36:74:@6657.4]
  assign request_critical_flatted_from_request_queue_2 = fifo_queue_2_io_request_out[80]; // @[priority_arbiter.scala 47:107:@6669.4]
  assign request_packed_from_request_queue_2 = fifo_queue_2_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@6671.4]
  assign request_packed_in_3 = io_request_flatted_in[319:240]; // @[priority_arbiter.scala 36:74:@6675.4]
  assign request_critical_flatted_from_request_queue_3 = fifo_queue_3_io_request_out[80]; // @[priority_arbiter.scala 47:107:@6687.4]
  assign request_packed_from_request_queue_3 = fifo_queue_3_io_request_out[79:0]; // @[priority_arbiter.scala 48:97:@6689.4]
  assign _T_111 = {request_critical_flatted_from_request_queue_1,request_critical_flatted_from_request_queue_0}; // @[priority_arbiter.scala 55:79:@6694.4]
  assign _T_112 = {request_critical_flatted_from_request_queue_3,request_critical_flatted_from_request_queue_2}; // @[priority_arbiter.scala 55:79:@6695.4]
  assign _T_113 = {_T_112,_T_111}; // @[priority_arbiter.scala 55:79:@6696.4]
  assign request_queue_full_1 = fifo_queue_1_io_is_full_out; // @[priority_arbiter.scala 32:38:@6619.4 priority_arbiter.scala 42:51:@6644.4]
  assign request_queue_full_0 = fifo_queue_io_is_full_out; // @[priority_arbiter.scala 32:38:@6619.4 priority_arbiter.scala 42:51:@6626.4]
  assign _T_114 = {request_queue_full_1,request_queue_full_0}; // @[priority_arbiter.scala 55:107:@6697.4]
  assign request_queue_full_3 = fifo_queue_3_io_is_full_out; // @[priority_arbiter.scala 32:38:@6619.4 priority_arbiter.scala 42:51:@6680.4]
  assign request_queue_full_2 = fifo_queue_2_io_is_full_out; // @[priority_arbiter.scala 32:38:@6619.4 priority_arbiter.scala 42:51:@6662.4]
  assign _T_115 = {request_queue_full_3,request_queue_full_2}; // @[priority_arbiter.scala 55:107:@6698.4]
  assign _T_116 = {_T_115,_T_114}; // @[priority_arbiter.scala 55:107:@6699.4]
  assign request_critical_final = _T_113 | _T_116; // @[priority_arbiter.scala 55:86:@6700.4]
  assign request_valid_flatted_from_request_queue_1 = fifo_queue_1_io_request_valid_out; // @[priority_arbiter.scala 31:60:@6618.4 priority_arbiter.scala 50:73:@6655.4]
  assign request_valid_flatted_from_request_queue_0 = fifo_queue_io_request_valid_out; // @[priority_arbiter.scala 31:60:@6618.4 priority_arbiter.scala 50:73:@6637.4]
  assign _T_122 = {request_valid_flatted_from_request_queue_1,request_valid_flatted_from_request_queue_0}; // @[priority_arbiter.scala 61:87:@6705.4]
  assign request_valid_flatted_from_request_queue_3 = fifo_queue_3_io_request_valid_out; // @[priority_arbiter.scala 31:60:@6618.4 priority_arbiter.scala 50:73:@6691.4]
  assign request_valid_flatted_from_request_queue_2 = fifo_queue_2_io_request_valid_out; // @[priority_arbiter.scala 31:60:@6618.4 priority_arbiter.scala 50:73:@6673.4]
  assign _T_123 = {request_valid_flatted_from_request_queue_3,request_valid_flatted_from_request_queue_2}; // @[priority_arbiter.scala 61:87:@6706.4]
  assign _T_124 = {_T_123,_T_122}; // @[priority_arbiter.scala 61:87:@6707.4]
  assign _T_126 = last_send_index + 2'h1; // @[priority_arbiter.scala 61:113:@6708.4]
  assign _T_127 = _T_126[1:0]; // @[priority_arbiter.scala 61:113:@6709.4]
  assign _T_128 = _T_124 >> _T_127; // @[priority_arbiter.scala 61:94:@6710.4]
  assign _GEN_56 = {{1'd0}, last_send_index}; // @[priority_arbiter.scala 62:148:@6714.4]
  assign _T_133 = 3'h4 - _GEN_56; // @[priority_arbiter.scala 62:148:@6714.4]
  assign _T_134 = $unsigned(_T_133); // @[priority_arbiter.scala 62:148:@6715.4]
  assign _T_135 = _T_134[2:0]; // @[priority_arbiter.scala 62:148:@6716.4]
  assign _T_137 = _T_135 - 3'h1; // @[priority_arbiter.scala 62:166:@6717.4]
  assign _T_138 = $unsigned(_T_137); // @[priority_arbiter.scala 62:166:@6718.4]
  assign _T_139 = _T_138[2:0]; // @[priority_arbiter.scala 62:166:@6719.4]
  assign _GEN_57 = {{7'd0}, _T_124}; // @[priority_arbiter.scala 62:130:@6720.4]
  assign _T_140 = _GEN_57 << _T_139; // @[priority_arbiter.scala 62:130:@6720.4]
  assign _GEN_58 = {{7'd0}, _T_128}; // @[priority_arbiter.scala 61:120:@6721.4]
  assign _T_141 = _GEN_58 | _T_140; // @[priority_arbiter.scala 61:120:@6721.4]
  assign _T_145 = request_critical_final >> _T_127; // @[priority_arbiter.scala 63:72:@6725.4]
  assign _GEN_60 = {{7'd0}, request_critical_final}; // @[priority_arbiter.scala 64:108:@6732.4]
  assign _T_154 = _GEN_60 << _T_139; // @[priority_arbiter.scala 64:108:@6732.4]
  assign _GEN_61 = {{7'd0}, _T_145}; // @[priority_arbiter.scala 63:98:@6733.4]
  assign _T_155 = _GEN_61 | _T_154; // @[priority_arbiter.scala 63:98:@6733.4]
  assign request_valid_flatted_shift_left = _T_141[3:0]; // @[priority_arbiter.scala 59:52:@6703.4 priority_arbiter.scala 61:42:@6722.4]
  assign _T_159 = request_valid_flatted_shift_left[3]; // @[priority_arbiter.scala 70:55:@6737.4]
  assign _T_161 = last_send_index + 2'h3; // @[priority_arbiter.scala 71:47:@6739.6]
  assign _T_162 = _T_161[1:0]; // @[priority_arbiter.scala 71:47:@6740.6]
  assign _T_164 = _T_162 + 2'h1; // @[priority_arbiter.scala 71:68:@6741.6]
  assign _T_165 = _T_164[1:0]; // @[priority_arbiter.scala 71:68:@6742.6]
  assign _GEN_62 = {{1'd0}, _T_165}; // @[priority_arbiter.scala 72:89:@6749.8]
  assign _GEN_1 = _T_159 ? _GEN_62 : 3'h0; // @[priority_arbiter.scala 70:75:@6738.4]
  assign _T_184 = request_valid_flatted_shift_left[2]; // @[priority_arbiter.scala 70:55:@6762.4]
  assign _T_186 = last_send_index + 2'h2; // @[priority_arbiter.scala 71:47:@6764.6]
  assign _T_187 = _T_186[1:0]; // @[priority_arbiter.scala 71:47:@6765.6]
  assign _T_189 = _T_187 + 2'h1; // @[priority_arbiter.scala 71:68:@6766.6]
  assign _T_190 = _T_189[1:0]; // @[priority_arbiter.scala 71:68:@6767.6]
  assign _GEN_63 = {{1'd0}, _T_190}; // @[priority_arbiter.scala 72:89:@6774.8]
  assign _GEN_3 = _T_184 ? _GEN_63 : _GEN_1; // @[priority_arbiter.scala 70:75:@6763.4]
  assign _T_209 = request_valid_flatted_shift_left[1]; // @[priority_arbiter.scala 70:55:@6787.4]
  assign _T_214 = _T_127 + 2'h1; // @[priority_arbiter.scala 71:68:@6791.6]
  assign _T_215 = _T_214[1:0]; // @[priority_arbiter.scala 71:68:@6792.6]
  assign _GEN_64 = {{1'd0}, _T_215}; // @[priority_arbiter.scala 72:89:@6799.8]
  assign _GEN_5 = _T_209 ? _GEN_64 : _GEN_3; // @[priority_arbiter.scala 70:75:@6788.4]
  assign _T_234 = request_valid_flatted_shift_left[0]; // @[priority_arbiter.scala 70:55:@6812.4]
  assign _T_237 = _GEN_56[1:0]; // @[priority_arbiter.scala 71:47:@6815.6]
  assign _T_239 = _T_237 + 2'h1; // @[priority_arbiter.scala 71:68:@6816.6]
  assign _T_240 = _T_239[1:0]; // @[priority_arbiter.scala 71:68:@6817.6]
  assign _GEN_65 = {{1'd0}, _T_240}; // @[priority_arbiter.scala 72:89:@6824.8]
  assign _GEN_7 = _T_234 ? _GEN_65 : _GEN_5; // @[priority_arbiter.scala 70:75:@6813.4]
  assign request_critical_flatted_shift_left = _T_155[3:0]; // @[priority_arbiter.scala 60:55:@6704.4 priority_arbiter.scala 63:45:@6734.4]
  assign _T_262 = request_critical_flatted_shift_left[3]; // @[priority_arbiter.scala 82:58:@6839.4]
  assign _T_264 = _T_262 & _T_159; // @[priority_arbiter.scala 82:80:@6841.4]
  assign _GEN_9 = _T_264 ? _GEN_62 : 3'h0; // @[priority_arbiter.scala 82:138:@6842.4]
  assign _T_289 = request_critical_flatted_shift_left[2]; // @[priority_arbiter.scala 82:58:@6866.4]
  assign _T_291 = _T_289 & _T_184; // @[priority_arbiter.scala 82:80:@6868.4]
  assign _GEN_11 = _T_291 ? _GEN_63 : _GEN_9; // @[priority_arbiter.scala 82:138:@6869.4]
  assign _T_316 = request_critical_flatted_shift_left[1]; // @[priority_arbiter.scala 82:58:@6893.4]
  assign _T_318 = _T_316 & _T_209; // @[priority_arbiter.scala 82:80:@6895.4]
  assign _GEN_13 = _T_318 ? _GEN_64 : _GEN_11; // @[priority_arbiter.scala 82:138:@6896.4]
  assign _T_343 = request_critical_flatted_shift_left[0]; // @[priority_arbiter.scala 82:58:@6920.4]
  assign _T_345 = _T_343 & _T_234; // @[priority_arbiter.scala 82:80:@6922.4]
  assign _GEN_15 = _T_345 ? _GEN_65 : _GEN_13; // @[priority_arbiter.scala 82:138:@6923.4]
  assign _T_421 = last_send_index == 2'h0; // @[priority_arbiter.scala 109:59:@7005.4]
  assign _T_427 = last_send_index == 2'h1; // @[priority_arbiter.scala 109:59:@7014.4]
  assign _T_433 = last_send_index == 2'h2; // @[priority_arbiter.scala 109:59:@7023.4]
  assign _T_439 = last_send_index == 2'h3; // @[priority_arbiter.scala 109:59:@7032.4]
  assign _T_448 = io_issue_ack_in & request_valid_out_reg; // @[priority_arbiter.scala 122:40:@7048.6]
  assign _T_449 = ~ request_valid_out_reg; // @[priority_arbiter.scala 122:68:@7049.6]
  assign _T_450 = _T_448 | _T_449; // @[priority_arbiter.scala 122:65:@7050.6]
  assign _T_452 = request_critical_final >> critical_sel; // @[priority_arbiter.scala 123:46:@7053.8]
  assign _T_453 = _T_452[0]; // @[priority_arbiter.scala 123:46:@7054.8]
  assign _GEN_29 = 2'h1 == critical_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 123:61:@7055.8]
  assign _GEN_30 = 2'h2 == critical_sel ? request_valid_flatted_from_request_queue_2 : _GEN_29; // @[priority_arbiter.scala 123:61:@7055.8]
  assign _GEN_31 = 2'h3 == critical_sel ? request_valid_flatted_from_request_queue_3 : _GEN_30; // @[priority_arbiter.scala 123:61:@7055.8]
  assign _T_455 = _T_453 & _GEN_31; // @[priority_arbiter.scala 123:61:@7055.8]
  assign _T_456 = critical_sel == last_send_index; // @[priority_arbiter.scala 124:50:@7056.8]
  assign _T_457 = _T_456 & request_valid_out_reg; // @[priority_arbiter.scala 124:70:@7057.8]
  assign _T_459 = _T_457 == 1'h0; // @[priority_arbiter.scala 124:35:@7058.8]
  assign _T_461 = _T_459 | _T_449; // @[priority_arbiter.scala 124:96:@7060.8]
  assign _T_462 = _T_455 & _T_461; // @[priority_arbiter.scala 123:118:@7061.8]
  assign _GEN_33 = 2'h1 == critical_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter.scala 125:41:@7064.10]
  assign _GEN_34 = 2'h2 == critical_sel ? request_packed_from_request_queue_2 : _GEN_33; // @[priority_arbiter.scala 125:41:@7064.10]
  assign _GEN_35 = 2'h3 == critical_sel ? request_packed_from_request_queue_3 : _GEN_34; // @[priority_arbiter.scala 125:41:@7064.10]
  assign _T_467 = valid_sel == last_send_index; // @[priority_arbiter.scala 129:47:@7069.10]
  assign _T_468 = _T_467 & request_valid_out_reg; // @[priority_arbiter.scala 129:67:@7070.10]
  assign _T_470 = _T_468 == 1'h0; // @[priority_arbiter.scala 129:35:@7071.10]
  assign _T_472 = _T_470 | _T_449; // @[priority_arbiter.scala 129:93:@7073.10]
  assign _GEN_37 = 2'h1 == valid_sel ? request_valid_flatted_from_request_queue_1 : request_valid_flatted_from_request_queue_0; // @[priority_arbiter.scala 128:83:@7074.10]
  assign _GEN_38 = 2'h2 == valid_sel ? request_valid_flatted_from_request_queue_2 : _GEN_37; // @[priority_arbiter.scala 128:83:@7074.10]
  assign _GEN_39 = 2'h3 == valid_sel ? request_valid_flatted_from_request_queue_3 : _GEN_38; // @[priority_arbiter.scala 128:83:@7074.10]
  assign _T_473 = _GEN_39 & _T_472; // @[priority_arbiter.scala 128:83:@7074.10]
  assign _GEN_41 = 2'h1 == valid_sel ? request_packed_from_request_queue_1 : request_packed_from_request_queue_0; // @[priority_arbiter.scala 130:41:@7077.12]
  assign _GEN_42 = 2'h2 == valid_sel ? request_packed_from_request_queue_2 : _GEN_41; // @[priority_arbiter.scala 130:41:@7077.12]
  assign _GEN_43 = 2'h3 == valid_sel ? request_packed_from_request_queue_3 : _GEN_42; // @[priority_arbiter.scala 130:41:@7077.12]
  assign _GEN_44 = _T_473 ? _GEN_43 : 80'h0; // @[priority_arbiter.scala 129:130:@7076.10]
  assign _GEN_46 = _T_473 ? valid_sel : last_send_index; // @[priority_arbiter.scala 129:130:@7076.10]
  assign _GEN_47 = _T_462 ? _GEN_35 : _GEN_44; // @[priority_arbiter.scala 124:133:@7063.8]
  assign _GEN_48 = _T_462 ? 1'h1 : _T_473; // @[priority_arbiter.scala 124:133:@7063.8]
  assign _GEN_49 = _T_462 ? critical_sel : _GEN_46; // @[priority_arbiter.scala 124:133:@7063.8]
  assign _GEN_50 = _T_450 ? _GEN_47 : request_out_reg; // @[priority_arbiter.scala 122:101:@7052.6]
  assign _GEN_51 = _T_450 ? _GEN_48 : request_valid_out_reg; // @[priority_arbiter.scala 122:101:@7052.6]
  assign _GEN_52 = _T_450 ? _GEN_49 : last_send_index; // @[priority_arbiter.scala 122:101:@7052.6]
  assign _GEN_53 = reset ? 80'h0 : _GEN_50; // @[priority_arbiter.scala 118:29:@7042.4]
  assign _GEN_54 = reset ? 1'h0 : _GEN_51; // @[priority_arbiter.scala 118:29:@7042.4]
  assign _GEN_55 = reset ? 2'h0 : _GEN_52; // @[priority_arbiter.scala 118:29:@7042.4]
  assign issue_ack_out_vec_1 = fifo_queue_1_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@6614.4 priority_arbiter.scala 45:50:@6650.4]
  assign issue_ack_out_vec_0 = fifo_queue_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@6614.4 priority_arbiter.scala 45:50:@6632.4]
  assign _T_479 = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter.scala 147:47:@7094.4]
  assign issue_ack_out_vec_3 = fifo_queue_3_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@6614.4 priority_arbiter.scala 45:50:@6686.4]
  assign issue_ack_out_vec_2 = fifo_queue_2_io_issue_ack_out; // @[priority_arbiter.scala 24:37:@6614.4 priority_arbiter.scala 45:50:@6668.4]
  assign _T_480 = {issue_ack_out_vec_3,issue_ack_out_vec_2}; // @[priority_arbiter.scala 147:47:@7095.4]
  assign io_issue_ack_out = {_T_480,_T_479}; // @[priority_arbiter.scala 147:26:@7097.4]
  assign io_request_out = request_out_reg; // @[priority_arbiter.scala 145:24:@7092.4]
  assign fifo_queue_clock = clock; // @[:@6624.4]
  assign fifo_queue_reset = reset; // @[:@6625.4]
  assign fifo_queue_io_request_in = {1'h1,request_packed_in_0}; // @[priority_arbiter.scala 43:45:@6629.4]
  assign fifo_queue_io_request_valid_in = io_request_valid_flatted_in[0]; // @[priority_arbiter.scala 44:51:@6631.4]
  assign fifo_queue_io_issue_ack_in = io_issue_ack_in & _T_421; // @[priority_arbiter.scala 51:47:@6638.4]
  assign fifo_queue_1_clock = clock; // @[:@6642.4]
  assign fifo_queue_1_reset = reset; // @[:@6643.4]
  assign fifo_queue_1_io_request_in = {1'h1,request_packed_in_1}; // @[priority_arbiter.scala 43:45:@6647.4]
  assign fifo_queue_1_io_request_valid_in = io_request_valid_flatted_in[1]; // @[priority_arbiter.scala 44:51:@6649.4]
  assign fifo_queue_1_io_issue_ack_in = io_issue_ack_in & _T_427; // @[priority_arbiter.scala 51:47:@6656.4]
  assign fifo_queue_2_clock = clock; // @[:@6660.4]
  assign fifo_queue_2_reset = reset; // @[:@6661.4]
  assign fifo_queue_2_io_request_in = {1'h1,request_packed_in_2}; // @[priority_arbiter.scala 43:45:@6665.4]
  assign fifo_queue_2_io_request_valid_in = io_request_valid_flatted_in[2]; // @[priority_arbiter.scala 44:51:@6667.4]
  assign fifo_queue_2_io_issue_ack_in = io_issue_ack_in & _T_433; // @[priority_arbiter.scala 51:47:@6674.4]
  assign fifo_queue_3_clock = clock; // @[:@6678.4]
  assign fifo_queue_3_reset = reset; // @[:@6679.4]
  assign fifo_queue_3_io_request_in = {1'h1,request_packed_in_3}; // @[priority_arbiter.scala 43:45:@6683.4]
  assign fifo_queue_3_io_request_valid_in = io_request_valid_flatted_in[3]; // @[priority_arbiter.scala 44:51:@6685.4]
  assign fifo_queue_3_io_issue_ack_in = io_issue_ack_in & _T_439; // @[priority_arbiter.scala 51:47:@6692.4]
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
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  valid_sel = _RAND_3[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  critical_sel = _RAND_4[1:0];
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
          if (_T_462) begin
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
            if (_T_473) begin
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
          if (_T_462) begin
            request_valid_out_reg <= 1'h1;
          end else begin
            request_valid_out_reg <= _T_473;
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
          if (_T_462) begin
            last_send_index <= critical_sel;
          end else begin
            if (_T_473) begin
              last_send_index <= valid_sel;
            end
          end
        end
      end
    end
    if (reset) begin
      valid_sel <= 2'h0;
    end else begin
      valid_sel <= _GEN_7[1:0];
    end
    if (reset) begin
      critical_sel <= 2'h0;
    end else begin
      critical_sel <= _GEN_15[1:0];
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
  wire  fifo_queue_clock; // @[unified_cache.scala 152:57:@8373.4]
  wire  fifo_queue_reset; // @[unified_cache.scala 152:57:@8373.4]
  wire  fifo_queue_io_is_empty_out; // @[unified_cache.scala 152:57:@8373.4]
  wire  fifo_queue_io_is_full_out; // @[unified_cache.scala 152:57:@8373.4]
  wire [79:0] fifo_queue_io_request_in; // @[unified_cache.scala 152:57:@8373.4]
  wire  fifo_queue_io_request_valid_in; // @[unified_cache.scala 152:57:@8373.4]
  wire  fifo_queue_io_issue_ack_out; // @[unified_cache.scala 152:57:@8373.4]
  wire [79:0] fifo_queue_io_request_out; // @[unified_cache.scala 152:57:@8373.4]
  wire  fifo_queue_io_request_valid_out; // @[unified_cache.scala 152:57:@8373.4]
  wire  fifo_queue_io_issue_ack_in; // @[unified_cache.scala 152:57:@8373.4]
  wire  fifo_queue_1_clock; // @[unified_cache.scala 152:57:@8376.4]
  wire  fifo_queue_1_reset; // @[unified_cache.scala 152:57:@8376.4]
  wire  fifo_queue_1_io_is_empty_out; // @[unified_cache.scala 152:57:@8376.4]
  wire  fifo_queue_1_io_is_full_out; // @[unified_cache.scala 152:57:@8376.4]
  wire [79:0] fifo_queue_1_io_request_in; // @[unified_cache.scala 152:57:@8376.4]
  wire  fifo_queue_1_io_request_valid_in; // @[unified_cache.scala 152:57:@8376.4]
  wire  fifo_queue_1_io_issue_ack_out; // @[unified_cache.scala 152:57:@8376.4]
  wire [79:0] fifo_queue_1_io_request_out; // @[unified_cache.scala 152:57:@8376.4]
  wire  fifo_queue_1_io_request_valid_out; // @[unified_cache.scala 152:57:@8376.4]
  wire  fifo_queue_1_io_issue_ack_in; // @[unified_cache.scala 152:57:@8376.4]
  wire  unified_cache_bank_clock; // @[unified_cache.scala 205:28:@8460.4]
  wire  unified_cache_bank_reset; // @[unified_cache.scala 205:28:@8460.4]
  wire [159:0] unified_cache_bank_io_input_request_flatted_in; // @[unified_cache.scala 205:28:@8460.4]
  wire [1:0] unified_cache_bank_io_input_request_valid_flatted_in; // @[unified_cache.scala 205:28:@8460.4]
  wire [1:0] unified_cache_bank_io_input_request_critical_flatted_in; // @[unified_cache.scala 205:28:@8460.4]
  wire [1:0] unified_cache_bank_io_input_request_ack_out; // @[unified_cache.scala 205:28:@8460.4]
  wire [79:0] unified_cache_bank_io_fetched_request_in; // @[unified_cache.scala 205:28:@8460.4]
  wire  unified_cache_bank_io_fetched_request_valid_in; // @[unified_cache.scala 205:28:@8460.4]
  wire  unified_cache_bank_io_fetch_ack_out; // @[unified_cache.scala 205:28:@8460.4]
  wire [79:0] unified_cache_bank_io_miss_request_out; // @[unified_cache.scala 205:28:@8460.4]
  wire  unified_cache_bank_io_miss_request_valid_out; // @[unified_cache.scala 205:28:@8460.4]
  wire  unified_cache_bank_io_miss_request_ack_in; // @[unified_cache.scala 205:28:@8460.4]
  wire [79:0] unified_cache_bank_io_return_request_out; // @[unified_cache.scala 205:28:@8460.4]
  wire  unified_cache_bank_io_return_request_valid_out; // @[unified_cache.scala 205:28:@8460.4]
  wire  unified_cache_bank_io_return_request_ack_in; // @[unified_cache.scala 205:28:@8460.4]
  wire  unified_cache_bank_1_clock; // @[unified_cache.scala 205:28:@8526.4]
  wire  unified_cache_bank_1_reset; // @[unified_cache.scala 205:28:@8526.4]
  wire [159:0] unified_cache_bank_1_io_input_request_flatted_in; // @[unified_cache.scala 205:28:@8526.4]
  wire [1:0] unified_cache_bank_1_io_input_request_valid_flatted_in; // @[unified_cache.scala 205:28:@8526.4]
  wire [1:0] unified_cache_bank_1_io_input_request_critical_flatted_in; // @[unified_cache.scala 205:28:@8526.4]
  wire [1:0] unified_cache_bank_1_io_input_request_ack_out; // @[unified_cache.scala 205:28:@8526.4]
  wire [79:0] unified_cache_bank_1_io_fetched_request_in; // @[unified_cache.scala 205:28:@8526.4]
  wire  unified_cache_bank_1_io_fetched_request_valid_in; // @[unified_cache.scala 205:28:@8526.4]
  wire  unified_cache_bank_1_io_fetch_ack_out; // @[unified_cache.scala 205:28:@8526.4]
  wire [79:0] unified_cache_bank_1_io_miss_request_out; // @[unified_cache.scala 205:28:@8526.4]
  wire  unified_cache_bank_1_io_miss_request_valid_out; // @[unified_cache.scala 205:28:@8526.4]
  wire  unified_cache_bank_1_io_miss_request_ack_in; // @[unified_cache.scala 205:28:@8526.4]
  wire [79:0] unified_cache_bank_1_io_return_request_out; // @[unified_cache.scala 205:28:@8526.4]
  wire  unified_cache_bank_1_io_return_request_valid_out; // @[unified_cache.scala 205:28:@8526.4]
  wire  unified_cache_bank_1_io_return_request_ack_in; // @[unified_cache.scala 205:28:@8526.4]
  wire  unified_cache_bank_2_clock; // @[unified_cache.scala 205:28:@8592.4]
  wire  unified_cache_bank_2_reset; // @[unified_cache.scala 205:28:@8592.4]
  wire [159:0] unified_cache_bank_2_io_input_request_flatted_in; // @[unified_cache.scala 205:28:@8592.4]
  wire [1:0] unified_cache_bank_2_io_input_request_valid_flatted_in; // @[unified_cache.scala 205:28:@8592.4]
  wire [1:0] unified_cache_bank_2_io_input_request_critical_flatted_in; // @[unified_cache.scala 205:28:@8592.4]
  wire [1:0] unified_cache_bank_2_io_input_request_ack_out; // @[unified_cache.scala 205:28:@8592.4]
  wire [79:0] unified_cache_bank_2_io_fetched_request_in; // @[unified_cache.scala 205:28:@8592.4]
  wire  unified_cache_bank_2_io_fetched_request_valid_in; // @[unified_cache.scala 205:28:@8592.4]
  wire  unified_cache_bank_2_io_fetch_ack_out; // @[unified_cache.scala 205:28:@8592.4]
  wire [79:0] unified_cache_bank_2_io_miss_request_out; // @[unified_cache.scala 205:28:@8592.4]
  wire  unified_cache_bank_2_io_miss_request_valid_out; // @[unified_cache.scala 205:28:@8592.4]
  wire  unified_cache_bank_2_io_miss_request_ack_in; // @[unified_cache.scala 205:28:@8592.4]
  wire [79:0] unified_cache_bank_2_io_return_request_out; // @[unified_cache.scala 205:28:@8592.4]
  wire  unified_cache_bank_2_io_return_request_valid_out; // @[unified_cache.scala 205:28:@8592.4]
  wire  unified_cache_bank_2_io_return_request_ack_in; // @[unified_cache.scala 205:28:@8592.4]
  wire  unified_cache_bank_3_clock; // @[unified_cache.scala 205:28:@8658.4]
  wire  unified_cache_bank_3_reset; // @[unified_cache.scala 205:28:@8658.4]
  wire [159:0] unified_cache_bank_3_io_input_request_flatted_in; // @[unified_cache.scala 205:28:@8658.4]
  wire [1:0] unified_cache_bank_3_io_input_request_valid_flatted_in; // @[unified_cache.scala 205:28:@8658.4]
  wire [1:0] unified_cache_bank_3_io_input_request_critical_flatted_in; // @[unified_cache.scala 205:28:@8658.4]
  wire [1:0] unified_cache_bank_3_io_input_request_ack_out; // @[unified_cache.scala 205:28:@8658.4]
  wire [79:0] unified_cache_bank_3_io_fetched_request_in; // @[unified_cache.scala 205:28:@8658.4]
  wire  unified_cache_bank_3_io_fetched_request_valid_in; // @[unified_cache.scala 205:28:@8658.4]
  wire  unified_cache_bank_3_io_fetch_ack_out; // @[unified_cache.scala 205:28:@8658.4]
  wire [79:0] unified_cache_bank_3_io_miss_request_out; // @[unified_cache.scala 205:28:@8658.4]
  wire  unified_cache_bank_3_io_miss_request_valid_out; // @[unified_cache.scala 205:28:@8658.4]
  wire  unified_cache_bank_3_io_miss_request_ack_in; // @[unified_cache.scala 205:28:@8658.4]
  wire [79:0] unified_cache_bank_3_io_return_request_out; // @[unified_cache.scala 205:28:@8658.4]
  wire  unified_cache_bank_3_io_return_request_valid_out; // @[unified_cache.scala 205:28:@8658.4]
  wire  unified_cache_bank_3_io_return_request_ack_in; // @[unified_cache.scala 205:28:@8658.4]
  wire  to_mem_arbiter_clock; // @[unified_cache.scala 254:30:@8730.4]
  wire  to_mem_arbiter_reset; // @[unified_cache.scala 254:30:@8730.4]
  wire [639:0] to_mem_arbiter_io_request_flatted_in; // @[unified_cache.scala 254:30:@8730.4]
  wire [7:0] to_mem_arbiter_io_request_valid_flatted_in; // @[unified_cache.scala 254:30:@8730.4]
  wire [7:0] to_mem_arbiter_io_issue_ack_out; // @[unified_cache.scala 254:30:@8730.4]
  wire [79:0] to_mem_arbiter_io_request_out; // @[unified_cache.scala 254:30:@8730.4]
  wire  to_mem_arbiter_io_issue_ack_in; // @[unified_cache.scala 254:30:@8730.4]
  wire  priority_arbiter_clock; // @[unified_cache.scala 283:32:@8814.4]
  wire  priority_arbiter_reset; // @[unified_cache.scala 283:32:@8814.4]
  wire [319:0] priority_arbiter_io_request_flatted_in; // @[unified_cache.scala 283:32:@8814.4]
  wire [3:0] priority_arbiter_io_request_valid_flatted_in; // @[unified_cache.scala 283:32:@8814.4]
  wire [3:0] priority_arbiter_io_issue_ack_out; // @[unified_cache.scala 283:32:@8814.4]
  wire [79:0] priority_arbiter_io_request_out; // @[unified_cache.scala 283:32:@8814.4]
  wire  priority_arbiter_io_issue_ack_in; // @[unified_cache.scala 283:32:@8814.4]
  wire  priority_arbiter_1_clock; // @[unified_cache.scala 283:32:@8858.4]
  wire  priority_arbiter_1_reset; // @[unified_cache.scala 283:32:@8858.4]
  wire [319:0] priority_arbiter_1_io_request_flatted_in; // @[unified_cache.scala 283:32:@8858.4]
  wire [3:0] priority_arbiter_1_io_request_valid_flatted_in; // @[unified_cache.scala 283:32:@8858.4]
  wire [3:0] priority_arbiter_1_io_issue_ack_out; // @[unified_cache.scala 283:32:@8858.4]
  wire [79:0] priority_arbiter_1_io_request_out; // @[unified_cache.scala 283:32:@8858.4]
  wire  priority_arbiter_1_io_issue_ack_in; // @[unified_cache.scala 283:32:@8858.4]
  wire [79:0] input_packet_packed_0; // @[unified_cache.scala 157:66:@8396.4]
  wire [79:0] input_packet_packed_1; // @[unified_cache.scala 157:66:@8408.4]
  wire [79:0] input_queue_vec_0_request_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8382.4]
  wire [31:0] _T_288_0; // @[unified_cache.scala 189:31:@8434.4 unified_cache.scala 193:35:@8437.4]
  wire [1:0] _T_309; // @[unified_cache.scala 194:70:@8438.4]
  wire  _T_311; // @[unified_cache.scala 194:147:@8439.4]
  wire  input_queue_vec_0_request_valid_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8381.4]
  wire  _T_312; // @[unified_cache.scala 195:91:@8441.4]
  wire [79:0] input_queue_vec_1_request_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8390.4]
  wire [31:0] _T_288_1; // @[unified_cache.scala 189:31:@8434.4 unified_cache.scala 193:35:@8443.4]
  wire [1:0] _T_313; // @[unified_cache.scala 194:70:@8444.4]
  wire  _T_315; // @[unified_cache.scala 194:147:@8445.4]
  wire  input_queue_vec_1_request_valid_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8389.4]
  wire  _T_316; // @[unified_cache.scala 195:91:@8447.4]
  wire [31:0] _T_323; // @[unified_cache.scala 201:47:@8452.4]
  wire [1:0] _T_324; // @[unified_cache.scala 202:48:@8454.4]
  wire  _T_326; // @[unified_cache.scala 202:125:@8455.4]
  wire  _T_327; // @[unified_cache.scala 203:52:@8457.4]
  wire  _T_328; // @[unified_cache.scala 203:87:@8458.4]
  wire [1:0] _T_329; // @[unified_cache.scala 209:32:@8463.4]
  wire  _T_331; // @[unified_cache.scala 209:39:@8464.4]
  wire [159:0] _T_332; // @[unified_cache.scala 210:79:@8466.6]
  wire  input_queue_vec_1_is_full_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8394.4]
  wire  input_queue_vec_0_is_full_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8386.4]
  wire [3:0] miss_request_ack_flatted; // @[unified_cache.scala 261:62:@8757.4]
  wire  _T_366; // @[unified_cache.scala 194:147:@8505.4]
  wire  _T_367; // @[unified_cache.scala 195:91:@8507.4]
  wire  _T_370; // @[unified_cache.scala 194:147:@8511.4]
  wire  _T_371; // @[unified_cache.scala 195:91:@8513.4]
  wire  _T_381; // @[unified_cache.scala 202:125:@8521.4]
  wire  _T_383; // @[unified_cache.scala 203:87:@8524.4]
  wire [1:0] _T_384; // @[unified_cache.scala 209:32:@8529.4]
  wire  _T_386; // @[unified_cache.scala 209:39:@8530.4]
  wire  _T_421; // @[unified_cache.scala 194:147:@8571.4]
  wire  _T_422; // @[unified_cache.scala 195:91:@8573.4]
  wire  _T_425; // @[unified_cache.scala 194:147:@8577.4]
  wire  _T_426; // @[unified_cache.scala 195:91:@8579.4]
  wire  _T_436; // @[unified_cache.scala 202:125:@8587.4]
  wire  _T_438; // @[unified_cache.scala 203:87:@8590.4]
  wire [1:0] _T_439; // @[unified_cache.scala 209:32:@8595.4]
  wire  _T_441; // @[unified_cache.scala 209:39:@8596.4]
  wire  _T_476; // @[unified_cache.scala 194:147:@8637.4]
  wire  _T_477; // @[unified_cache.scala 195:91:@8639.4]
  wire  _T_480; // @[unified_cache.scala 194:147:@8643.4]
  wire  _T_481; // @[unified_cache.scala 195:91:@8645.4]
  wire  _T_491; // @[unified_cache.scala 202:125:@8653.4]
  wire  _T_493; // @[unified_cache.scala 203:87:@8656.4]
  wire [1:0] _T_494; // @[unified_cache.scala 209:32:@8661.4]
  wire  _T_496; // @[unified_cache.scala 209:39:@8662.4]
  wire  from_mem_packet_ack_flatted_1; // @[unified_cache.scala 172:41:@8421.4 unified_cache.scala 226:45:@8551.4]
  wire  from_mem_packet_ack_flatted_0; // @[unified_cache.scala 172:41:@8421.4 unified_cache.scala 226:45:@8485.4]
  wire [1:0] _T_505; // @[unified_cache.scala 245:61:@8698.4]
  wire  from_mem_packet_ack_flatted_3; // @[unified_cache.scala 172:41:@8421.4 unified_cache.scala 226:45:@8683.4]
  wire  from_mem_packet_ack_flatted_2; // @[unified_cache.scala 172:41:@8421.4 unified_cache.scala 226:45:@8617.4]
  wire [1:0] _T_506; // @[unified_cache.scala 245:61:@8699.4]
  wire [3:0] _T_507; // @[unified_cache.scala 245:61:@8700.4]
  wire [1:0] cache_to_input_queue_ack_flatted_0; // @[unified_cache.scala 171:46:@8420.4 unified_cache.scala 217:50:@8476.4]
  wire  cache_to_input_queue_ack_packed_0_0; // @[unified_cache.scala 249:110:@8704.4]
  wire [1:0] cache_to_input_queue_ack_flatted_1; // @[unified_cache.scala 171:46:@8420.4 unified_cache.scala 217:50:@8542.4]
  wire  cache_to_input_queue_ack_packed_0_1; // @[unified_cache.scala 249:110:@8706.4]
  wire [1:0] cache_to_input_queue_ack_flatted_2; // @[unified_cache.scala 171:46:@8420.4 unified_cache.scala 217:50:@8608.4]
  wire  cache_to_input_queue_ack_packed_0_2; // @[unified_cache.scala 249:110:@8708.4]
  wire [1:0] cache_to_input_queue_ack_flatted_3; // @[unified_cache.scala 171:46:@8420.4 unified_cache.scala 217:50:@8674.4]
  wire  cache_to_input_queue_ack_packed_0_3; // @[unified_cache.scala 249:110:@8710.4]
  wire [1:0] _T_592; // @[unified_cache.scala 251:96:@8712.4]
  wire [1:0] _T_593; // @[unified_cache.scala 251:96:@8713.4]
  wire [3:0] _T_594; // @[unified_cache.scala 251:96:@8714.4]
  wire  cache_to_input_queue_ack_packed_1_0; // @[unified_cache.scala 249:110:@8717.4]
  wire  cache_to_input_queue_ack_packed_1_1; // @[unified_cache.scala 249:110:@8719.4]
  wire  cache_to_input_queue_ack_packed_1_2; // @[unified_cache.scala 249:110:@8721.4]
  wire  cache_to_input_queue_ack_packed_1_3; // @[unified_cache.scala 249:110:@8723.4]
  wire [1:0] _T_601; // @[unified_cache.scala 251:96:@8725.4]
  wire [1:0] _T_602; // @[unified_cache.scala 251:96:@8726.4]
  wire [3:0] _T_603; // @[unified_cache.scala 251:96:@8727.4]
  wire [79:0] miss_request_flatted_1; // @[unified_cache.scala 173:34:@8422.4 unified_cache.scala 228:38:@8552.4]
  wire [79:0] miss_request_flatted_0; // @[unified_cache.scala 173:34:@8422.4 unified_cache.scala 228:38:@8486.4]
  wire [159:0] _T_606; // @[unified_cache.scala 258:68:@8733.4]
  wire [79:0] miss_request_flatted_3; // @[unified_cache.scala 173:34:@8422.4 unified_cache.scala 228:38:@8684.4]
  wire [79:0] miss_request_flatted_2; // @[unified_cache.scala 173:34:@8422.4 unified_cache.scala 228:38:@8618.4]
  wire [159:0] _T_607; // @[unified_cache.scala 258:68:@8734.4]
  wire [319:0] _T_608; // @[unified_cache.scala 258:68:@8735.4]
  wire  miss_request_valid_flatted_1; // @[unified_cache.scala 174:40:@8423.4 unified_cache.scala 229:44:@8553.4]
  wire  miss_request_valid_flatted_0; // @[unified_cache.scala 174:40:@8423.4 unified_cache.scala 229:44:@8487.4]
  wire [1:0] _T_613; // @[unified_cache.scala 259:80:@8741.4]
  wire  miss_request_valid_flatted_3; // @[unified_cache.scala 174:40:@8423.4 unified_cache.scala 229:44:@8685.4]
  wire  miss_request_valid_flatted_2; // @[unified_cache.scala 174:40:@8423.4 unified_cache.scala 229:44:@8619.4]
  wire [1:0] _T_614; // @[unified_cache.scala 259:80:@8742.4]
  wire [3:0] _T_615; // @[unified_cache.scala 259:80:@8743.4]
  wire [3:0] return_request_ack_flatted_0; // @[unified_cache.scala 267:40:@8763.4 unified_cache.scala 290:44:@8833.4]
  wire  return_request_ack_packed_0_0; // @[unified_cache.scala 271:98:@8765.4]
  wire [3:0] return_request_ack_flatted_1; // @[unified_cache.scala 267:40:@8763.4 unified_cache.scala 290:44:@8877.4]
  wire  return_request_ack_packed_0_1; // @[unified_cache.scala 271:98:@8767.4]
  wire [1:0] _T_724; // @[unified_cache.scala 273:84:@8769.4]
  wire  return_request_ack_packed_1_0; // @[unified_cache.scala 271:98:@8772.4]
  wire  return_request_ack_packed_1_1; // @[unified_cache.scala 271:98:@8774.4]
  wire [1:0] _T_729; // @[unified_cache.scala 273:84:@8776.4]
  wire  return_request_ack_packed_2_0; // @[unified_cache.scala 271:98:@8779.4]
  wire  return_request_ack_packed_2_1; // @[unified_cache.scala 271:98:@8781.4]
  wire [1:0] _T_734; // @[unified_cache.scala 273:84:@8783.4]
  wire  return_request_ack_packed_3_0; // @[unified_cache.scala 271:98:@8786.4]
  wire  return_request_ack_packed_3_1; // @[unified_cache.scala 271:98:@8788.4]
  wire [1:0] _T_739; // @[unified_cache.scala 273:84:@8790.4]
  wire [79:0] return_request_flatted_0; // @[unified_cache.scala 183:36:@8430.4 unified_cache.scala 238:40:@8496.4]
  wire [1:0] _T_752; // @[unified_cache.scala 279:71:@8794.4]
  wire  _T_754; // @[unified_cache.scala 279:164:@8795.4]
  wire  _T_755; // @[unified_cache.scala 280:71:@8796.4]
  wire  _T_756; // @[unified_cache.scala 279:182:@8797.4]
  wire [79:0] return_request_flatted_1; // @[unified_cache.scala 183:36:@8430.4 unified_cache.scala 238:40:@8562.4]
  wire [1:0] _T_757; // @[unified_cache.scala 279:71:@8799.4]
  wire  _T_759; // @[unified_cache.scala 279:164:@8800.4]
  wire  _T_760; // @[unified_cache.scala 280:71:@8801.4]
  wire  _T_761; // @[unified_cache.scala 279:182:@8802.4]
  wire [79:0] return_request_flatted_2; // @[unified_cache.scala 183:36:@8430.4 unified_cache.scala 238:40:@8628.4]
  wire [1:0] _T_762; // @[unified_cache.scala 279:71:@8804.4]
  wire  _T_764; // @[unified_cache.scala 279:164:@8805.4]
  wire  _T_765; // @[unified_cache.scala 280:71:@8806.4]
  wire  _T_766; // @[unified_cache.scala 279:182:@8807.4]
  wire [79:0] return_request_flatted_3; // @[unified_cache.scala 183:36:@8430.4 unified_cache.scala 238:40:@8694.4]
  wire [1:0] _T_767; // @[unified_cache.scala 279:71:@8809.4]
  wire  _T_769; // @[unified_cache.scala 279:164:@8810.4]
  wire  _T_770; // @[unified_cache.scala 280:71:@8811.4]
  wire  _T_771; // @[unified_cache.scala 279:182:@8812.4]
  wire [159:0] _T_772; // @[unified_cache.scala 287:68:@8817.4]
  wire [159:0] _T_773; // @[unified_cache.scala 287:68:@8818.4]
  wire  return_request_valid_flatted_1; // @[unified_cache.scala 184:42:@8431.4 unified_cache.scala 239:46:@8563.4]
  wire  return_request_valid_flatted_0; // @[unified_cache.scala 184:42:@8431.4 unified_cache.scala 239:46:@8497.4]
  wire [1:0] _T_775; // @[unified_cache.scala 288:80:@8821.4]
  wire  return_request_valid_flatted_3; // @[unified_cache.scala 184:42:@8431.4 unified_cache.scala 239:46:@8695.4]
  wire  return_request_valid_flatted_2; // @[unified_cache.scala 184:42:@8431.4 unified_cache.scala 239:46:@8629.4]
  wire [1:0] _T_776; // @[unified_cache.scala 288:80:@8822.4]
  wire [3:0] _T_777; // @[unified_cache.scala 288:80:@8823.4]
  wire [1:0] _T_778; // @[unified_cache.scala 288:103:@8824.4]
  wire [1:0] _T_779; // @[unified_cache.scala 288:103:@8825.4]
  wire [3:0] _T_780; // @[unified_cache.scala 288:103:@8826.4]
  wire  _T_798; // @[unified_cache.scala 279:164:@8839.4]
  wire  _T_800; // @[unified_cache.scala 279:182:@8841.4]
  wire  _T_803; // @[unified_cache.scala 279:164:@8844.4]
  wire  _T_805; // @[unified_cache.scala 279:182:@8846.4]
  wire  _T_808; // @[unified_cache.scala 279:164:@8849.4]
  wire  _T_810; // @[unified_cache.scala 279:182:@8851.4]
  wire  _T_813; // @[unified_cache.scala 279:164:@8854.4]
  wire  _T_815; // @[unified_cache.scala 279:182:@8856.4]
  wire [1:0] _T_822; // @[unified_cache.scala 288:103:@8868.4]
  wire [1:0] _T_823; // @[unified_cache.scala 288:103:@8869.4]
  wire [3:0] _T_824; // @[unified_cache.scala 288:103:@8870.4]
  wire  input_queue_vec_1_issue_ack_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8391.4]
  wire  input_queue_vec_0_issue_ack_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8383.4]
  wire [79:0] return_packet_flatted_out_vec_1; // @[unified_cache.scala 142:43:@8365.4 unified_cache.scala 291:47:@8878.4]
  wire [79:0] return_packet_flatted_out_vec_0; // @[unified_cache.scala 142:43:@8365.4 unified_cache.scala 291:47:@8834.4]
  fifo_queue fifo_queue ( // @[unified_cache.scala 152:57:@8373.4]
    .clock(fifo_queue_clock),
    .reset(fifo_queue_reset),
    .io_is_empty_out(fifo_queue_io_is_empty_out),
    .io_is_full_out(fifo_queue_io_is_full_out),
    .io_request_in(fifo_queue_io_request_in),
    .io_request_valid_in(fifo_queue_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_io_issue_ack_out),
    .io_request_out(fifo_queue_io_request_out),
    .io_request_valid_out(fifo_queue_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_io_issue_ack_in)
  );
  fifo_queue fifo_queue_1 ( // @[unified_cache.scala 152:57:@8376.4]
    .clock(fifo_queue_1_clock),
    .reset(fifo_queue_1_reset),
    .io_is_empty_out(fifo_queue_1_io_is_empty_out),
    .io_is_full_out(fifo_queue_1_io_is_full_out),
    .io_request_in(fifo_queue_1_io_request_in),
    .io_request_valid_in(fifo_queue_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_1_io_issue_ack_out),
    .io_request_out(fifo_queue_1_io_request_out),
    .io_request_valid_out(fifo_queue_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_1_io_issue_ack_in)
  );
  unified_cache_bank unified_cache_bank ( // @[unified_cache.scala 205:28:@8460.4]
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
  unified_cache_bank unified_cache_bank_1 ( // @[unified_cache.scala 205:28:@8526.4]
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
  unified_cache_bank unified_cache_bank_2 ( // @[unified_cache.scala 205:28:@8592.4]
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
  unified_cache_bank unified_cache_bank_3 ( // @[unified_cache.scala 205:28:@8658.4]
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
  priority_arbiter_4 to_mem_arbiter ( // @[unified_cache.scala 254:30:@8730.4]
    .clock(to_mem_arbiter_clock),
    .reset(to_mem_arbiter_reset),
    .io_request_flatted_in(to_mem_arbiter_io_request_flatted_in),
    .io_request_valid_flatted_in(to_mem_arbiter_io_request_valid_flatted_in),
    .io_issue_ack_out(to_mem_arbiter_io_issue_ack_out),
    .io_request_out(to_mem_arbiter_io_request_out),
    .io_issue_ack_in(to_mem_arbiter_io_issue_ack_in)
  );
  priority_arbiter_5 priority_arbiter ( // @[unified_cache.scala 283:32:@8814.4]
    .clock(priority_arbiter_clock),
    .reset(priority_arbiter_reset),
    .io_request_flatted_in(priority_arbiter_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_io_request_valid_flatted_in),
    .io_issue_ack_out(priority_arbiter_io_issue_ack_out),
    .io_request_out(priority_arbiter_io_request_out),
    .io_issue_ack_in(priority_arbiter_io_issue_ack_in)
  );
  priority_arbiter_5 priority_arbiter_1 ( // @[unified_cache.scala 283:32:@8858.4]
    .clock(priority_arbiter_1_clock),
    .reset(priority_arbiter_1_reset),
    .io_request_flatted_in(priority_arbiter_1_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_1_io_request_valid_flatted_in),
    .io_issue_ack_out(priority_arbiter_1_io_issue_ack_out),
    .io_request_out(priority_arbiter_1_io_request_out),
    .io_issue_ack_in(priority_arbiter_1_io_issue_ack_in)
  );
  assign input_packet_packed_0 = io_input_packet_flatted_in[79:0]; // @[unified_cache.scala 157:66:@8396.4]
  assign input_packet_packed_1 = io_input_packet_flatted_in[159:80]; // @[unified_cache.scala 157:66:@8408.4]
  assign input_queue_vec_0_request_out = fifo_queue_io_request_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8382.4]
  assign _T_288_0 = input_queue_vec_0_request_out[31:0]; // @[unified_cache.scala 189:31:@8434.4 unified_cache.scala 193:35:@8437.4]
  assign _T_309 = _T_288_0[3:2]; // @[unified_cache.scala 194:70:@8438.4]
  assign _T_311 = _T_309 == 2'h0; // @[unified_cache.scala 194:147:@8439.4]
  assign input_queue_vec_0_request_valid_out = fifo_queue_io_request_valid_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8381.4]
  assign _T_312 = input_queue_vec_0_request_valid_out & _T_311; // @[unified_cache.scala 195:91:@8441.4]
  assign input_queue_vec_1_request_out = fifo_queue_1_io_request_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8390.4]
  assign _T_288_1 = input_queue_vec_1_request_out[31:0]; // @[unified_cache.scala 189:31:@8434.4 unified_cache.scala 193:35:@8443.4]
  assign _T_313 = _T_288_1[3:2]; // @[unified_cache.scala 194:70:@8444.4]
  assign _T_315 = _T_313 == 2'h0; // @[unified_cache.scala 194:147:@8445.4]
  assign input_queue_vec_1_request_valid_out = fifo_queue_1_io_request_valid_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8389.4]
  assign _T_316 = input_queue_vec_1_request_valid_out & _T_315; // @[unified_cache.scala 195:91:@8447.4]
  assign _T_323 = io_from_mem_packet_in[31:0]; // @[unified_cache.scala 201:47:@8452.4]
  assign _T_324 = _T_323[3:2]; // @[unified_cache.scala 202:48:@8454.4]
  assign _T_326 = _T_324 == 2'h0; // @[unified_cache.scala 202:125:@8455.4]
  assign _T_327 = io_from_mem_packet_in[77]; // @[unified_cache.scala 203:52:@8457.4]
  assign _T_328 = _T_327 & _T_326; // @[unified_cache.scala 203:87:@8458.4]
  assign _T_329 = {_T_316,_T_312}; // @[unified_cache.scala 209:32:@8463.4]
  assign _T_331 = _T_329 > 2'h0; // @[unified_cache.scala 209:39:@8464.4]
  assign _T_332 = {input_queue_vec_1_request_out,input_queue_vec_0_request_out}; // @[unified_cache.scala 210:79:@8466.6]
  assign input_queue_vec_1_is_full_out = fifo_queue_1_io_is_full_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8394.4]
  assign input_queue_vec_0_is_full_out = fifo_queue_io_is_full_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8386.4]
  assign miss_request_ack_flatted = to_mem_arbiter_io_issue_ack_out[7:4]; // @[unified_cache.scala 261:62:@8757.4]
  assign _T_366 = _T_309 == 2'h1; // @[unified_cache.scala 194:147:@8505.4]
  assign _T_367 = input_queue_vec_0_request_valid_out & _T_366; // @[unified_cache.scala 195:91:@8507.4]
  assign _T_370 = _T_313 == 2'h1; // @[unified_cache.scala 194:147:@8511.4]
  assign _T_371 = input_queue_vec_1_request_valid_out & _T_370; // @[unified_cache.scala 195:91:@8513.4]
  assign _T_381 = _T_324 == 2'h1; // @[unified_cache.scala 202:125:@8521.4]
  assign _T_383 = _T_327 & _T_381; // @[unified_cache.scala 203:87:@8524.4]
  assign _T_384 = {_T_371,_T_367}; // @[unified_cache.scala 209:32:@8529.4]
  assign _T_386 = _T_384 > 2'h0; // @[unified_cache.scala 209:39:@8530.4]
  assign _T_421 = _T_309 == 2'h2; // @[unified_cache.scala 194:147:@8571.4]
  assign _T_422 = input_queue_vec_0_request_valid_out & _T_421; // @[unified_cache.scala 195:91:@8573.4]
  assign _T_425 = _T_313 == 2'h2; // @[unified_cache.scala 194:147:@8577.4]
  assign _T_426 = input_queue_vec_1_request_valid_out & _T_425; // @[unified_cache.scala 195:91:@8579.4]
  assign _T_436 = _T_324 == 2'h2; // @[unified_cache.scala 202:125:@8587.4]
  assign _T_438 = _T_327 & _T_436; // @[unified_cache.scala 203:87:@8590.4]
  assign _T_439 = {_T_426,_T_422}; // @[unified_cache.scala 209:32:@8595.4]
  assign _T_441 = _T_439 > 2'h0; // @[unified_cache.scala 209:39:@8596.4]
  assign _T_476 = _T_309 == 2'h3; // @[unified_cache.scala 194:147:@8637.4]
  assign _T_477 = input_queue_vec_0_request_valid_out & _T_476; // @[unified_cache.scala 195:91:@8639.4]
  assign _T_480 = _T_313 == 2'h3; // @[unified_cache.scala 194:147:@8643.4]
  assign _T_481 = input_queue_vec_1_request_valid_out & _T_480; // @[unified_cache.scala 195:91:@8645.4]
  assign _T_491 = _T_324 == 2'h3; // @[unified_cache.scala 202:125:@8653.4]
  assign _T_493 = _T_327 & _T_491; // @[unified_cache.scala 203:87:@8656.4]
  assign _T_494 = {_T_481,_T_477}; // @[unified_cache.scala 209:32:@8661.4]
  assign _T_496 = _T_494 > 2'h0; // @[unified_cache.scala 209:39:@8662.4]
  assign from_mem_packet_ack_flatted_1 = unified_cache_bank_1_io_fetch_ack_out; // @[unified_cache.scala 172:41:@8421.4 unified_cache.scala 226:45:@8551.4]
  assign from_mem_packet_ack_flatted_0 = unified_cache_bank_io_fetch_ack_out; // @[unified_cache.scala 172:41:@8421.4 unified_cache.scala 226:45:@8485.4]
  assign _T_505 = {from_mem_packet_ack_flatted_1,from_mem_packet_ack_flatted_0}; // @[unified_cache.scala 245:61:@8698.4]
  assign from_mem_packet_ack_flatted_3 = unified_cache_bank_3_io_fetch_ack_out; // @[unified_cache.scala 172:41:@8421.4 unified_cache.scala 226:45:@8683.4]
  assign from_mem_packet_ack_flatted_2 = unified_cache_bank_2_io_fetch_ack_out; // @[unified_cache.scala 172:41:@8421.4 unified_cache.scala 226:45:@8617.4]
  assign _T_506 = {from_mem_packet_ack_flatted_3,from_mem_packet_ack_flatted_2}; // @[unified_cache.scala 245:61:@8699.4]
  assign _T_507 = {_T_506,_T_505}; // @[unified_cache.scala 245:61:@8700.4]
  assign cache_to_input_queue_ack_flatted_0 = unified_cache_bank_io_input_request_ack_out; // @[unified_cache.scala 171:46:@8420.4 unified_cache.scala 217:50:@8476.4]
  assign cache_to_input_queue_ack_packed_0_0 = cache_to_input_queue_ack_flatted_0[0]; // @[unified_cache.scala 249:110:@8704.4]
  assign cache_to_input_queue_ack_flatted_1 = unified_cache_bank_1_io_input_request_ack_out; // @[unified_cache.scala 171:46:@8420.4 unified_cache.scala 217:50:@8542.4]
  assign cache_to_input_queue_ack_packed_0_1 = cache_to_input_queue_ack_flatted_1[0]; // @[unified_cache.scala 249:110:@8706.4]
  assign cache_to_input_queue_ack_flatted_2 = unified_cache_bank_2_io_input_request_ack_out; // @[unified_cache.scala 171:46:@8420.4 unified_cache.scala 217:50:@8608.4]
  assign cache_to_input_queue_ack_packed_0_2 = cache_to_input_queue_ack_flatted_2[0]; // @[unified_cache.scala 249:110:@8708.4]
  assign cache_to_input_queue_ack_flatted_3 = unified_cache_bank_3_io_input_request_ack_out; // @[unified_cache.scala 171:46:@8420.4 unified_cache.scala 217:50:@8674.4]
  assign cache_to_input_queue_ack_packed_0_3 = cache_to_input_queue_ack_flatted_3[0]; // @[unified_cache.scala 249:110:@8710.4]
  assign _T_592 = {cache_to_input_queue_ack_packed_0_1,cache_to_input_queue_ack_packed_0_0}; // @[unified_cache.scala 251:96:@8712.4]
  assign _T_593 = {cache_to_input_queue_ack_packed_0_3,cache_to_input_queue_ack_packed_0_2}; // @[unified_cache.scala 251:96:@8713.4]
  assign _T_594 = {_T_593,_T_592}; // @[unified_cache.scala 251:96:@8714.4]
  assign cache_to_input_queue_ack_packed_1_0 = cache_to_input_queue_ack_flatted_0[1]; // @[unified_cache.scala 249:110:@8717.4]
  assign cache_to_input_queue_ack_packed_1_1 = cache_to_input_queue_ack_flatted_1[1]; // @[unified_cache.scala 249:110:@8719.4]
  assign cache_to_input_queue_ack_packed_1_2 = cache_to_input_queue_ack_flatted_2[1]; // @[unified_cache.scala 249:110:@8721.4]
  assign cache_to_input_queue_ack_packed_1_3 = cache_to_input_queue_ack_flatted_3[1]; // @[unified_cache.scala 249:110:@8723.4]
  assign _T_601 = {cache_to_input_queue_ack_packed_1_1,cache_to_input_queue_ack_packed_1_0}; // @[unified_cache.scala 251:96:@8725.4]
  assign _T_602 = {cache_to_input_queue_ack_packed_1_3,cache_to_input_queue_ack_packed_1_2}; // @[unified_cache.scala 251:96:@8726.4]
  assign _T_603 = {_T_602,_T_601}; // @[unified_cache.scala 251:96:@8727.4]
  assign miss_request_flatted_1 = unified_cache_bank_1_io_miss_request_out; // @[unified_cache.scala 173:34:@8422.4 unified_cache.scala 228:38:@8552.4]
  assign miss_request_flatted_0 = unified_cache_bank_io_miss_request_out; // @[unified_cache.scala 173:34:@8422.4 unified_cache.scala 228:38:@8486.4]
  assign _T_606 = {miss_request_flatted_1,miss_request_flatted_0}; // @[unified_cache.scala 258:68:@8733.4]
  assign miss_request_flatted_3 = unified_cache_bank_3_io_miss_request_out; // @[unified_cache.scala 173:34:@8422.4 unified_cache.scala 228:38:@8684.4]
  assign miss_request_flatted_2 = unified_cache_bank_2_io_miss_request_out; // @[unified_cache.scala 173:34:@8422.4 unified_cache.scala 228:38:@8618.4]
  assign _T_607 = {miss_request_flatted_3,miss_request_flatted_2}; // @[unified_cache.scala 258:68:@8734.4]
  assign _T_608 = {_T_607,_T_606}; // @[unified_cache.scala 258:68:@8735.4]
  assign miss_request_valid_flatted_1 = unified_cache_bank_1_io_miss_request_valid_out; // @[unified_cache.scala 174:40:@8423.4 unified_cache.scala 229:44:@8553.4]
  assign miss_request_valid_flatted_0 = unified_cache_bank_io_miss_request_valid_out; // @[unified_cache.scala 174:40:@8423.4 unified_cache.scala 229:44:@8487.4]
  assign _T_613 = {miss_request_valid_flatted_1,miss_request_valid_flatted_0}; // @[unified_cache.scala 259:80:@8741.4]
  assign miss_request_valid_flatted_3 = unified_cache_bank_3_io_miss_request_valid_out; // @[unified_cache.scala 174:40:@8423.4 unified_cache.scala 229:44:@8685.4]
  assign miss_request_valid_flatted_2 = unified_cache_bank_2_io_miss_request_valid_out; // @[unified_cache.scala 174:40:@8423.4 unified_cache.scala 229:44:@8619.4]
  assign _T_614 = {miss_request_valid_flatted_3,miss_request_valid_flatted_2}; // @[unified_cache.scala 259:80:@8742.4]
  assign _T_615 = {_T_614,_T_613}; // @[unified_cache.scala 259:80:@8743.4]
  assign return_request_ack_flatted_0 = priority_arbiter_io_issue_ack_out; // @[unified_cache.scala 267:40:@8763.4 unified_cache.scala 290:44:@8833.4]
  assign return_request_ack_packed_0_0 = return_request_ack_flatted_0[0]; // @[unified_cache.scala 271:98:@8765.4]
  assign return_request_ack_flatted_1 = priority_arbiter_1_io_issue_ack_out; // @[unified_cache.scala 267:40:@8763.4 unified_cache.scala 290:44:@8877.4]
  assign return_request_ack_packed_0_1 = return_request_ack_flatted_1[0]; // @[unified_cache.scala 271:98:@8767.4]
  assign _T_724 = {return_request_ack_packed_0_1,return_request_ack_packed_0_0}; // @[unified_cache.scala 273:84:@8769.4]
  assign return_request_ack_packed_1_0 = return_request_ack_flatted_0[1]; // @[unified_cache.scala 271:98:@8772.4]
  assign return_request_ack_packed_1_1 = return_request_ack_flatted_1[1]; // @[unified_cache.scala 271:98:@8774.4]
  assign _T_729 = {return_request_ack_packed_1_1,return_request_ack_packed_1_0}; // @[unified_cache.scala 273:84:@8776.4]
  assign return_request_ack_packed_2_0 = return_request_ack_flatted_0[2]; // @[unified_cache.scala 271:98:@8779.4]
  assign return_request_ack_packed_2_1 = return_request_ack_flatted_1[2]; // @[unified_cache.scala 271:98:@8781.4]
  assign _T_734 = {return_request_ack_packed_2_1,return_request_ack_packed_2_0}; // @[unified_cache.scala 273:84:@8783.4]
  assign return_request_ack_packed_3_0 = return_request_ack_flatted_0[3]; // @[unified_cache.scala 271:98:@8786.4]
  assign return_request_ack_packed_3_1 = return_request_ack_flatted_1[3]; // @[unified_cache.scala 271:98:@8788.4]
  assign _T_739 = {return_request_ack_packed_3_1,return_request_ack_packed_3_0}; // @[unified_cache.scala 273:84:@8790.4]
  assign return_request_flatted_0 = unified_cache_bank_io_return_request_out; // @[unified_cache.scala 183:36:@8430.4 unified_cache.scala 238:40:@8496.4]
  assign _T_752 = return_request_flatted_0[73:72]; // @[unified_cache.scala 279:71:@8794.4]
  assign _T_754 = _T_752 == 2'h0; // @[unified_cache.scala 279:164:@8795.4]
  assign _T_755 = return_request_flatted_0[77]; // @[unified_cache.scala 280:71:@8796.4]
  assign _T_756 = _T_754 & _T_755; // @[unified_cache.scala 279:182:@8797.4]
  assign return_request_flatted_1 = unified_cache_bank_1_io_return_request_out; // @[unified_cache.scala 183:36:@8430.4 unified_cache.scala 238:40:@8562.4]
  assign _T_757 = return_request_flatted_1[73:72]; // @[unified_cache.scala 279:71:@8799.4]
  assign _T_759 = _T_757 == 2'h0; // @[unified_cache.scala 279:164:@8800.4]
  assign _T_760 = return_request_flatted_1[77]; // @[unified_cache.scala 280:71:@8801.4]
  assign _T_761 = _T_759 & _T_760; // @[unified_cache.scala 279:182:@8802.4]
  assign return_request_flatted_2 = unified_cache_bank_2_io_return_request_out; // @[unified_cache.scala 183:36:@8430.4 unified_cache.scala 238:40:@8628.4]
  assign _T_762 = return_request_flatted_2[73:72]; // @[unified_cache.scala 279:71:@8804.4]
  assign _T_764 = _T_762 == 2'h0; // @[unified_cache.scala 279:164:@8805.4]
  assign _T_765 = return_request_flatted_2[77]; // @[unified_cache.scala 280:71:@8806.4]
  assign _T_766 = _T_764 & _T_765; // @[unified_cache.scala 279:182:@8807.4]
  assign return_request_flatted_3 = unified_cache_bank_3_io_return_request_out; // @[unified_cache.scala 183:36:@8430.4 unified_cache.scala 238:40:@8694.4]
  assign _T_767 = return_request_flatted_3[73:72]; // @[unified_cache.scala 279:71:@8809.4]
  assign _T_769 = _T_767 == 2'h0; // @[unified_cache.scala 279:164:@8810.4]
  assign _T_770 = return_request_flatted_3[77]; // @[unified_cache.scala 280:71:@8811.4]
  assign _T_771 = _T_769 & _T_770; // @[unified_cache.scala 279:182:@8812.4]
  assign _T_772 = {return_request_flatted_1,return_request_flatted_0}; // @[unified_cache.scala 287:68:@8817.4]
  assign _T_773 = {return_request_flatted_3,return_request_flatted_2}; // @[unified_cache.scala 287:68:@8818.4]
  assign return_request_valid_flatted_1 = unified_cache_bank_1_io_return_request_valid_out; // @[unified_cache.scala 184:42:@8431.4 unified_cache.scala 239:46:@8563.4]
  assign return_request_valid_flatted_0 = unified_cache_bank_io_return_request_valid_out; // @[unified_cache.scala 184:42:@8431.4 unified_cache.scala 239:46:@8497.4]
  assign _T_775 = {return_request_valid_flatted_1,return_request_valid_flatted_0}; // @[unified_cache.scala 288:80:@8821.4]
  assign return_request_valid_flatted_3 = unified_cache_bank_3_io_return_request_valid_out; // @[unified_cache.scala 184:42:@8431.4 unified_cache.scala 239:46:@8695.4]
  assign return_request_valid_flatted_2 = unified_cache_bank_2_io_return_request_valid_out; // @[unified_cache.scala 184:42:@8431.4 unified_cache.scala 239:46:@8629.4]
  assign _T_776 = {return_request_valid_flatted_3,return_request_valid_flatted_2}; // @[unified_cache.scala 288:80:@8822.4]
  assign _T_777 = {_T_776,_T_775}; // @[unified_cache.scala 288:80:@8823.4]
  assign _T_778 = {_T_761,_T_756}; // @[unified_cache.scala 288:103:@8824.4]
  assign _T_779 = {_T_771,_T_766}; // @[unified_cache.scala 288:103:@8825.4]
  assign _T_780 = {_T_779,_T_778}; // @[unified_cache.scala 288:103:@8826.4]
  assign _T_798 = _T_752 == 2'h1; // @[unified_cache.scala 279:164:@8839.4]
  assign _T_800 = _T_798 & _T_755; // @[unified_cache.scala 279:182:@8841.4]
  assign _T_803 = _T_757 == 2'h1; // @[unified_cache.scala 279:164:@8844.4]
  assign _T_805 = _T_803 & _T_760; // @[unified_cache.scala 279:182:@8846.4]
  assign _T_808 = _T_762 == 2'h1; // @[unified_cache.scala 279:164:@8849.4]
  assign _T_810 = _T_808 & _T_765; // @[unified_cache.scala 279:182:@8851.4]
  assign _T_813 = _T_767 == 2'h1; // @[unified_cache.scala 279:164:@8854.4]
  assign _T_815 = _T_813 & _T_770; // @[unified_cache.scala 279:182:@8856.4]
  assign _T_822 = {_T_805,_T_800}; // @[unified_cache.scala 288:103:@8868.4]
  assign _T_823 = {_T_815,_T_810}; // @[unified_cache.scala 288:103:@8869.4]
  assign _T_824 = {_T_823,_T_822}; // @[unified_cache.scala 288:103:@8870.4]
  assign input_queue_vec_1_issue_ack_out = fifo_queue_1_io_issue_ack_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8391.4]
  assign input_queue_vec_0_issue_ack_out = fifo_queue_io_issue_ack_out; // @[unified_cache.scala 152:50:@8379.4 unified_cache.scala 152:50:@8383.4]
  assign return_packet_flatted_out_vec_1 = priority_arbiter_1_io_request_out; // @[unified_cache.scala 142:43:@8365.4 unified_cache.scala 291:47:@8878.4]
  assign return_packet_flatted_out_vec_0 = priority_arbiter_io_request_out; // @[unified_cache.scala 142:43:@8365.4 unified_cache.scala 291:47:@8834.4]
  assign io_input_packet_ack_flatted_out = {input_queue_vec_1_issue_ack_out,input_queue_vec_0_issue_ack_out}; // @[unified_cache.scala 296:35:@8882.4]
  assign io_return_packet_flatted_out = {return_packet_flatted_out_vec_1,return_packet_flatted_out_vec_0}; // @[unified_cache.scala 297:32:@8884.4]
  assign io_from_mem_packet_ack_out = _T_507 != 4'h0; // @[unified_cache.scala 245:30:@8702.4]
  assign io_to_mem_packet_out = to_mem_arbiter_io_request_out; // @[unified_cache.scala 263:24:@8761.4]
  assign fifo_queue_clock = clock; // @[:@8374.4]
  assign fifo_queue_reset = reset; // @[:@8375.4]
  assign fifo_queue_io_request_in = io_input_packet_flatted_in[79:0]; // @[unified_cache.scala 152:50:@8385.4]
  assign fifo_queue_io_request_valid_in = input_packet_packed_0[77]; // @[unified_cache.scala 152:50:@8384.4]
  assign fifo_queue_io_issue_ack_in = _T_594 != 4'h0; // @[unified_cache.scala 152:50:@8380.4]
  assign fifo_queue_1_clock = clock; // @[:@8377.4]
  assign fifo_queue_1_reset = reset; // @[:@8378.4]
  assign fifo_queue_1_io_request_in = io_input_packet_flatted_in[159:80]; // @[unified_cache.scala 152:50:@8393.4]
  assign fifo_queue_1_io_request_valid_in = input_packet_packed_1[77]; // @[unified_cache.scala 152:50:@8392.4]
  assign fifo_queue_1_io_issue_ack_in = _T_603 != 4'h0; // @[unified_cache.scala 152:50:@8388.4]
  assign unified_cache_bank_clock = clock; // @[:@8461.4]
  assign unified_cache_bank_reset = reset; // @[:@8462.4]
  assign unified_cache_bank_io_input_request_flatted_in = _T_331 ? _T_332 : 160'h0; // @[unified_cache.scala 210:46:@8467.6 unified_cache.scala 212:46:@8470.6]
  assign unified_cache_bank_io_input_request_valid_flatted_in = {_T_316,_T_312}; // @[unified_cache.scala 215:50:@8473.4]
  assign unified_cache_bank_io_input_request_critical_flatted_in = {input_queue_vec_1_is_full_out,input_queue_vec_0_is_full_out}; // @[unified_cache.scala 216:53:@8475.4]
  assign unified_cache_bank_io_fetched_request_in = _T_328 ? io_from_mem_packet_in : 80'h0; // @[unified_cache.scala 220:40:@8479.6 unified_cache.scala 222:40:@8482.6]
  assign unified_cache_bank_io_fetched_request_valid_in = _T_327 & _T_326; // @[unified_cache.scala 225:44:@8484.4]
  assign unified_cache_bank_io_miss_request_ack_in = miss_request_ack_flatted[0]; // @[unified_cache.scala 231:39:@8490.4]
  assign unified_cache_bank_io_return_request_ack_in = _T_724 != 2'h0; // @[unified_cache.scala 241:41:@8499.4]
  assign unified_cache_bank_1_clock = clock; // @[:@8527.4]
  assign unified_cache_bank_1_reset = reset; // @[:@8528.4]
  assign unified_cache_bank_1_io_input_request_flatted_in = _T_386 ? _T_332 : 160'h0; // @[unified_cache.scala 210:46:@8533.6 unified_cache.scala 212:46:@8536.6]
  assign unified_cache_bank_1_io_input_request_valid_flatted_in = {_T_371,_T_367}; // @[unified_cache.scala 215:50:@8539.4]
  assign unified_cache_bank_1_io_input_request_critical_flatted_in = {input_queue_vec_1_is_full_out,input_queue_vec_0_is_full_out}; // @[unified_cache.scala 216:53:@8541.4]
  assign unified_cache_bank_1_io_fetched_request_in = _T_383 ? io_from_mem_packet_in : 80'h0; // @[unified_cache.scala 220:40:@8545.6 unified_cache.scala 222:40:@8548.6]
  assign unified_cache_bank_1_io_fetched_request_valid_in = _T_327 & _T_381; // @[unified_cache.scala 225:44:@8550.4]
  assign unified_cache_bank_1_io_miss_request_ack_in = miss_request_ack_flatted[1]; // @[unified_cache.scala 231:39:@8556.4]
  assign unified_cache_bank_1_io_return_request_ack_in = _T_729 != 2'h0; // @[unified_cache.scala 241:41:@8565.4]
  assign unified_cache_bank_2_clock = clock; // @[:@8593.4]
  assign unified_cache_bank_2_reset = reset; // @[:@8594.4]
  assign unified_cache_bank_2_io_input_request_flatted_in = _T_441 ? _T_332 : 160'h0; // @[unified_cache.scala 210:46:@8599.6 unified_cache.scala 212:46:@8602.6]
  assign unified_cache_bank_2_io_input_request_valid_flatted_in = {_T_426,_T_422}; // @[unified_cache.scala 215:50:@8605.4]
  assign unified_cache_bank_2_io_input_request_critical_flatted_in = {input_queue_vec_1_is_full_out,input_queue_vec_0_is_full_out}; // @[unified_cache.scala 216:53:@8607.4]
  assign unified_cache_bank_2_io_fetched_request_in = _T_438 ? io_from_mem_packet_in : 80'h0; // @[unified_cache.scala 220:40:@8611.6 unified_cache.scala 222:40:@8614.6]
  assign unified_cache_bank_2_io_fetched_request_valid_in = _T_327 & _T_436; // @[unified_cache.scala 225:44:@8616.4]
  assign unified_cache_bank_2_io_miss_request_ack_in = miss_request_ack_flatted[2]; // @[unified_cache.scala 231:39:@8622.4]
  assign unified_cache_bank_2_io_return_request_ack_in = _T_734 != 2'h0; // @[unified_cache.scala 241:41:@8631.4]
  assign unified_cache_bank_3_clock = clock; // @[:@8659.4]
  assign unified_cache_bank_3_reset = reset; // @[:@8660.4]
  assign unified_cache_bank_3_io_input_request_flatted_in = _T_496 ? _T_332 : 160'h0; // @[unified_cache.scala 210:46:@8665.6 unified_cache.scala 212:46:@8668.6]
  assign unified_cache_bank_3_io_input_request_valid_flatted_in = {_T_481,_T_477}; // @[unified_cache.scala 215:50:@8671.4]
  assign unified_cache_bank_3_io_input_request_critical_flatted_in = {input_queue_vec_1_is_full_out,input_queue_vec_0_is_full_out}; // @[unified_cache.scala 216:53:@8673.4]
  assign unified_cache_bank_3_io_fetched_request_in = _T_493 ? io_from_mem_packet_in : 80'h0; // @[unified_cache.scala 220:40:@8677.6 unified_cache.scala 222:40:@8680.6]
  assign unified_cache_bank_3_io_fetched_request_valid_in = _T_327 & _T_491; // @[unified_cache.scala 225:44:@8682.4]
  assign unified_cache_bank_3_io_miss_request_ack_in = miss_request_ack_flatted[3]; // @[unified_cache.scala 231:39:@8688.4]
  assign unified_cache_bank_3_io_return_request_ack_in = _T_739 != 2'h0; // @[unified_cache.scala 241:41:@8697.4]
  assign to_mem_arbiter_clock = clock; // @[:@8731.4]
  assign to_mem_arbiter_reset = reset; // @[:@8732.4]
  assign to_mem_arbiter_io_request_flatted_in = {_T_608,320'h0}; // @[unified_cache.scala 258:40:@8740.4]
  assign to_mem_arbiter_io_request_valid_flatted_in = {_T_615,4'h0}; // @[unified_cache.scala 259:46:@8748.4]
  assign to_mem_arbiter_io_issue_ack_in = io_to_mem_packet_ack_in; // @[unified_cache.scala 264:34:@8762.4]
  assign priority_arbiter_clock = clock; // @[:@8815.4]
  assign priority_arbiter_reset = reset; // @[:@8816.4]
  assign priority_arbiter_io_request_flatted_in = {_T_773,_T_772}; // @[unified_cache.scala 287:42:@8820.4]
  assign priority_arbiter_io_request_valid_flatted_in = _T_777 & _T_780; // @[unified_cache.scala 288:48:@8828.4]
  assign priority_arbiter_io_issue_ack_in = io_return_packet_ack_flatted_in[0]; // @[unified_cache.scala 292:36:@8836.4]
  assign priority_arbiter_1_clock = clock; // @[:@8859.4]
  assign priority_arbiter_1_reset = reset; // @[:@8860.4]
  assign priority_arbiter_1_io_request_flatted_in = {_T_773,_T_772}; // @[unified_cache.scala 287:42:@8864.4]
  assign priority_arbiter_1_io_request_valid_flatted_in = _T_777 & _T_824; // @[unified_cache.scala 288:48:@8872.4]
  assign priority_arbiter_1_io_issue_ack_in = io_return_packet_ack_flatted_in[1]; // @[unified_cache.scala 292:36:@8880.4]
endmodule
