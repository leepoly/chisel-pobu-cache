module Queue( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  output        io_enq_ready, // @[:@6.4]
  input         io_enq_valid, // @[:@6.4]
  input  [79:0] io_enq_bits, // @[:@6.4]
  input         io_deq_ready, // @[:@6.4]
  output        io_deq_valid, // @[:@6.4]
  output [79:0] io_deq_bits // @[:@6.4]
);
  reg [79:0] ram [0:3]; // @[Decoupled.scala 214:24:@8.4]
  reg [95:0] _RAND_0;
  wire [79:0] ram__T_63_data; // @[Decoupled.scala 214:24:@8.4]
  wire [1:0] ram__T_63_addr; // @[Decoupled.scala 214:24:@8.4]
  wire [79:0] ram__T_49_data; // @[Decoupled.scala 214:24:@8.4]
  wire [1:0] ram__T_49_addr; // @[Decoupled.scala 214:24:@8.4]
  wire  ram__T_49_mask; // @[Decoupled.scala 214:24:@8.4]
  wire  ram__T_49_en; // @[Decoupled.scala 214:24:@8.4]
  reg [1:0] value; // @[Counter.scala 26:33:@9.4]
  reg [31:0] _RAND_1;
  reg [1:0] value_1; // @[Counter.scala 26:33:@10.4]
  reg [31:0] _RAND_2;
  reg  maybe_full; // @[Decoupled.scala 217:35:@11.4]
  reg [31:0] _RAND_3;
  wire  _T_41; // @[Decoupled.scala 219:41:@12.4]
  wire  _T_43; // @[Decoupled.scala 220:36:@13.4]
  wire  empty; // @[Decoupled.scala 220:33:@14.4]
  wire  _T_44; // @[Decoupled.scala 221:32:@15.4]
  wire  do_enq; // @[Decoupled.scala 37:37:@16.4]
  wire  do_deq; // @[Decoupled.scala 37:37:@19.4]
  wire [2:0] _T_52; // @[Counter.scala 35:22:@26.6]
  wire [1:0] _T_53; // @[Counter.scala 35:22:@27.6]
  wire [1:0] _GEN_5; // @[Decoupled.scala 225:17:@22.4]
  wire [2:0] _T_56; // @[Counter.scala 35:22:@32.6]
  wire [1:0] _T_57; // @[Counter.scala 35:22:@33.6]
  wire [1:0] _GEN_6; // @[Decoupled.scala 229:17:@30.4]
  wire  _T_58; // @[Decoupled.scala 232:16:@36.4]
  wire  _GEN_7; // @[Decoupled.scala 232:28:@37.4]
  assign ram__T_63_addr = value_1;
  assign ram__T_63_data = ram[ram__T_63_addr]; // @[Decoupled.scala 214:24:@8.4]
  assign ram__T_49_data = io_enq_bits;
  assign ram__T_49_addr = value;
  assign ram__T_49_mask = 1'h1;
  assign ram__T_49_en = io_enq_ready & io_enq_valid;
  assign _T_41 = value == value_1; // @[Decoupled.scala 219:41:@12.4]
  assign _T_43 = maybe_full == 1'h0; // @[Decoupled.scala 220:36:@13.4]
  assign empty = _T_41 & _T_43; // @[Decoupled.scala 220:33:@14.4]
  assign _T_44 = _T_41 & maybe_full; // @[Decoupled.scala 221:32:@15.4]
  assign do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 37:37:@16.4]
  assign do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 37:37:@19.4]
  assign _T_52 = value + 2'h1; // @[Counter.scala 35:22:@26.6]
  assign _T_53 = _T_52[1:0]; // @[Counter.scala 35:22:@27.6]
  assign _GEN_5 = do_enq ? _T_53 : value; // @[Decoupled.scala 225:17:@22.4]
  assign _T_56 = value_1 + 2'h1; // @[Counter.scala 35:22:@32.6]
  assign _T_57 = _T_56[1:0]; // @[Counter.scala 35:22:@33.6]
  assign _GEN_6 = do_deq ? _T_57 : value_1; // @[Decoupled.scala 229:17:@30.4]
  assign _T_58 = do_enq != do_deq; // @[Decoupled.scala 232:16:@36.4]
  assign _GEN_7 = _T_58 ? do_enq : maybe_full; // @[Decoupled.scala 232:28:@37.4]
  assign io_enq_ready = _T_44 == 1'h0; // @[Decoupled.scala 237:16:@43.4]
  assign io_deq_valid = empty == 1'h0; // @[Decoupled.scala 236:16:@41.4]
  assign io_deq_bits = ram__T_63_data; // @[Decoupled.scala 238:15:@45.4]
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
  _RAND_0 = {3{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    ram[initvar] = _RAND_0[79:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  value_1 = _RAND_2[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_49_en & ram__T_49_mask) begin
      ram[ram__T_49_addr] <= ram__T_49_data; // @[Decoupled.scala 214:24:@8.4]
    end
    if (reset) begin
      value <= 2'h0;
    end else begin
      if (do_enq) begin
        value <= _T_53;
      end
    end
    if (reset) begin
      value_1 <= 2'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_57;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_58) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module fifo_queue( // @[:@53.2]
  input         clock, // @[:@54.4]
  input         reset, // @[:@55.4]
  input  [79:0] io_request_in, // @[:@56.4]
  input         io_request_valid_in, // @[:@56.4]
  output        io_issue_ack_out, // @[:@56.4]
  output [79:0] io_request_out, // @[:@56.4]
  output        io_request_valid_out, // @[:@56.4]
  input         io_issue_ack_in // @[:@56.4]
);
  wire  queue_clock; // @[fifo_queue.scala 26:27:@58.4]
  wire  queue_reset; // @[fifo_queue.scala 26:27:@58.4]
  wire  queue_io_enq_ready; // @[fifo_queue.scala 26:27:@58.4]
  wire  queue_io_enq_valid; // @[fifo_queue.scala 26:27:@58.4]
  wire [79:0] queue_io_enq_bits; // @[fifo_queue.scala 26:27:@58.4]
  wire  queue_io_deq_ready; // @[fifo_queue.scala 26:27:@58.4]
  wire  queue_io_deq_valid; // @[fifo_queue.scala 26:27:@58.4]
  wire [79:0] queue_io_deq_bits; // @[fifo_queue.scala 26:27:@58.4]
  Queue queue ( // @[fifo_queue.scala 26:27:@58.4]
    .clock(queue_clock),
    .reset(queue_reset),
    .io_enq_ready(queue_io_enq_ready),
    .io_enq_valid(queue_io_enq_valid),
    .io_enq_bits(queue_io_enq_bits),
    .io_deq_ready(queue_io_deq_ready),
    .io_deq_valid(queue_io_deq_valid),
    .io_deq_bits(queue_io_deq_bits)
  );
  assign io_issue_ack_out = queue_io_enq_ready; // @[fifo_queue.scala 30:26:@63.4]
  assign io_request_out = queue_io_deq_bits; // @[fifo_queue.scala 32:24:@64.4]
  assign io_request_valid_out = queue_io_deq_valid; // @[fifo_queue.scala 33:30:@65.4]
  assign queue_clock = clock; // @[:@59.4]
  assign queue_reset = reset; // @[:@60.4]
  assign queue_io_enq_valid = io_request_valid_in; // @[fifo_queue.scala 29:28:@62.4]
  assign queue_io_enq_bits = io_request_in; // @[fifo_queue.scala 28:27:@61.4]
  assign queue_io_deq_ready = io_issue_ack_in; // @[fifo_queue.scala 34:28:@66.4]
endmodule
module RRArbiter( // @[:@141.2]
  input         clock, // @[:@142.4]
  input 		reset,
  output        io_in_0_ready, // @[:@144.4]
  input         io_in_0_valid, // @[:@144.4]
  input  [79:0] io_in_0_bits, // @[:@144.4]
  output        io_in_1_ready, // @[:@144.4]
  input         io_in_1_valid, // @[:@144.4]
  input  [79:0] io_in_1_bits, // @[:@144.4]
  input         io_out_ready, // @[:@144.4]
  output        io_out_valid, // @[:@144.4]
  output [79:0] io_out_bits, // @[:@144.4]
  output        io_chosen // @[:@144.4]
);
  wire  _T_79; // @[Decoupled.scala 37:37:@151.4]
  reg  lastGrant; // @[Reg.scala 11:16:@152.4]
  reg [31:0] _RAND_0;
  wire  grantMask_1; // @[Arbiter.scala 67:57:@157.4]
  wire  validMask_1; // @[Arbiter.scala 68:83:@159.4]
  wire  _T_84; // @[Arbiter.scala 31:68:@161.4]
  wire  _T_88; // @[Arbiter.scala 31:78:@163.4]
  wire  _T_90; // @[Arbiter.scala 31:78:@164.4]
  wire  _T_94; // @[Arbiter.scala 72:50:@168.4]
  wire  _GEN_7; // @[Arbiter.scala 77:27:@173.4]
  assign _T_79 = io_out_ready & io_out_valid; // @[Decoupled.scala 37:37:@151.4]
  assign grantMask_1 = 1'h1 > lastGrant; // @[Arbiter.scala 67:57:@157.4]
  assign validMask_1 = io_in_1_valid & grantMask_1; // @[Arbiter.scala 68:83:@159.4]
  assign _T_84 = validMask_1 | io_in_0_valid; // @[Arbiter.scala 31:68:@161.4]
  assign _T_88 = validMask_1 == 1'h0; // @[Arbiter.scala 31:78:@163.4]
  assign _T_90 = _T_84 == 1'h0; // @[Arbiter.scala 31:78:@164.4]
  assign _T_94 = grantMask_1 | _T_90; // @[Arbiter.scala 72:50:@168.4]
  assign _GEN_7 = io_in_0_valid ? 1'h0 : 1'h1; // @[Arbiter.scala 77:27:@173.4]
  assign io_in_0_ready = _T_88 & io_out_ready; // @[Arbiter.scala 60:16:@170.4]
  assign io_in_1_ready = _T_94 & io_out_ready; // @[Arbiter.scala 60:16:@172.4]
  assign io_out_valid = io_chosen ? io_in_1_valid : io_in_0_valid; // @[Arbiter.scala 41:16:@149.4]
  assign io_out_bits = io_chosen ? io_in_1_bits : io_in_0_bits; // @[Arbiter.scala 42:15:@150.4]
  assign io_chosen = validMask_1 ? 1'h1 : _GEN_7; // @[Arbiter.scala 40:13:@148.4]

  always @(posedge clock) begin
    if (reset) begin
	  lastGrant <= 1'h1;
	end
    else if (_T_79) begin
      lastGrant <= io_chosen;
    end
  end
endmodule
module Queue_2( // @[:@180.2]
  input         clock, // @[:@181.4]
  input         reset, // @[:@182.4]
  output        io_enq_ready, // @[:@183.4]
  input         io_enq_valid, // @[:@183.4]
  input  [79:0] io_enq_bits, // @[:@183.4]
  input         io_deq_ready, // @[:@183.4]
  output        io_deq_valid, // @[:@183.4]
  output [79:0] io_deq_bits // @[:@183.4]
);
  reg [79:0] ram [0:1]; // @[Decoupled.scala 214:24:@185.4]
  reg [95:0] _RAND_0;
  wire [79:0] ram__T_63_data; // @[Decoupled.scala 214:24:@185.4]
  wire  ram__T_63_addr; // @[Decoupled.scala 214:24:@185.4]
  wire [79:0] ram__T_49_data; // @[Decoupled.scala 214:24:@185.4]
  wire  ram__T_49_addr; // @[Decoupled.scala 214:24:@185.4]
  wire  ram__T_49_mask; // @[Decoupled.scala 214:24:@185.4]
  wire  ram__T_49_en; // @[Decoupled.scala 214:24:@185.4]
  reg  value; // @[Counter.scala 26:33:@186.4]
  reg [31:0] _RAND_1;
  reg  value_1; // @[Counter.scala 26:33:@187.4]
  reg [31:0] _RAND_2;
  reg  maybe_full; // @[Decoupled.scala 217:35:@188.4]
  reg [31:0] _RAND_3;
  wire  _T_41; // @[Decoupled.scala 219:41:@189.4]
  wire  _T_43; // @[Decoupled.scala 220:36:@190.4]
  wire  empty; // @[Decoupled.scala 220:33:@191.4]
  wire  _T_44; // @[Decoupled.scala 221:32:@192.4]
  wire  do_enq; // @[Decoupled.scala 37:37:@193.4]
  wire  do_deq; // @[Decoupled.scala 37:37:@196.4]
  wire [1:0] _T_52; // @[Counter.scala 35:22:@203.6]
  wire  _T_53; // @[Counter.scala 35:22:@204.6]
  wire  _GEN_5; // @[Decoupled.scala 225:17:@199.4]
  wire [1:0] _T_56; // @[Counter.scala 35:22:@209.6]
  wire  _T_57; // @[Counter.scala 35:22:@210.6]
  wire  _GEN_6; // @[Decoupled.scala 229:17:@207.4]
  wire  _T_58; // @[Decoupled.scala 232:16:@213.4]
  wire  _GEN_7; // @[Decoupled.scala 232:28:@214.4]
  assign ram__T_63_addr = value_1;
  assign ram__T_63_data = ram[ram__T_63_addr]; // @[Decoupled.scala 214:24:@185.4]
  assign ram__T_49_data = io_enq_bits;
  assign ram__T_49_addr = value;
  assign ram__T_49_mask = 1'h1;
  assign ram__T_49_en = io_enq_ready & io_enq_valid;
  assign _T_41 = value == value_1; // @[Decoupled.scala 219:41:@189.4]
  assign _T_43 = maybe_full == 1'h0; // @[Decoupled.scala 220:36:@190.4]
  assign empty = _T_41 & _T_43; // @[Decoupled.scala 220:33:@191.4]
  assign _T_44 = _T_41 & maybe_full; // @[Decoupled.scala 221:32:@192.4]
  assign do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 37:37:@193.4]
  assign do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 37:37:@196.4]
  assign _T_52 = value + 1'h1; // @[Counter.scala 35:22:@203.6]
  assign _T_53 = _T_52[0:0]; // @[Counter.scala 35:22:@204.6]
  assign _GEN_5 = do_enq ? _T_53 : value; // @[Decoupled.scala 225:17:@199.4]
  assign _T_56 = value_1 + 1'h1; // @[Counter.scala 35:22:@209.6]
  assign _T_57 = _T_56[0:0]; // @[Counter.scala 35:22:@210.6]
  assign _GEN_6 = do_deq ? _T_57 : value_1; // @[Decoupled.scala 229:17:@207.4]
  assign _T_58 = do_enq != do_deq; // @[Decoupled.scala 232:16:@213.4]
  assign _GEN_7 = _T_58 ? do_enq : maybe_full; // @[Decoupled.scala 232:28:@214.4]
  assign io_enq_ready = _T_44 == 1'h0; // @[Decoupled.scala 237:16:@220.4]
  assign io_deq_valid = empty == 1'h0; // @[Decoupled.scala 236:16:@218.4]
  assign io_deq_bits = ram__T_63_data; // @[Decoupled.scala 238:15:@222.4]
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
  _RAND_0 = {3{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram[initvar] = _RAND_0[79:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  value = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  value_1 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(ram__T_49_en & ram__T_49_mask) begin
      ram[ram__T_49_addr] <= ram__T_49_data; // @[Decoupled.scala 214:24:@185.4]
    end
    if (reset) begin
      value <= 1'h0;
    end else begin
      if (do_enq) begin
        value <= _T_53;
      end
    end
    if (reset) begin
      value_1 <= 1'h0;
    end else begin
      if (do_deq) begin
        value_1 <= _T_57;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else begin
      if (_T_58) begin
        maybe_full <= do_enq;
      end
    end
  end
endmodule
module priority_arbiter( // @[:@280.2]
  input          clock, // @[:@281.4]
  input          reset, // @[:@282.4]
  input  [159:0] io_request_flatted_in, // @[:@283.4]
  input  [1:0]   io_request_valid_flatted_in, // @[:@283.4]
  output [1:0]   io_issue_ack_out, // @[:@283.4]
  output [79:0]  io_request_out, // @[:@283.4]
  output         io_request_valid_out, // @[:@283.4]
  input          io_issue_ack_in // @[:@283.4]
);
  wire  arbiter_clock; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire  arbiter_io_in_0_ready; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire  arbiter_io_in_0_valid; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire [79:0] arbiter_io_in_0_bits; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire  arbiter_io_in_1_ready; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire  arbiter_io_in_1_valid; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire [79:0] arbiter_io_in_1_bits; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire  arbiter_io_out_ready; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire  arbiter_io_out_valid; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire [79:0] arbiter_io_out_bits; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire  arbiter_io_chosen; // @[priority_arbiter_chisel.scala 26:29:@286.4]
  wire  Queue_clock; // @[priority_arbiter_chisel.scala 30:40:@290.4]
  wire  Queue_reset; // @[priority_arbiter_chisel.scala 30:40:@290.4]
  wire  Queue_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@290.4]
  wire  Queue_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@290.4]
  wire [79:0] Queue_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@290.4]
  wire  Queue_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@290.4]
  wire  Queue_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@290.4]
  wire [79:0] Queue_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@290.4]
  wire  Queue_1_clock; // @[priority_arbiter_chisel.scala 30:40:@301.4]
  wire  Queue_1_reset; // @[priority_arbiter_chisel.scala 30:40:@301.4]
  wire  Queue_1_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@301.4]
  wire  Queue_1_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@301.4]
  wire [79:0] Queue_1_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@301.4]
  wire  Queue_1_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@301.4]
  wire  Queue_1_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@301.4]
  wire [79:0] Queue_1_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@301.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter_chisel.scala 25:37:@285.4 priority_arbiter_chisel.scala 33:48:@308.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter_chisel.scala 25:37:@285.4 priority_arbiter_chisel.scala 33:48:@297.4]
  RRArbiter arbiter ( // @[priority_arbiter_chisel.scala 26:29:@286.4]
    .clock(arbiter_clock),
	.reset(reset),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_0_bits(arbiter_io_in_0_bits),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_1_bits(arbiter_io_in_1_bits),
    .io_out_ready(arbiter_io_out_ready),
    .io_out_valid(arbiter_io_out_valid),
    .io_out_bits(arbiter_io_out_bits),
    .io_chosen(arbiter_io_chosen)
  );
  Queue_2 Queue ( // @[priority_arbiter_chisel.scala 30:40:@290.4]
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits(Queue_io_enq_bits),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits(Queue_io_deq_bits)
  );
  Queue_2 Queue_1 ( // @[priority_arbiter_chisel.scala 30:40:@301.4]
    .clock(Queue_1_clock),
    .reset(Queue_1_reset),
    .io_enq_ready(Queue_1_io_enq_ready),
    .io_enq_valid(Queue_1_io_enq_valid),
    .io_enq_bits(Queue_1_io_enq_bits),
    .io_deq_ready(Queue_1_io_deq_ready),
    .io_deq_valid(Queue_1_io_deq_valid),
    .io_deq_bits(Queue_1_io_deq_bits)
  );
  assign issue_ack_out_vec_1 = Queue_1_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@285.4 priority_arbiter_chisel.scala 33:48:@308.4]
  assign issue_ack_out_vec_0 = Queue_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@285.4 priority_arbiter_chisel.scala 33:48:@297.4]
  assign io_issue_ack_out = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter_chisel.scala 43:26:@322.4]
  assign io_request_out = arbiter_io_out_bits; // @[priority_arbiter_chisel.scala 39:24:@318.4]
  assign io_request_valid_out = arbiter_io_out_valid; // @[priority_arbiter_chisel.scala 40:30:@319.4]
  assign arbiter_clock = clock; // @[:@287.4]
  assign arbiter_io_in_0_valid = Queue_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@313.4]
  assign arbiter_io_in_0_bits = Queue_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@312.4]
  assign arbiter_io_in_1_valid = Queue_1_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@316.4]
  assign arbiter_io_in_1_bits = Queue_1_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@315.4]
  assign arbiter_io_out_ready = io_issue_ack_in; // @[priority_arbiter_chisel.scala 41:30:@320.4]
  assign Queue_clock = clock; // @[:@291.4]
  assign Queue_reset = reset; // @[:@292.4]
  assign Queue_io_enq_valid = io_request_valid_flatted_in[0]; // @[priority_arbiter_chisel.scala 32:41:@296.4]
  assign Queue_io_enq_bits = io_request_flatted_in[79:0]; // @[priority_arbiter_chisel.scala 31:40:@294.4]
  assign Queue_io_deq_ready = arbiter_io_in_0_ready; // @[priority_arbiter_chisel.scala 35:41:@300.4]
  assign Queue_1_clock = clock; // @[:@302.4]
  assign Queue_1_reset = reset; // @[:@303.4]
  assign Queue_1_io_enq_valid = io_request_valid_flatted_in[1]; // @[priority_arbiter_chisel.scala 32:41:@307.4]
  assign Queue_1_io_enq_bits = io_request_flatted_in[159:80]; // @[priority_arbiter_chisel.scala 31:40:@305.4]
  assign Queue_1_io_deq_ready = arbiter_io_in_1_ready; // @[priority_arbiter_chisel.scala 35:41:@311.4]
