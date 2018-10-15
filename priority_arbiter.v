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