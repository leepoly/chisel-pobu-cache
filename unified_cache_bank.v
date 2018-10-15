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