endmodule
module unified_cache_bank( // @[:@324.2]
  input          clock, // @[:@325.4]
  input          reset, // @[:@326.4]
  input  [159:0] io_input_request_flatted_in, // @[:@327.4]
  input  [1:0]   io_input_request_valid_flatted_in, // @[:@327.4]
  output [1:0]   io_input_request_ack_out, // @[:@327.4]
  input  [79:0]  io_fetched_request_in, // @[:@327.4]
  input          io_fetched_request_valid_in, // @[:@327.4]
  output         io_fetch_ack_out, // @[:@327.4]
  output [79:0]  io_miss_request_out, // @[:@327.4]
  output         io_miss_request_valid_out, // @[:@327.4]
  input          io_miss_request_ack_in, // @[:@327.4]
  output [79:0]  io_return_request_out, // @[:@327.4]
  output         io_return_request_valid_out, // @[:@327.4]
  input          io_return_request_ack_in // @[:@327.4]
);
  wire  priority_arbiter_clock; // @[unified_cache_bank.scala 48:36:@329.4]
  wire  priority_arbiter_reset; // @[unified_cache_bank.scala 48:36:@329.4]
  wire [159:0] priority_arbiter_io_request_flatted_in; // @[unified_cache_bank.scala 48:36:@329.4]
  wire [1:0] priority_arbiter_io_request_valid_flatted_in; // @[unified_cache_bank.scala 48:36:@329.4]
  wire [1:0] priority_arbiter_io_issue_ack_out; // @[unified_cache_bank.scala 48:36:@329.4]
  wire [79:0] priority_arbiter_io_request_out; // @[unified_cache_bank.scala 48:36:@329.4]
  wire  priority_arbiter_io_request_valid_out; // @[unified_cache_bank.scala 48:36:@329.4]
  wire  priority_arbiter_io_issue_ack_in; // @[unified_cache_bank.scala 48:36:@329.4]
  priority_arbiter priority_arbiter ( // @[unified_cache_bank.scala 48:36:@329.4]
    .clock(priority_arbiter_clock),
    .reset(priority_arbiter_reset),
    .io_request_flatted_in(priority_arbiter_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_io_request_valid_flatted_in),
    .io_issue_ack_out(priority_arbiter_io_issue_ack_out),
    .io_request_out(priority_arbiter_io_request_out),
    .io_request_valid_out(priority_arbiter_io_request_valid_out),
    .io_issue_ack_in(priority_arbiter_io_issue_ack_in)
  );
  assign io_input_request_ack_out = priority_arbiter_io_issue_ack_out; // @[unified_cache_bank.scala 56:34:@335.4]
  assign io_fetch_ack_out = io_return_request_ack_in; // @[unified_cache_bank.scala 67:26:@342.4]
  assign io_miss_request_out = priority_arbiter_io_request_out; // @[unified_cache_bank.scala 57:29:@336.4]
  assign io_miss_request_valid_out = priority_arbiter_io_request_valid_out; // @[unified_cache_bank.scala 58:35:@337.4]
  assign io_return_request_out = io_fetched_request_in; // @[unified_cache_bank.scala 65:31:@340.4]
  assign io_return_request_valid_out = io_fetched_request_valid_in; // @[unified_cache_bank.scala 66:37:@341.4]
  assign priority_arbiter_clock = clock; // @[:@330.4]
  assign priority_arbiter_reset = reset; // @[:@331.4]
  assign priority_arbiter_io_request_flatted_in = io_input_request_flatted_in; // @[unified_cache_bank.scala 53:50:@332.4]
  assign priority_arbiter_io_request_valid_flatted_in = io_input_request_valid_flatted_in; // @[unified_cache_bank.scala 54:56:@333.4]
  assign priority_arbiter_io_issue_ack_in = io_miss_request_ack_in; // @[unified_cache_bank.scala 59:44:@338.4]
endmodule
module RRArbiter_4( // @[:@969.2]
  input         clock, // @[:@970.4]
  input 		reset,
  output        io_in_0_ready, // @[:@972.4]
  input         io_in_0_valid, // @[:@972.4]
  input  [79:0] io_in_0_bits, // @[:@972.4]
  output        io_in_1_ready, // @[:@972.4]
  input         io_in_1_valid, // @[:@972.4]
  input  [79:0] io_in_1_bits, // @[:@972.4]
  output        io_in_2_ready, // @[:@972.4]
  input         io_in_2_valid, // @[:@972.4]
  input  [79:0] io_in_2_bits, // @[:@972.4]
  output        io_in_3_ready, // @[:@972.4]
  input         io_in_3_valid, // @[:@972.4]
  input  [79:0] io_in_3_bits, // @[:@972.4]
  output        io_in_4_ready, // @[:@972.4]
  input         io_in_4_valid, // @[:@972.4]
  input  [79:0] io_in_4_bits, // @[:@972.4]
  output        io_in_5_ready, // @[:@972.4]
  input         io_in_5_valid, // @[:@972.4]
  input  [79:0] io_in_5_bits, // @[:@972.4]
  output        io_in_6_ready, // @[:@972.4]
  input         io_in_6_valid, // @[:@972.4]
  input  [79:0] io_in_6_bits, // @[:@972.4]
  output        io_in_7_ready, // @[:@972.4]
  input         io_in_7_valid, // @[:@972.4]
  input  [79:0] io_in_7_bits, // @[:@972.4]
  input         io_out_ready, // @[:@972.4]
  output        io_out_valid, // @[:@972.4]
  output [79:0] io_out_bits, // @[:@972.4]
  output [2:0]  io_chosen // @[:@972.4]
);
  wire  _GEN_4; // @[Arbiter.scala 41:16:@977.4]
  wire [79:0] _GEN_5; // @[Arbiter.scala 41:16:@977.4]
  wire  _GEN_7; // @[Arbiter.scala 41:16:@977.4]
  wire [79:0] _GEN_8; // @[Arbiter.scala 41:16:@977.4]
  wire  _GEN_10; // @[Arbiter.scala 41:16:@977.4]
  wire [79:0] _GEN_11; // @[Arbiter.scala 41:16:@977.4]
  wire  _GEN_13; // @[Arbiter.scala 41:16:@977.4]
  wire [79:0] _GEN_14; // @[Arbiter.scala 41:16:@977.4]
  wire  _GEN_16; // @[Arbiter.scala 41:16:@977.4]
  wire [79:0] _GEN_17; // @[Arbiter.scala 41:16:@977.4]
  wire  _GEN_19; // @[Arbiter.scala 41:16:@977.4]
  wire [79:0] _GEN_20; // @[Arbiter.scala 41:16:@977.4]
  wire  _T_163; // @[Decoupled.scala 37:37:@979.4]
  reg [2:0] lastGrant; // @[Reg.scala 11:16:@980.4]
  reg [31:0] _RAND_0;
  wire  grantMask_1; // @[Arbiter.scala 67:57:@985.4]
  wire  grantMask_2; // @[Arbiter.scala 67:57:@986.4]
  wire  grantMask_3; // @[Arbiter.scala 67:57:@987.4]
  wire  grantMask_4; // @[Arbiter.scala 67:57:@988.4]
  wire  grantMask_5; // @[Arbiter.scala 67:57:@989.4]
  wire  grantMask_6; // @[Arbiter.scala 67:57:@990.4]
  wire  grantMask_7; // @[Arbiter.scala 67:57:@991.4]
  wire  validMask_1; // @[Arbiter.scala 68:83:@993.4]
  wire  validMask_2; // @[Arbiter.scala 68:83:@994.4]
  wire  validMask_3; // @[Arbiter.scala 68:83:@995.4]
  wire  validMask_4; // @[Arbiter.scala 68:83:@996.4]
  wire  validMask_5; // @[Arbiter.scala 68:83:@997.4]
  wire  validMask_6; // @[Arbiter.scala 68:83:@998.4]
  wire  validMask_7; // @[Arbiter.scala 68:83:@999.4]
  wire  _T_174; // @[Arbiter.scala 31:68:@1001.4]
  wire  _T_175; // @[Arbiter.scala 31:68:@1002.4]
  wire  _T_176; // @[Arbiter.scala 31:68:@1003.4]
  wire  _T_177; // @[Arbiter.scala 31:68:@1004.4]
  wire  _T_178; // @[Arbiter.scala 31:68:@1005.4]
  wire  _T_179; // @[Arbiter.scala 31:68:@1006.4]
  wire  _T_180; // @[Arbiter.scala 31:68:@1007.4]
  wire  _T_181; // @[Arbiter.scala 31:68:@1008.4]
  wire  _T_182; // @[Arbiter.scala 31:68:@1009.4]
  wire  _T_183; // @[Arbiter.scala 31:68:@1010.4]
  wire  _T_184; // @[Arbiter.scala 31:68:@1011.4]
  wire  _T_185; // @[Arbiter.scala 31:68:@1012.4]
  wire  _T_186; // @[Arbiter.scala 31:68:@1013.4]
  wire  _T_190; // @[Arbiter.scala 31:78:@1015.4]
  wire  _T_192; // @[Arbiter.scala 31:78:@1016.4]
  wire  _T_194; // @[Arbiter.scala 31:78:@1017.4]
  wire  _T_196; // @[Arbiter.scala 31:78:@1018.4]
  wire  _T_198; // @[Arbiter.scala 31:78:@1019.4]
  wire  _T_200; // @[Arbiter.scala 31:78:@1020.4]
  wire  _T_202; // @[Arbiter.scala 31:78:@1021.4]
  wire  _T_204; // @[Arbiter.scala 31:78:@1022.4]
  wire  _T_206; // @[Arbiter.scala 31:78:@1023.4]
  wire  _T_208; // @[Arbiter.scala 31:78:@1024.4]
  wire  _T_210; // @[Arbiter.scala 31:78:@1025.4]
  wire  _T_212; // @[Arbiter.scala 31:78:@1026.4]
  wire  _T_214; // @[Arbiter.scala 31:78:@1027.4]
  wire  _T_216; // @[Arbiter.scala 31:78:@1028.4]
  wire  _T_220; // @[Arbiter.scala 72:50:@1032.4]
  wire  _T_221; // @[Arbiter.scala 72:34:@1033.4]
  wire  _T_222; // @[Arbiter.scala 72:50:@1034.4]
  wire  _T_223; // @[Arbiter.scala 72:34:@1035.4]
  wire  _T_224; // @[Arbiter.scala 72:50:@1036.4]
  wire  _T_225; // @[Arbiter.scala 72:34:@1037.4]
  wire  _T_226; // @[Arbiter.scala 72:50:@1038.4]
  wire  _T_227; // @[Arbiter.scala 72:34:@1039.4]
  wire  _T_228; // @[Arbiter.scala 72:50:@1040.4]
  wire  _T_229; // @[Arbiter.scala 72:34:@1041.4]
  wire  _T_230; // @[Arbiter.scala 72:50:@1042.4]
  wire  _T_231; // @[Arbiter.scala 72:34:@1043.4]
  wire  _T_232; // @[Arbiter.scala 72:50:@1044.4]
  wire [2:0] _GEN_25; // @[Arbiter.scala 77:27:@1061.4]
  wire [2:0] _GEN_26; // @[Arbiter.scala 77:27:@1064.4]
  wire [2:0] _GEN_27; // @[Arbiter.scala 77:27:@1067.4]
  wire [2:0] _GEN_28; // @[Arbiter.scala 77:27:@1070.4]
  wire [2:0] _GEN_29; // @[Arbiter.scala 77:27:@1073.4]
  wire [2:0] _GEN_30; // @[Arbiter.scala 77:27:@1076.4]
  wire [2:0] _GEN_31; // @[Arbiter.scala 77:27:@1079.4]
  wire [2:0] _GEN_32; // @[Arbiter.scala 79:25:@1082.4]
  wire [2:0] _GEN_33; // @[Arbiter.scala 79:25:@1085.4]
  wire [2:0] _GEN_34; // @[Arbiter.scala 79:25:@1088.4]
  wire [2:0] _GEN_35; // @[Arbiter.scala 79:25:@1091.4]
  wire [2:0] _GEN_36; // @[Arbiter.scala 79:25:@1094.4]
  wire [2:0] _GEN_37; // @[Arbiter.scala 79:25:@1097.4]
  assign _GEN_4 = 3'h1 == io_chosen ? io_in_1_valid : io_in_0_valid; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_5 = 3'h1 == io_chosen ? io_in_1_bits : io_in_0_bits; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_7 = 3'h2 == io_chosen ? io_in_2_valid : _GEN_4; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_8 = 3'h2 == io_chosen ? io_in_2_bits : _GEN_5; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_10 = 3'h3 == io_chosen ? io_in_3_valid : _GEN_7; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_11 = 3'h3 == io_chosen ? io_in_3_bits : _GEN_8; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_13 = 3'h4 == io_chosen ? io_in_4_valid : _GEN_10; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_14 = 3'h4 == io_chosen ? io_in_4_bits : _GEN_11; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_16 = 3'h5 == io_chosen ? io_in_5_valid : _GEN_13; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_17 = 3'h5 == io_chosen ? io_in_5_bits : _GEN_14; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_19 = 3'h6 == io_chosen ? io_in_6_valid : _GEN_16; // @[Arbiter.scala 41:16:@977.4]
  assign _GEN_20 = 3'h6 == io_chosen ? io_in_6_bits : _GEN_17; // @[Arbiter.scala 41:16:@977.4]
  assign _T_163 = io_out_ready & io_out_valid; // @[Decoupled.scala 37:37:@979.4]
  assign grantMask_1 = 3'h1 > lastGrant; // @[Arbiter.scala 67:57:@985.4]
  assign grantMask_2 = 3'h2 > lastGrant; // @[Arbiter.scala 67:57:@986.4]
  assign grantMask_3 = 3'h3 > lastGrant; // @[Arbiter.scala 67:57:@987.4]
  assign grantMask_4 = 3'h4 > lastGrant; // @[Arbiter.scala 67:57:@988.4]
  assign grantMask_5 = 3'h5 > lastGrant; // @[Arbiter.scala 67:57:@989.4]
  assign grantMask_6 = 3'h6 > lastGrant; // @[Arbiter.scala 67:57:@990.4]
  assign grantMask_7 = 3'h7 > lastGrant; // @[Arbiter.scala 67:57:@991.4]
  assign validMask_1 = io_in_1_valid & grantMask_1; // @[Arbiter.scala 68:83:@993.4]
  assign validMask_2 = io_in_2_valid & grantMask_2; // @[Arbiter.scala 68:83:@994.4]
  assign validMask_3 = io_in_3_valid & grantMask_3; // @[Arbiter.scala 68:83:@995.4]
  assign validMask_4 = io_in_4_valid & grantMask_4; // @[Arbiter.scala 68:83:@996.4]
  assign validMask_5 = io_in_5_valid & grantMask_5; // @[Arbiter.scala 68:83:@997.4]
  assign validMask_6 = io_in_6_valid & grantMask_6; // @[Arbiter.scala 68:83:@998.4]
  assign validMask_7 = io_in_7_valid & grantMask_7; // @[Arbiter.scala 68:83:@999.4]
  assign _T_174 = validMask_1 | validMask_2; // @[Arbiter.scala 31:68:@1001.4]
  assign _T_175 = _T_174 | validMask_3; // @[Arbiter.scala 31:68:@1002.4]
  assign _T_176 = _T_175 | validMask_4; // @[Arbiter.scala 31:68:@1003.4]
  assign _T_177 = _T_176 | validMask_5; // @[Arbiter.scala 31:68:@1004.4]
  assign _T_178 = _T_177 | validMask_6; // @[Arbiter.scala 31:68:@1005.4]
  assign _T_179 = _T_178 | validMask_7; // @[Arbiter.scala 31:68:@1006.4]
  assign _T_180 = _T_179 | io_in_0_valid; // @[Arbiter.scala 31:68:@1007.4]
  assign _T_181 = _T_180 | io_in_1_valid; // @[Arbiter.scala 31:68:@1008.4]
  assign _T_182 = _T_181 | io_in_2_valid; // @[Arbiter.scala 31:68:@1009.4]
  assign _T_183 = _T_182 | io_in_3_valid; // @[Arbiter.scala 31:68:@1010.4]
  assign _T_184 = _T_183 | io_in_4_valid; // @[Arbiter.scala 31:68:@1011.4]
  assign _T_185 = _T_184 | io_in_5_valid; // @[Arbiter.scala 31:68:@1012.4]
  assign _T_186 = _T_185 | io_in_6_valid; // @[Arbiter.scala 31:68:@1013.4]
  assign _T_190 = validMask_1 == 1'h0; // @[Arbiter.scala 31:78:@1015.4]
  assign _T_192 = _T_174 == 1'h0; // @[Arbiter.scala 31:78:@1016.4]
  assign _T_194 = _T_175 == 1'h0; // @[Arbiter.scala 31:78:@1017.4]
  assign _T_196 = _T_176 == 1'h0; // @[Arbiter.scala 31:78:@1018.4]
  assign _T_198 = _T_177 == 1'h0; // @[Arbiter.scala 31:78:@1019.4]
  assign _T_200 = _T_178 == 1'h0; // @[Arbiter.scala 31:78:@1020.4]
  assign _T_202 = _T_179 == 1'h0; // @[Arbiter.scala 31:78:@1021.4]
  assign _T_204 = _T_180 == 1'h0; // @[Arbiter.scala 31:78:@1022.4]
  assign _T_206 = _T_181 == 1'h0; // @[Arbiter.scala 31:78:@1023.4]
  assign _T_208 = _T_182 == 1'h0; // @[Arbiter.scala 31:78:@1024.4]
  assign _T_210 = _T_183 == 1'h0; // @[Arbiter.scala 31:78:@1025.4]
  assign _T_212 = _T_184 == 1'h0; // @[Arbiter.scala 31:78:@1026.4]
  assign _T_214 = _T_185 == 1'h0; // @[Arbiter.scala 31:78:@1027.4]
  assign _T_216 = _T_186 == 1'h0; // @[Arbiter.scala 31:78:@1028.4]
  assign _T_220 = grantMask_1 | _T_204; // @[Arbiter.scala 72:50:@1032.4]
  assign _T_221 = _T_190 & grantMask_2; // @[Arbiter.scala 72:34:@1033.4]
  assign _T_222 = _T_221 | _T_206; // @[Arbiter.scala 72:50:@1034.4]
  assign _T_223 = _T_192 & grantMask_3; // @[Arbiter.scala 72:34:@1035.4]
  assign _T_224 = _T_223 | _T_208; // @[Arbiter.scala 72:50:@1036.4]
  assign _T_225 = _T_194 & grantMask_4; // @[Arbiter.scala 72:34:@1037.4]
  assign _T_226 = _T_225 | _T_210; // @[Arbiter.scala 72:50:@1038.4]
  assign _T_227 = _T_196 & grantMask_5; // @[Arbiter.scala 72:34:@1039.4]
  assign _T_228 = _T_227 | _T_212; // @[Arbiter.scala 72:50:@1040.4]
  assign _T_229 = _T_198 & grantMask_6; // @[Arbiter.scala 72:34:@1041.4]
  assign _T_230 = _T_229 | _T_214; // @[Arbiter.scala 72:50:@1042.4]
  assign _T_231 = _T_200 & grantMask_7; // @[Arbiter.scala 72:34:@1043.4]
  assign _T_232 = _T_231 | _T_216; // @[Arbiter.scala 72:50:@1044.4]
  assign _GEN_25 = io_in_6_valid ? 3'h6 : 3'h7; // @[Arbiter.scala 77:27:@1061.4]
  assign _GEN_26 = io_in_5_valid ? 3'h5 : _GEN_25; // @[Arbiter.scala 77:27:@1064.4]
  assign _GEN_27 = io_in_4_valid ? 3'h4 : _GEN_26; // @[Arbiter.scala 77:27:@1067.4]
  assign _GEN_28 = io_in_3_valid ? 3'h3 : _GEN_27; // @[Arbiter.scala 77:27:@1070.4]
  assign _GEN_29 = io_in_2_valid ? 3'h2 : _GEN_28; // @[Arbiter.scala 77:27:@1073.4]
  assign _GEN_30 = io_in_1_valid ? 3'h1 : _GEN_29; // @[Arbiter.scala 77:27:@1076.4]
  assign _GEN_31 = io_in_0_valid ? 3'h0 : _GEN_30; // @[Arbiter.scala 77:27:@1079.4]
  assign _GEN_32 = validMask_7 ? 3'h7 : _GEN_31; // @[Arbiter.scala 79:25:@1082.4]
  assign _GEN_33 = validMask_6 ? 3'h6 : _GEN_32; // @[Arbiter.scala 79:25:@1085.4]
  assign _GEN_34 = validMask_5 ? 3'h5 : _GEN_33; // @[Arbiter.scala 79:25:@1088.4]
  assign _GEN_35 = validMask_4 ? 3'h4 : _GEN_34; // @[Arbiter.scala 79:25:@1091.4]
  assign _GEN_36 = validMask_3 ? 3'h3 : _GEN_35; // @[Arbiter.scala 79:25:@1094.4]
  assign _GEN_37 = validMask_2 ? 3'h2 : _GEN_36; // @[Arbiter.scala 79:25:@1097.4]
  assign io_in_0_ready = _T_202 & io_out_ready; // @[Arbiter.scala 60:16:@1046.4]
  assign io_in_1_ready = _T_220 & io_out_ready; // @[Arbiter.scala 60:16:@1048.4]
  assign io_in_2_ready = _T_222 & io_out_ready; // @[Arbiter.scala 60:16:@1050.4]
  assign io_in_3_ready = _T_224 & io_out_ready; // @[Arbiter.scala 60:16:@1052.4]
  assign io_in_4_ready = _T_226 & io_out_ready; // @[Arbiter.scala 60:16:@1054.4]
  assign io_in_5_ready = _T_228 & io_out_ready; // @[Arbiter.scala 60:16:@1056.4]
  assign io_in_6_ready = _T_230 & io_out_ready; // @[Arbiter.scala 60:16:@1058.4]
  assign io_in_7_ready = _T_232 & io_out_ready; // @[Arbiter.scala 60:16:@1060.4]
  assign io_out_valid = 3'h7 == io_chosen ? io_in_7_valid : _GEN_19; // @[Arbiter.scala 41:16:@977.4]
  assign io_out_bits = 3'h7 == io_chosen ? io_in_7_bits : _GEN_20; // @[Arbiter.scala 42:15:@978.4]
  assign io_chosen = validMask_1 ? 3'h1 : _GEN_37; // @[Arbiter.scala 40:13:@976.4]

  always @(posedge clock) begin
    if (reset) begin
	  lastGrant <= 3'h7;
	end
	else if (_T_163) begin
      lastGrant <= io_chosen;
    end
  end
