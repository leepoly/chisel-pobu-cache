`include "sim_config.h"
`include "parameters.h"

module select_biggest_testbench();

parameter SINGLE_WAY_WIDTH_IN_BITS = 4;
parameter NUM_WAY                  = 16;

integer                                           test_case_num;
reg                                               test_judge;
reg  [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY - 1 : 0] vector_input;
reg  [NUM_WAY                           -  1 : 0] condition;
wire [SINGLE_WAY_WIDTH_IN_BITS           - 1 : 0] result;

initial
begin
    `ifdef DUMP
        $dumpfile(`DUMP_FILENAME);
        $dumpvars(0, select_biggest_testbench);
    `endif

    $display("\n[info-testbench] simulation for %m begins now");

    test_judge         = 1'b0;
    test_case_num      = 1'b0;
    
    #(`FULL_CYCLE_DELAY) vector_input = {4'ha, 4'hb, 4'hc, 4'hd, 4'h5, 4'h2, 4'h3, 4'h4,
                                         4'h5, 4'h2, 4'h3, 4'h4, 4'ha, 4'hb, 4'ha, 4'h5};
                         condition    = 16'b1110_0111_1110_0111;
    #(`FULL_CYCLE_DELAY) test_judge   = result == 4'hc;
    $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "simple select & condition", test_judge ? "passed" : "failed");

    test_judge         = 1'b0;
    test_case_num      = test_case_num + 1'b1;
    
    #(`FULL_CYCLE_DELAY) vector_input = {4'h5, 4'h8, 4'h7, 4'hc, 4'h2, 4'h9, 4'h3, 4'h4,
                                         4'h2, 4'h9, 4'h3, 4'h4, 4'h5, 4'h8, 4'h7, 4'ha};
                         condition    = 16'b1011_0111_1111_1111;
    #(`FULL_CYCLE_DELAY) test_judge   = result == 4'hc;
    $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "simple select & condition", test_judge ? "passed" : "failed");

    #(`FULL_CYCLE_DELAY) $display("\n[info-rtl] simulation comes to the end\n");
    $finish;
end

select_biggest
#(
    .SINGLE_WAY_WIDTH_IN_BITS(SINGLE_WAY_WIDTH_IN_BITS),
    .NUM_WAY(NUM_WAY)
)
select_biggest
(
    .way_flatted_in     (vector_input),
    .condition_in       (condition),
    .select_out         (result)
);

endmodule
