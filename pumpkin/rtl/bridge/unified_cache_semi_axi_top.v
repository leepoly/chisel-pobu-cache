`include "parameters.h"

module unified_cache_semi_axi_top
#(
    // cache parameters
    parameter NUM_INPUT_PORT                        = 2,
    parameter NUM_BANK                              = 4,
    parameter NUM_SET                               = 4,
    parameter NUM_WAY                               = 4,
    parameter BLOCK_SIZE_IN_BYTES                   = `UNIFIED_CACHE_BLOCK_SIZE_IN_BYTES,
    parameter BLOCK_SIZE_IN_BITS                    = `UNIFIED_CACHE_BLOCK_SIZE_IN_BITS,
    parameter UNIFIED_CACHE_PACKET_WIDTH_IN_BITS    = `UNIFIED_CACHE_PACKET_WIDTH_IN_BITS,
    parameter PORT_ID_WIDTH                         = $clog2(NUM_INPUT_PORT) + 1,
    parameter BANK_BITS                             = $clog2(NUM_BANK),

    // AXI parameters
    parameter C_M_TARGET_SLAVE_BASE_ADDR	        = 32'h1000_0000,
    parameter C_M_AXI_ADDR_WIDTH	                = 32,
    parameter C_M_AXI_DATA_WIDTH	                = 64,
    parameter C_M_AXI_BURST_LEN	                    = `UNIFIED_CACHE_BLOCK_SIZE_IN_BITS / C_M_AXI_DATA_WIDTH,
    parameter C_M_AXI_ID_WIDTH	                    = 4,
    parameter C_M_AXI_AWUSER_WIDTH	                = 1,
    parameter C_M_AXI_ARUSER_WIDTH	                = 1,
    parameter C_M_AXI_WUSER_WIDTH	                = C_M_AXI_DATA_WIDTH,
    parameter C_M_AXI_RUSER_WIDTH	                = C_M_AXI_DATA_WIDTH,
    parameter C_M_AXI_BUSER_WIDTH	                = 1
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

    //AXI signals
    input                                           M_AXI_ACLK,
    input                                           M_AXI_ARESETN,
    output      [C_M_AXI_ID_WIDTH       - 1 : 0]    M_AXI_AWID,
    output      [C_M_AXI_ADDR_WIDTH     - 1 : 0]    M_AXI_AWADDR,
    output      [7                          : 0]    M_AXI_AWLEN,
    output      [2                          : 0]    M_AXI_AWSIZE,
    output      [1                          : 0]    M_AXI_AWBURST,
    output                                          M_AXI_AWLOCK,
    output      [3                          : 0]    M_AXI_AWCACHE,
    output      [2                          : 0]    M_AXI_AWPROT,
    output      [3                          : 0]    M_AXI_AWQOS,
    output      [C_M_AXI_AWUSER_WIDTH   - 1 : 0]    M_AXI_AWUSER,
    output                                          M_AXI_AWVALID,
    input                                           M_AXI_AWREADY,
    output      [C_M_AXI_DATA_WIDTH     - 1 : 0]    M_AXI_WDATA,
    output      [C_M_AXI_DATA_WIDTH / 8 - 1 : 0]    M_AXI_WSTRB,
    output                                          M_AXI_WLAST,
    output      [C_M_AXI_WUSER_WIDTH    - 1 : 0]    M_AXI_WUSER,
    output                                          M_AXI_WVALID,
    input                                           M_AXI_WREADY,
    input       [C_M_AXI_ID_WIDTH       - 1 : 0]    M_AXI_BID,
    input       [1                          : 0]    M_AXI_BRESP,
    input       [C_M_AXI_BUSER_WIDTH    - 1 : 0]    M_AXI_BUSER,
    input                                           M_AXI_BVALID,
    output                                          M_AXI_BREADY,
    output      [C_M_AXI_ID_WIDTH       - 1 : 0]    M_AXI_ARID,
    output      [C_M_AXI_ADDR_WIDTH     - 1 : 0]    M_AXI_ARADDR,
    output      [7                          : 0]    M_AXI_ARLEN,
    output      [2                          : 0]    M_AXI_ARSIZE,
    output      [1                          : 0]    M_AXI_ARBURST,
    output                                          M_AXI_ARLOCK,
    output      [3                          : 0]    M_AXI_ARCACHE,
    output      [2                          : 0]    M_AXI_ARPROT,
    output      [3                          : 0]    M_AXI_ARQOS,
    output      [C_M_AXI_ARUSER_WIDTH   - 1 : 0]    M_AXI_ARUSER,
    output                                          M_AXI_ARVALID,
    input                                           M_AXI_ARREADY,
    input       [C_M_AXI_ID_WIDTH       - 1 : 0]    M_AXI_RID,
    input       [C_M_AXI_DATA_WIDTH     - 1 : 0]    M_AXI_RDATA,
    input       [1                          : 0]    M_AXI_RRESP,
    input                                           M_AXI_RLAST,
    input       [C_M_AXI_RUSER_WIDTH    - 1 : 0]    M_AXI_RUSER,
    input                                           M_AXI_RVALID,
    output                                          M_AXI_RREADY
);

reg                                                 init_pulse;
wire [UNIFIED_CACHE_PACKET_WIDTH_IN_BITS  - 1 : 0]  cache_to_mem_packet;
reg  [UNIFIED_CACHE_PACKET_WIDTH_IN_BITS  - 1 : 0]  mem_to_cache_packet;
wire [BLOCK_SIZE_IN_BITS                  - 1 : 0]  mem_return_data;

wire                                                mem_done;
wire                                                from_cache_ack;
reg                                                 to_cache_ack;

wire [UNIFIED_CACHE_PACKET_WIDTH_IN_BITS - 1 : 0]   mem_to_cache_packet_concatenated;
packet_concat mem_to_cache_packet_concat
(
    .addr_in        (cache_to_mem_packet[`UNIFIED_CACHE_PACKET_ADDR_POS_HI : `UNIFIED_CACHE_PACKET_ADDR_POS_LO]),
    .data_in        (mem_return_data),
    .type_in        (cache_to_mem_packet[`UNIFIED_CACHE_PACKET_TYPE_POS_HI : `UNIFIED_CACHE_PACKET_TYPE_POS_LO]),
    .write_mask_in  (cache_to_mem_packet[`UNIFIED_CACHE_PACKET_BYTE_MASK_POS_HI : `UNIFIED_CACHE_PACKET_BYTE_MASK_POS_LO]),
    .port_num_in    (cache_to_mem_packet[`UNIFIED_CACHE_PACKET_PORT_NUM_HI : `UNIFIED_CACHE_PACKET_PORT_NUM_LO]),
    .valid_in       (cache_to_mem_packet[`UNIFIED_CACHE_PACKET_VALID_POS]),
    .is_write_in    (cache_to_mem_packet[`UNIFIED_CACHE_PACKET_IS_WRITE_POS]),
    .cacheable_in   (cache_to_mem_packet[`UNIFIED_CACHE_PACKET_CACHEABLE_POS]),
    .packet_out     (mem_to_cache_packet_concatenated)
);

