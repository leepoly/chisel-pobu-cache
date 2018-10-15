`include "parameters.h"

module associative_single_port_array
#(
    parameter SINGLE_ENTRY_SIZE_IN_BITS     = 64,
    parameter NUM_SET                       = 64,
    parameter NUM_WAY                       = 16,
    parameter SET_PTR_WIDTH_IN_BITS         = $clog2(NUM_SET) + 1,
    parameter WRITE_MASK_LEN                = SINGLE_ENTRY_SIZE_IN_BITS / `BYTE_LEN_IN_BITS,
    parameter STORAGE_TYPE                  = "LUTRAM"
)
(
    input                                                       reset_in,
    input                                                       clk_in,

    input                                                       access_en_in,
    input  [WRITE_MASK_LEN                          - 1 : 0]    write_en_in,

    input  [SET_PTR_WIDTH_IN_BITS                   - 1 : 0]    access_set_addr_in,
    input  [NUM_WAY                                 - 1 : 0]    way_select_in,

    output [SINGLE_ENTRY_SIZE_IN_BITS * NUM_WAY     - 1 : 0]    read_set_out,
    output [SINGLE_ENTRY_SIZE_IN_BITS               - 1 : 0]    read_single_entry_out,
    input  [SINGLE_ENTRY_SIZE_IN_BITS               - 1 : 0]    write_single_entry_in
);

wire   [SINGLE_ENTRY_SIZE_IN_BITS * NUM_WAY - 1 : 0] data_to_mux;
assign read_set_out = data_to_mux;

generate
    genvar gen;

    if(STORAGE_TYPE == "LUTRAM")
    begin
        for(gen = 0; gen < NUM_WAY; gen = gen + 1)
        begin
            single_port_lutram
            #(
                .SINGLE_ENTRY_SIZE_IN_BITS  (SINGLE_ENTRY_SIZE_IN_BITS),
                .NUM_SET                    (NUM_SET),
                .SET_PTR_WIDTH_IN_BITS      (SET_PTR_WIDTH_IN_BITS)
            )
            entry_way
            (
                .reset_in                   (reset_in),
                .clk_in                     (clk_in),

                .access_en_in               (access_en_in & way_select_in[gen]),
                .write_en_in                (write_en_in  & {(WRITE_MASK_LEN){way_select_in[gen]}}),

                .access_set_addr_in         (access_set_addr_in),

                .write_entry_in             (write_single_entry_in),
                .read_entry_out             (data_to_mux[gen * SINGLE_ENTRY_SIZE_IN_BITS +: SINGLE_ENTRY_SIZE_IN_BITS])
            );
        end
    end
    else if(STORAGE_TYPE == "BRAM")
    begin
        for(gen = 0; gen < NUM_WAY; gen = gen + 1)
        begin
            single_port_blockram
            #(
                .SINGLE_ENTRY_SIZE_IN_BITS  (SINGLE_ENTRY_SIZE_IN_BITS),
                .NUM_SET                    (NUM_SET),
                .SET_PTR_WIDTH_IN_BITS      (SET_PTR_WIDTH_IN_BITS)
            )
            entry_way
            (
                .clk_in                     (clk_in),

                .access_en_in               (access_en_in & way_select_in[gen]),
                .write_en_in                (write_en_in  & {(WRITE_MASK_LEN){way_select_in[gen]}}),

                .access_set_addr_in         (access_set_addr_in),

                .write_entry_in             (write_single_entry_in),
                .read_entry_out             (data_to_mux[gen * SINGLE_ENTRY_SIZE_IN_BITS +: SINGLE_ENTRY_SIZE_IN_BITS])
            );
        end
    end
endgenerate

reg [NUM_WAY - 1 : 0] way_select_stage;
always @(posedge clk_in or posedge reset_in)
begin
    if(reset_in)
    begin
        way_select_stage <= {(NUM_WAY){1'b0}};
    end

    else
    begin
        way_select_stage <= way_select_in;
    end
end

mux_decoded_8
#(
    .NUM_WAY(NUM_WAY),
    .SINGLE_ENTRY_SIZE_IN_BITS(SINGLE_ENTRY_SIZE_IN_BITS)
)
mux_8
(
    .way_flatted_in     (data_to_mux),
    .sel_in             (way_select_stage),
    .way_flatted_out    (read_single_entry_out)
);

endmodule
