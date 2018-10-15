`include "sim_config.h"
`include "parameters.h"

module mux_decoded_testbench();

parameter SINGLE_WAY_WIDTH_IN_BITS = 4;
parameter NUM_WAY                  = 8;

integer                                              test_case_num;
reg                                                  test_judge;
reg  [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY - 1 : 0]    vector_input;
reg  [NUM_WAY                            - 1 : 0]    select;
wire [SINGLE_WAY_WIDTH_IN_BITS           - 1 : 0]    result;

initial
begin
    `ifdef DUMP
        $dumpfile(`DUMP_FILENAME);
        $dumpvars(0, mux_decoded_testbench);
    `endif

    $display("\n[info-testbench] simulation for %m begins now");

    test_judge         = 1'b0;
    test_case_num      = 1'b0;
    
    #(`FULL_CYCLE_DELAY) vector_input = {4'ha, 4'hb, 4'hc, 4'hd, 4'h1, 4'h2, 4'h3, 4'h4};
                         select       = 8'b0010_0000;
    #(`FULL_CYCLE_DELAY) test_judge   = result == 4'hc;
    $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "simple select", test_judge ? "passed" : "failed");

    #(`FULL_CYCLE_DELAY) $display("\n[info-rtl] simulation comes to the end\n");
    $finish;
end

mux_decoded
#(
    .SINGLE_WAY_WIDTH_IN_BITS(SINGLE_WAY_WIDTH_IN_BITS),
    .NUM_WAY(NUM_WAY)
)
mux_decoded
(
    .way_flatted_in     (vector_input),
    .sel_in             (select),
    .way_flatted_out    (result)
);

endmodule