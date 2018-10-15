`include "parameters.h"

module unified_cache
#(
    parameter NUM_INPUT_PORT                     = 2,
    parameter NUM_SET                            = 64,
    parameter NUM_BANK                           = 4,
    parameter NUM_WAY                            = 4,
    parameter BLOCK_SIZE_IN_BYTES                = 4,
    
    parameter UNIFIED_CACHE_PACKET_WIDTH_IN_BITS = `UNIFIED_CACHE_PACKET_WIDTH_IN_BITS,
    parameter PORT_ID_WIDTH                      = $clog2(NUM_INPUT_PORT) + 1,
    parameter BANK_BITS                          = $clog2(NUM_BANK)
)
(
    input                                                                               reset_in,
    input                                                                               clk_in,

    // input packet
    input   [NUM_INPUT_PORT * (UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]             input_packet_flatted_in,
    output  [NUM_INPUT_PORT - 1 : 0]                                                    input_packet_ack_flatted_out,

    // return packet
    output  [NUM_INPUT_PORT * (UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]             return_packet_flatted_out,
    input   [NUM_INPUT_PORT - 1 : 0]                                                    return_packet_ack_flatted_in,

    // from mem
    input   [(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]                              from_mem_packet_in,
    output                                                                              from_mem_packet_ack_out,

    // to mem
    output  [(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]                              to_mem_packet_out,
    input                                                                               to_mem_packet_ack_in
);
  true_unified_cache
  true_unified_cache
  (
    .reset                       (reset_in),
    .clock                         (clk_in),

    .io_input_packet_flatted_in        (input_packet_flatted_in),
    .io_input_packet_ack_flatted_out   (input_packet_ack_flatted_out),
    
    .io_return_packet_flatted_out      (return_packet_flatted_out),
    .io_return_packet_ack_flatted_in   (return_packet_ack_flatted_in),

    .io_from_mem_packet_in             (from_mem_packet_in),
    .io_from_mem_packet_ack_out        (from_mem_packet_ack_out),

    .io_to_mem_packet_out              (to_mem_packet_out),
    .io_to_mem_packet_ack_in           (to_mem_packet_ack_in)
	);
	
endmodule