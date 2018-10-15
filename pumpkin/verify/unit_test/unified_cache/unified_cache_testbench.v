`include "sim_config.h"
`include "parameters.h"

`define MEM_SIZE 64

module unified_cache_testbench();

reg                                                             clk_in;
reg                                                             reset_in;

reg     [31:0]                                                  clk_ctr;
reg     [1023:0]                                                mem_image_path;
reg     [511:0]                                                 test_case_content;

reg     [(`UNIFIED_CACHE_BLOCK_SIZE_IN_BITS)   - 1 : 0]         sim_main_memory                 [0 : (`MEM_SIZE)   - 1];
reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way1_packet_issue               [0 : (`MEM_SIZE)/2 - 1];
reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way2_packet_issue               [0 : (`MEM_SIZE)/2 - 1];
reg     [(`UNIFIED_CACHE_BLOCK_SIZE_IN_BITS) - 1 : 0]           correct_result_mem_1            [0 : (`MEM_SIZE)/2 - 1];
reg     [(`UNIFIED_CACHE_BLOCK_SIZE_IN_BITS) - 1 : 0]           correct_result_mem_2            [0 : (`MEM_SIZE)/2 - 1];

reg     [(`UNIFIED_CACHE_BLOCK_SIZE_IN_BITS) - 1 : 0]           test_way1_scoreboard_data       [(`MEM_SIZE)/2 - 1 : 0];
reg     [(`CPU_DATA_LEN_IN_BITS) - 1 : 0]                       test_way1_scoreboard_addr       [(`MEM_SIZE)/2 - 1 : 0];
reg     [(`MEM_SIZE)/2 - 1 : 0]                                 test_way1_scoreboard_valid_array;
reg     [31:0]                                                  test_way1_scoreboard_ctr;

reg     [(`UNIFIED_CACHE_BLOCK_SIZE_IN_BITS) - 1 : 0]           test_way2_scoreboard_data       [(`MEM_SIZE)/2 - 1 : 0];
reg     [(`CPU_DATA_LEN_IN_BITS) - 1 : 0]                       test_way2_scoreboard_addr       [(`MEM_SIZE)/2 - 1 : 0];
reg     [(`MEM_SIZE)/2 - 1 : 0]                                 test_way2_scoreboard_valid_array;
reg     [31:0]                                                  test_way2_scoreboard_ctr;

reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS)   - 1 : 0]       test_way1_result_pool           [(`MEM_SIZE)   - 1 : 0];
reg     [31:0]                                                  test_way1_result_ctr;

reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS)   - 1 : 0]       test_way2_result_pool           [(`MEM_SIZE)   - 1 : 0];
reg     [31:0]                                                  test_way2_result_ctr;

reg                                                             is_way1_scoreboard_hit;
reg                                                             is_way2_scoreboard_hit;

reg     [31:0]                                                  correct_result_ctr_1;
reg     [31:0]                                                  correct_result_ctr_2;
reg     [31:0]                                                  test_hit_1;
reg     [31:0]                                                  test_hit_2;
reg                                                             test_gen_flag;
reg                                                             test_way1_check_flag;
reg                                                             test_way1_is_checked_flag;
reg                                                             test_way2_check_flag;
reg                                                             test_way2_is_checked_flag;
reg     [31:0]                                                  test_check_clk;

reg                                                             test_cache_to_mem_accept_flag;
reg                                                             test_mem_to_cache_accept_flag;

reg                                                             test_mem_wait;
reg     [31:0]                                                  test_mem_clk_ctr;
reg                                                             test_mem_pending_lock;

reg                                                             test_judge;
reg                                                             test_way1_enable;
reg                                                             test_way2_enable;

reg                                                             test_way1_ack_in_ctr;
reg                                                             test_way2_ack_in_ctr;

reg     [15:0]                                                  test_gen_char          [15:0];
reg     [511:0]                                                 test_case_char         [15:0];

integer                                                         test_gen;
integer                                                         test_scoreboard_index;
integer                                                         test_result_index;

integer                                                         test_case;
integer                                                         test_latency;
integer                                                         test_phase;

reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way1_last_packet_from_cache;
reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way1_last_packet_to_cache;
reg                                                             way1_wait;
reg                                                             test_way1_valid;
reg                                                             test_way1_accept_flag;
reg                                                             test_way1_record_flag;

wire                                                            test_way1_is_next_packet_from_cache;
reg                                                             test_way1_gotten_invalid_packet;

reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way2_last_packet_from_cache;
reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way2_last_packet_to_cache;
reg                                                             way2_wait;
reg                                                             test_way2_valid;
reg                                                             test_way2_accept_flag;
reg                                                             test_way2_record_flag;

wire                                                            test_way2_is_next_packet_from_cache;
reg                                                             test_way2_gotten_invalid_packet;

wire    [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way1_packet_to_cache;
wire                                                            way1_packet_ack_from_cache;
reg     [$clog2(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS):0]         way1_packet_index;

wire    [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way1_packet_from_cache;
reg                                                             way1_packet_ack_to_cache;

wire    [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way2_packet_to_cache;
wire                                                            way2_packet_ack_from_cache;
reg     [$clog2(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) :0]        way2_packet_index;

wire    [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         way2_packet_from_cache;
reg                                                             way2_packet_ack_to_cache;

reg     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]         mem_packet_to_cache;
wire                                                            mem_packet_ack_from_cache;

wire     [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]        mem_packet_from_cache;
reg      [(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS) - 1 : 0]        cache_packet_pending;
reg                                                             mem_packet_ack_to_cache;

assign way1_packet_to_cache = (test_way1_enable & test_way1_valid & ~test_way1_is_checked_flag)? way1_packet_issue[way1_packet_index] : {(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS){1'b0}};
assign way2_packet_to_cache = (test_way2_enable & test_way2_valid & ~test_way2_is_checked_flag)? way2_packet_issue[way2_packet_index] : {(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS){1'b0}};

assign test_way1_is_next_packet_from_cache = (way1_last_packet_from_cache == {(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS){1'b0}} | way1_last_packet_from_cache != way1_packet_from_cache) | (test_way1_gotten_invalid_packet);
assign test_way2_is_next_packet_from_cache = (way2_last_packet_from_cache == {(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS){1'b0}} | way2_last_packet_from_cache != way2_packet_from_cache) | (test_way2_gotten_invalid_packet);

always@(posedge clk_in or posedge reset_in)
begin
    if (reset_in)
    begin
            way1_packet_index                   <= 0;
            way2_packet_index                   <= 0;

            mem_packet_to_cache                 <= 0;

            way1_packet_ack_to_cache            <= 0;
            way2_packet_ack_to_cache            <= 0;
            mem_packet_ack_to_cache             <= 0;
            
            correct_result_ctr_1                <= 0;
            correct_result_ctr_2                <= 0;
            
            test_hit_1                          <= 0;
            test_hit_2                          <= 0;
                        
            test_way1_ack_in_ctr                <= 0;
            test_way2_ack_in_ctr                <= 0; 
                        
            test_way1_enable                    <= 0;
            test_way2_enable                    <= 0;
            test_judge                          <= 0;
            
            test_gen_flag                       <= 1;
            test_way1_check_flag                <= 0;
            test_way2_check_flag                <= 0;
            
            test_way1_scoreboard_valid_array    <= {((`MEM_SIZE)/2){1'b0}};
            test_way1_scoreboard_ctr            <= 0;
            
            test_way1_result_ctr                <= 0;
            
            test_way2_scoreboard_valid_array    <= {((`MEM_SIZE)/2){1'b0}};
            test_way2_scoreboard_ctr            <= 0;
            
            test_way2_result_ctr                <= 0;
            
            way1_last_packet_from_cache         <= {(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS){1'b0}};
            way1_last_packet_to_cache           <= {(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS){1'b0}};
            way1_wait                           <= 1;
            test_way1_valid                     <= 1;
            test_way1_accept_flag               <= 0;
            test_way1_record_flag               <= 0;
            
            test_way1_gotten_invalid_packet     <= 0;
            
            way2_last_packet_from_cache         <= {(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS){1'b0}};
            way2_last_packet_to_cache           <= {(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS){1'b0}};
            way2_wait                           <= 1;
            test_way2_valid                     <= 1;
            test_way2_accept_flag               <= 0;
            test_way2_record_flag               <= 0;
            
            test_way2_gotten_invalid_packet     <= 0;
            
            test_way1_is_checked_flag           <= 0;
            test_way2_is_checked_flag           <= 0;
    end

    else
    begin
        // way1 packet to cache
        if(test_way1_enable)
        begin
        
            if (test_way1_record_flag)
            begin
            
                if (~way1_last_packet_to_cache[`UNIFIED_CACHE_PACKET_IS_WRITE_POS])
                begin
                    test_way1_scoreboard_valid_array[test_way1_scoreboard_ctr]      <= 1'b1;
                    test_way1_scoreboard_addr[test_way1_scoreboard_ctr]             <= way1_last_packet_to_cache[`UNIFIED_CACHE_PACKET_ADDR_POS_HI : `UNIFIED_CACHE_PACKET_ADDR_POS_LO];
                    test_way1_scoreboard_data[test_way1_scoreboard_ctr]             <= correct_result_mem_1[test_way1_scoreboard_ctr];
                    test_way1_scoreboard_ctr                                        <= test_way1_scoreboard_ctr + 1'b1;
                end
                test_way1_record_flag                                               <= 0;
            end
        
            if(clk_ctr % 3 == 0 & test_way1_accept_flag)
            begin
                //next request
                
                test_way1_valid                                                     <= 1;
                test_way1_record_flag                                               <= 1;
                way1_packet_index                                                   <= way1_packet_index + 1'b1;
                test_way1_accept_flag                                               <= 0;
                
                if (way1_packet_index + 1'b1 == (`MEM_SIZE)/2 )
                begin
                    test_way1_is_checked_flag                                    <= 1;
                end 
            end

            else
            begin
                if(way1_packet_ack_from_cache)
                begin
                    if(test_way1_valid & ~test_way1_record_flag)
                    begin
                        way1_last_packet_to_cache                                   <= way1_packet_to_cache;
                        test_way1_accept_flag                                       <= 1;
                        test_way1_valid                                             <= 0;
                    end
                end
            end


            //way1 packet from cache
            if(way1_packet_from_cache[`UNIFIED_CACHE_PACKET_VALID_POS] & test_way1_is_next_packet_from_cache) 
            begin
                            
                if (~way1_wait)
                begin
                    way1_last_packet_from_cache                                     <= way1_packet_from_cache;
                    way1_packet_ack_to_cache                                        <= 1'b1;
                    test_way1_gotten_invalid_packet                                 <= 0;
                    
                    if (~ way1_packet_ack_to_cache & ~ way1_packet_from_cache[`UNIFIED_CACHE_PACKET_IS_WRITE_POS])
                    begin
                        if (test_way1_result_ctr < ((test_phase == 32'b0)? (`MEM_SIZE)/2 : (`MEM_SIZE)/4))
                        begin
                            test_way1_result_pool[test_way1_result_ctr]             <= way1_packet_from_cache;
                            test_way1_result_ctr                                    <= test_way1_result_ctr + 1'b1;
                        end
                        
                        if (test_way1_result_ctr + 1'b1 == ((test_phase == 32'b0)? (`MEM_SIZE)/2 : (`MEM_SIZE)/4))
                        begin
                            test_way1_check_flag                                         <= 1;
                            test_way1_valid                                              <= 0;
                        end
                    end
                    
                    way1_wait           <= 1;
                end
                else
                begin
                    way1_wait           <= 0;
                end
            end
            
            else
            begin
                way1_packet_ack_to_cache <= 1'b0;
                
                if (way1_packet_from_cache == 0)
                begin
                    test_way1_gotten_invalid_packet = 1;
                end
            end
        end

        // way2 packet to cache
        if (test_way2_enable)
        begin
            if (test_way2_record_flag)
            begin
                    
                if (~way2_last_packet_to_cache[`UNIFIED_CACHE_PACKET_IS_WRITE_POS])
                begin
                    test_way2_scoreboard_valid_array[test_way2_scoreboard_ctr]      <= 1'b1;
                    test_way2_scoreboard_addr[test_way2_scoreboard_ctr]             <= way2_last_packet_to_cache[`UNIFIED_CACHE_PACKET_ADDR_POS_HI : `UNIFIED_CACHE_PACKET_ADDR_POS_LO];
                    test_way2_scoreboard_data[test_way2_scoreboard_ctr]             <= correct_result_mem_2[test_way2_scoreboard_ctr];
                    test_way2_scoreboard_ctr                                        <= test_way2_scoreboard_ctr + 1'b1;
                end
                test_way2_record_flag                                               <= 0;
            end
                
            if(clk_ctr % 4 == 0 & test_way2_accept_flag)
            begin
                //next request
                
                test_way2_valid         <= 1;
                test_way2_record_flag   <= 1;
                way2_packet_index       <= way2_packet_index + 1'b1;
                test_way2_accept_flag   <= 0;
                
                if (way2_packet_index + 1'b1 == (`MEM_SIZE)/2 )
                begin
                    test_way2_is_checked_flag                                    <= 1;
                end 
            end
        
            else
            begin
                if(way2_packet_ack_from_cache)
                begin
                    if(test_way2_valid & ~test_way2_record_flag)
                    begin
                        way2_last_packet_to_cache   <= way2_packet_to_cache;
                        test_way2_accept_flag       <= 1;
                        test_way2_valid             <= 0;
                    end
                end
            end
    
            // way2 packet from cache
            if(way2_packet_from_cache[`UNIFIED_CACHE_PACKET_VALID_POS] & test_way2_is_next_packet_from_cache) 
            begin
                            
                if (~way2_wait)
                begin
                    way2_last_packet_from_cache                                     <= way2_packet_from_cache;
                    test_way2_ack_in_ctr                                            <= test_way2_ack_in_ctr + 1'b1;
                    way2_packet_ack_to_cache                                        <= 1'b1;
                    test_way2_gotten_invalid_packet                                 <= 0;
                    
                    if (~ way2_packet_ack_to_cache & ~ way2_packet_from_cache[`UNIFIED_CACHE_PACKET_IS_WRITE_POS])
                    begin
                        if (test_way2_result_ctr < ((test_phase == 32'b0)? (`MEM_SIZE)/2 : (`MEM_SIZE)/4))
                        begin
                            test_way2_result_pool[test_way2_result_ctr]             <= way2_packet_from_cache;
                            test_way2_result_ctr                                    <= test_way2_result_ctr + 1'b1;
                        end
                        
                        if (test_way2_result_ctr + 1'b1 == ((test_phase == 32'b0)? (`MEM_SIZE)/2 : (`MEM_SIZE)/4))
                        begin
                            test_way2_check_flag                                         <= 1;
                            test_way2_valid                                              <= 0;
                        end
                    end
                    
                    way2_wait           <= 1;
                end
                else
                begin
                    way2_wait           <= 0;
                end
            end
            
            else
            begin
                way2_packet_ack_to_cache <= 1'b0;
                
                if (way2_packet_from_cache == 0)
                begin
                    test_way2_gotten_invalid_packet = 1;
                end
            end
            
        end
    end
end

//check the result
always@((test_way1_enable? test_way1_check_flag : ~test_way1_check_flag) & (test_way2_enable? test_way2_check_flag : ~test_way2_check_flag))
begin
    
    test_way1_check_flag = 0;
    test_way2_check_flag = 0;
    
    //way1 check
    if (test_way1_enable)
        begin
        
        for (test_result_index = 0; test_result_index < test_way1_result_ctr; test_result_index = test_result_index + 1'b1)
        begin
            test_gen_flag = 1;
            begin:BREAK_1
                
                for (test_scoreboard_index = 0; (test_scoreboard_index < (`MEM_SIZE)/2) & test_gen_flag; test_scoreboard_index = test_scoreboard_index + 1'b1)
                begin
                    if (test_way1_scoreboard_valid_array[test_scoreboard_index])
                    begin
                        if (test_way1_scoreboard_addr[test_scoreboard_index] == test_way1_result_pool[test_result_index][`UNIFIED_CACHE_PACKET_ADDR_POS_HI : `UNIFIED_CACHE_PACKET_ADDR_POS_LO])
                        begin
                            test_gen_flag = 0;
                        end
                    end                       
                end
            
                #(`FULL_CYCLE_DELAY)
                //judge
                is_way1_scoreboard_hit = (~test_gen_flag &&
                    (test_way1_scoreboard_data[test_scoreboard_index - 1] == test_way1_result_pool[test_result_index][`UNIFIED_CACHE_PACKET_DATA_POS_HI : `UNIFIED_CACHE_PACKET_DATA_POS_LO]))? 1 : 0;
                
                
                #(`FULL_CYCLE_DELAY)
                if (is_way1_scoreboard_hit)
                begin
                    test_hit_1 <= test_hit_1 + 1'b1;
                    test_way1_scoreboard_valid_array[test_scoreboard_index - 1] = 1'b0;
                end
                else
                begin
                    test_hit_1 = test_hit_1;
                end
                
            end
        end
    end
    
    //way2 check
    if (test_way2_enable)
        begin
        
        for (test_result_index = 0; test_result_index < test_way2_result_ctr; test_result_index = test_result_index + 1'b1)
        begin
            test_gen_flag = 1;
            begin:BREAK_2
                
                for (test_scoreboard_index = 0; (test_scoreboard_index < (`MEM_SIZE)/2) & test_gen_flag; test_scoreboard_index = test_scoreboard_index + 1'b1)
                begin
                    if (test_way2_scoreboard_valid_array[test_scoreboard_index])
                    begin
                        if (test_way2_scoreboard_addr[test_scoreboard_index] == test_way2_result_pool[test_result_index][`UNIFIED_CACHE_PACKET_ADDR_POS_HI : `UNIFIED_CACHE_PACKET_ADDR_POS_LO])
                        begin
                            test_gen_flag = 0;
                        end
                    end                       
                end
            
                #(`FULL_CYCLE_DELAY)
                //judge
                is_way2_scoreboard_hit = (~test_gen_flag &&
                    (test_way2_scoreboard_data[test_scoreboard_index - 1] == test_way2_result_pool[test_result_index][`UNIFIED_CACHE_PACKET_DATA_POS_HI : `UNIFIED_CACHE_PACKET_DATA_POS_LO]))? 1 : 0;
                
                
                #(`FULL_CYCLE_DELAY)
                if (is_way2_scoreboard_hit)
                begin
                    test_hit_2 <= test_hit_2 + 1'b1;
                    test_way2_scoreboard_valid_array[test_scoreboard_index - 1] = 1'b0;
                end
                else
                begin
                    test_hit_2 = test_hit_2;
                end
                
            end
        end
    end
end

// from cache packet
wire [`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS - 1 : 0]   from_cache_packet_concatenated;
packet_concat from_cache_packet_concat
(
    .addr_in        (mem_packet_from_cache[`UNIFIED_CACHE_PACKET_ADDR_POS_HI : `UNIFIED_CACHE_PACKET_ADDR_POS_LO]),
    .data_in        (mem_packet_from_cache[`UNIFIED_CACHE_PACKET_IS_WRITE_POS] ?
                     mem_packet_from_cache[`UNIFIED_CACHE_PACKET_DATA_POS_HI : `UNIFIED_CACHE_PACKET_DATA_POS_LO]:
                     sim_main_memory[{{2'b0},mem_packet_from_cache[`UNIFIED_CACHE_PACKET_ADDR_POS_HI : `UNIFIED_CACHE_PACKET_ADDR_POS_LO + 2]}]),
    .type_in        (mem_packet_from_cache[`UNIFIED_CACHE_PACKET_TYPE_POS_HI : `UNIFIED_CACHE_PACKET_TYPE_POS_LO]),
    .write_mask_in  (mem_packet_from_cache[`UNIFIED_CACHE_PACKET_BYTE_MASK_POS_HI : `UNIFIED_CACHE_PACKET_BYTE_MASK_POS_LO]),
    .port_num_in    (mem_packet_from_cache[`UNIFIED_CACHE_PACKET_PORT_NUM_HI : `UNIFIED_CACHE_PACKET_PORT_NUM_LO]),
    .valid_in       (mem_packet_from_cache[`UNIFIED_CACHE_PACKET_VALID_POS]),
    .is_write_in    (mem_packet_from_cache[`UNIFIED_CACHE_PACKET_IS_WRITE_POS]),
    .cacheable_in   (mem_packet_from_cache[`UNIFIED_CACHE_PACKET_CACHEABLE_POS]),
    .packet_out     (from_cache_packet_concatenated)
);

always@(posedge clk_in or posedge reset_in)
begin
    if(reset_in)
    begin
        test_cache_to_mem_accept_flag       <= 1;
        mem_packet_ack_to_cache             <= 0;
        cache_packet_pending                <= 0;
        test_mem_wait                       <= 0;
        test_mem_clk_ctr                    <= 0;
        
        test_mem_pending_lock               <= 0;
    end
    
    else if(mem_packet_from_cache[`UNIFIED_CACHE_PACKET_VALID_POS] & (~test_mem_wait) & (test_cache_to_mem_accept_flag) & (~test_mem_pending_lock))
    begin
        test_mem_pending_lock   <= 1;
        test_cache_to_mem_accept_flag    <= 0;
        mem_packet_ack_to_cache <= 1;
        
        if ({mem_packet_from_cache[`UNIFIED_CACHE_PACKET_IS_WRITE_POS]})
        begin
            sim_main_memory[{{2'b0},mem_packet_from_cache[`UNIFIED_CACHE_PACKET_ADDR_POS_HI : `UNIFIED_CACHE_PACKET_ADDR_POS_LO + 2]}] <= mem_packet_from_cache[`UNIFIED_CACHE_PACKET_DATA_POS_HI : `UNIFIED_CACHE_PACKET_DATA_POS_LO];
        end
        
        cache_packet_pending    <= from_cache_packet_concatenated;
    end

    else if(mem_packet_ack_to_cache)
    begin
        if(~test_cache_to_mem_accept_flag)
        begin
            test_cache_to_mem_accept_flag    <= 1;
            mem_packet_ack_to_cache          <= 0;       
        end
    end
    
    if (test_mem_wait)
    begin
        
        test_mem_clk_ctr            <= test_mem_clk_ctr + 1'b1;
    
        if ((test_mem_clk_ctr + 1'b1) % test_latency == 0)
        begin
            test_mem_wait           <= 0;

        end
        
    end
end

// to cache packet
always@(posedge clk_in or posedge reset_in)
begin
    if(reset_in)
    begin
        mem_packet_to_cache             <= 0;
        test_mem_to_cache_accept_flag   <= 1;
    end
    else
    begin
        
        if (mem_packet_ack_from_cache)
        begin
            test_mem_to_cache_accept_flag   <= 1;
            mem_packet_to_cache             <= 0; 
        end
        
        if(cache_packet_pending[`UNIFIED_CACHE_PACKET_VALID_POS] & test_mem_pending_lock & test_mem_to_cache_accept_flag)
        begin
            mem_packet_to_cache             <= cache_packet_pending;
            test_mem_to_cache_accept_flag   <= 0;
            test_mem_pending_lock           <= 0;
            
            test_mem_wait                    <= 1;
            test_mem_clk_ctr                 <= 0;
        end
    

    end
end

always@(posedge clk_in or posedge reset_in)
begin
    if (reset_in)
    begin
        test_latency = 200;
    end
    
    else
    begin
        case(test_phase)
        0: test_latency = 20;
        1: test_latency = 2;
        2: test_latency = 200;
        endcase
    end
    
end

always@(posedge clk_in or posedge reset_in)
begin
    if (reset_in)
    begin
            clk_ctr <= 1;
    end
    
    else
    begin
            clk_ctr <= clk_ctr + 1'b1;            
    end
end

always begin #(`HALF_CYCLE_DELAY) clk_in <= ~clk_in; end

initial
begin
    
    `ifdef DUMP
        $dumpfile(`DUMP_FILENAME);
        $dumpvars(0, unified_cache_testbench);
    `endif
    
    $display("\n[info-testbench] simulation for %m begins now");
    
                                clk_in                               = 1'b0;
                                reset_in                             = 1'b0;
                                test_case                            = 1'b0;
                                
                                test_gen_char[0]                     = "00";
                                test_gen_char[1]                     = "01";
                                test_gen_char[2]                     = "02";
                                test_gen_char[3]                     = "03";
                                
                                test_gen_char[4]                     = "04";
                                test_gen_char[5]                     = "05";
                                test_gen_char[6]                     = "06";
                                test_gen_char[7]                     = "07";
                                
                                test_gen_char[8]                     = "08";
                                test_gen_char[9]                     = "09";
                                test_gen_char[10]                    = "10";
                                test_gen_char[11]                    = "11";
                                
                                test_gen_char[12]                    = "12";
                                test_gen_char[13]                    = "13";
                                test_gen_char[14]                    = "14";
                                test_gen_char[15]                    = "15";
    
                                test_case_char[0]                    = "single-way random read";
                                test_case_char[1]                    = "single-way random write and read";
                                test_case_char[2]                    = "single-way interleaved-bank read";
                                test_case_char[3]                    = "single-way interleaved-bank write and read";
                                
                                test_case_char[4]                    = "single-way same-bank read";
                                test_case_char[5]                    = "single-way same-bank write and read";
                                test_case_char[6]                    = "single-way same-set read";
                                test_case_char[7]                    = "single-way same-set write and read";
                                
                                test_case_char[8]                    = "dual-way random read";
                                test_case_char[9]                    = "dual-way random write and read";
                                test_case_char[10]                   = "dual-way interleaved-bank read";
                                test_case_char[11]                   = "dual-way interleaved-bank write and read";
                                
                                test_case_char[12]                   = "dual-way same-bank read";
                                test_case_char[13]                   = "dual-way same-bank write and read";
                                test_case_char[14]                   = "dual-way same-set read";
                                test_case_char[15]                   = "dual-way same-set write and read";
    

    //case 0 ~ case 7
    for (test_gen = 0; test_gen < 4; test_gen = test_gen + 1'b1)
    begin                             
                                
        #(`FULL_CYCLE_DELAY * 2)    reset_in                             = 1'b1;
        #(`FULL_CYCLE_DELAY)        reset_in                             = 1'b0;
    
        //case 0
                                    test_phase                           <= 0;
                                    test_way1_enable                     <= 1;
                                    test_way2_enable                     <= 0;
    
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/sim_main_mem"};
        $readmemb(mem_image_path, sim_main_memory);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_request_pool"};
        $readmemb(mem_image_path, way1_packet_issue);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_1);
        
        #(`FULL_CYCLE_DELAY * 2000) test_judge                           = (test_hit_1 == (`MEM_SIZE) / 2)? 1 : 0;
        
//        test_case_content = {"                      ", test_case_char[test_case]};
        test_case_content = {test_case_char[test_case]};
        $display("[info-testbench] test case %d\t%s : \t%s", test_case, test_case_content, test_judge? "passed" : "failed");

        
         //case 1 (phase 1)
                                     test_phase                           <= 1;
         #(`FULL_CYCLE_DELAY)        test_case                            <= test_case + 1'b1;
         #(`FULL_CYCLE_DELAY)        reset_in                             = 1'b1;
         #(`FULL_CYCLE_DELAY)        reset_in                             = 1'b0;
         
                                     test_way1_enable                     <= 1;
                                     test_way2_enable                     <= 0;
         
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/sim_main_mem"};
        $readmemb(mem_image_path, sim_main_memory);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_request_pool"};
        $readmemb(mem_image_path, way1_packet_issue);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_1);     
    
        #(`FULL_CYCLE_DELAY * 2000) test_judge = (test_hit_1 == (`MEM_SIZE) / 4)? 1 : 0;
        
        test_case_content = {" (latency : 2 cycles)   ", test_case_char[test_case]};
        $display("[info-testbench] test case %d\t%s : \t%s", test_case, test_case_content, test_judge? "passed" : "failed");

         
         //case 1 (phase 2)
                                    test_phase                           <= 2;

                                        
        #(`FULL_CYCLE_DELAY)        reset_in                             = 1'b1;
        #(`FULL_CYCLE_DELAY)        reset_in                             = 1'b0;
                                    
                                    test_way1_enable                     <= 1;
                                    test_way2_enable                     <= 0;         

        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/sim_main_mem"};
        $readmemb(mem_image_path, sim_main_memory);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_request_pool"};
        $readmemb(mem_image_path, way1_packet_issue);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_1); 
        
    
        #(`FULL_CYCLE_DELAY * 16000) test_judge = (test_hit_1 == (`MEM_SIZE) / 4)? 1 : 0;
        
        test_case_content = {" (latency : 200 cycles) ", test_case_char[test_case]};
        $display("[info-testbench] test case %d\t%s : \t%s", test_case,test_case_content, test_judge? "passed" : "failed");
        
        test_case                                                        <= test_case + 1'b1;
    end
     
    //case 8 ~ case 15
    for (test_gen = 4; test_gen < 8; test_gen = test_gen + 1'b1)
    begin  
        //case 8
                                     test_phase                          <= 0;
        
         #(`FULL_CYCLE_DELAY)        reset_in                            = 1'b1;
         #(`FULL_CYCLE_DELAY)        reset_in                            = 1'b0;
    
                                     test_way1_enable                    <= 1;
                                     test_way2_enable                    <= 1;
    
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/sim_main_mem"};
        $readmemb(mem_image_path, sim_main_memory);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_request_pool"};
        $readmemb(mem_image_path, way1_packet_issue);

        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_1);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way2_request_pool"};
        $readmemb(mem_image_path, way2_packet_issue);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way2_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_2); 
        
        #(`FULL_CYCLE_DELAY * 2000) test_judge = (test_hit_1 == (`MEM_SIZE) / 2 && test_hit_2 == (`MEM_SIZE) / 2)? 1 : 0;
        
        test_case_content = {test_case_char[test_case]};
        $display("[info-testbench] test case %d\t%s : \t%s", test_case, test_case_content, test_judge? "passed" : "failed");

        
        //case 9 (phase 1)
                                    test_phase                          <= 1;
                                    test_case                           <= test_case + 1'b1;
        
        #(`FULL_CYCLE_DELAY)        reset_in                            = 1'b1;
        #(`FULL_CYCLE_DELAY)        reset_in                            = 1'b0;
        
                                    test_way1_enable                    <= 1;
                                    test_way2_enable                    <= 1;
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/sim_main_mem"};
        $readmemb(mem_image_path, sim_main_memory);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_request_pool"};
        $readmemb(mem_image_path, way1_packet_issue);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_1);     
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way2_request_pool"};
        $readmemb(mem_image_path, way2_packet_issue);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way2_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_2); 

        #(`FULL_CYCLE_DELAY * 2000) test_judge = (test_hit_1 == (`MEM_SIZE) / 4 && test_hit_2 == (`MEM_SIZE) / 4)? 1 : 0;
        
        test_case_content = {" (latency : 2 cycles)   ", test_case_char[test_case]};
        $display("[info-testbench] test case %d\t%s : \t%s", test_case, test_case_content, test_judge? "passed" : "failed");

        
        //case 9 (phase 2)
                                    test_phase                         <= 2;
                                        
        #(`FULL_CYCLE_DELAY)        reset_in                           = 1'b1;
        #(`FULL_CYCLE_DELAY)        reset_in                           = 1'b0;
        
                                    test_way1_enable                   <= 1;
                                    test_way2_enable                   <= 1;

        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/sim_main_mem"};
        $readmemb(mem_image_path, sim_main_memory);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_request_pool"};
        $readmemb(mem_image_path, way1_packet_issue);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way1_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_1);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way2_request_pool"};
        $readmemb(mem_image_path, way2_packet_issue);
        
        mem_image_path = {`MEM_IMAGE_DIR, "/unified_cache/case_", test_gen_char[test_case], "/way2_correct_result_mem"};
        $readmemb(mem_image_path, correct_result_mem_2);  
    
        #(`FULL_CYCLE_DELAY * 16000) test_judge = ((test_hit_1 == ((`MEM_SIZE)) / 4)) && (test_hit_2 == ((`MEM_SIZE) / 4))? 1 : 0;
        
        test_case_content = {" (latency : 200 cycles) ", test_case_char[test_case]};
        $display("[info-testbench] test case %d\t%s : \t%s", test_case, test_case_content, test_judge? "passed" : "failed");
        
        test_case                                                        <= test_case + 1'b1;
    end
 
 
     #(`FULL_CYCLE_DELAY * 3000)  $display("\n[info-testbench] simulation for %m comes to the end\n");
                                  $finish;

end

unified_cache
#(
    .NUM_INPUT_PORT(2),
    .NUM_BANK(4),
    .UNIFIED_CACHE_PACKET_WIDTH_IN_BITS(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS)
)
unified_cache
(
    .reset_in                       (reset_in),
    .clk_in                         (clk_in),

    .input_packet_flatted_in        ({way2_packet_to_cache, way1_packet_to_cache}),
    .input_packet_ack_flatted_out   ({way2_packet_ack_from_cache, way1_packet_ack_from_cache}),
    
    .return_packet_flatted_out      ({way2_packet_from_cache, way1_packet_from_cache}),
    .return_packet_ack_flatted_in   ({way2_packet_ack_to_cache, way1_packet_ack_to_cache}),

    .from_mem_packet_in             (mem_packet_to_cache),
    .from_mem_packet_ack_out        (mem_packet_ack_from_cache),

    .to_mem_packet_out              (mem_packet_from_cache),
    .to_mem_packet_ack_in           (mem_packet_ack_to_cache)
);
//unified_cache
//#(
//    .NUM_INPUT_PORT(2),
//    .NUM_BANK(4),
//    .UNIFIED_CACHE_PACKET_WIDTH_IN_BITS(`UNIFIED_CACHE_PACKET_WIDTH_IN_BITS)
//)
//unified_cache
//(
//    .reset                       (reset_in),
//    .clock                         (clk_in),
//
//    .io_input_packet_flatted_in        ({way2_packet_to_cache, way1_packet_to_cache}),
//    .io_input_packet_ack_flatted_out   ({way2_packet_ack_from_cache, way1_packet_ack_from_cache}),
//    
//    .io_return_packet_flatted_out      ({way2_packet_from_cache, way1_packet_from_cache}),
//    .io_return_packet_ack_flatted_in   ({way2_packet_ack_to_cache, way1_packet_ack_to_cache}),
//
//    .io_from_mem_packet_in             (mem_packet_to_cache),
//    .io_from_mem_packet_ack_out        (mem_packet_ack_from_cache),
//
//    .io_to_mem_packet_out              (mem_packet_from_cache),
//    .io_to_mem_packet_ack_in           (mem_packet_ack_to_cache)
//);

endmodule