endmodule
module priority_arbiter_4( // @[:@1504.2]
  input          clock, // @[:@1505.4]
  input          reset, // @[:@1506.4]
  input  [639:0] io_request_flatted_in, // @[:@1507.4]
  input  [7:0]   io_request_valid_flatted_in, // @[:@1507.4]
  output [7:0]   io_issue_ack_out, // @[:@1507.4]
  output [79:0]  io_request_out, // @[:@1507.4]
  input          io_issue_ack_in // @[:@1507.4]
);
  wire  arbiter_clock; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_0_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_0_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_in_0_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_1_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_1_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_in_1_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_2_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_2_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_in_2_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_3_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_3_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_in_3_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_4_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_4_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_in_4_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_5_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_5_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_in_5_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_6_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_6_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_in_6_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_7_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_in_7_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_in_7_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_out_ready; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  arbiter_io_out_valid; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [79:0] arbiter_io_out_bits; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire [2:0] arbiter_io_chosen; // @[priority_arbiter_chisel.scala 26:29:@1510.4]
  wire  Queue_clock; // @[priority_arbiter_chisel.scala 30:40:@1514.4]
  wire  Queue_reset; // @[priority_arbiter_chisel.scala 30:40:@1514.4]
  wire  Queue_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1514.4]
  wire  Queue_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1514.4]
  wire [79:0] Queue_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1514.4]
  wire  Queue_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1514.4]
  wire  Queue_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1514.4]
  wire [79:0] Queue_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1514.4]
  wire  Queue_1_clock; // @[priority_arbiter_chisel.scala 30:40:@1525.4]
  wire  Queue_1_reset; // @[priority_arbiter_chisel.scala 30:40:@1525.4]
  wire  Queue_1_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1525.4]
  wire  Queue_1_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1525.4]
  wire [79:0] Queue_1_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1525.4]
  wire  Queue_1_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1525.4]
  wire  Queue_1_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1525.4]
  wire [79:0] Queue_1_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1525.4]
  wire  Queue_2_clock; // @[priority_arbiter_chisel.scala 30:40:@1536.4]
  wire  Queue_2_reset; // @[priority_arbiter_chisel.scala 30:40:@1536.4]
  wire  Queue_2_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1536.4]
  wire  Queue_2_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1536.4]
  wire [79:0] Queue_2_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1536.4]
  wire  Queue_2_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1536.4]
  wire  Queue_2_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1536.4]
  wire [79:0] Queue_2_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1536.4]
  wire  Queue_3_clock; // @[priority_arbiter_chisel.scala 30:40:@1547.4]
  wire  Queue_3_reset; // @[priority_arbiter_chisel.scala 30:40:@1547.4]
  wire  Queue_3_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1547.4]
  wire  Queue_3_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1547.4]
  wire [79:0] Queue_3_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1547.4]
  wire  Queue_3_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1547.4]
  wire  Queue_3_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1547.4]
  wire [79:0] Queue_3_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1547.4]
  wire  Queue_4_clock; // @[priority_arbiter_chisel.scala 30:40:@1558.4]
  wire  Queue_4_reset; // @[priority_arbiter_chisel.scala 30:40:@1558.4]
  wire  Queue_4_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1558.4]
  wire  Queue_4_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1558.4]
  wire [79:0] Queue_4_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1558.4]
  wire  Queue_4_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1558.4]
  wire  Queue_4_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1558.4]
  wire [79:0] Queue_4_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1558.4]
  wire  Queue_5_clock; // @[priority_arbiter_chisel.scala 30:40:@1569.4]
  wire  Queue_5_reset; // @[priority_arbiter_chisel.scala 30:40:@1569.4]
  wire  Queue_5_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1569.4]
  wire  Queue_5_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1569.4]
  wire [79:0] Queue_5_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1569.4]
  wire  Queue_5_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1569.4]
  wire  Queue_5_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1569.4]
  wire [79:0] Queue_5_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1569.4]
  wire  Queue_6_clock; // @[priority_arbiter_chisel.scala 30:40:@1580.4]
  wire  Queue_6_reset; // @[priority_arbiter_chisel.scala 30:40:@1580.4]
  wire  Queue_6_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1580.4]
  wire  Queue_6_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1580.4]
  wire [79:0] Queue_6_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1580.4]
  wire  Queue_6_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1580.4]
  wire  Queue_6_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1580.4]
  wire [79:0] Queue_6_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1580.4]
  wire  Queue_7_clock; // @[priority_arbiter_chisel.scala 30:40:@1591.4]
  wire  Queue_7_reset; // @[priority_arbiter_chisel.scala 30:40:@1591.4]
  wire  Queue_7_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1591.4]
  wire  Queue_7_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1591.4]
  wire [79:0] Queue_7_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1591.4]
  wire  Queue_7_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1591.4]
  wire  Queue_7_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1591.4]
  wire [79:0] Queue_7_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1591.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1532.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1521.4]
  wire [1:0] _T_193; // @[priority_arbiter_chisel.scala 43:47:@1629.4]
  wire  issue_ack_out_vec_3; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1554.4]
  wire  issue_ack_out_vec_2; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1543.4]
  wire [1:0] _T_194; // @[priority_arbiter_chisel.scala 43:47:@1630.4]
  wire [3:0] _T_195; // @[priority_arbiter_chisel.scala 43:47:@1631.4]
  wire  issue_ack_out_vec_5; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1576.4]
  wire  issue_ack_out_vec_4; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1565.4]
  wire [1:0] _T_196; // @[priority_arbiter_chisel.scala 43:47:@1632.4]
  wire  issue_ack_out_vec_7; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1598.4]
  wire  issue_ack_out_vec_6; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1587.4]
  wire [1:0] _T_197; // @[priority_arbiter_chisel.scala 43:47:@1633.4]
  wire [3:0] _T_198; // @[priority_arbiter_chisel.scala 43:47:@1634.4]
  RRArbiter_4 arbiter ( // @[priority_arbiter_chisel.scala 26:29:@1510.4]
    .clock(arbiter_clock),
	.reset(reset),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_0_bits(arbiter_io_in_0_bits),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_1_bits(arbiter_io_in_1_bits),
    .io_in_2_ready(arbiter_io_in_2_ready),
    .io_in_2_valid(arbiter_io_in_2_valid),
    .io_in_2_bits(arbiter_io_in_2_bits),
    .io_in_3_ready(arbiter_io_in_3_ready),
    .io_in_3_valid(arbiter_io_in_3_valid),
    .io_in_3_bits(arbiter_io_in_3_bits),
    .io_in_4_ready(arbiter_io_in_4_ready),
    .io_in_4_valid(arbiter_io_in_4_valid),
    .io_in_4_bits(arbiter_io_in_4_bits),
    .io_in_5_ready(arbiter_io_in_5_ready),
    .io_in_5_valid(arbiter_io_in_5_valid),
    .io_in_5_bits(arbiter_io_in_5_bits),
    .io_in_6_ready(arbiter_io_in_6_ready),
    .io_in_6_valid(arbiter_io_in_6_valid),
    .io_in_6_bits(arbiter_io_in_6_bits),
    .io_in_7_ready(arbiter_io_in_7_ready),
    .io_in_7_valid(arbiter_io_in_7_valid),
    .io_in_7_bits(arbiter_io_in_7_bits),
    .io_out_ready(arbiter_io_out_ready),
    .io_out_valid(arbiter_io_out_valid),
    .io_out_bits(arbiter_io_out_bits),
    .io_chosen(arbiter_io_chosen)
  );
  Queue_2 Queue ( // @[priority_arbiter_chisel.scala 30:40:@1514.4]
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits(Queue_io_enq_bits),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits(Queue_io_deq_bits)
  );
  Queue_2 Queue_1 ( // @[priority_arbiter_chisel.scala 30:40:@1525.4]
    .clock(Queue_1_clock),
    .reset(Queue_1_reset),
    .io_enq_ready(Queue_1_io_enq_ready),
    .io_enq_valid(Queue_1_io_enq_valid),
    .io_enq_bits(Queue_1_io_enq_bits),
    .io_deq_ready(Queue_1_io_deq_ready),
    .io_deq_valid(Queue_1_io_deq_valid),
    .io_deq_bits(Queue_1_io_deq_bits)
  );
  Queue_2 Queue_2 ( // @[priority_arbiter_chisel.scala 30:40:@1536.4]
    .clock(Queue_2_clock),
    .reset(Queue_2_reset),
    .io_enq_ready(Queue_2_io_enq_ready),
    .io_enq_valid(Queue_2_io_enq_valid),
    .io_enq_bits(Queue_2_io_enq_bits),
    .io_deq_ready(Queue_2_io_deq_ready),
    .io_deq_valid(Queue_2_io_deq_valid),
    .io_deq_bits(Queue_2_io_deq_bits)
  );
  Queue_2 Queue_3 ( // @[priority_arbiter_chisel.scala 30:40:@1547.4]
    .clock(Queue_3_clock),
    .reset(Queue_3_reset),
    .io_enq_ready(Queue_3_io_enq_ready),
    .io_enq_valid(Queue_3_io_enq_valid),
    .io_enq_bits(Queue_3_io_enq_bits),
    .io_deq_ready(Queue_3_io_deq_ready),
    .io_deq_valid(Queue_3_io_deq_valid),
    .io_deq_bits(Queue_3_io_deq_bits)
  );
  Queue_2 Queue_4 ( // @[priority_arbiter_chisel.scala 30:40:@1558.4]
    .clock(Queue_4_clock),
    .reset(Queue_4_reset),
    .io_enq_ready(Queue_4_io_enq_ready),
    .io_enq_valid(Queue_4_io_enq_valid),
    .io_enq_bits(Queue_4_io_enq_bits),
    .io_deq_ready(Queue_4_io_deq_ready),
    .io_deq_valid(Queue_4_io_deq_valid),
    .io_deq_bits(Queue_4_io_deq_bits)
  );
  Queue_2 Queue_5 ( // @[priority_arbiter_chisel.scala 30:40:@1569.4]
    .clock(Queue_5_clock),
    .reset(Queue_5_reset),
    .io_enq_ready(Queue_5_io_enq_ready),
    .io_enq_valid(Queue_5_io_enq_valid),
    .io_enq_bits(Queue_5_io_enq_bits),
    .io_deq_ready(Queue_5_io_deq_ready),
    .io_deq_valid(Queue_5_io_deq_valid),
    .io_deq_bits(Queue_5_io_deq_bits)
  );
  Queue_2 Queue_6 ( // @[priority_arbiter_chisel.scala 30:40:@1580.4]
    .clock(Queue_6_clock),
    .reset(Queue_6_reset),
    .io_enq_ready(Queue_6_io_enq_ready),
    .io_enq_valid(Queue_6_io_enq_valid),
    .io_enq_bits(Queue_6_io_enq_bits),
    .io_deq_ready(Queue_6_io_deq_ready),
    .io_deq_valid(Queue_6_io_deq_valid),
    .io_deq_bits(Queue_6_io_deq_bits)
  );
  Queue_2 Queue_7 ( // @[priority_arbiter_chisel.scala 30:40:@1591.4]
    .clock(Queue_7_clock),
    .reset(Queue_7_reset),
    .io_enq_ready(Queue_7_io_enq_ready),
    .io_enq_valid(Queue_7_io_enq_valid),
    .io_enq_bits(Queue_7_io_enq_bits),
    .io_deq_ready(Queue_7_io_deq_ready),
    .io_deq_valid(Queue_7_io_deq_valid),
    .io_deq_bits(Queue_7_io_deq_bits)
  );
  assign issue_ack_out_vec_1 = Queue_1_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1532.4]
  assign issue_ack_out_vec_0 = Queue_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1521.4]
  assign _T_193 = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter_chisel.scala 43:47:@1629.4]
  assign issue_ack_out_vec_3 = Queue_3_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1554.4]
  assign issue_ack_out_vec_2 = Queue_2_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1543.4]
  assign _T_194 = {issue_ack_out_vec_3,issue_ack_out_vec_2}; // @[priority_arbiter_chisel.scala 43:47:@1630.4]
  assign _T_195 = {_T_194,_T_193}; // @[priority_arbiter_chisel.scala 43:47:@1631.4]
  assign issue_ack_out_vec_5 = Queue_5_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1576.4]
  assign issue_ack_out_vec_4 = Queue_4_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1565.4]
  assign _T_196 = {issue_ack_out_vec_5,issue_ack_out_vec_4}; // @[priority_arbiter_chisel.scala 43:47:@1632.4]
  assign issue_ack_out_vec_7 = Queue_7_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1598.4]
  assign issue_ack_out_vec_6 = Queue_6_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1509.4 priority_arbiter_chisel.scala 33:48:@1587.4]
  assign _T_197 = {issue_ack_out_vec_7,issue_ack_out_vec_6}; // @[priority_arbiter_chisel.scala 43:47:@1633.4]
  assign _T_198 = {_T_197,_T_196}; // @[priority_arbiter_chisel.scala 43:47:@1634.4]
  assign io_issue_ack_out = {_T_198,_T_195}; // @[priority_arbiter_chisel.scala 43:26:@1636.4]
  assign io_request_out = arbiter_io_out_bits; // @[priority_arbiter_chisel.scala 39:24:@1626.4]
  assign arbiter_clock = clock; // @[:@1511.4]
  assign arbiter_io_in_0_valid = Queue_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1603.4]
  assign arbiter_io_in_0_bits = Queue_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1602.4]
  assign arbiter_io_in_1_valid = Queue_1_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1606.4]
  assign arbiter_io_in_1_bits = Queue_1_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1605.4]
  assign arbiter_io_in_2_valid = Queue_2_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1609.4]
  assign arbiter_io_in_2_bits = Queue_2_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1608.4]
  assign arbiter_io_in_3_valid = Queue_3_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1612.4]
  assign arbiter_io_in_3_bits = Queue_3_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1611.4]
  assign arbiter_io_in_4_valid = Queue_4_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1615.4]
  assign arbiter_io_in_4_bits = Queue_4_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1614.4]
  assign arbiter_io_in_5_valid = Queue_5_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1618.4]
  assign arbiter_io_in_5_bits = Queue_5_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1617.4]
  assign arbiter_io_in_6_valid = Queue_6_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1621.4]
  assign arbiter_io_in_6_bits = Queue_6_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1620.4]
  assign arbiter_io_in_7_valid = Queue_7_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1624.4]
  assign arbiter_io_in_7_bits = Queue_7_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1623.4]
  assign arbiter_io_out_ready = io_issue_ack_in; // @[priority_arbiter_chisel.scala 41:30:@1628.4]
  assign Queue_clock = clock; // @[:@1515.4]
  assign Queue_reset = reset; // @[:@1516.4]
  assign Queue_io_enq_valid = io_request_valid_flatted_in[0]; // @[priority_arbiter_chisel.scala 32:41:@1520.4]
  assign Queue_io_enq_bits = io_request_flatted_in[79:0]; // @[priority_arbiter_chisel.scala 31:40:@1518.4]
  assign Queue_io_deq_ready = arbiter_io_in_0_ready; // @[priority_arbiter_chisel.scala 35:41:@1524.4]
  assign Queue_1_clock = clock; // @[:@1526.4]
  assign Queue_1_reset = reset; // @[:@1527.4]
  assign Queue_1_io_enq_valid = io_request_valid_flatted_in[1]; // @[priority_arbiter_chisel.scala 32:41:@1531.4]
  assign Queue_1_io_enq_bits = io_request_flatted_in[159:80]; // @[priority_arbiter_chisel.scala 31:40:@1529.4]
  assign Queue_1_io_deq_ready = arbiter_io_in_1_ready; // @[priority_arbiter_chisel.scala 35:41:@1535.4]
  assign Queue_2_clock = clock; // @[:@1537.4]
  assign Queue_2_reset = reset; // @[:@1538.4]
  assign Queue_2_io_enq_valid = io_request_valid_flatted_in[2]; // @[priority_arbiter_chisel.scala 32:41:@1542.4]
  assign Queue_2_io_enq_bits = io_request_flatted_in[239:160]; // @[priority_arbiter_chisel.scala 31:40:@1540.4]
  assign Queue_2_io_deq_ready = arbiter_io_in_2_ready; // @[priority_arbiter_chisel.scala 35:41:@1546.4]
  assign Queue_3_clock = clock; // @[:@1548.4]
  assign Queue_3_reset = reset; // @[:@1549.4]
  assign Queue_3_io_enq_valid = io_request_valid_flatted_in[3]; // @[priority_arbiter_chisel.scala 32:41:@1553.4]
  assign Queue_3_io_enq_bits = io_request_flatted_in[319:240]; // @[priority_arbiter_chisel.scala 31:40:@1551.4]
  assign Queue_3_io_deq_ready = arbiter_io_in_3_ready; // @[priority_arbiter_chisel.scala 35:41:@1557.4]
  assign Queue_4_clock = clock; // @[:@1559.4]
  assign Queue_4_reset = reset; // @[:@1560.4]
  assign Queue_4_io_enq_valid = io_request_valid_flatted_in[4]; // @[priority_arbiter_chisel.scala 32:41:@1564.4]
  assign Queue_4_io_enq_bits = io_request_flatted_in[399:320]; // @[priority_arbiter_chisel.scala 31:40:@1562.4]
  assign Queue_4_io_deq_ready = arbiter_io_in_4_ready; // @[priority_arbiter_chisel.scala 35:41:@1568.4]
  assign Queue_5_clock = clock; // @[:@1570.4]
  assign Queue_5_reset = reset; // @[:@1571.4]
  assign Queue_5_io_enq_valid = io_request_valid_flatted_in[5]; // @[priority_arbiter_chisel.scala 32:41:@1575.4]
  assign Queue_5_io_enq_bits = io_request_flatted_in[479:400]; // @[priority_arbiter_chisel.scala 31:40:@1573.4]
  assign Queue_5_io_deq_ready = arbiter_io_in_5_ready; // @[priority_arbiter_chisel.scala 35:41:@1579.4]
  assign Queue_6_clock = clock; // @[:@1581.4]
  assign Queue_6_reset = reset; // @[:@1582.4]
  assign Queue_6_io_enq_valid = io_request_valid_flatted_in[6]; // @[priority_arbiter_chisel.scala 32:41:@1586.4]
  assign Queue_6_io_enq_bits = io_request_flatted_in[559:480]; // @[priority_arbiter_chisel.scala 31:40:@1584.4]
  assign Queue_6_io_deq_ready = arbiter_io_in_6_ready; // @[priority_arbiter_chisel.scala 35:41:@1590.4]
  assign Queue_7_clock = clock; // @[:@1592.4]
  assign Queue_7_reset = reset; // @[:@1593.4]
  assign Queue_7_io_enq_valid = io_request_valid_flatted_in[7]; // @[priority_arbiter_chisel.scala 32:41:@1597.4]
  assign Queue_7_io_enq_bits = io_request_flatted_in[639:560]; // @[priority_arbiter_chisel.scala 31:40:@1595.4]
  assign Queue_7_io_deq_ready = arbiter_io_in_7_ready; // @[priority_arbiter_chisel.scala 35:41:@1601.4]
