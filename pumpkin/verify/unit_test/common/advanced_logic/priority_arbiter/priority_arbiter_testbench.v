`include "sim_config.h"
`include "parameters.h"

module priority_arbiter_testbench();

parameter NUM_REQUEST  = 3;
parameter SINGLE_REQUEST_WIDTH_IN_BITS = 64;

reg                                                     clk_in;
reg                                                     reset_in;
reg     [31:0]                                          clk_ctr;

reg     [(SINGLE_REQUEST_WIDTH_IN_BITS - 1):0]          request_0_to_arb;
reg                                                     request_0_valid_to_arb;
reg                                                     request_0_critical_to_arb;
wire                                                    issue_ack_0_from_arb;

reg     [(SINGLE_REQUEST_WIDTH_IN_BITS - 1):0]          request_1_to_arb;
reg                                                     request_1_valid_to_arb;
reg                                                     request_1_critical_to_arb;
wire                                                    issue_ack_1_from_arb;

reg     [(SINGLE_REQUEST_WIDTH_IN_BITS - 1):0]          request_2_to_arb;
reg                                                     request_2_valid_to_arb;
reg                                                     request_2_critical_to_arb;
wire                                                    issue_ack_2_from_arb;

wire    [(SINGLE_REQUEST_WIDTH_IN_BITS - 1):0]          request_from_arb;
wire                                                    request_valid_from_arb;
reg	                                                    issue_ack_to_arb;

integer                                                 test_i;
integer                                                 test_case;
reg                                                     test_end_flag;
reg                                                     test_check_flag;
reg                                                     test_judge;

reg     [(SINGLE_REQUEST_WIDTH_IN_BITS - 1):0]          test_input_value;
reg     [(SINGLE_REQUEST_WIDTH_IN_BITS - 1):0]          test_output_value;

reg     [(SINGLE_REQUEST_WIDTH_IN_BITS - 1):0]          test_buffer[9:0];
reg     [31:0]                                          test_ctr;
reg     [31:0]                                          test_write_ctr;
reg     [31:0]                                          test_read_ctr;

always @(posedge clk_in or posedge reset_in)
begin
    if(reset_in)
    begin

    end


    /**
    *  test case 0
    **/

    else if(test_case == 0 & ~test_check_flag & ~test_end_flag)
    begin
        if(clk_ctr == 256)
        begin
            test_check_flag                      = 1'b1;
        end
            clk_ctr                              = clk_ctr + 1'b1;

        // request 0
        if(issue_ack_0_from_arb & request_0_valid_to_arb)
        begin
            request_0_to_arb                    <= request_0_to_arb + 1'b1;
            request_0_valid_to_arb              <= 1'b0;
        end

        else
        begin
            request_0_to_arb                    <= request_0_to_arb;
            request_0_valid_to_arb              <= 1'b0;
        end

        if(clk_ctr % 25 == 0 & request_0_valid_to_arb)
        begin
            request_0_critical_to_arb           <= 1'b1;
        end

        else if(request_0_critical_to_arb & issue_ack_0_from_arb)
        begin
            request_0_critical_to_arb           <= 1'b0;
        end

        // request 1
        if(issue_ack_1_from_arb & request_1_valid_to_arb)
        begin
            request_1_to_arb                    <= request_1_to_arb + 1'b1;
            request_1_valid_to_arb              <= 1'b0;
        end

        else
        begin
                request_1_to_arb                <= request_1_to_arb;
                request_1_valid_to_arb          <= 1'b0;
        end

        if(clk_ctr % 15 == 0 & request_1_valid_to_arb)
        begin
                request_1_critical_to_arb       <= 1'b1;
        end

        else if(request_1_critical_to_arb & issue_ack_1_from_arb)
        begin
                request_1_critical_to_arb       <= 1'b0;
        end

        // request 2
        if(issue_ack_2_from_arb & request_2_valid_to_arb)
        begin
                request_2_to_arb                <= request_2_to_arb + 1'b1;
                request_2_valid_to_arb <= 1'b0;
        end

        else
        begin
                request_2_to_arb                <= request_2_to_arb;
                request_2_valid_to_arb          <= 1'b0;
        end

        if(clk_ctr % 10 == 0 & request_2_valid_to_arb)
        begin
                request_2_critical_to_arb       <= 1'b1;
        end

        else if(request_2_critical_to_arb & issue_ack_2_from_arb)
        begin
                request_2_critical_to_arb       <= 1'b0;
        end

        // issue ack to arb
        if(clk_ctr % 3 == 0)
        begin
                issue_ack_to_arb                <= 1'b1;


                test_buffer[test_read_ctr]      = request_from_arb | request_valid_from_arb;
                test_read_ctr                   = test_read_ctr + 1'b1;
        end

        else
        begin
                issue_ack_to_arb                <= 1'b0;
        end
    //check
    end

    if(test_check_flag & ~test_end_flag)
    begin
        for(test_i = 0; test_i < test_read_ctr; test_i = test_i + 1)
        begin
                if(|test_buffer[test_i])
                begin
                        test_i                  = test_read_ctr + 1'b1;
                end
        end

        test_judge                              = (test_i == test_read_ctr);
        test_end_flag                           = 1'b1;
    end
