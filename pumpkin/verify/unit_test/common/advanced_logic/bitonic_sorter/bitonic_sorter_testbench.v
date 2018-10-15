`include "sim_config.h"
`include "parameters.h"

module bitonic_sorter_testbench();

parameter SINGLE_WAY_WIDTH_IN_BITS = 4;
parameter NUM_WAY                  = 16; // must be a power of 2

reg                                                clk_in;
reg                                                reset_in;

reg  [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY - 1 : 0]  pre_sort_flatted;
wire [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY - 1 : 0]  post_sort_flatted;

integer test_case;
reg test_judge;
reg [NUM_WAY - 1 : 0] sorted;
integer loop_index;
always@*
begin
    for(loop_index = 0; loop_index < NUM_WAY; loop_index = loop_index + 1)
    begin
        if(loop_index == 0)
            sorted[loop_index] <= 1;
        else
            sorted[loop_index] <= post_sort_flatted[loop_index] - post_sort_flatted[loop_index - 1] >= 0;
    end
end

always@(posedge clk_in, posedge reset_in)
begin
    if(reset_in)
    begin
        test_judge <= 0;
    end

    else
    begin
        test_judge <= &sorted;
    end
end

initial
begin

    `ifdef DUMP
        $dumpfile(`DUMP_FILENAME);
        $dumpvars(0, bitonic_sorter_testbench);
    `endif

    $display("\n[info-testbench] simulation for %m begins now");
    test_case                   = 0;
    clk_in                      = 1'b0;
    reset_in                    = 1'b0;

    #(`FULL_CYCLE_DELAY)        reset_in = 1'b1;    
    #(`FULL_CYCLE_DELAY)        reset_in = 1'b0;
    
    #(`FULL_CYCLE_DELAY)        pre_sort_flatted = {4'h0, 4'h1, 4'h2, 4'h3,
                                                    4'h4, 4'h5, 4'h6, 4'h7,
                                                    4'h8, 4'h9, 4'ha, 4'hb,
                                                    4'hc, 4'hd, 4'he, 4'hf};
    #(`FULL_CYCLE_DELAY * 500)  $display("[info-rtl] test case %d %35s : \t%s",
                                test_case, "full reverse order",
                                test_judge? "passed": "failed");

    #(`FULL_CYCLE_DELAY)        test_case = test_case + 1'b1;
    #(`FULL_CYCLE_DELAY)        pre_sort_flatted = {4'h0, 4'h0, 4'h2, 4'h2,
                                                    4'h4, 4'h4, 4'h6, 4'h6,
                                                    4'h8, 4'h8, 4'hb, 4'hb,
                                                    4'hd, 4'hd, 4'hf, 4'hf};
    #(`FULL_CYCLE_DELAY * 500)  $display("[info-rtl] test case %d %35s : \t%s",
                                test_case, "full reverse order with duplicates",
                                test_judge? "passed": "failed");

    #(`FULL_CYCLE_DELAY)        test_case = test_case + 1'b1;
    #(`FULL_CYCLE_DELAY)        pre_sort_flatted = {4'h8, 4'h7, 4'hb, 4'h4,
                                                    4'ha, 4'hc, 4'hf, 4'ha,
                                                    4'h0, 4'h3, 4'hf, 4'h5,
                                                    4'h4, 4'h8, 4'h9, 4'h2};
    #(`FULL_CYCLE_DELAY * 500)  $display("[info-rtl] test case %d %35s : \t%s",
                                test_case, "out of order with duplicates",
                                test_judge? "passed": "failed");

    #(`FULL_CYCLE_DELAY * 1500) $display("\n[info-rtl] simulation comes to the end\n");
    $finish;
end

always begin #(`HALF_CYCLE_DELAY) clk_in <= ~clk_in; end

bitonic_sorter
#(
    .SINGLE_WAY_WIDTH_IN_BITS(SINGLE_WAY_WIDTH_IN_BITS),
    .NUM_WAY(NUM_WAY)
)
bitonic_sorter
(
    .clk_in(clk_in),
    .reset_in(reset_in),
    .pre_sort_flatted_in(pre_sort_flatted),
    .post_sort_flatted_out(post_sort_flatted)
);

endmodule
