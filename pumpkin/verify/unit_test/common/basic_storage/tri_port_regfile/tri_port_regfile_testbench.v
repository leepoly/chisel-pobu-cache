`include "parameters.h"
`include "sim_config.h"

module tri_port_regfile_testbench();

    parameter SINGLE_ENTRY_SIZE_IN_BITS                         = 8;
    parameter NUM_ENTRY                                         = 4;
    
    reg                                                         reset_in;
    reg                                                         clk_in;

    reg                                                         read_en_in;
    reg                                                         write_en_in;
    reg                                                         cam_en_in;

    reg     [NUM_ENTRY   - 1 : 0]                               read_entry_addr_decoded_in;
    reg     [NUM_ENTRY   - 1 : 0]                               write_entry_addr_decoded_in;
    reg     [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]                 cam_entry_in;

    reg     [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]                 write_entry_in;
    wire    [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]                 read_entry_out;
    wire    [NUM_ENTRY              - 1 : 0]                    cam_result_decoded_out;     

    integer                                                     test_case_num;
    reg                                                         test_judge;
    reg     [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]                 test_input_1;
    reg     [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]                 test_input_2;
    reg     [SINGLE_ENTRY_SIZE_IN_BITS - 1 : 0]                 test_result_1;
    
    initial
    begin
        `ifdef DUMP
            $dumpfile(`DUMP_FILENAME);
            $dumpvars(0, tri_port_testbench_testbench);
        `endif

        $display("\n[info-testbench] simulation for %m begins now");
    
        clk_in                                                      = 0;
        reset_in                                                    = 1;
    
        read_en_in                                                  = 0;
        write_en_in                                                 = 0;
        cam_en_in                                                   = 0;
    
        read_entry_addr_decoded_in                                  = 0;
        write_entry_addr_decoded_in                                 = 0;
    
        cam_entry_in                                                = 0;
        write_entry_in                                              = 0;
    
        test_case_num                                               = 0;
        test_judge                                                  = 0;
        
        #(`FULL_CYCLE_DELAY) reset_in                               = 0;
        $display("[info-testbench] %m testbench reset completed\n");

        /**
         *  test case 0 
         **/
         
                                    read_entry_addr_decoded_in      = 4'b0001;
                                    write_entry_addr_decoded_in     = 4'b0001;
                                    
                                    test_input_1                    = {{(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b1}}, {(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b0}}};
        
        #(`FULL_CYCLE_DELAY)        write_entry_in                  = test_input_1;
        

        #(`FULL_CYCLE_DELAY)        write_en_in                     = 1'b1;
        #(`FULL_CYCLE_DELAY)        write_en_in                     = 1'b0;
        
        
        #(`FULL_CYCLE_DELAY)        read_en_in                      = 1'b1;
        #(`FULL_CYCLE_DELAY)        test_result_1                   = read_entry_out;
        #(`FULL_CYCLE_DELAY)        read_en_in                      = 1'b0;
                
        test_judge                                          = (test_result_1 === test_input_1) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});
        $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "basic write-read access", test_judge ? "passed" : "failed");

        /**
         *  test case 1 
         **/

        #(`FULL_CYCLE_DELAY * 50)   test_case_num                   = test_case_num + 1;
                                    test_input_1                    = {{(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b1}}, {(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b0}}};
                                    test_input_2                    = {{(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b0}}, {(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b1}}};
                                    
                                    read_entry_addr_decoded_in      = 4'b0001;
                                    write_entry_addr_decoded_in     = 4'b0001;
                                    
        #(`FULL_CYCLE_DELAY)        write_entry_in                  = test_input_1;
        
        #(`FULL_CYCLE_DELAY)        read_en_in                      = 1'b1;
                                    write_en_in                     = 1'b1;
        
        #(`FULL_CYCLE_DELAY)        write_en_in                     = 1'b0;
        #(`FULL_CYCLE_DELAY)        write_entry_in                  = test_input_2;
        #(`FULL_CYCLE_DELAY)        test_result_1                   = read_entry_out;
        #(`FULL_CYCLE_DELAY)        read_en_in                      = 1'b0;
        
                                    test_judge                      = (test_result_1 === test_input_1) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});
                                    
        $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "write enable verify", test_judge ? "passed" : "failed");

        /**
         *  test case 2 
         **/
    
        #(`FULL_CYCLE_DELAY * 50)   test_case_num                   = test_case_num + 1;
                                    test_judge                      = 1;
        #(`FULL_CYCLE_DELAY)        reset_in                        = 1'b1;
        #(`FULL_CYCLE_DELAY)        reset_in                        = 1'b0;
        
                                    test_input_1                    = {{(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b1}}, {(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b0}}};
                                    test_input_2                    = {{(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b0}}, {(SINGLE_ENTRY_SIZE_IN_BITS / 2){1'b1}}};
    
        #(`FULL_CYCLE_DELAY)        cam_en_in                       = 1'b1;
                                    cam_entry_in                    = test_input_1;
    
        #(`FULL_CYCLE_DELAY)        test_result_1                   = cam_result_decoded_out;
                                    cam_en_in                       = 1'b0;
    
                                    test_judge                      = test_judge & (test_result_1 === 4'b0000) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});

        #(`FULL_CYCLE_DELAY)        write_entry_in                  = test_input_1;
        #(`FULL_CYCLE_DELAY)        write_en_in                     = 1'b1;
        
        #(`FULL_CYCLE_DELAY)        write_entry_addr_decoded_in     = 4'b1111;
        #(`FULL_CYCLE_DELAY)        cam_en_in                       = 1'b1;
        
        #(`FULL_CYCLE_DELAY)        test_result_1                   = cam_result_decoded_out;
        
                                    cam_en_in                       = 1'b0;
                                    write_en_in                     = 1'b0;
                                       
                                    test_judge                      = test_judge & (test_result_1 === 4'b1111) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});

        #(`FULL_CYCLE_DELAY)        write_entry_in                  = test_input_2;
        #(`FULL_CYCLE_DELAY)        write_entry_addr_decoded_in     = 4'b1010;
        #(`FULL_CYCLE_DELAY)        write_en_in                     = 1'b1;
        
        #(`FULL_CYCLE_DELAY)        cam_en_in                       = 1'b1;
        
        #(`FULL_CYCLE_DELAY)        test_result_1                   = cam_result_decoded_out;
        
                                    cam_en_in                       = 1'b0;
                                    write_en_in                     = 1'b0;

                                    test_judge                      = test_judge & (test_result_1 === 4'b0101) && (test_result_1 !== {(SINGLE_ENTRY_SIZE_IN_BITS){1'bx}});


        $display("[info-testbench] test case %d %40s : \t%s", test_case_num, "basic cam access", test_judge ? "passed" : "failed");

    
        #(`FULL_CYCLE_DELAY * 1500)
        $display("\n[info-testbench] simulation for %m comes to the end\n");
        $finish;
    end

    always begin #`HALF_CYCLE_DELAY clk_in <= ~clk_in; end

    tri_port_regfile
    #
    (
        .SINGLE_ENTRY_SIZE_IN_BITS                              (SINGLE_ENTRY_SIZE_IN_BITS),
        .NUM_ENTRY                                              (NUM_ENTRY)
    )
    
    tri_port_regfile
    (
        .reset_in                                               (reset_in),
        .clk_in                                                 (clk_in),
    
        .read_en_in                                             (read_en_in),
        .write_en_in                                            (write_en_in),
        .cam_en_in                                              (cam_en_in),

        .read_entry_addr_decoded_in                             (read_entry_addr_decoded_in),
        .write_entry_addr_decoded_in                            (write_entry_addr_decoded_in),
        .cam_entry_in                                           (cam_entry_in),

        .write_entry_in                                         (write_entry_in),
        .read_entry_out                                         (read_entry_out),
        .cam_result_decoded_out                                 (cam_result_decoded_out)
    );

endmodule