end

always @(posedge clk_in)
begin

    /**
    *  test case 1
    **/

    if(test_case == 1 & ~test_check_flag & ~test_end_flag)
    begin
        if(test_write_ctr == 10)
        begin
            test_check_flag                 = 1'b1;
        end

        clk_ctr                                 <= clk_ctr + 1'b1;

        // request 2
        if(issue_ack_2_from_arb & request_2_valid_to_arb)
        begin
            request_2_to_arb                = request_2_to_arb + 1'b1;
            request_2_valid_to_arb          = 1'b1;


            test_buffer[test_write_ctr]     = request_2_to_arb;
            test_write_ctr                  = test_write_ctr + 1'b1;
        end

        else
        begin
            request_2_to_arb                <= request_2_to_arb;
            request_2_valid_to_arb          <= 1'b1;
        end

        // request 0
        if(issue_ack_0_from_arb & request_0_valid_to_arb)
        begin
            request_0_to_arb                = request_0_to_arb + 1'b1;
            request_0_valid_to_arb          = 1'b1;

            test_buffer[test_write_ctr]     = request_0_to_arb;
            test_write_ctr                  = test_write_ctr + 1'b1;
        end

        else
        begin
            request_0_to_arb                <= request_0_to_arb;
            request_0_valid_to_arb          <= 1'b1;
        end

        // request 1
        if(issue_ack_1_from_arb & request_1_valid_to_arb)
        begin
            request_1_to_arb                = request_1_to_arb + 1'b1;
            request_1_valid_to_arb          = 1'b1;

            test_buffer[test_write_ctr]     = request_1_to_arb;
            test_write_ctr                  = test_write_ctr + 1'b1;
        end

        else
        begin
            request_1_to_arb                <= request_1_to_arb;
            request_1_valid_to_arb          <= 1'b1;
        end

        // issue ack to arb
        if(clk_ctr % 3 == 0 & request_valid_from_arb)
        begin
            issue_ack_to_arb                <= 1'b1;

            test_buffer[test_read_ctr]      <= test_buffer[test_read_ctr] ^ request_from_arb;
            #(`FULL_CYCLE_DELAY) test_read_ctr = test_read_ctr + 1;
        end

        else
        begin
            issue_ack_to_arb                <= 1'b0;
        end
    end

    //check
    else if(test_check_flag & ~test_end_flag)
    begin
        for(test_i = 0; test_i < test_read_ctr; test_i = test_i + 1)
        begin
            if(|test_buffer[test_i])
            begin
                test_i                      = test_read_ctr + 1'b1;
            end
        end

        test_judge                              = (test_i == test_read_ctr);
        test_end_flag                           = 1'b1;
    end
end

