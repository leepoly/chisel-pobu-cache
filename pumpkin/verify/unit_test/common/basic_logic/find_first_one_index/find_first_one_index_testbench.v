`include "sim_config.h"
`include "parameters.h"

module find_first_one_index_testbench();

    parameter                                   VECTOR_LENGTH       = 8;

    parameter                                   TEST_INDEX_1        = 0;
    parameter                                   TEST_INDEX_2        = VECTOR_LENGTH / 2;
    parameter                                   TEST_INDEX_3        = VECTOR_LENGTH - 1;
    parameter                                   MAX_OUTPUT_WIDTH    = 32;

    reg                                         clk_in;
    reg                                         reset_in;
    reg  [31 : 0]                               clk_ctr;

    reg  [VECTOR_LENGTH    - 1 : 0]             vector_input;
    wire [MAX_OUTPUT_WIDTH - 1 : 0]             first_one_index;
    wire                                        one_is_found;

    integer                                     test_case_num;
    reg                                         test_judge;
    reg  [VECTOR_LENGTH    - 1 : 0]             test_input_1;

    find_first_one_index
    #(
        .VECTOR_LENGTH                          (VECTOR_LENGTH),
        .MAX_OUTPUT_WIDTH                       (MAX_OUTPUT_WIDTH)
    )

    find_first_one_index
    (
        .vector_in                              (vector_input),
        .first_one_index_out                    (first_one_index),
        .one_is_found_out                       (one_is_found)
    );

    initial
    begin
	    `ifdef DUMP
        	$dumpfile(`DUMP_FILENAME);
            $dumpvars(0, find_first_one_index_testbench);
	    `endif

        $display("\n[info-testbench] simulation for %m begins now");

        clk_in                                  = 1'b0;
        reset_in                                = 1'b0;
        vector_input                            = {(VECTOR_LENGTH){1'b0}};
        test_judge                              = 1'b0;

        #(`FULL_CYCLE_DELAY) reset_in           = 1'b1;
        #(`FULL_CYCLE_DELAY) reset_in           = 1'b0;

                             test_case_num      = 1'b0;
        #(`FULL_CYCLE_DELAY) test_input_1       = { {(VECTOR_LENGTH-(TEST_INDEX_1)-1){1'b0}}, {{1'b0}}, {(TEST_INDEX_1){1'b0}} };
                             vector_input       = test_input_1;
        #(`FULL_CYCLE_DELAY) test_judge         = (TEST_INDEX_1 == first_one_index) & ~one_is_found;
        $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "not found", test_judge ? "passed" : "failed");

                             test_case_num      = test_case_num + 1'b1;
        #(`FULL_CYCLE_DELAY) test_input_1       = { {(VECTOR_LENGTH-(TEST_INDEX_1)-1){1'b0}}, {{1'b1}}};
                             vector_input       = test_input_1;
        #(`FULL_CYCLE_DELAY) test_judge         = (TEST_INDEX_1 == first_one_index) & one_is_found;
        $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "first num", test_judge ? "passed" : "failed");

                             test_case_num      = test_case_num + 1'b1;
        #(`FULL_CYCLE_DELAY) test_input_1       = { {(VECTOR_LENGTH-(TEST_INDEX_2)-1){1'b0}}, {{1'b1}}, {(TEST_INDEX_2){1'b0}} };
                             vector_input       = test_input_1;
        #(`FULL_CYCLE_DELAY) test_judge         = (TEST_INDEX_2 == first_one_index);
        $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "middle num", test_judge ? "passed" : "failed");

                             test_case_num      = test_case_num + 1'b1;
        #(`FULL_CYCLE_DELAY) test_input_1       = { {(VECTOR_LENGTH-(TEST_INDEX_3)-1){1'b0}}, {{1'b1}}, {(TEST_INDEX_3){1'b0}} };
                             vector_input       = test_input_1;
        #(`FULL_CYCLE_DELAY) test_judge         = (TEST_INDEX_3 == first_one_index);
        $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "edge num", test_judge ? "passed" : "failed");

        #(`FULL_CYCLE_DELAY) $display("\n[info-rtl] simulation comes to the end\n");
        $finish;
    end

    always begin #(`HALF_CYCLE_DELAY) clk_in <= ~clk_in; end

endmodule
