module mux_decoded
#(
    parameter SINGLE_WAY_WIDTH_IN_BITS = 32,
    parameter NUMBER_WAY = 8
)
(
    input      [SINGLE_WAY_WIDTH_IN_BITS * NUMBER_WAY - 1 : 0]  way_flatted_in,
    input      [NUMBER_WAY                            - 1 : 0]  sel_in,
    output     [SINGLE_WAY_WIDTH_IN_BITS              - 1 : 0]  way_flatted_out
);

parameter NUMBER_WAY_LOG2 = $clog2(NUMBER_WAY) + 1;
wire [NUMBER_WAY_LOG2 - 1 : 0] sel_index;

find_first_one_index
#(
    .VECTOR_LENGTH(NUMBER_WAY),
    .MAX_OUTPUT_WIDTH(NUMBER_WAY_LOG2)
)
find_first_one_index
(
    .vector_in(sel_in),
    .first_one_index_out(sel_index),
    .one_is_found_out()
);

assign way_flatted_out = way_flatted_in[sel_index * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];

endmodule