always @(posedge clk_in)
begin

    /**
    *  test case 2
    **/

    if (test_case == 2 & ~test_check_flag & ~test_end_flag)
    begin
        clk_ctr <= clk_ctr + 1'b1;

        if(test_write_ctr == 10)
        begin
            test_check_flag                  = 1'b1;
        end

        if((test_write_ctr == 4) & ~request_0_critical_to_arb)
        begin
            request_0_critical_to_arb        = 1'b1;
        end

        // request 0
        if(issue_ack_0_from_arb & request_0_valid_to_arb)
        begin
            request_0_to_arb                 = request_0_to_arb + 1'b1;
            request_0_valid_to_arb           = 1'b1;

            test_buffer[test_write_ctr]      = request_0_to_arb;
            test_write_ctr                   = test_write_ctr + 1'b1;
        end

        else
        begin
            request_0_to_arb                <= request_0_to_arb;
            request_0_valid_to_arb          <= 1'b1;
        end

        // request 1
        if(issue_ack_1_from_arb & request_1_valid_to_arb)
        begin
            request_1_to_arb                = request_1_to_arb + 1'b1;
            request_1_valid_to_arb          = 1'b1;

            if(~request_0_critical_to_arb)
            begin
                    test_buffer[test_write_ctr] = request_1_to_arb;
                            test_write_ctr      = test_write_ctr + 1'b1;
            end
        end

        else
        begin
            request_1_to_arb                <= request_1_to_arb;
            request_1_valid_to_arb          <= 1'b1;
        end

        // request 2
        if(issue_ack_2_from_arb & request_2_valid_to_arb)
        begin
            request_2_to_arb                = request_2_to_arb + 1'b1;
            request_2_valid_to_arb          = 1'b1;

            if(~request_0_critical_to_arb)
            begin
                    test_buffer[test_write_ctr]      = request_2_to_arb;
                    test_write_ctr                   = test_write_ctr + 1'b1;
            end
        end

        else
        begin
            request_2_to_arb                <= request_2_to_arb;
            request_2_valid_to_arb          <= 1'b1;
        end


        // issue ack to arb
        if(clk_ctr % 3 == 0 & request_valid_from_arb)
        begin
            issue_ack_to_arb                <= 1'b1;
            test_buffer[test_read_ctr]       = test_buffer[test_read_ctr] ^ request_from_arb;
            test_read_ctr                    = test_read_ctr + 1;

            if (test_read_ctr == 4)
                    test_buffer[test_read_ctr - 1] = 1'b0;
        end

        else
        begin
            issue_ack_to_arb                <= 1'b0;
        end
    end

    //check
    else if(test_check_flag & ~test_end_flag)
    begin
        for(test_i = 0; test_i < test_read_ctr; test_i = test_i + 1)
        begin
            if(|test_buffer[test_i])
            begin
                test_i                      = test_read_ctr + 1'b1;
            end
        end

        test_judge                              = (test_i == test_read_ctr);
        test_end_flag                           = 1'b1;
    end
end

always @(posedge clk_in)
begin
    /**
    *  test case 3
    **/

    if (test_case == 3 & ~test_check_flag & ~test_end_flag)
    begin
        if(test_write_ctr == 10)
        begin
            test_check_flag                 = 1'b1;
        end

        if(test_write_ctr == 4)
        begin
            request_0_critical_to_arb       = 1'b1;
            request_1_critical_to_arb       = 1'b1;
        end

        clk_ctr                                 <= clk_ctr + 1'b1;

        // request 0
        if(issue_ack_0_from_arb & request_0_valid_to_arb)
        begin
            request_0_to_arb                        = request_0_to_arb + 1'b1;
            request_0_valid_to_arb                  = 1'b1;

            test_buffer[test_write_ctr]             = request_0_to_arb;
            test_write_ctr                          = test_write_ctr + 1'b1;
        end

        else
        begin
            request_0_to_arb                        <= request_0_to_arb;
            request_0_valid_to_arb                  <= 1'b1;
        end

        // request 1
        if(issue_ack_1_from_arb & request_1_valid_to_arb)
        begin
            request_1_to_arb                        = request_1_to_arb + 1'b1;
            request_1_valid_to_arb                  = 1'b1;

            test_buffer[test_write_ctr]             = request_1_to_arb;
            test_write_ctr                          = test_write_ctr + 1'b1;
        end

        else
        begin
            request_1_to_arb                        <= request_1_to_arb;
            request_1_valid_to_arb                  <= 1'b1;
        end

        // request 2
        if(issue_ack_2_from_arb & request_2_valid_to_arb)
        begin
            request_2_to_arb                        = request_2_to_arb + 1'b1;
            request_2_valid_to_arb                  = 1'b1;

            if(~request_0_critical_to_arb)
            begin
                test_buffer[test_write_ctr]     = request_2_to_arb;
                test_write_ctr                  = test_write_ctr + 1'b1;
            end
        end

        else
        begin
            request_2_to_arb                        <= request_2_to_arb;
            request_2_valid_to_arb                  <= 1'b1;
        end

        // issue ack to arb
        if(clk_ctr % 3 == 0 & request_valid_from_arb)
        begin
            issue_ack_to_arb                        <= 1'b1;

            test_buffer[test_read_ctr]              = test_buffer[test_read_ctr] ^ request_from_arb;
            test_read_ctr                           = test_read_ctr + 1;
        end

        else
        begin
            issue_ack_to_arb <= 1'b0;
        end
    end

    //check
    else if(test_check_flag & ~test_end_flag)
    begin
        for(test_i = 0; test_i < test_read_ctr; test_i = test_i + 1)
        begin
            if(|test_buffer[test_i])
            begin
                test_i = test_read_ctr + 1'b1;
            end
        end

        test_judge = (test_i == test_read_ctr);
        test_end_flag = 1'b1;
    end
