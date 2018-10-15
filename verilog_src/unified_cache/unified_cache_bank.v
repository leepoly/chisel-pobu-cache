`include "parameters.h"

module unified_cache_bank
#(
    parameter NUM_INPUT_PORT                     = 2,
    parameter NUM_SET                            = 4,
    parameter NUM_WAY                            = 4,
    parameter BLOCK_SIZE_IN_BYTES                = 4,

    parameter BANK_NUM                           = 0,
    parameter MODE                               = `UNIFIED_CACHE_BANK_ARCHITECTURE,

    parameter UNIFIED_CACHE_PACKET_WIDTH_IN_BITS = `UNIFIED_CACHE_PACKET_WIDTH_IN_BITS,
    parameter BLOCK_SIZE_IN_BITS                 = BLOCK_SIZE_IN_BYTES * `BYTE_LEN_IN_BITS,
    parameter SET_PTR_WIDTH_IN_BITS              = $clog2(NUM_SET)
)
(
    input                                                                   clk_in,
    input                                                                   reset_in,
    input  [NUM_INPUT_PORT * (UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]  input_request_flatted_in,
    input  [NUM_INPUT_PORT                                        - 1 : 0]  input_request_valid_flatted_in,
    input  [NUM_INPUT_PORT                                        - 1 : 0]  input_request_critical_flatted_in,
    output [NUM_INPUT_PORT                                        - 1 : 0]  input_request_ack_out,

    input  [UNIFIED_CACHE_PACKET_WIDTH_IN_BITS                    - 1 : 0]  fetched_request_in,
    input                                                                   fetched_request_valid_in,
    output                                                                  fetch_ack_out,

    output [UNIFIED_CACHE_PACKET_WIDTH_IN_BITS                    - 1 : 0]  miss_request_out,
    output                                                                  miss_request_valid_out,
    output                                                                  miss_request_critical_out,
    input                                                                   miss_request_ack_in,

    output [UNIFIED_CACHE_PACKET_WIDTH_IN_BITS                    - 1 : 0]  writeback_request_out,
    output                                                                  writeback_request_valid_out,
    output                                                                  writeback_request_critical_out,
    input                                                                   writeback_request_ack_in,

    output [UNIFIED_CACHE_PACKET_WIDTH_IN_BITS                    - 1 : 0]  return_request_out,
    output                                                                  return_request_valid_out,
    output                                                                  return_request_critical_out,
    input                                                                   return_request_ack_in
);

generate

if(MODE == "OFF")
begin
    priority_arbiter
    #(
        .SINGLE_REQUEST_WIDTH_IN_BITS(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS),
        .NUM_REQUEST(NUM_INPUT_PORT),
        .INPUT_QUEUE_SIZE(2)
    )
    intra_bank_arbiter
    (
        .reset_in                       (reset_in),
        .clk_in                         (clk_in),

        // the arbiter considers priority from right(high) to left(low)
        .request_flatted_in             (input_request_flatted_in),
        .request_valid_flatted_in       (input_request_valid_flatted_in),
        .request_critical_flatted_in    (input_request_critical_flatted_in),
        .issue_ack_out                  (input_request_ack_out),

        .request_out                    (miss_request_out),
        .request_valid_out              (miss_request_valid_out),
        .issue_ack_in                   (miss_request_ack_in)
    );

    assign miss_request_critical_out        = 1'b0;

    assign return_request_out               = fetched_request_in;
    assign return_request_valid_out         = fetched_request_valid_in;
    assign fetch_ack_out                    = return_request_ack_in;
    assign return_request_critical_out      = 1'b1;

    assign writeback_request_out            = 0;
    assign writeback_request_valid_out      = 0;
    assign writeback_request_critical_out   = 0;
end

endgenerate

endmodule