endmodule
module RRArbiter_5( // @[:@1638.2]
  input         clock, // @[:@1639.4]
  input 		reset,
  output        io_in_0_ready, // @[:@1641.4]
  input         io_in_0_valid, // @[:@1641.4]
  input  [79:0] io_in_0_bits, // @[:@1641.4]
  output        io_in_1_ready, // @[:@1641.4]
  input         io_in_1_valid, // @[:@1641.4]
  input  [79:0] io_in_1_bits, // @[:@1641.4]
  output        io_in_2_ready, // @[:@1641.4]
  input         io_in_2_valid, // @[:@1641.4]
  input  [79:0] io_in_2_bits, // @[:@1641.4]
  output        io_in_3_ready, // @[:@1641.4]
  input         io_in_3_valid, // @[:@1641.4]
  input  [79:0] io_in_3_bits, // @[:@1641.4]
  input         io_out_ready, // @[:@1641.4]
  output        io_out_valid, // @[:@1641.4]
  output [79:0] io_out_bits, // @[:@1641.4]
  output [1:0]  io_chosen // @[:@1641.4]
);
  wire  _GEN_4; // @[Arbiter.scala 41:16:@1646.4]
  wire [79:0] _GEN_5; // @[Arbiter.scala 41:16:@1646.4]
  wire  _GEN_7; // @[Arbiter.scala 41:16:@1646.4]
  wire [79:0] _GEN_8; // @[Arbiter.scala 41:16:@1646.4]
  wire  _T_107; // @[Decoupled.scala 37:37:@1648.4]
  reg [1:0] lastGrant; // @[Reg.scala 11:16:@1649.4]
  reg [31:0] _RAND_0;
  wire  grantMask_1; // @[Arbiter.scala 67:57:@1654.4]
  wire  grantMask_2; // @[Arbiter.scala 67:57:@1655.4]
  wire  grantMask_3; // @[Arbiter.scala 67:57:@1656.4]
  wire  validMask_1; // @[Arbiter.scala 68:83:@1658.4]
  wire  validMask_2; // @[Arbiter.scala 68:83:@1659.4]
  wire  validMask_3; // @[Arbiter.scala 68:83:@1660.4]
  wire  _T_114; // @[Arbiter.scala 31:68:@1662.4]
  wire  _T_115; // @[Arbiter.scala 31:68:@1663.4]
  wire  _T_116; // @[Arbiter.scala 31:68:@1664.4]
  wire  _T_117; // @[Arbiter.scala 31:68:@1665.4]
  wire  _T_118; // @[Arbiter.scala 31:68:@1666.4]
  wire  _T_122; // @[Arbiter.scala 31:78:@1668.4]
  wire  _T_124; // @[Arbiter.scala 31:78:@1669.4]
  wire  _T_126; // @[Arbiter.scala 31:78:@1670.4]
  wire  _T_128; // @[Arbiter.scala 31:78:@1671.4]
  wire  _T_130; // @[Arbiter.scala 31:78:@1672.4]
  wire  _T_132; // @[Arbiter.scala 31:78:@1673.4]
  wire  _T_136; // @[Arbiter.scala 72:50:@1677.4]
  wire  _T_137; // @[Arbiter.scala 72:34:@1678.4]
  wire  _T_138; // @[Arbiter.scala 72:50:@1679.4]
  wire  _T_139; // @[Arbiter.scala 72:34:@1680.4]
  wire  _T_140; // @[Arbiter.scala 72:50:@1681.4]
  wire [1:0] _GEN_13; // @[Arbiter.scala 77:27:@1690.4]
  wire [1:0] _GEN_14; // @[Arbiter.scala 77:27:@1693.4]
  wire [1:0] _GEN_15; // @[Arbiter.scala 77:27:@1696.4]
  wire [1:0] _GEN_16; // @[Arbiter.scala 79:25:@1699.4]
  wire [1:0] _GEN_17; // @[Arbiter.scala 79:25:@1702.4]
  assign _GEN_4 = 2'h1 == io_chosen ? io_in_1_valid : io_in_0_valid; // @[Arbiter.scala 41:16:@1646.4]
  assign _GEN_5 = 2'h1 == io_chosen ? io_in_1_bits : io_in_0_bits; // @[Arbiter.scala 41:16:@1646.4]
  assign _GEN_7 = 2'h2 == io_chosen ? io_in_2_valid : _GEN_4; // @[Arbiter.scala 41:16:@1646.4]
  assign _GEN_8 = 2'h2 == io_chosen ? io_in_2_bits : _GEN_5; // @[Arbiter.scala 41:16:@1646.4]
  assign _T_107 = io_out_ready & io_out_valid; // @[Decoupled.scala 37:37:@1648.4]
  assign grantMask_1 = 2'h1 > lastGrant; // @[Arbiter.scala 67:57:@1654.4]
  assign grantMask_2 = 2'h2 > lastGrant; // @[Arbiter.scala 67:57:@1655.4]
  assign grantMask_3 = 2'h3 > lastGrant; // @[Arbiter.scala 67:57:@1656.4]
  assign validMask_1 = io_in_1_valid & grantMask_1; // @[Arbiter.scala 68:83:@1658.4]
  assign validMask_2 = io_in_2_valid & grantMask_2; // @[Arbiter.scala 68:83:@1659.4]
  assign validMask_3 = io_in_3_valid & grantMask_3; // @[Arbiter.scala 68:83:@1660.4]
  assign _T_114 = validMask_1 | validMask_2; // @[Arbiter.scala 31:68:@1662.4]
  assign _T_115 = _T_114 | validMask_3; // @[Arbiter.scala 31:68:@1663.4]
  assign _T_116 = _T_115 | io_in_0_valid; // @[Arbiter.scala 31:68:@1664.4]
  assign _T_117 = _T_116 | io_in_1_valid; // @[Arbiter.scala 31:68:@1665.4]
  assign _T_118 = _T_117 | io_in_2_valid; // @[Arbiter.scala 31:68:@1666.4]
  assign _T_122 = validMask_1 == 1'h0; // @[Arbiter.scala 31:78:@1668.4]
  assign _T_124 = _T_114 == 1'h0; // @[Arbiter.scala 31:78:@1669.4]
  assign _T_126 = _T_115 == 1'h0; // @[Arbiter.scala 31:78:@1670.4]
  assign _T_128 = _T_116 == 1'h0; // @[Arbiter.scala 31:78:@1671.4]
  assign _T_130 = _T_117 == 1'h0; // @[Arbiter.scala 31:78:@1672.4]
  assign _T_132 = _T_118 == 1'h0; // @[Arbiter.scala 31:78:@1673.4]
  assign _T_136 = grantMask_1 | _T_128; // @[Arbiter.scala 72:50:@1677.4]
  assign _T_137 = _T_122 & grantMask_2; // @[Arbiter.scala 72:34:@1678.4]
  assign _T_138 = _T_137 | _T_130; // @[Arbiter.scala 72:50:@1679.4]
  assign _T_139 = _T_124 & grantMask_3; // @[Arbiter.scala 72:34:@1680.4]
  assign _T_140 = _T_139 | _T_132; // @[Arbiter.scala 72:50:@1681.4]
  assign _GEN_13 = io_in_2_valid ? 2'h2 : 2'h3; // @[Arbiter.scala 77:27:@1690.4]
  assign _GEN_14 = io_in_1_valid ? 2'h1 : _GEN_13; // @[Arbiter.scala 77:27:@1693.4]
  assign _GEN_15 = io_in_0_valid ? 2'h0 : _GEN_14; // @[Arbiter.scala 77:27:@1696.4]
  assign _GEN_16 = validMask_3 ? 2'h3 : _GEN_15; // @[Arbiter.scala 79:25:@1699.4]
  assign _GEN_17 = validMask_2 ? 2'h2 : _GEN_16; // @[Arbiter.scala 79:25:@1702.4]
  assign io_in_0_ready = _T_126 & io_out_ready; // @[Arbiter.scala 60:16:@1683.4]
  assign io_in_1_ready = _T_136 & io_out_ready; // @[Arbiter.scala 60:16:@1685.4]
  assign io_in_2_ready = _T_138 & io_out_ready; // @[Arbiter.scala 60:16:@1687.4]
  assign io_in_3_ready = _T_140 & io_out_ready; // @[Arbiter.scala 60:16:@1689.4]
  assign io_out_valid = 2'h3 == io_chosen ? io_in_3_valid : _GEN_7; // @[Arbiter.scala 41:16:@1646.4]
  assign io_out_bits = 2'h3 == io_chosen ? io_in_3_bits : _GEN_8; // @[Arbiter.scala 42:15:@1647.4]
  assign io_chosen = validMask_1 ? 2'h1 : _GEN_17; // @[Arbiter.scala 40:13:@1645.4]

  always @(posedge clock) begin
    if (reset) begin
	  lastGrant <= 2'h3;
	end
	else if (_T_107) begin
      lastGrant <= io_chosen;
    end
  end