end


always @(posedge clk_in)
begin

    /**
        *  test case 4
        **/

    if (test_case == 4 & ~test_check_flag & ~test_end_flag)
    begin

        if(test_write_ctr == 10)
        begin
            test_check_flag = 1'b1;
        end

        if(test_write_ctr == 5)
        begin
            request_0_critical_to_arb = 1'b1;
            request_1_critical_to_arb = 1'b1;
            request_2_critical_to_arb = 1'b1;
        end

        clk_ctr <= clk_ctr + 1'b1;

        // request 0
        if(issue_ack_0_from_arb & request_0_valid_to_arb)
        begin
            request_0_to_arb                 = request_0_to_arb + 1'b1;
            request_0_valid_to_arb           = 1'b1;

            test_buffer[test_write_ctr]      = request_0_to_arb;
            test_write_ctr                   = test_write_ctr + 1'b1;
        end

        else
        begin
            request_0_to_arb                <= request_0_to_arb;
            request_0_valid_to_arb          <= 1'b1;
        end

        // request 1
        if(issue_ack_1_from_arb & request_1_valid_to_arb)
        begin
            request_1_to_arb                 = request_1_to_arb + 1'b1;
            request_1_valid_to_arb           = 1'b1;

            test_buffer[test_write_ctr]      = request_1_to_arb;
            test_write_ctr                   = test_write_ctr + 1'b1;
        end

        else
        begin
            request_1_to_arb                <= request_1_to_arb;
            request_1_valid_to_arb          <= 1'b1;
        end

        // request 2
        if(issue_ack_2_from_arb & request_2_valid_to_arb)
        begin
            request_2_to_arb                 = request_2_to_arb + 1'b1;
            request_2_valid_to_arb           = 1'b1;

            test_buffer[test_write_ctr]      = request_2_to_arb;
            test_write_ctr                   = test_write_ctr + 1'b1;
        end

        else
        begin
            request_2_to_arb                <= request_2_to_arb;
            request_2_valid_to_arb          <= 1'b1;
        end

        // issue ack to arb
        if(clk_ctr % 3 == 0 & request_valid_from_arb)
        begin
            issue_ack_to_arb                  <= 1'b1;

            test_buffer[test_read_ctr]        = test_buffer[test_read_ctr] ^ request_from_arb;
            test_read_ctr                     = test_read_ctr + 1;
        end

        else
        begin
            issue_ack_to_arb  <= 1'b0;
        end
    end

    //check
    else if(test_check_flag & ~test_end_flag)
    begin
        for(test_i = 0; test_i < test_read_ctr; test_i = test_i + 1)
        begin
            if(|test_buffer[test_i])
            begin
                test_i = test_read_ctr + 1'b1;
            end
        end

        test_judge = (test_i == test_read_ctr);
        test_end_flag = 1'b1;
    end
end

