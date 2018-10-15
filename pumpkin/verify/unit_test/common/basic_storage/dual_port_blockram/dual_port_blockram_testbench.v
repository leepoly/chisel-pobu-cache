`include "parameters.h"
`include "sim_config.h"

module dual_port_blockram_testbench();

parameter SINGLE_ENTRY_SIZE_IN_BITS     = 64;
parameter NUM_SET                       = 64;
parameter SET_PTR_WIDTH_IN_BITS         = 6;

reg                                         reset_in;
reg                                         clk_in;

reg                                         read_en_in;
reg  [SET_PTR_WIDTH_IN_BITS     - 1 : 0]    read_set_addr_in;
wire [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]    read_entry_out;

reg                                         write_en_in;
reg  [SET_PTR_WIDTH_IN_BITS     - 1 : 0]    write_set_addr_in;
reg  [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]    write_entry_in;
wire [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]    evict_entry_out;

reg  [2:0]                                  test_case_num;
reg  [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]    test_input_1;
reg  [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]    test_input_2;
reg  [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]    test_result_1;
reg  [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]    test_result_2;
reg                                         test_judge;

initial
begin

    `ifdef DUMP
        $dumpfile(`DUMP_FILENAME);
        $dumpvars(0, dual_port_blockram_testbench);
    `endif

    $display("\n[info-testbench] simulation for %m begins now");

    /**
     *  reset
     **/

    clk_in                  = 0;

    test_case_num           = 0;
    test_input_1            = 0;

    write_en_in             = 0;
    write_set_addr_in       = 0;
    write_entry_in          = 0;

    read_en_in              = 0;
    read_set_addr_in        = 0;

    test_result_1           = 0;
    test_result_2           = 0;
    test_judge              = 0;

    $display("[info-testbench] %m testbench reset completed\n");

    /**
     *  write "test_input_1" to "write_set_addr_in" then read from "write_set_addr_in"
     *  pass : the data is read should equal the data is written
     **/

    #(`FULL_CYCLE_DELAY)
    test_input_1                            = { {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b1}}, {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b0}} };

    read_en_in                              = 1;
    write_en_in                             = 1;

    #(`FULL_CYCLE_DELAY) write_set_addr_in  = NUM_SET - test_case_num;
    read_set_addr_in                        = NUM_SET - test_case_num;

    write_entry_in                          = test_input_1;
    #(`FULL_CYCLE_DELAY) write_en_in        = 0;
    #(`FULL_CYCLE_DELAY) test_result_1      = read_entry_out;

    write_en_in                             = 0;
    read_en_in                              = 0;

    test_judge                              = (test_result_1 === test_input_1) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});

    $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "basic asynchronous write-read access",test_judge ? "passed" : "failed");

    /**
     *  write "test_input_1" to "write_set_addr_in" and read from "write_set_addr_in" simultaneously
     *  pass : the data is read should equal the data is written
     **/

    #(`FULL_CYCLE_DELAY * 3) test_case_num  = test_case_num + 1;
    #(`FULL_CYCLE_DELAY)     test_input_1   = { {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b1}}, {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b1}} };

    #(`FULL_CYCLE_DELAY) read_en_in         = 1;
    write_set_addr_in                       = NUM_SET - test_case_num;
    read_set_addr_in                        = NUM_SET - test_case_num;

    #(`HALF_CYCLE_DELAY) write_entry_in     = {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}};

    #(`FULL_CYCLE_DELAY) write_entry_in     = test_input_1;
    #(`FULL_CYCLE_DELAY) write_en_in        = 1;

    #(`FULL_CYCLE_DELAY * 2) test_result_1  = read_entry_out;

    #(`FULL_CYCLE_DELAY * 5) write_en_in    = 0;
    read_en_in                              = 0;

    test_judge                              = (test_result_1 === test_input_1) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});

    $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "basic simultaneous write-read access", test_judge ? "passed" : "failed");

    /**
     *  write "test_input_2" to "write_set_addr_in"
     *  pass : evicted data should equal the value in "test_input_1"
     **/

    #(`FULL_CYCLE_DELAY * 3) test_case_num  = test_case_num + 1;
    test_input_1                            = { {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b0}}, {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b1}} };
    test_input_2                            = { {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b1}}, {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b0}} };

    read_en_in                              = 1;
    write_en_in                             = 1;

    #(`FULL_CYCLE_DELAY) write_set_addr_in  = NUM_SET - test_case_num;
    read_set_addr_in                        = NUM_SET - test_case_num;

    write_entry_in                          = test_input_1;

    #(`FULL_CYCLE_DELAY) write_en_in        = 0;
    #(`FULL_CYCLE_DELAY) write_en_in        = 1;

    write_entry_in                          = test_input_2;
    #`FULL_CYCLE_DELAY write_en_in          = 0;
    #(`FULL_CYCLE_DELAY * 5) test_result_1  = evict_entry_out;


    #(`FULL_CYCLE_DELAY) read_en_in         = 0;
    write_en_in                             = 0;

    test_judge                              = (test_result_1 === test_input_1) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});

    $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "evict access", test_judge ? "passed" : "failed");

    /**
     *  set "write_en_in" to zero then write new data
     *  pass : RAM should be read the old data
     **/

    #(`FULL_CYCLE_DELAY*3) test_case_num    = test_case_num + 1;

    test_input_1                            = { {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b0}}, {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b1}} };
    test_input_2                            = { {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b1}}, {(SINGLE_ENTRY_SIZE_IN_BITS/2){1'b0}} };

    read_en_in                              = 1;
    write_en_in                             = 1;

    #(`FULL_CYCLE_DELAY) write_set_addr_in  = NUM_SET - test_case_num;
    read_set_addr_in                        = NUM_SET - test_case_num;

    write_entry_in                          = test_input_1;

    #(`FULL_CYCLE_DELAY * 10) write_en_in   = 0;
    #(`FULL_CYCLE_DELAY) write_entry_in     = test_input_2;
    #(`FULL_CYCLE_DELAY) write_en_in        = 0;

    #(`FULL_CYCLE_DELAY) test_result_1      = read_entry_out;

    #(`FULL_CYCLE_DELAY) read_en_in         = 0;
    write_en_in                             = 0;

    test_judge                              = (test_result_1 === test_input_1) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});

    $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "write enable verify", test_judge ? "passed" : "failed");

    #(`FULL_CYCLE_DELAY * 300) $display("\n[info-testbench] simulation for %m comes to the end\n");
    $finish;
end

always begin #(`HALF_CYCLE_DELAY) clk_in <= ~clk_in; end

dual_port_blockram
#(
    .SINGLE_ENTRY_SIZE_IN_BITS      (SINGLE_ENTRY_SIZE_IN_BITS),
    .NUM_SET                        (NUM_SET),
    .SET_PTR_WIDTH_IN_BITS          (SET_PTR_WIDTH_IN_BITS)
)

dual_port_blockram
(
    .clk_in                         (clk_in),

    .read_en_in                     (read_en_in),
    .read_set_addr_in               (read_set_addr_in),
    .read_entry_out                 (read_entry_out),

    .write_en_in                    (write_en_in),
    .write_set_addr_in              (write_set_addr_in),
    .write_entry_in                 (write_entry_in),
    .evict_entry_out                (evict_entry_out)
);

endmodule