endmodule
module priority_arbiter_5( // @[:@1909.2]
  input          clock, // @[:@1910.4]
  input          reset, // @[:@1911.4]
  input  [319:0] io_request_flatted_in, // @[:@1912.4]
  input  [3:0]   io_request_valid_flatted_in, // @[:@1912.4]
  output [3:0]   io_issue_ack_out, // @[:@1912.4]
  output [79:0]  io_request_out, // @[:@1912.4]
  input          io_issue_ack_in // @[:@1912.4]
);
  wire  arbiter_clock; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_in_0_ready; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_in_0_valid; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire [79:0] arbiter_io_in_0_bits; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_in_1_ready; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_in_1_valid; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire [79:0] arbiter_io_in_1_bits; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_in_2_ready; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_in_2_valid; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire [79:0] arbiter_io_in_2_bits; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_in_3_ready; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_in_3_valid; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire [79:0] arbiter_io_in_3_bits; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_out_ready; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  arbiter_io_out_valid; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire [79:0] arbiter_io_out_bits; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire [1:0] arbiter_io_chosen; // @[priority_arbiter_chisel.scala 26:29:@1915.4]
  wire  Queue_clock; // @[priority_arbiter_chisel.scala 30:40:@1919.4]
  wire  Queue_reset; // @[priority_arbiter_chisel.scala 30:40:@1919.4]
  wire  Queue_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1919.4]
  wire  Queue_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1919.4]
  wire [79:0] Queue_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1919.4]
  wire  Queue_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1919.4]
  wire  Queue_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1919.4]
  wire [79:0] Queue_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1919.4]
  wire  Queue_1_clock; // @[priority_arbiter_chisel.scala 30:40:@1930.4]
  wire  Queue_1_reset; // @[priority_arbiter_chisel.scala 30:40:@1930.4]
  wire  Queue_1_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1930.4]
  wire  Queue_1_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1930.4]
  wire [79:0] Queue_1_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1930.4]
  wire  Queue_1_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1930.4]
  wire  Queue_1_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1930.4]
  wire [79:0] Queue_1_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1930.4]
  wire  Queue_2_clock; // @[priority_arbiter_chisel.scala 30:40:@1941.4]
  wire  Queue_2_reset; // @[priority_arbiter_chisel.scala 30:40:@1941.4]
  wire  Queue_2_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1941.4]
  wire  Queue_2_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1941.4]
  wire [79:0] Queue_2_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1941.4]
  wire  Queue_2_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1941.4]
  wire  Queue_2_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1941.4]
  wire [79:0] Queue_2_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1941.4]
  wire  Queue_3_clock; // @[priority_arbiter_chisel.scala 30:40:@1952.4]
  wire  Queue_3_reset; // @[priority_arbiter_chisel.scala 30:40:@1952.4]
  wire  Queue_3_io_enq_ready; // @[priority_arbiter_chisel.scala 30:40:@1952.4]
  wire  Queue_3_io_enq_valid; // @[priority_arbiter_chisel.scala 30:40:@1952.4]
  wire [79:0] Queue_3_io_enq_bits; // @[priority_arbiter_chisel.scala 30:40:@1952.4]
  wire  Queue_3_io_deq_ready; // @[priority_arbiter_chisel.scala 30:40:@1952.4]
  wire  Queue_3_io_deq_valid; // @[priority_arbiter_chisel.scala 30:40:@1952.4]
  wire [79:0] Queue_3_io_deq_bits; // @[priority_arbiter_chisel.scala 30:40:@1952.4]
  wire  issue_ack_out_vec_1; // @[priority_arbiter_chisel.scala 25:37:@1914.4 priority_arbiter_chisel.scala 33:48:@1937.4]
  wire  issue_ack_out_vec_0; // @[priority_arbiter_chisel.scala 25:37:@1914.4 priority_arbiter_chisel.scala 33:48:@1926.4]
  wire [1:0] _T_121; // @[priority_arbiter_chisel.scala 43:47:@1978.4]
  wire  issue_ack_out_vec_3; // @[priority_arbiter_chisel.scala 25:37:@1914.4 priority_arbiter_chisel.scala 33:48:@1959.4]
  wire  issue_ack_out_vec_2; // @[priority_arbiter_chisel.scala 25:37:@1914.4 priority_arbiter_chisel.scala 33:48:@1948.4]
  wire [1:0] _T_122; // @[priority_arbiter_chisel.scala 43:47:@1979.4]
  RRArbiter_5 arbiter ( // @[priority_arbiter_chisel.scala 26:29:@1915.4]
    .clock(arbiter_clock),
	.reset(reset),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_0_bits(arbiter_io_in_0_bits),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_1_bits(arbiter_io_in_1_bits),
    .io_in_2_ready(arbiter_io_in_2_ready),
    .io_in_2_valid(arbiter_io_in_2_valid),
    .io_in_2_bits(arbiter_io_in_2_bits),
    .io_in_3_ready(arbiter_io_in_3_ready),
    .io_in_3_valid(arbiter_io_in_3_valid),
    .io_in_3_bits(arbiter_io_in_3_bits),
    .io_out_ready(arbiter_io_out_ready),
    .io_out_valid(arbiter_io_out_valid),
    .io_out_bits(arbiter_io_out_bits),
    .io_chosen(arbiter_io_chosen)
  );
  Queue_2 Queue ( // @[priority_arbiter_chisel.scala 30:40:@1919.4]
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits(Queue_io_enq_bits),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits(Queue_io_deq_bits)
  );
  Queue_2 Queue_1 ( // @[priority_arbiter_chisel.scala 30:40:@1930.4]
    .clock(Queue_1_clock),
    .reset(Queue_1_reset),
    .io_enq_ready(Queue_1_io_enq_ready),
    .io_enq_valid(Queue_1_io_enq_valid),
    .io_enq_bits(Queue_1_io_enq_bits),
    .io_deq_ready(Queue_1_io_deq_ready),
    .io_deq_valid(Queue_1_io_deq_valid),
    .io_deq_bits(Queue_1_io_deq_bits)
  );
  Queue_2 Queue_2 ( // @[priority_arbiter_chisel.scala 30:40:@1941.4]
    .clock(Queue_2_clock),
    .reset(Queue_2_reset),
    .io_enq_ready(Queue_2_io_enq_ready),
    .io_enq_valid(Queue_2_io_enq_valid),
    .io_enq_bits(Queue_2_io_enq_bits),
    .io_deq_ready(Queue_2_io_deq_ready),
    .io_deq_valid(Queue_2_io_deq_valid),
    .io_deq_bits(Queue_2_io_deq_bits)
  );
  Queue_2 Queue_3 ( // @[priority_arbiter_chisel.scala 30:40:@1952.4]
    .clock(Queue_3_clock),
    .reset(Queue_3_reset),
    .io_enq_ready(Queue_3_io_enq_ready),
    .io_enq_valid(Queue_3_io_enq_valid),
    .io_enq_bits(Queue_3_io_enq_bits),
    .io_deq_ready(Queue_3_io_deq_ready),
    .io_deq_valid(Queue_3_io_deq_valid),
    .io_deq_bits(Queue_3_io_deq_bits)
  );
  assign issue_ack_out_vec_1 = Queue_1_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1914.4 priority_arbiter_chisel.scala 33:48:@1937.4]
  assign issue_ack_out_vec_0 = Queue_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1914.4 priority_arbiter_chisel.scala 33:48:@1926.4]
  assign _T_121 = {issue_ack_out_vec_1,issue_ack_out_vec_0}; // @[priority_arbiter_chisel.scala 43:47:@1978.4]
  assign issue_ack_out_vec_3 = Queue_3_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1914.4 priority_arbiter_chisel.scala 33:48:@1959.4]
  assign issue_ack_out_vec_2 = Queue_2_io_enq_ready; // @[priority_arbiter_chisel.scala 25:37:@1914.4 priority_arbiter_chisel.scala 33:48:@1948.4]
  assign _T_122 = {issue_ack_out_vec_3,issue_ack_out_vec_2}; // @[priority_arbiter_chisel.scala 43:47:@1979.4]
  assign io_issue_ack_out = {_T_122,_T_121}; // @[priority_arbiter_chisel.scala 43:26:@1981.4]
  assign io_request_out = arbiter_io_out_bits; // @[priority_arbiter_chisel.scala 39:24:@1975.4]
  assign arbiter_clock = clock; // @[:@1916.4]
  assign arbiter_io_in_0_valid = Queue_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1964.4]
  assign arbiter_io_in_0_bits = Queue_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1963.4]
  assign arbiter_io_in_1_valid = Queue_1_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1967.4]
  assign arbiter_io_in_1_bits = Queue_1_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1966.4]
  assign arbiter_io_in_2_valid = Queue_2_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1970.4]
  assign arbiter_io_in_2_bits = Queue_2_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1969.4]
  assign arbiter_io_in_3_valid = Queue_3_io_deq_valid; // @[priority_arbiter_chisel.scala 37:23:@1973.4]
  assign arbiter_io_in_3_bits = Queue_3_io_deq_bits; // @[priority_arbiter_chisel.scala 37:23:@1972.4]
  assign arbiter_io_out_ready = io_issue_ack_in; // @[priority_arbiter_chisel.scala 41:30:@1977.4]
  assign Queue_clock = clock; // @[:@1920.4]
  assign Queue_reset = reset; // @[:@1921.4]
  assign Queue_io_enq_valid = io_request_valid_flatted_in[0]; // @[priority_arbiter_chisel.scala 32:41:@1925.4]
  assign Queue_io_enq_bits = io_request_flatted_in[79:0]; // @[priority_arbiter_chisel.scala 31:40:@1923.4]
  assign Queue_io_deq_ready = arbiter_io_in_0_ready; // @[priority_arbiter_chisel.scala 35:41:@1929.4]
  assign Queue_1_clock = clock; // @[:@1931.4]
  assign Queue_1_reset = reset; // @[:@1932.4]
  assign Queue_1_io_enq_valid = io_request_valid_flatted_in[1]; // @[priority_arbiter_chisel.scala 32:41:@1936.4]
  assign Queue_1_io_enq_bits = io_request_flatted_in[159:80]; // @[priority_arbiter_chisel.scala 31:40:@1934.4]
  assign Queue_1_io_deq_ready = arbiter_io_in_1_ready; // @[priority_arbiter_chisel.scala 35:41:@1940.4]
  assign Queue_2_clock = clock; // @[:@1942.4]
  assign Queue_2_reset = reset; // @[:@1943.4]
  assign Queue_2_io_enq_valid = io_request_valid_flatted_in[2]; // @[priority_arbiter_chisel.scala 32:41:@1947.4]
  assign Queue_2_io_enq_bits = io_request_flatted_in[239:160]; // @[priority_arbiter_chisel.scala 31:40:@1945.4]
  assign Queue_2_io_deq_ready = arbiter_io_in_2_ready; // @[priority_arbiter_chisel.scala 35:41:@1951.4]
  assign Queue_3_clock = clock; // @[:@1953.4]
  assign Queue_3_reset = reset; // @[:@1954.4]
  assign Queue_3_io_enq_valid = io_request_valid_flatted_in[3]; // @[priority_arbiter_chisel.scala 32:41:@1958.4]
  assign Queue_3_io_enq_bits = io_request_flatted_in[319:240]; // @[priority_arbiter_chisel.scala 31:40:@1956.4]
  assign Queue_3_io_deq_ready = arbiter_io_in_3_ready; // @[priority_arbiter_chisel.scala 35:41:@1962.4]
