module tri_port_regfile
#(
    parameter SINGLE_ENTRY_SIZE_IN_BITS = 8,
    parameter NUM_ENTRY                 = 4
)
(
    input                                                   reset_in,
    input                                                   clk_in,

    input                                                   read_en_in,
    input                                                   write_en_in,
    input                                                   cam_en_in,

    input      [NUM_ENTRY   - 1 : 0]                        read_entry_addr_decoded_in,
    input      [NUM_ENTRY   - 1 : 0]                        write_entry_addr_decoded_in,
    input      [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]          cam_entry_in,

    input      [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]          write_entry_in,
    output reg [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]          read_entry_out,
    output reg [NUM_ENTRY              - 1 : 0]             cam_result_decoded_out
);

wire [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]                    entry_packed [NUM_ENTRY - 1 : 0];

generate
genvar gen;

    for(gen = 0; gen < NUM_ENTRY; gen = gen + 1)
    begin

        reg [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0] entry;

        assign entry_packed[gen] = entry;

        always @(posedge clk_in, posedge reset_in)
        begin
            if(reset_in)
            begin
                entry <= {(SINGLE_ENTRY_SIZE_IN_BITS){1'b0}};
            end

            else
            begin

                // write entry
                if(write_en_in && write_entry_addr_decoded_in[gen])
                begin
                    entry <= write_entry_in;
                end

                // cam
                if(cam_en_in)
                begin
                    cam_result_decoded_out[gen] = entry == cam_entry_in ? 1'b1 : 1'b0;
                end

                else
                begin
                    cam_result_decoded_out[gen] = 1'b0;
                end
            end
        end
    end

endgenerate

wire [$clog2(NUM_ENTRY):0] read_index;

find_first_one_index
#(
    .VECTOR_LENGTH(NUM_ENTRY),
    .MAX_OUTPUT_WIDTH($clog2(NUM_ENTRY)+1)
)
find_read_index
(
    .vector_in(read_entry_addr_decoded_in),
    .first_one_index_out(read_index),
    .one_is_found_out()
);

always@(posedge clk_in, posedge reset_in)
begin
    if(reset_in)
    begin
        read_entry_out <= {(SINGLE_ENTRY_SIZE_IN_BITS){1'b0}};
    end

    else if(read_en_in)
    begin
        read_entry_out <= entry_packed[read_index];
    end

    else
    begin
        read_entry_out <= {(SINGLE_ENTRY_SIZE_IN_BITS){1'b0}};
    end
end

endmodule
