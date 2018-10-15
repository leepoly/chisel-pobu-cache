module dual_port_blockram
#(
    parameter SINGLE_ENTRY_SIZE_IN_BITS   = 64,
    parameter NUM_SET                     = 64,
    parameter SET_PTR_WIDTH_IN_BITS       = 6
)
(
    input                                               clk_in,

    input                                               read_en_in,
    input      [SET_PTR_WIDTH_IN_BITS     - 1 : 0]      read_set_addr_in,
    output reg [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]      read_entry_out,

    input                                               write_en_in,
    input      [SET_PTR_WIDTH_IN_BITS     - 1 : 0]      write_set_addr_in,
    input      [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]      write_entry_in,
    output reg [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]      evict_entry_out
);

(* ram_style = "block" *) reg [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0] blockram [NUM_SET - 1 : 0];

always @(posedge clk_in)
begin
    if(read_en_in)
    begin

        read_entry_out <= blockram[read_set_addr_in];

        if(write_en_in)
        begin
            evict_entry_out             <= blockram[write_set_addr_in];
            blockram[write_set_addr_in] <= write_entry_in;
        end
    end
end
endmodule