endmodule
module true_unified_cache( // @[:@2328.2]
  input          clock, // @[:@2329.4]
  input          reset, // @[:@2330.4]
  input  [159:0] io_input_packet_flatted_in, // @[:@2331.4]
  output [1:0]   io_input_packet_ack_flatted_out, // @[:@2331.4]
  output [159:0] io_return_packet_flatted_out, // @[:@2331.4]
  input  [1:0]   io_return_packet_ack_flatted_in, // @[:@2331.4]
  input  [79:0]  io_from_mem_packet_in, // @[:@2331.4]
  output         io_from_mem_packet_ack_out, // @[:@2331.4]
  output [79:0]  io_to_mem_packet_out, // @[:@2331.4]
  input          io_to_mem_packet_ack_in // @[:@2331.4]
);
  wire  fifo_queue_clock; // @[true_unified_cache.scala 152:57:@2342.4]
  wire  fifo_queue_reset; // @[true_unified_cache.scala 152:57:@2342.4]
  wire [79:0] fifo_queue_io_request_in; // @[true_unified_cache.scala 152:57:@2342.4]
  wire  fifo_queue_io_request_valid_in; // @[true_unified_cache.scala 152:57:@2342.4]
  wire  fifo_queue_io_issue_ack_out; // @[true_unified_cache.scala 152:57:@2342.4]
  wire [79:0] fifo_queue_io_request_out; // @[true_unified_cache.scala 152:57:@2342.4]
  wire  fifo_queue_io_request_valid_out; // @[true_unified_cache.scala 152:57:@2342.4]
  wire  fifo_queue_io_issue_ack_in; // @[true_unified_cache.scala 152:57:@2342.4]
  wire  fifo_queue_1_clock; // @[true_unified_cache.scala 152:57:@2345.4]
  wire  fifo_queue_1_reset; // @[true_unified_cache.scala 152:57:@2345.4]
  wire [79:0] fifo_queue_1_io_request_in; // @[true_unified_cache.scala 152:57:@2345.4]
  wire  fifo_queue_1_io_request_valid_in; // @[true_unified_cache.scala 152:57:@2345.4]
  wire  fifo_queue_1_io_issue_ack_out; // @[true_unified_cache.scala 152:57:@2345.4]
  wire [79:0] fifo_queue_1_io_request_out; // @[true_unified_cache.scala 152:57:@2345.4]
  wire  fifo_queue_1_io_request_valid_out; // @[true_unified_cache.scala 152:57:@2345.4]
  wire  fifo_queue_1_io_issue_ack_in; // @[true_unified_cache.scala 152:57:@2345.4]
  wire  unified_cache_bank_clock; // @[true_unified_cache.scala 209:28:@2429.4]
  wire  unified_cache_bank_reset; // @[true_unified_cache.scala 209:28:@2429.4]
  wire [159:0] unified_cache_bank_io_input_request_flatted_in; // @[true_unified_cache.scala 209:28:@2429.4]
  wire [1:0] unified_cache_bank_io_input_request_valid_flatted_in; // @[true_unified_cache.scala 209:28:@2429.4]
  wire [1:0] unified_cache_bank_io_input_request_ack_out; // @[true_unified_cache.scala 209:28:@2429.4]
  wire [79:0] unified_cache_bank_io_fetched_request_in; // @[true_unified_cache.scala 209:28:@2429.4]
  wire  unified_cache_bank_io_fetched_request_valid_in; // @[true_unified_cache.scala 209:28:@2429.4]
  wire  unified_cache_bank_io_fetch_ack_out; // @[true_unified_cache.scala 209:28:@2429.4]
  wire [79:0] unified_cache_bank_io_miss_request_out; // @[true_unified_cache.scala 209:28:@2429.4]
  wire  unified_cache_bank_io_miss_request_valid_out; // @[true_unified_cache.scala 209:28:@2429.4]
  wire  unified_cache_bank_io_miss_request_ack_in; // @[true_unified_cache.scala 209:28:@2429.4]
  wire [79:0] unified_cache_bank_io_return_request_out; // @[true_unified_cache.scala 209:28:@2429.4]
  wire  unified_cache_bank_io_return_request_valid_out; // @[true_unified_cache.scala 209:28:@2429.4]
  wire  unified_cache_bank_io_return_request_ack_in; // @[true_unified_cache.scala 209:28:@2429.4]
  wire  unified_cache_bank_1_clock; // @[true_unified_cache.scala 209:28:@2495.4]
  wire  unified_cache_bank_1_reset; // @[true_unified_cache.scala 209:28:@2495.4]
  wire [159:0] unified_cache_bank_1_io_input_request_flatted_in; // @[true_unified_cache.scala 209:28:@2495.4]
  wire [1:0] unified_cache_bank_1_io_input_request_valid_flatted_in; // @[true_unified_cache.scala 209:28:@2495.4]
  wire [1:0] unified_cache_bank_1_io_input_request_ack_out; // @[true_unified_cache.scala 209:28:@2495.4]
  wire [79:0] unified_cache_bank_1_io_fetched_request_in; // @[true_unified_cache.scala 209:28:@2495.4]
  wire  unified_cache_bank_1_io_fetched_request_valid_in; // @[true_unified_cache.scala 209:28:@2495.4]
  wire  unified_cache_bank_1_io_fetch_ack_out; // @[true_unified_cache.scala 209:28:@2495.4]
  wire [79:0] unified_cache_bank_1_io_miss_request_out; // @[true_unified_cache.scala 209:28:@2495.4]
  wire  unified_cache_bank_1_io_miss_request_valid_out; // @[true_unified_cache.scala 209:28:@2495.4]
  wire  unified_cache_bank_1_io_miss_request_ack_in; // @[true_unified_cache.scala 209:28:@2495.4]
  wire [79:0] unified_cache_bank_1_io_return_request_out; // @[true_unified_cache.scala 209:28:@2495.4]
  wire  unified_cache_bank_1_io_return_request_valid_out; // @[true_unified_cache.scala 209:28:@2495.4]
  wire  unified_cache_bank_1_io_return_request_ack_in; // @[true_unified_cache.scala 209:28:@2495.4]
  wire  unified_cache_bank_2_clock; // @[true_unified_cache.scala 209:28:@2561.4]
  wire  unified_cache_bank_2_reset; // @[true_unified_cache.scala 209:28:@2561.4]
  wire [159:0] unified_cache_bank_2_io_input_request_flatted_in; // @[true_unified_cache.scala 209:28:@2561.4]
  wire [1:0] unified_cache_bank_2_io_input_request_valid_flatted_in; // @[true_unified_cache.scala 209:28:@2561.4]
  wire [1:0] unified_cache_bank_2_io_input_request_ack_out; // @[true_unified_cache.scala 209:28:@2561.4]
  wire [79:0] unified_cache_bank_2_io_fetched_request_in; // @[true_unified_cache.scala 209:28:@2561.4]
  wire  unified_cache_bank_2_io_fetched_request_valid_in; // @[true_unified_cache.scala 209:28:@2561.4]
  wire  unified_cache_bank_2_io_fetch_ack_out; // @[true_unified_cache.scala 209:28:@2561.4]
  wire [79:0] unified_cache_bank_2_io_miss_request_out; // @[true_unified_cache.scala 209:28:@2561.4]
  wire  unified_cache_bank_2_io_miss_request_valid_out; // @[true_unified_cache.scala 209:28:@2561.4]
  wire  unified_cache_bank_2_io_miss_request_ack_in; // @[true_unified_cache.scala 209:28:@2561.4]
  wire [79:0] unified_cache_bank_2_io_return_request_out; // @[true_unified_cache.scala 209:28:@2561.4]
  wire  unified_cache_bank_2_io_return_request_valid_out; // @[true_unified_cache.scala 209:28:@2561.4]
  wire  unified_cache_bank_2_io_return_request_ack_in; // @[true_unified_cache.scala 209:28:@2561.4]
  wire  unified_cache_bank_3_clock; // @[true_unified_cache.scala 209:28:@2627.4]
  wire  unified_cache_bank_3_reset; // @[true_unified_cache.scala 209:28:@2627.4]
  wire [159:0] unified_cache_bank_3_io_input_request_flatted_in; // @[true_unified_cache.scala 209:28:@2627.4]
  wire [1:0] unified_cache_bank_3_io_input_request_valid_flatted_in; // @[true_unified_cache.scala 209:28:@2627.4]
  wire [1:0] unified_cache_bank_3_io_input_request_ack_out; // @[true_unified_cache.scala 209:28:@2627.4]
  wire [79:0] unified_cache_bank_3_io_fetched_request_in; // @[true_unified_cache.scala 209:28:@2627.4]
  wire  unified_cache_bank_3_io_fetched_request_valid_in; // @[true_unified_cache.scala 209:28:@2627.4]
  wire  unified_cache_bank_3_io_fetch_ack_out; // @[true_unified_cache.scala 209:28:@2627.4]
  wire [79:0] unified_cache_bank_3_io_miss_request_out; // @[true_unified_cache.scala 209:28:@2627.4]
  wire  unified_cache_bank_3_io_miss_request_valid_out; // @[true_unified_cache.scala 209:28:@2627.4]
  wire  unified_cache_bank_3_io_miss_request_ack_in; // @[true_unified_cache.scala 209:28:@2627.4]
  wire [79:0] unified_cache_bank_3_io_return_request_out; // @[true_unified_cache.scala 209:28:@2627.4]
  wire  unified_cache_bank_3_io_return_request_valid_out; // @[true_unified_cache.scala 209:28:@2627.4]
  wire  unified_cache_bank_3_io_return_request_ack_in; // @[true_unified_cache.scala 209:28:@2627.4]
  wire  to_mem_arbiter_clock; // @[true_unified_cache.scala 266:30:@2699.4]
  wire  to_mem_arbiter_reset; // @[true_unified_cache.scala 266:30:@2699.4]
  wire [639:0] to_mem_arbiter_io_request_flatted_in; // @[true_unified_cache.scala 266:30:@2699.4]
  wire [7:0] to_mem_arbiter_io_request_valid_flatted_in; // @[true_unified_cache.scala 266:30:@2699.4]
  wire [7:0] to_mem_arbiter_io_issue_ack_out; // @[true_unified_cache.scala 266:30:@2699.4]
  wire [79:0] to_mem_arbiter_io_request_out; // @[true_unified_cache.scala 266:30:@2699.4]
  wire  to_mem_arbiter_io_issue_ack_in; // @[true_unified_cache.scala 266:30:@2699.4]
  wire  priority_arbiter_clock; // @[true_unified_cache.scala 296:32:@2783.4]
  wire  priority_arbiter_reset; // @[true_unified_cache.scala 296:32:@2783.4]
  wire [319:0] priority_arbiter_io_request_flatted_in; // @[true_unified_cache.scala 296:32:@2783.4]
  wire [3:0] priority_arbiter_io_request_valid_flatted_in; // @[true_unified_cache.scala 296:32:@2783.4]
  wire [3:0] priority_arbiter_io_issue_ack_out; // @[true_unified_cache.scala 296:32:@2783.4]
  wire [79:0] priority_arbiter_io_request_out; // @[true_unified_cache.scala 296:32:@2783.4]
  wire  priority_arbiter_io_issue_ack_in; // @[true_unified_cache.scala 296:32:@2783.4]
  wire  priority_arbiter_1_clock; // @[true_unified_cache.scala 296:32:@2827.4]
  wire  priority_arbiter_1_reset; // @[true_unified_cache.scala 296:32:@2827.4]
  wire [319:0] priority_arbiter_1_io_request_flatted_in; // @[true_unified_cache.scala 296:32:@2827.4]
  wire [3:0] priority_arbiter_1_io_request_valid_flatted_in; // @[true_unified_cache.scala 296:32:@2827.4]
  wire [3:0] priority_arbiter_1_io_issue_ack_out; // @[true_unified_cache.scala 296:32:@2827.4]
  wire [79:0] priority_arbiter_1_io_request_out; // @[true_unified_cache.scala 296:32:@2827.4]
  wire  priority_arbiter_1_io_issue_ack_in; // @[true_unified_cache.scala 296:32:@2827.4]
  wire [79:0] input_packet_packed_0; // @[true_unified_cache.scala 161:66:@2365.4]
  wire [79:0] input_packet_packed_1; // @[true_unified_cache.scala 161:66:@2377.4]
  wire [79:0] input_queue_vec_0_request_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2351.4]
  wire [31:0] _T_288_0; // @[true_unified_cache.scala 193:31:@2403.4 true_unified_cache.scala 197:35:@2406.4]
  wire [1:0] _T_309; // @[true_unified_cache.scala 198:70:@2407.4]
  wire  _T_311; // @[true_unified_cache.scala 198:147:@2408.4]
  wire  input_queue_vec_0_request_valid_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2350.4]
  wire  _T_312; // @[true_unified_cache.scala 199:91:@2410.4]
  wire [79:0] input_queue_vec_1_request_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2359.4]
  wire [31:0] _T_288_1; // @[true_unified_cache.scala 193:31:@2403.4 true_unified_cache.scala 197:35:@2412.4]
  wire [1:0] _T_313; // @[true_unified_cache.scala 198:70:@2413.4]
  wire  _T_315; // @[true_unified_cache.scala 198:147:@2414.4]
  wire  input_queue_vec_1_request_valid_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2358.4]
  wire  _T_316; // @[true_unified_cache.scala 199:91:@2416.4]
  wire [31:0] _T_323; // @[true_unified_cache.scala 205:47:@2421.4]
  wire [1:0] _T_324; // @[true_unified_cache.scala 206:48:@2423.4]
  wire  _T_326; // @[true_unified_cache.scala 206:125:@2424.4]
  wire  _T_327; // @[true_unified_cache.scala 207:52:@2426.4]
  wire  _T_328; // @[true_unified_cache.scala 207:87:@2427.4]
  wire [1:0] _T_329; // @[true_unified_cache.scala 221:32:@2432.4]
  wire  _T_331; // @[true_unified_cache.scala 221:39:@2433.4]
  wire [159:0] _T_332; // @[true_unified_cache.scala 222:79:@2435.6]
  wire [3:0] miss_request_ack_flatted; // @[true_unified_cache.scala 274:62:@2726.4]
  wire  _T_366; // @[true_unified_cache.scala 198:147:@2474.4]
  wire  _T_367; // @[true_unified_cache.scala 199:91:@2476.4]
  wire  _T_370; // @[true_unified_cache.scala 198:147:@2480.4]
  wire  _T_371; // @[true_unified_cache.scala 199:91:@2482.4]
  wire  _T_381; // @[true_unified_cache.scala 206:125:@2490.4]
  wire  _T_383; // @[true_unified_cache.scala 207:87:@2493.4]
  wire [1:0] _T_384; // @[true_unified_cache.scala 221:32:@2498.4]
  wire  _T_386; // @[true_unified_cache.scala 221:39:@2499.4]
  wire  _T_421; // @[true_unified_cache.scala 198:147:@2540.4]
  wire  _T_422; // @[true_unified_cache.scala 199:91:@2542.4]
  wire  _T_425; // @[true_unified_cache.scala 198:147:@2546.4]
  wire  _T_426; // @[true_unified_cache.scala 199:91:@2548.4]
  wire  _T_436; // @[true_unified_cache.scala 206:125:@2556.4]
  wire  _T_438; // @[true_unified_cache.scala 207:87:@2559.4]
  wire [1:0] _T_439; // @[true_unified_cache.scala 221:32:@2564.4]
  wire  _T_441; // @[true_unified_cache.scala 221:39:@2565.4]
  wire  _T_476; // @[true_unified_cache.scala 198:147:@2606.4]
  wire  _T_477; // @[true_unified_cache.scala 199:91:@2608.4]
  wire  _T_480; // @[true_unified_cache.scala 198:147:@2612.4]
  wire  _T_481; // @[true_unified_cache.scala 199:91:@2614.4]
  wire  _T_491; // @[true_unified_cache.scala 206:125:@2622.4]
  wire  _T_493; // @[true_unified_cache.scala 207:87:@2625.4]
  wire [1:0] _T_494; // @[true_unified_cache.scala 221:32:@2630.4]
  wire  _T_496; // @[true_unified_cache.scala 221:39:@2631.4]
  wire  from_mem_packet_ack_flatted_1; // @[true_unified_cache.scala 176:41:@2390.4 true_unified_cache.scala 238:45:@2520.4]
  wire  from_mem_packet_ack_flatted_0; // @[true_unified_cache.scala 176:41:@2390.4 true_unified_cache.scala 238:45:@2454.4]
  wire [1:0] _T_505; // @[true_unified_cache.scala 257:61:@2667.4]
  wire  from_mem_packet_ack_flatted_3; // @[true_unified_cache.scala 176:41:@2390.4 true_unified_cache.scala 238:45:@2652.4]
  wire  from_mem_packet_ack_flatted_2; // @[true_unified_cache.scala 176:41:@2390.4 true_unified_cache.scala 238:45:@2586.4]
  wire [1:0] _T_506; // @[true_unified_cache.scala 257:61:@2668.4]
  wire [3:0] _T_507; // @[true_unified_cache.scala 257:61:@2669.4]
  wire [1:0] cache_to_input_queue_ack_flatted_0; // @[true_unified_cache.scala 175:46:@2389.4 true_unified_cache.scala 229:50:@2445.4]
  wire  cache_to_input_queue_ack_packed_0_0; // @[true_unified_cache.scala 261:110:@2673.4]
  wire [1:0] cache_to_input_queue_ack_flatted_1; // @[true_unified_cache.scala 175:46:@2389.4 true_unified_cache.scala 229:50:@2511.4]
  wire  cache_to_input_queue_ack_packed_0_1; // @[true_unified_cache.scala 261:110:@2675.4]
  wire [1:0] cache_to_input_queue_ack_flatted_2; // @[true_unified_cache.scala 175:46:@2389.4 true_unified_cache.scala 229:50:@2577.4]
  wire  cache_to_input_queue_ack_packed_0_2; // @[true_unified_cache.scala 261:110:@2677.4]
  wire [1:0] cache_to_input_queue_ack_flatted_3; // @[true_unified_cache.scala 175:46:@2389.4 true_unified_cache.scala 229:50:@2643.4]
  wire  cache_to_input_queue_ack_packed_0_3; // @[true_unified_cache.scala 261:110:@2679.4]
  wire [1:0] _T_592; // @[true_unified_cache.scala 263:96:@2681.4]
  wire [1:0] _T_593; // @[true_unified_cache.scala 263:96:@2682.4]
  wire [3:0] _T_594; // @[true_unified_cache.scala 263:96:@2683.4]
  wire  cache_to_input_queue_ack_packed_1_0; // @[true_unified_cache.scala 261:110:@2686.4]
  wire  cache_to_input_queue_ack_packed_1_1; // @[true_unified_cache.scala 261:110:@2688.4]
  wire  cache_to_input_queue_ack_packed_1_2; // @[true_unified_cache.scala 261:110:@2690.4]
  wire  cache_to_input_queue_ack_packed_1_3; // @[true_unified_cache.scala 261:110:@2692.4]
  wire [1:0] _T_601; // @[true_unified_cache.scala 263:96:@2694.4]
  wire [1:0] _T_602; // @[true_unified_cache.scala 263:96:@2695.4]
  wire [3:0] _T_603; // @[true_unified_cache.scala 263:96:@2696.4]
  wire [79:0] miss_request_flatted_1; // @[true_unified_cache.scala 177:34:@2391.4 true_unified_cache.scala 240:38:@2521.4]
  wire [79:0] miss_request_flatted_0; // @[true_unified_cache.scala 177:34:@2391.4 true_unified_cache.scala 240:38:@2455.4]
  wire [159:0] _T_606; // @[true_unified_cache.scala 271:68:@2702.4]
  wire [79:0] miss_request_flatted_3; // @[true_unified_cache.scala 177:34:@2391.4 true_unified_cache.scala 240:38:@2653.4]
  wire [79:0] miss_request_flatted_2; // @[true_unified_cache.scala 177:34:@2391.4 true_unified_cache.scala 240:38:@2587.4]
  wire [159:0] _T_607; // @[true_unified_cache.scala 271:68:@2703.4]
  wire [319:0] _T_608; // @[true_unified_cache.scala 271:68:@2704.4]
  wire  miss_request_valid_flatted_1; // @[true_unified_cache.scala 178:40:@2392.4 true_unified_cache.scala 241:44:@2522.4]
  wire  miss_request_valid_flatted_0; // @[true_unified_cache.scala 178:40:@2392.4 true_unified_cache.scala 241:44:@2456.4]
  wire [1:0] _T_613; // @[true_unified_cache.scala 272:80:@2710.4]
  wire  miss_request_valid_flatted_3; // @[true_unified_cache.scala 178:40:@2392.4 true_unified_cache.scala 241:44:@2654.4]
  wire  miss_request_valid_flatted_2; // @[true_unified_cache.scala 178:40:@2392.4 true_unified_cache.scala 241:44:@2588.4]
  wire [1:0] _T_614; // @[true_unified_cache.scala 272:80:@2711.4]
  wire [3:0] _T_615; // @[true_unified_cache.scala 272:80:@2712.4]
  wire [3:0] return_request_ack_flatted_0; // @[true_unified_cache.scala 280:40:@2732.4 true_unified_cache.scala 304:44:@2802.4]
  wire  return_request_ack_packed_0_0; // @[true_unified_cache.scala 284:98:@2734.4]
  wire [3:0] return_request_ack_flatted_1; // @[true_unified_cache.scala 280:40:@2732.4 true_unified_cache.scala 304:44:@2846.4]
  wire  return_request_ack_packed_0_1; // @[true_unified_cache.scala 284:98:@2736.4]
  wire [1:0] _T_724; // @[true_unified_cache.scala 286:84:@2738.4]
  wire  return_request_ack_packed_1_0; // @[true_unified_cache.scala 284:98:@2741.4]
  wire  return_request_ack_packed_1_1; // @[true_unified_cache.scala 284:98:@2743.4]
  wire [1:0] _T_729; // @[true_unified_cache.scala 286:84:@2745.4]
  wire  return_request_ack_packed_2_0; // @[true_unified_cache.scala 284:98:@2748.4]
  wire  return_request_ack_packed_2_1; // @[true_unified_cache.scala 284:98:@2750.4]
  wire [1:0] _T_734; // @[true_unified_cache.scala 286:84:@2752.4]
  wire  return_request_ack_packed_3_0; // @[true_unified_cache.scala 284:98:@2755.4]
  wire  return_request_ack_packed_3_1; // @[true_unified_cache.scala 284:98:@2757.4]
  wire [1:0] _T_739; // @[true_unified_cache.scala 286:84:@2759.4]
  wire [79:0] return_request_flatted_0; // @[true_unified_cache.scala 187:36:@2399.4 true_unified_cache.scala 250:40:@2465.4]
  wire [1:0] _T_752; // @[true_unified_cache.scala 292:71:@2763.4]
  wire  _T_754; // @[true_unified_cache.scala 292:164:@2764.4]
  wire  _T_755; // @[true_unified_cache.scala 293:71:@2765.4]
  wire  _T_756; // @[true_unified_cache.scala 292:182:@2766.4]
  wire [79:0] return_request_flatted_1; // @[true_unified_cache.scala 187:36:@2399.4 true_unified_cache.scala 250:40:@2531.4]
  wire [1:0] _T_757; // @[true_unified_cache.scala 292:71:@2768.4]
  wire  _T_759; // @[true_unified_cache.scala 292:164:@2769.4]
  wire  _T_760; // @[true_unified_cache.scala 293:71:@2770.4]
  wire  _T_761; // @[true_unified_cache.scala 292:182:@2771.4]
  wire [79:0] return_request_flatted_2; // @[true_unified_cache.scala 187:36:@2399.4 true_unified_cache.scala 250:40:@2597.4]
  wire [1:0] _T_762; // @[true_unified_cache.scala 292:71:@2773.4]
  wire  _T_764; // @[true_unified_cache.scala 292:164:@2774.4]
  wire  _T_765; // @[true_unified_cache.scala 293:71:@2775.4]
  wire  _T_766; // @[true_unified_cache.scala 292:182:@2776.4]
  wire [79:0] return_request_flatted_3; // @[true_unified_cache.scala 187:36:@2399.4 true_unified_cache.scala 250:40:@2663.4]
  wire [1:0] _T_767; // @[true_unified_cache.scala 292:71:@2778.4]
  wire  _T_769; // @[true_unified_cache.scala 292:164:@2779.4]
  wire  _T_770; // @[true_unified_cache.scala 293:71:@2780.4]
  wire  _T_771; // @[true_unified_cache.scala 292:182:@2781.4]
  wire [159:0] _T_772; // @[true_unified_cache.scala 301:68:@2786.4]
  wire [159:0] _T_773; // @[true_unified_cache.scala 301:68:@2787.4]
  wire  return_request_valid_flatted_1; // @[true_unified_cache.scala 188:42:@2400.4 true_unified_cache.scala 251:46:@2532.4]
  wire  return_request_valid_flatted_0; // @[true_unified_cache.scala 188:42:@2400.4 true_unified_cache.scala 251:46:@2466.4]
  wire [1:0] _T_775; // @[true_unified_cache.scala 302:80:@2790.4]
  wire  return_request_valid_flatted_3; // @[true_unified_cache.scala 188:42:@2400.4 true_unified_cache.scala 251:46:@2664.4]
  wire  return_request_valid_flatted_2; // @[true_unified_cache.scala 188:42:@2400.4 true_unified_cache.scala 251:46:@2598.4]
  wire [1:0] _T_776; // @[true_unified_cache.scala 302:80:@2791.4]
  wire [3:0] _T_777; // @[true_unified_cache.scala 302:80:@2792.4]
  wire [1:0] _T_778; // @[true_unified_cache.scala 302:103:@2793.4]
  wire [1:0] _T_779; // @[true_unified_cache.scala 302:103:@2794.4]
  wire [3:0] _T_780; // @[true_unified_cache.scala 302:103:@2795.4]
  wire  _T_798; // @[true_unified_cache.scala 292:164:@2808.4]
  wire  _T_800; // @[true_unified_cache.scala 292:182:@2810.4]
  wire  _T_803; // @[true_unified_cache.scala 292:164:@2813.4]
  wire  _T_805; // @[true_unified_cache.scala 292:182:@2815.4]
  wire  _T_808; // @[true_unified_cache.scala 292:164:@2818.4]
  wire  _T_810; // @[true_unified_cache.scala 292:182:@2820.4]
  wire  _T_813; // @[true_unified_cache.scala 292:164:@2823.4]
  wire  _T_815; // @[true_unified_cache.scala 292:182:@2825.4]
  wire [1:0] _T_822; // @[true_unified_cache.scala 302:103:@2837.4]
  wire [1:0] _T_823; // @[true_unified_cache.scala 302:103:@2838.4]
  wire [3:0] _T_824; // @[true_unified_cache.scala 302:103:@2839.4]
  wire  input_queue_vec_1_issue_ack_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2360.4]
  wire  input_queue_vec_0_issue_ack_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2352.4]
  wire [79:0] return_packet_flatted_out_vec_1; // @[true_unified_cache.scala 142:43:@2334.4 true_unified_cache.scala 305:47:@2847.4]
  wire [79:0] return_packet_flatted_out_vec_0; // @[true_unified_cache.scala 142:43:@2334.4 true_unified_cache.scala 305:47:@2803.4]
  fifo_queue fifo_queue ( // @[true_unified_cache.scala 152:57:@2342.4]
    .clock(fifo_queue_clock),
    .reset(fifo_queue_reset),
    .io_request_in(fifo_queue_io_request_in),
    .io_request_valid_in(fifo_queue_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_io_issue_ack_out),
    .io_request_out(fifo_queue_io_request_out),
    .io_request_valid_out(fifo_queue_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_io_issue_ack_in)
  );
  fifo_queue fifo_queue_1 ( // @[true_unified_cache.scala 152:57:@2345.4]
    .clock(fifo_queue_1_clock),
    .reset(fifo_queue_1_reset),
    .io_request_in(fifo_queue_1_io_request_in),
    .io_request_valid_in(fifo_queue_1_io_request_valid_in),
    .io_issue_ack_out(fifo_queue_1_io_issue_ack_out),
    .io_request_out(fifo_queue_1_io_request_out),
    .io_request_valid_out(fifo_queue_1_io_request_valid_out),
    .io_issue_ack_in(fifo_queue_1_io_issue_ack_in)
  );
  unified_cache_bank unified_cache_bank ( // @[true_unified_cache.scala 209:28:@2429.4]
    .clock(unified_cache_bank_clock),
    .reset(unified_cache_bank_reset),
    .io_input_request_flatted_in(unified_cache_bank_io_input_request_flatted_in),
    .io_input_request_valid_flatted_in(unified_cache_bank_io_input_request_valid_flatted_in),
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
  unified_cache_bank unified_cache_bank_1 ( // @[true_unified_cache.scala 209:28:@2495.4]
    .clock(unified_cache_bank_1_clock),
    .reset(unified_cache_bank_1_reset),
    .io_input_request_flatted_in(unified_cache_bank_1_io_input_request_flatted_in),
    .io_input_request_valid_flatted_in(unified_cache_bank_1_io_input_request_valid_flatted_in),
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
  unified_cache_bank unified_cache_bank_2 ( // @[true_unified_cache.scala 209:28:@2561.4]
    .clock(unified_cache_bank_2_clock),
    .reset(unified_cache_bank_2_reset),
    .io_input_request_flatted_in(unified_cache_bank_2_io_input_request_flatted_in),
    .io_input_request_valid_flatted_in(unified_cache_bank_2_io_input_request_valid_flatted_in),
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
  unified_cache_bank unified_cache_bank_3 ( // @[true_unified_cache.scala 209:28:@2627.4]
    .clock(unified_cache_bank_3_clock),
    .reset(unified_cache_bank_3_reset),
    .io_input_request_flatted_in(unified_cache_bank_3_io_input_request_flatted_in),
    .io_input_request_valid_flatted_in(unified_cache_bank_3_io_input_request_valid_flatted_in),
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
  priority_arbiter_4 to_mem_arbiter ( // @[true_unified_cache.scala 266:30:@2699.4]
    .clock(to_mem_arbiter_clock),
    .reset(to_mem_arbiter_reset),
    .io_request_flatted_in(to_mem_arbiter_io_request_flatted_in),
    .io_request_valid_flatted_in(to_mem_arbiter_io_request_valid_flatted_in),
    .io_issue_ack_out(to_mem_arbiter_io_issue_ack_out),
    .io_request_out(to_mem_arbiter_io_request_out),
    .io_issue_ack_in(to_mem_arbiter_io_issue_ack_in)
  );
  priority_arbiter_5 priority_arbiter ( // @[true_unified_cache.scala 296:32:@2783.4]
    .clock(priority_arbiter_clock),
    .reset(priority_arbiter_reset),
    .io_request_flatted_in(priority_arbiter_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_io_request_valid_flatted_in),
    .io_issue_ack_out(priority_arbiter_io_issue_ack_out),
    .io_request_out(priority_arbiter_io_request_out),
    .io_issue_ack_in(priority_arbiter_io_issue_ack_in)
  );
  priority_arbiter_5 priority_arbiter_1 ( // @[true_unified_cache.scala 296:32:@2827.4]
    .clock(priority_arbiter_1_clock),
    .reset(priority_arbiter_1_reset),
    .io_request_flatted_in(priority_arbiter_1_io_request_flatted_in),
    .io_request_valid_flatted_in(priority_arbiter_1_io_request_valid_flatted_in),
    .io_issue_ack_out(priority_arbiter_1_io_issue_ack_out),
    .io_request_out(priority_arbiter_1_io_request_out),
    .io_issue_ack_in(priority_arbiter_1_io_issue_ack_in)
  );
  assign input_packet_packed_0 = io_input_packet_flatted_in[79:0]; // @[true_unified_cache.scala 161:66:@2365.4]
  assign input_packet_packed_1 = io_input_packet_flatted_in[159:80]; // @[true_unified_cache.scala 161:66:@2377.4]
  assign input_queue_vec_0_request_out = fifo_queue_io_request_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2351.4]
  assign _T_288_0 = input_queue_vec_0_request_out[31:0]; // @[true_unified_cache.scala 193:31:@2403.4 true_unified_cache.scala 197:35:@2406.4]
  assign _T_309 = _T_288_0[3:2]; // @[true_unified_cache.scala 198:70:@2407.4]
  assign _T_311 = _T_309 == 2'h0; // @[true_unified_cache.scala 198:147:@2408.4]
  assign input_queue_vec_0_request_valid_out = fifo_queue_io_request_valid_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2350.4]
  assign _T_312 = input_queue_vec_0_request_valid_out & _T_311; // @[true_unified_cache.scala 199:91:@2410.4]
  assign input_queue_vec_1_request_out = fifo_queue_1_io_request_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2359.4]
  assign _T_288_1 = input_queue_vec_1_request_out[31:0]; // @[true_unified_cache.scala 193:31:@2403.4 true_unified_cache.scala 197:35:@2412.4]
  assign _T_313 = _T_288_1[3:2]; // @[true_unified_cache.scala 198:70:@2413.4]
  assign _T_315 = _T_313 == 2'h0; // @[true_unified_cache.scala 198:147:@2414.4]
  assign input_queue_vec_1_request_valid_out = fifo_queue_1_io_request_valid_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2358.4]
  assign _T_316 = input_queue_vec_1_request_valid_out & _T_315; // @[true_unified_cache.scala 199:91:@2416.4]
  assign _T_323 = io_from_mem_packet_in[31:0]; // @[true_unified_cache.scala 205:47:@2421.4]
  assign _T_324 = _T_323[3:2]; // @[true_unified_cache.scala 206:48:@2423.4]
  assign _T_326 = _T_324 == 2'h0; // @[true_unified_cache.scala 206:125:@2424.4]
  assign _T_327 = io_from_mem_packet_in[77]; // @[true_unified_cache.scala 207:52:@2426.4]
  assign _T_328 = _T_327 & _T_326; // @[true_unified_cache.scala 207:87:@2427.4]
  assign _T_329 = {_T_316,_T_312}; // @[true_unified_cache.scala 221:32:@2432.4]
  assign _T_331 = _T_329 > 2'h0; // @[true_unified_cache.scala 221:39:@2433.4]
  assign _T_332 = {input_queue_vec_1_request_out,input_queue_vec_0_request_out}; // @[true_unified_cache.scala 222:79:@2435.6]
  assign miss_request_ack_flatted = to_mem_arbiter_io_issue_ack_out[7:4]; // @[true_unified_cache.scala 274:62:@2726.4]
  assign _T_366 = _T_309 == 2'h1; // @[true_unified_cache.scala 198:147:@2474.4]
  assign _T_367 = input_queue_vec_0_request_valid_out & _T_366; // @[true_unified_cache.scala 199:91:@2476.4]
  assign _T_370 = _T_313 == 2'h1; // @[true_unified_cache.scala 198:147:@2480.4]
  assign _T_371 = input_queue_vec_1_request_valid_out & _T_370; // @[true_unified_cache.scala 199:91:@2482.4]
  assign _T_381 = _T_324 == 2'h1; // @[true_unified_cache.scala 206:125:@2490.4]
  assign _T_383 = _T_327 & _T_381; // @[true_unified_cache.scala 207:87:@2493.4]
  assign _T_384 = {_T_371,_T_367}; // @[true_unified_cache.scala 221:32:@2498.4]
  assign _T_386 = _T_384 > 2'h0; // @[true_unified_cache.scala 221:39:@2499.4]
  assign _T_421 = _T_309 == 2'h2; // @[true_unified_cache.scala 198:147:@2540.4]
  assign _T_422 = input_queue_vec_0_request_valid_out & _T_421; // @[true_unified_cache.scala 199:91:@2542.4]
  assign _T_425 = _T_313 == 2'h2; // @[true_unified_cache.scala 198:147:@2546.4]
  assign _T_426 = input_queue_vec_1_request_valid_out & _T_425; // @[true_unified_cache.scala 199:91:@2548.4]
  assign _T_436 = _T_324 == 2'h2; // @[true_unified_cache.scala 206:125:@2556.4]
  assign _T_438 = _T_327 & _T_436; // @[true_unified_cache.scala 207:87:@2559.4]
  assign _T_439 = {_T_426,_T_422}; // @[true_unified_cache.scala 221:32:@2564.4]
  assign _T_441 = _T_439 > 2'h0; // @[true_unified_cache.scala 221:39:@2565.4]
  assign _T_476 = _T_309 == 2'h3; // @[true_unified_cache.scala 198:147:@2606.4]
  assign _T_477 = input_queue_vec_0_request_valid_out & _T_476; // @[true_unified_cache.scala 199:91:@2608.4]
  assign _T_480 = _T_313 == 2'h3; // @[true_unified_cache.scala 198:147:@2612.4]
  assign _T_481 = input_queue_vec_1_request_valid_out & _T_480; // @[true_unified_cache.scala 199:91:@2614.4]
  assign _T_491 = _T_324 == 2'h3; // @[true_unified_cache.scala 206:125:@2622.4]
  assign _T_493 = _T_327 & _T_491; // @[true_unified_cache.scala 207:87:@2625.4]
  assign _T_494 = {_T_481,_T_477}; // @[true_unified_cache.scala 221:32:@2630.4]
  assign _T_496 = _T_494 > 2'h0; // @[true_unified_cache.scala 221:39:@2631.4]
  assign from_mem_packet_ack_flatted_1 = unified_cache_bank_1_io_fetch_ack_out; // @[true_unified_cache.scala 176:41:@2390.4 true_unified_cache.scala 238:45:@2520.4]
  assign from_mem_packet_ack_flatted_0 = unified_cache_bank_io_fetch_ack_out; // @[true_unified_cache.scala 176:41:@2390.4 true_unified_cache.scala 238:45:@2454.4]
  assign _T_505 = {from_mem_packet_ack_flatted_1,from_mem_packet_ack_flatted_0}; // @[true_unified_cache.scala 257:61:@2667.4]
  assign from_mem_packet_ack_flatted_3 = unified_cache_bank_3_io_fetch_ack_out; // @[true_unified_cache.scala 176:41:@2390.4 true_unified_cache.scala 238:45:@2652.4]
  assign from_mem_packet_ack_flatted_2 = unified_cache_bank_2_io_fetch_ack_out; // @[true_unified_cache.scala 176:41:@2390.4 true_unified_cache.scala 238:45:@2586.4]
  assign _T_506 = {from_mem_packet_ack_flatted_3,from_mem_packet_ack_flatted_2}; // @[true_unified_cache.scala 257:61:@2668.4]
  assign _T_507 = {_T_506,_T_505}; // @[true_unified_cache.scala 257:61:@2669.4]
  assign cache_to_input_queue_ack_flatted_0 = unified_cache_bank_io_input_request_ack_out; // @[true_unified_cache.scala 175:46:@2389.4 true_unified_cache.scala 229:50:@2445.4]
  assign cache_to_input_queue_ack_packed_0_0 = cache_to_input_queue_ack_flatted_0[0]; // @[true_unified_cache.scala 261:110:@2673.4]
  assign cache_to_input_queue_ack_flatted_1 = unified_cache_bank_1_io_input_request_ack_out; // @[true_unified_cache.scala 175:46:@2389.4 true_unified_cache.scala 229:50:@2511.4]
  assign cache_to_input_queue_ack_packed_0_1 = cache_to_input_queue_ack_flatted_1[0]; // @[true_unified_cache.scala 261:110:@2675.4]
  assign cache_to_input_queue_ack_flatted_2 = unified_cache_bank_2_io_input_request_ack_out; // @[true_unified_cache.scala 175:46:@2389.4 true_unified_cache.scala 229:50:@2577.4]
  assign cache_to_input_queue_ack_packed_0_2 = cache_to_input_queue_ack_flatted_2[0]; // @[true_unified_cache.scala 261:110:@2677.4]
  assign cache_to_input_queue_ack_flatted_3 = unified_cache_bank_3_io_input_request_ack_out; // @[true_unified_cache.scala 175:46:@2389.4 true_unified_cache.scala 229:50:@2643.4]
  assign cache_to_input_queue_ack_packed_0_3 = cache_to_input_queue_ack_flatted_3[0]; // @[true_unified_cache.scala 261:110:@2679.4]
  assign _T_592 = {cache_to_input_queue_ack_packed_0_1,cache_to_input_queue_ack_packed_0_0}; // @[true_unified_cache.scala 263:96:@2681.4]
  assign _T_593 = {cache_to_input_queue_ack_packed_0_3,cache_to_input_queue_ack_packed_0_2}; // @[true_unified_cache.scala 263:96:@2682.4]
  assign _T_594 = {_T_593,_T_592}; // @[true_unified_cache.scala 263:96:@2683.4]
  assign cache_to_input_queue_ack_packed_1_0 = cache_to_input_queue_ack_flatted_0[1]; // @[true_unified_cache.scala 261:110:@2686.4]
  assign cache_to_input_queue_ack_packed_1_1 = cache_to_input_queue_ack_flatted_1[1]; // @[true_unified_cache.scala 261:110:@2688.4]
  assign cache_to_input_queue_ack_packed_1_2 = cache_to_input_queue_ack_flatted_2[1]; // @[true_unified_cache.scala 261:110:@2690.4]
  assign cache_to_input_queue_ack_packed_1_3 = cache_to_input_queue_ack_flatted_3[1]; // @[true_unified_cache.scala 261:110:@2692.4]
  assign _T_601 = {cache_to_input_queue_ack_packed_1_1,cache_to_input_queue_ack_packed_1_0}; // @[true_unified_cache.scala 263:96:@2694.4]
  assign _T_602 = {cache_to_input_queue_ack_packed_1_3,cache_to_input_queue_ack_packed_1_2}; // @[true_unified_cache.scala 263:96:@2695.4]
  assign _T_603 = {_T_602,_T_601}; // @[true_unified_cache.scala 263:96:@2696.4]
  assign miss_request_flatted_1 = unified_cache_bank_1_io_miss_request_out; // @[true_unified_cache.scala 177:34:@2391.4 true_unified_cache.scala 240:38:@2521.4]
  assign miss_request_flatted_0 = unified_cache_bank_io_miss_request_out; // @[true_unified_cache.scala 177:34:@2391.4 true_unified_cache.scala 240:38:@2455.4]
  assign _T_606 = {miss_request_flatted_1,miss_request_flatted_0}; // @[true_unified_cache.scala 271:68:@2702.4]
  assign miss_request_flatted_3 = unified_cache_bank_3_io_miss_request_out; // @[true_unified_cache.scala 177:34:@2391.4 true_unified_cache.scala 240:38:@2653.4]
  assign miss_request_flatted_2 = unified_cache_bank_2_io_miss_request_out; // @[true_unified_cache.scala 177:34:@2391.4 true_unified_cache.scala 240:38:@2587.4]
  assign _T_607 = {miss_request_flatted_3,miss_request_flatted_2}; // @[true_unified_cache.scala 271:68:@2703.4]
  assign _T_608 = {_T_607,_T_606}; // @[true_unified_cache.scala 271:68:@2704.4]
  assign miss_request_valid_flatted_1 = unified_cache_bank_1_io_miss_request_valid_out; // @[true_unified_cache.scala 178:40:@2392.4 true_unified_cache.scala 241:44:@2522.4]
  assign miss_request_valid_flatted_0 = unified_cache_bank_io_miss_request_valid_out; // @[true_unified_cache.scala 178:40:@2392.4 true_unified_cache.scala 241:44:@2456.4]
  assign _T_613 = {miss_request_valid_flatted_1,miss_request_valid_flatted_0}; // @[true_unified_cache.scala 272:80:@2710.4]
  assign miss_request_valid_flatted_3 = unified_cache_bank_3_io_miss_request_valid_out; // @[true_unified_cache.scala 178:40:@2392.4 true_unified_cache.scala 241:44:@2654.4]
  assign miss_request_valid_flatted_2 = unified_cache_bank_2_io_miss_request_valid_out; // @[true_unified_cache.scala 178:40:@2392.4 true_unified_cache.scala 241:44:@2588.4]
  assign _T_614 = {miss_request_valid_flatted_3,miss_request_valid_flatted_2}; // @[true_unified_cache.scala 272:80:@2711.4]
  assign _T_615 = {_T_614,_T_613}; // @[true_unified_cache.scala 272:80:@2712.4]
  assign return_request_ack_flatted_0 = priority_arbiter_io_issue_ack_out; // @[true_unified_cache.scala 280:40:@2732.4 true_unified_cache.scala 304:44:@2802.4]
  assign return_request_ack_packed_0_0 = return_request_ack_flatted_0[0]; // @[true_unified_cache.scala 284:98:@2734.4]
  assign return_request_ack_flatted_1 = priority_arbiter_1_io_issue_ack_out; // @[true_unified_cache.scala 280:40:@2732.4 true_unified_cache.scala 304:44:@2846.4]
  assign return_request_ack_packed_0_1 = return_request_ack_flatted_1[0]; // @[true_unified_cache.scala 284:98:@2736.4]
  assign _T_724 = {return_request_ack_packed_0_1,return_request_ack_packed_0_0}; // @[true_unified_cache.scala 286:84:@2738.4]
  assign return_request_ack_packed_1_0 = return_request_ack_flatted_0[1]; // @[true_unified_cache.scala 284:98:@2741.4]
  assign return_request_ack_packed_1_1 = return_request_ack_flatted_1[1]; // @[true_unified_cache.scala 284:98:@2743.4]
  assign _T_729 = {return_request_ack_packed_1_1,return_request_ack_packed_1_0}; // @[true_unified_cache.scala 286:84:@2745.4]
  assign return_request_ack_packed_2_0 = return_request_ack_flatted_0[2]; // @[true_unified_cache.scala 284:98:@2748.4]
  assign return_request_ack_packed_2_1 = return_request_ack_flatted_1[2]; // @[true_unified_cache.scala 284:98:@2750.4]
  assign _T_734 = {return_request_ack_packed_2_1,return_request_ack_packed_2_0}; // @[true_unified_cache.scala 286:84:@2752.4]
  assign return_request_ack_packed_3_0 = return_request_ack_flatted_0[3]; // @[true_unified_cache.scala 284:98:@2755.4]
  assign return_request_ack_packed_3_1 = return_request_ack_flatted_1[3]; // @[true_unified_cache.scala 284:98:@2757.4]
  assign _T_739 = {return_request_ack_packed_3_1,return_request_ack_packed_3_0}; // @[true_unified_cache.scala 286:84:@2759.4]
  assign return_request_flatted_0 = unified_cache_bank_io_return_request_out; // @[true_unified_cache.scala 187:36:@2399.4 true_unified_cache.scala 250:40:@2465.4]
  assign _T_752 = return_request_flatted_0[73:72]; // @[true_unified_cache.scala 292:71:@2763.4]
  assign _T_754 = _T_752 == 2'h0; // @[true_unified_cache.scala 292:164:@2764.4]
  assign _T_755 = return_request_flatted_0[77]; // @[true_unified_cache.scala 293:71:@2765.4]
  assign _T_756 = _T_754 & _T_755; // @[true_unified_cache.scala 292:182:@2766.4]
  assign return_request_flatted_1 = unified_cache_bank_1_io_return_request_out; // @[true_unified_cache.scala 187:36:@2399.4 true_unified_cache.scala 250:40:@2531.4]
  assign _T_757 = return_request_flatted_1[73:72]; // @[true_unified_cache.scala 292:71:@2768.4]
  assign _T_759 = _T_757 == 2'h0; // @[true_unified_cache.scala 292:164:@2769.4]
  assign _T_760 = return_request_flatted_1[77]; // @[true_unified_cache.scala 293:71:@2770.4]
  assign _T_761 = _T_759 & _T_760; // @[true_unified_cache.scala 292:182:@2771.4]
  assign return_request_flatted_2 = unified_cache_bank_2_io_return_request_out; // @[true_unified_cache.scala 187:36:@2399.4 true_unified_cache.scala 250:40:@2597.4]
  assign _T_762 = return_request_flatted_2[73:72]; // @[true_unified_cache.scala 292:71:@2773.4]
  assign _T_764 = _T_762 == 2'h0; // @[true_unified_cache.scala 292:164:@2774.4]
  assign _T_765 = return_request_flatted_2[77]; // @[true_unified_cache.scala 293:71:@2775.4]
  assign _T_766 = _T_764 & _T_765; // @[true_unified_cache.scala 292:182:@2776.4]
  assign return_request_flatted_3 = unified_cache_bank_3_io_return_request_out; // @[true_unified_cache.scala 187:36:@2399.4 true_unified_cache.scala 250:40:@2663.4]
  assign _T_767 = return_request_flatted_3[73:72]; // @[true_unified_cache.scala 292:71:@2778.4]
  assign _T_769 = _T_767 == 2'h0; // @[true_unified_cache.scala 292:164:@2779.4]
  assign _T_770 = return_request_flatted_3[77]; // @[true_unified_cache.scala 293:71:@2780.4]
  assign _T_771 = _T_769 & _T_770; // @[true_unified_cache.scala 292:182:@2781.4]
  assign _T_772 = {return_request_flatted_1,return_request_flatted_0}; // @[true_unified_cache.scala 301:68:@2786.4]
  assign _T_773 = {return_request_flatted_3,return_request_flatted_2}; // @[true_unified_cache.scala 301:68:@2787.4]
  assign return_request_valid_flatted_1 = unified_cache_bank_1_io_return_request_valid_out; // @[true_unified_cache.scala 188:42:@2400.4 true_unified_cache.scala 251:46:@2532.4]
  assign return_request_valid_flatted_0 = unified_cache_bank_io_return_request_valid_out; // @[true_unified_cache.scala 188:42:@2400.4 true_unified_cache.scala 251:46:@2466.4]
  assign _T_775 = {return_request_valid_flatted_1,return_request_valid_flatted_0}; // @[true_unified_cache.scala 302:80:@2790.4]
  assign return_request_valid_flatted_3 = unified_cache_bank_3_io_return_request_valid_out; // @[true_unified_cache.scala 188:42:@2400.4 true_unified_cache.scala 251:46:@2664.4]
  assign return_request_valid_flatted_2 = unified_cache_bank_2_io_return_request_valid_out; // @[true_unified_cache.scala 188:42:@2400.4 true_unified_cache.scala 251:46:@2598.4]
  assign _T_776 = {return_request_valid_flatted_3,return_request_valid_flatted_2}; // @[true_unified_cache.scala 302:80:@2791.4]
  assign _T_777 = {_T_776,_T_775}; // @[true_unified_cache.scala 302:80:@2792.4]
  assign _T_778 = {_T_761,_T_756}; // @[true_unified_cache.scala 302:103:@2793.4]
  assign _T_779 = {_T_771,_T_766}; // @[true_unified_cache.scala 302:103:@2794.4]
  assign _T_780 = {_T_779,_T_778}; // @[true_unified_cache.scala 302:103:@2795.4]
  assign _T_798 = _T_752 == 2'h1; // @[true_unified_cache.scala 292:164:@2808.4]
  assign _T_800 = _T_798 & _T_755; // @[true_unified_cache.scala 292:182:@2810.4]
  assign _T_803 = _T_757 == 2'h1; // @[true_unified_cache.scala 292:164:@2813.4]
  assign _T_805 = _T_803 & _T_760; // @[true_unified_cache.scala 292:182:@2815.4]
  assign _T_808 = _T_762 == 2'h1; // @[true_unified_cache.scala 292:164:@2818.4]
  assign _T_810 = _T_808 & _T_765; // @[true_unified_cache.scala 292:182:@2820.4]
  assign _T_813 = _T_767 == 2'h1; // @[true_unified_cache.scala 292:164:@2823.4]
  assign _T_815 = _T_813 & _T_770; // @[true_unified_cache.scala 292:182:@2825.4]
  assign _T_822 = {_T_805,_T_800}; // @[true_unified_cache.scala 302:103:@2837.4]
  assign _T_823 = {_T_815,_T_810}; // @[true_unified_cache.scala 302:103:@2838.4]
  assign _T_824 = {_T_823,_T_822}; // @[true_unified_cache.scala 302:103:@2839.4]
  assign input_queue_vec_1_issue_ack_out = fifo_queue_1_io_issue_ack_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2360.4]
  assign input_queue_vec_0_issue_ack_out = fifo_queue_io_issue_ack_out; // @[true_unified_cache.scala 152:50:@2348.4 true_unified_cache.scala 152:50:@2352.4]
  assign return_packet_flatted_out_vec_1 = priority_arbiter_1_io_request_out; // @[true_unified_cache.scala 142:43:@2334.4 true_unified_cache.scala 305:47:@2847.4]
  assign return_packet_flatted_out_vec_0 = priority_arbiter_io_request_out; // @[true_unified_cache.scala 142:43:@2334.4 true_unified_cache.scala 305:47:@2803.4]
  assign io_input_packet_ack_flatted_out = {input_queue_vec_1_issue_ack_out,input_queue_vec_0_issue_ack_out}; // @[true_unified_cache.scala 310:35:@2851.4]
  assign io_return_packet_flatted_out = {return_packet_flatted_out_vec_1,return_packet_flatted_out_vec_0}; // @[true_unified_cache.scala 311:32:@2853.4]
  assign io_from_mem_packet_ack_out = _T_507 != 4'h0; // @[true_unified_cache.scala 257:30:@2671.4]
  assign io_to_mem_packet_out = to_mem_arbiter_io_request_out; // @[true_unified_cache.scala 276:24:@2730.4]
  assign fifo_queue_clock = clock; // @[:@2343.4]
  assign fifo_queue_reset = reset; // @[:@2344.4]
  assign fifo_queue_io_request_in = io_input_packet_flatted_in[79:0]; // @[true_unified_cache.scala 152:50:@2354.4]
  assign fifo_queue_io_request_valid_in = input_packet_packed_0[77]; // @[true_unified_cache.scala 152:50:@2353.4]
  assign fifo_queue_io_issue_ack_in = _T_594 != 4'h0; // @[true_unified_cache.scala 152:50:@2349.4]
  assign fifo_queue_1_clock = clock; // @[:@2346.4]
  assign fifo_queue_1_reset = reset; // @[:@2347.4]
  assign fifo_queue_1_io_request_in = io_input_packet_flatted_in[159:80]; // @[true_unified_cache.scala 152:50:@2362.4]
  assign fifo_queue_1_io_request_valid_in = input_packet_packed_1[77]; // @[true_unified_cache.scala 152:50:@2361.4]
  assign fifo_queue_1_io_issue_ack_in = _T_603 != 4'h0; // @[true_unified_cache.scala 152:50:@2357.4]
  assign unified_cache_bank_clock = clock; // @[:@2430.4]
  assign unified_cache_bank_reset = reset; // @[:@2431.4]
  assign unified_cache_bank_io_input_request_flatted_in = _T_331 ? _T_332 : 160'h0; // @[true_unified_cache.scala 222:46:@2436.6 true_unified_cache.scala 224:46:@2439.6]
  assign unified_cache_bank_io_input_request_valid_flatted_in = {_T_316,_T_312}; // @[true_unified_cache.scala 227:50:@2442.4]
  assign unified_cache_bank_io_fetched_request_in = _T_328 ? io_from_mem_packet_in : 80'h0; // @[true_unified_cache.scala 232:40:@2448.6 true_unified_cache.scala 234:40:@2451.6]
  assign unified_cache_bank_io_fetched_request_valid_in = _T_327 & _T_326; // @[true_unified_cache.scala 237:44:@2453.4]
  assign unified_cache_bank_io_miss_request_ack_in = miss_request_ack_flatted[0]; // @[true_unified_cache.scala 243:39:@2459.4]
  assign unified_cache_bank_io_return_request_ack_in = _T_724 != 2'h0; // @[true_unified_cache.scala 253:41:@2468.4]
  assign unified_cache_bank_1_clock = clock; // @[:@2496.4]
  assign unified_cache_bank_1_reset = reset; // @[:@2497.4]
  assign unified_cache_bank_1_io_input_request_flatted_in = _T_386 ? _T_332 : 160'h0; // @[true_unified_cache.scala 222:46:@2502.6 true_unified_cache.scala 224:46:@2505.6]
  assign unified_cache_bank_1_io_input_request_valid_flatted_in = {_T_371,_T_367}; // @[true_unified_cache.scala 227:50:@2508.4]
  assign unified_cache_bank_1_io_fetched_request_in = _T_383 ? io_from_mem_packet_in : 80'h0; // @[true_unified_cache.scala 232:40:@2514.6 true_unified_cache.scala 234:40:@2517.6]
  assign unified_cache_bank_1_io_fetched_request_valid_in = _T_327 & _T_381; // @[true_unified_cache.scala 237:44:@2519.4]
  assign unified_cache_bank_1_io_miss_request_ack_in = miss_request_ack_flatted[1]; // @[true_unified_cache.scala 243:39:@2525.4]
  assign unified_cache_bank_1_io_return_request_ack_in = _T_729 != 2'h0; // @[true_unified_cache.scala 253:41:@2534.4]
  assign unified_cache_bank_2_clock = clock; // @[:@2562.4]
  assign unified_cache_bank_2_reset = reset; // @[:@2563.4]
  assign unified_cache_bank_2_io_input_request_flatted_in = _T_441 ? _T_332 : 160'h0; // @[true_unified_cache.scala 222:46:@2568.6 true_unified_cache.scala 224:46:@2571.6]
  assign unified_cache_bank_2_io_input_request_valid_flatted_in = {_T_426,_T_422}; // @[true_unified_cache.scala 227:50:@2574.4]
  assign unified_cache_bank_2_io_fetched_request_in = _T_438 ? io_from_mem_packet_in : 80'h0; // @[true_unified_cache.scala 232:40:@2580.6 true_unified_cache.scala 234:40:@2583.6]
  assign unified_cache_bank_2_io_fetched_request_valid_in = _T_327 & _T_436; // @[true_unified_cache.scala 237:44:@2585.4]
  assign unified_cache_bank_2_io_miss_request_ack_in = miss_request_ack_flatted[2]; // @[true_unified_cache.scala 243:39:@2591.4]
  assign unified_cache_bank_2_io_return_request_ack_in = _T_734 != 2'h0; // @[true_unified_cache.scala 253:41:@2600.4]
  assign unified_cache_bank_3_clock = clock; // @[:@2628.4]
  assign unified_cache_bank_3_reset = reset; // @[:@2629.4]
  assign unified_cache_bank_3_io_input_request_flatted_in = _T_496 ? _T_332 : 160'h0; // @[true_unified_cache.scala 222:46:@2634.6 true_unified_cache.scala 224:46:@2637.6]
  assign unified_cache_bank_3_io_input_request_valid_flatted_in = {_T_481,_T_477}; // @[true_unified_cache.scala 227:50:@2640.4]
  assign unified_cache_bank_3_io_fetched_request_in = _T_493 ? io_from_mem_packet_in : 80'h0; // @[true_unified_cache.scala 232:40:@2646.6 true_unified_cache.scala 234:40:@2649.6]
  assign unified_cache_bank_3_io_fetched_request_valid_in = _T_327 & _T_491; // @[true_unified_cache.scala 237:44:@2651.4]
  assign unified_cache_bank_3_io_miss_request_ack_in = miss_request_ack_flatted[3]; // @[true_unified_cache.scala 243:39:@2657.4]
  assign unified_cache_bank_3_io_return_request_ack_in = _T_739 != 2'h0; // @[true_unified_cache.scala 253:41:@2666.4]
  assign to_mem_arbiter_clock = clock; // @[:@2700.4]
  assign to_mem_arbiter_reset = reset; // @[:@2701.4]
  assign to_mem_arbiter_io_request_flatted_in = {_T_608,320'h0}; // @[true_unified_cache.scala 271:40:@2709.4]
  assign to_mem_arbiter_io_request_valid_flatted_in = {_T_615,4'h0}; // @[true_unified_cache.scala 272:46:@2717.4]
  assign to_mem_arbiter_io_issue_ack_in = io_to_mem_packet_ack_in; // @[true_unified_cache.scala 277:34:@2731.4]
  assign priority_arbiter_clock = clock; // @[:@2784.4]
  assign priority_arbiter_reset = reset; // @[:@2785.4]
  assign priority_arbiter_io_request_flatted_in = {_T_773,_T_772}; // @[true_unified_cache.scala 301:42:@2789.4]
  assign priority_arbiter_io_request_valid_flatted_in = _T_777 & _T_780; // @[true_unified_cache.scala 302:48:@2797.4]
  assign priority_arbiter_io_issue_ack_in = io_return_packet_ack_flatted_in[0]; // @[true_unified_cache.scala 306:36:@2805.4]
  assign priority_arbiter_1_clock = clock; // @[:@2828.4]
  assign priority_arbiter_1_reset = reset; // @[:@2829.4]
  assign priority_arbiter_1_io_request_flatted_in = {_T_773,_T_772}; // @[true_unified_cache.scala 301:42:@2833.4]
  assign priority_arbiter_1_io_request_valid_flatted_in = _T_777 & _T_824; // @[true_unified_cache.scala 302:48:@2841.4]
  assign priority_arbiter_1_io_issue_ack_in = io_return_packet_ack_flatted_in[1]; // @[true_unified_cache.scala 306:36:@2849.4]
endmodule