// generate master pulse

reg [UNIFIED_CACHE_PACKET_WIDTH_IN_BITS  - 1 : 0]   cache_to_mem_packet_last_cycle;

always@(posedge clk_in or posedge reset_in)
begin
    if(reset_in)
    begin
        init_pulse                              <= 1'b0;
        cache_to_mem_packet_last_cycle          <= 0;
    end

    else
    begin
        cache_to_mem_packet_last_cycle <= cache_to_mem_packet;
        
        if(cache_to_mem_packet[`UNIFIED_CACHE_PACKET_VALID_POS] & cache_to_mem_packet != cache_to_mem_packet_last_cycle)
        begin
            if(~init_pulse)
            begin
                init_pulse      <= 1'b1;
            end
        end

        else if(cache_to_mem_packet[`UNIFIED_CACHE_PACKET_VALID_POS])
        begin
            init_pulse      <= 1'b0;
        end
    end
end

// release to cache ack
always@(posedge clk_in or posedge reset_in)
begin
    if(reset_in)
    begin
        to_cache_ack <= 1'b0;
    end

    else
    begin
        // write
        if(cache_to_mem_packet[`UNIFIED_CACHE_PACKET_VALID_POS]    &
           cache_to_mem_packet[`UNIFIED_CACHE_PACKET_IS_WRITE_POS] &
           mem_done)
        begin
            to_cache_ack <= 1'b1;
        end

        // read
        else if(cache_to_mem_packet[`UNIFIED_CACHE_PACKET_VALID_POS]     &
                ~cache_to_mem_packet[`UNIFIED_CACHE_PACKET_IS_WRITE_POS] &
                from_cache_ack)
            to_cache_ack <= 1'b1;
        
        else to_cache_ack <= 1'b0;
    end
end