always @(*)
begin
    if(reset_in)
    begin
        clk_ctr                                 <= 0;

        request_0_to_arb                        <= {(SINGLE_REQUEST_WIDTH_IN_BITS){1'b0}} + 1'b1;
        request_0_valid_to_arb                  <= 1'b0;
        request_0_critical_to_arb               <= 1'b0;

        request_1_to_arb                        <= {{(SINGLE_REQUEST_WIDTH_IN_BITS/2){1'b1}},{(SINGLE_REQUEST_WIDTH_IN_BITS/2){1'b0}}};
        request_1_valid_to_arb                  <= 1'b0;
        request_1_critical_to_arb               <= 1'b0;

        request_2_to_arb                        <= {(SINGLE_REQUEST_WIDTH_IN_BITS){1'b1}};
        request_2_valid_to_arb                  <= 1'b0;
        request_2_critical_to_arb               <= 1'b0;

        test_check_flag                         <= 1'b0;
        issue_ack_to_arb                        <= {(NUM_REQUEST){1'b1}};
        #(`FULL_CYCLE_DELAY * 24)

        test_judge                              <= 1'b0;
        test_ctr                                <= 32'b0;
        test_write_ctr                          <= 32'b0;
        test_read_ctr                           <= 32'b0;

        #(`FULL_CYCLE_DELAY * 3)
        test_buffer[0]                          <= request_1_to_arb;
        test_buffer[1]                          <= request_2_to_arb;
        test_buffer[2]                          <= request_0_to_arb;

        test_write_ctr                          <= 3;
        test_read_ctr                           <= 0;

        reset_in                                = 1'b0;
        #(`FULL_CYCLE_DELAY)
        test_end_flag                           = 1'b0;
    end
end

initial
begin

    `ifdef DUMP
        $dumpfile(`DUMP_FILENAME);
        $dumpvars(0, priority_arbiter_testbench);
    `endif

    $display("\n[info-testbench] simulation for %m begins now");
    clk_in                      = 1'b0;
    reset_in                    = 1'b0;

    test_case                   = 1'b0;
    test_check_flag             = 1'b0;
    test_end_flag               = 1'b1;

//    #(`FULL_CYCLE_DELAY)        reset_in = 1'b1;

//    #(`FULL_CYCLE_DELAY)        reset_in = 1'b0;
//    #(`FULL_CYCLE_DELAY * 500)  $display("[info-rtl] test case %d %35s : \t%s", test_case, "invalid request", test_judge? "passed": "failed");

//     reset_in = 1'b1; #(`FULL_CYCLE_DELAY * 500)

//    #(`FULL_CYCLE_DELAY)        test_case = test_case + 1'b1;
//    #(`FULL_CYCLE_DELAY)        reset_in = 1'b0;
//    #(`FULL_CYCLE_DELAY * 500)  $display("[info-rtl] test case %d %35s : \t%s", test_case, "basic request", test_judge? "passed": "failed");

    #(`FULL_CYCLE_DELAY * 500)  reset_in = 1'b1;

    #(`FULL_CYCLE_DELAY)        test_case = 2;
    #(`FULL_CYCLE_DELAY)        reset_in = 1'b0;
    #(`FULL_CYCLE_DELAY * 500)  $display("[info-rtl] test case %d %35s : \t%s", test_case, "1 critical requests", test_judge? "passed": "failed");

    #(`FULL_CYCLE_DELAY * 500)  reset_in = 1'b1;

//    #(`FULL_CYCLE_DELAY)        test_case = 3;
//    #(`FULL_CYCLE_DELAY)        reset_in = 1'b0;
//    #(`FULL_CYCLE_DELAY * 500)  $display("[info-rtl] test case %d %35s : \t%s", test_case, "2 critical requests", test_judge? "passed": "failed");

//    #(`FULL_CYCLE_DELAY * 500)  reset_in = 1'b1;

//    #(`FULL_CYCLE_DELAY)        test_case = 4;
//    #(`FULL_CYCLE_DELAY)        reset_in = 1'b0;
//    #(`FULL_CYCLE_DELAY * 500)  $display("[info-rtl] test case %d %35s : \t%s", test_case, "3 critical requests", test_judge? "passed": "failed");

    #(`FULL_CYCLE_DELAY * 1500) $display("\n[info-rtl] simulation comes to the end\n");
    $finish;
end

always begin #(`HALF_CYCLE_DELAY) clk_in <= ~clk_in; end

priority_arbiter
#(
    .NUM_REQUEST                                    (NUM_REQUEST),
    .SINGLE_REQUEST_WIDTH_IN_BITS                   (SINGLE_REQUEST_WIDTH_IN_BITS)
 )

priority_arbiter
(
    .reset_in                                       (reset_in),
    .clk_in                                         (clk_in),

    // the arbiter considers priority from right(high) to left(low)
    .request_flatted_in                             ({request_2_to_arb,             request_1_to_arb,           request_0_to_arb}),
    .request_valid_flatted_in                       ({request_2_valid_to_arb,       request_1_valid_to_arb,     request_0_valid_to_arb}),
    .request_critical_flatted_in                    ({request_2_critical_to_arb,    request_1_critical_to_arb,  request_0_critical_to_arb}),
    .issue_ack_out                                  ({issue_ack_2_from_arb,         issue_ack_1_from_arb,       issue_ack_0_from_arb}),

    .request_out                                    (request_from_arb),
    .request_valid_out                              (request_valid_from_arb),
    .issue_ack_in                                   (issue_ack_to_arb)
);

endmodule