// generate to cache packet
always@(posedge clk_in or posedge reset_in)
begin
    if(reset_in)
    begin
        mem_to_cache_packet <= 0;
    end

    else
    begin
        if(cache_to_mem_packet[`UNIFIED_CACHE_PACKET_VALID_POS]    &
          ~cache_to_mem_packet[`UNIFIED_CACHE_PACKET_IS_WRITE_POS] &
          mem_done)
        begin
            mem_to_cache_packet <= mem_to_cache_packet_concatenated;
        end

        else if(from_cache_ack & mem_to_cache_packet[`UNIFIED_CACHE_PACKET_VALID_POS])
        begin
            mem_to_cache_packet <= 0;
        end

        else
            mem_to_cache_packet <= mem_to_cache_packet;
    end
end

unified_cache
//#(
//    .UNIFIED_CACHE_PACKET_WIDTH_IN_BITS (UNIFIED_CACHE_PACKET_WIDTH_IN_BITS),
//    .NUM_INPUT_PORT                     (NUM_INPUT_PORT),
//    .NUM_BANK                           (NUM_BANK),
//    .NUM_SET                            (NUM_SET),
//    .NUM_WAY                            (NUM_WAY),
//    .BLOCK_SIZE_IN_BYTES                (BLOCK_SIZE_IN_BYTES)
//)
unified_cache
(
    .reset                       (reset_in),
    .clock                         (clk_in),
    .io_input_packet_flatted_in        (input_packet_flatted_in),
    .io_input_packet_ack_flatted_out   (input_packet_ack_flatted_out),

    .io_return_packet_flatted_out      (return_packet_flatted_out),
    .io_return_packet_ack_flatted_in   (return_packet_ack_flatted_in),

    .io_from_mem_packet_in             (mem_to_cache_packet),
    .io_from_mem_packet_ack_out        (from_cache_ack),

    .io_to_mem_packet_out              (cache_to_mem_packet),
    .io_to_mem_packet_ack_in           (to_cache_ack)
);

axi4_master
#(
    .C_M_TARGET_SLAVE_BASE_ADDR     (C_M_TARGET_SLAVE_BASE_ADDR),
    .C_M_AXI_ADDR_WIDTH             (C_M_AXI_ADDR_WIDTH),
    .C_M_AXI_DATA_WIDTH	            (C_M_AXI_DATA_WIDTH),
    .C_M_AXI_BURST_LEN	            (C_M_AXI_BURST_LEN),
    .C_M_AXI_ID_WIDTH	            (C_M_AXI_ID_WIDTH),
    .C_M_AXI_AWUSER_WIDTH	        (C_M_AXI_AWUSER_WIDTH),
    .C_M_AXI_ARUSER_WIDTH	        (C_M_AXI_ARUSER_WIDTH),
    .C_M_AXI_WUSER_WIDTH	        (C_M_AXI_WUSER_WIDTH),
    .C_M_AXI_RUSER_WIDTH	        (C_M_AXI_RUSER_WIDTH),
    .C_M_AXI_BUSER_WIDTH	        (C_M_AXI_BUSER_WIDTH)
)
axi4_master
(
    .INIT_AXI_TXN                    (init_pulse),
    .TRANSACTION_PACKET              (cache_to_mem_packet),
    .RETURN_DATA                     (mem_return_data),
    .TXN_DONE                        (mem_done),

    .M_AXI_ACLK                      (M_AXI_ACLK),
    .M_AXI_ARESETN                   (M_AXI_ARESETN),
    .M_AXI_AWID                      (M_AXI_AWID),
    .M_AXI_AWADDR                    (M_AXI_AWADDR),
    .M_AXI_AWLEN                     (M_AXI_AWLEN),
    .M_AXI_AWSIZE                    (M_AXI_AWSIZE),
    .M_AXI_AWBURST                   (M_AXI_AWBURST),
    .M_AXI_AWLOCK                    (M_AXI_AWLOCK),
    .M_AXI_AWCACHE                   (M_AXI_AWCACHE),
    .M_AXI_AWPROT                    (M_AXI_AWPROT),
    .M_AXI_AWQOS                     (M_AXI_AWQOS),
    .M_AXI_AWUSER                    (M_AXI_AWUSER),
    .M_AXI_AWVALID                   (M_AXI_AWVALID),
    .M_AXI_AWREADY                   (M_AXI_AWREADY),
    .M_AXI_WDATA                     (M_AXI_WDATA),
    .M_AXI_WSTRB                     (M_AXI_WSTRB),
    .M_AXI_WLAST                     (M_AXI_WLAST),
    .M_AXI_WUSER                     (M_AXI_WUSER),
    .M_AXI_WVALID                    (M_AXI_WVALID),
    .M_AXI_WREADY                    (M_AXI_WREADY),
    .M_AXI_BID                       (M_AXI_BID),
    .M_AXI_BRESP                     (M_AXI_BRESP),
    .M_AXI_BUSER                     (M_AXI_BUSER),
    .M_AXI_BVALID                    (M_AXI_BVALID),
    .M_AXI_BREADY                    (M_AXI_BREADY),
    .M_AXI_ARID                      (M_AXI_ARID),
    .M_AXI_ARADDR                    (M_AXI_ARADDR),
    .M_AXI_ARLEN                     (M_AXI_ARLEN),
    .M_AXI_ARSIZE                    (M_AXI_ARSIZE),
    .M_AXI_ARBURST                   (M_AXI_ARBURST),
    .M_AXI_ARLOCK                    (M_AXI_ARLOCK),
    .M_AXI_ARCACHE                   (M_AXI_ARCACHE),
    .M_AXI_ARPROT                    (M_AXI_ARPROT),
    .M_AXI_ARQOS                     (M_AXI_ARQOS),
    .M_AXI_ARUSER                    (M_AXI_ARUSER),
    .M_AXI_ARVALID                   (M_AXI_ARVALID),
    .M_AXI_ARREADY                   (M_AXI_ARREADY),
    .M_AXI_RID                       (M_AXI_RID),
    .M_AXI_RDATA                     (M_AXI_RDATA),
    .M_AXI_RRESP                     (M_AXI_RRESP),
    .M_AXI_RLAST                     (M_AXI_RLAST),
    .M_AXI_RUSER                     (M_AXI_RUSER),
    .M_AXI_RVALID                    (M_AXI_RVALID),
    .M_AXI_RREADY                    (M_AXI_RREADY)
);

endmodule