module autocat
#(
    parameter CACHE_ASSOCIATIVITY = 16, // currently only support 16-way fix configuration
    parameter COUNTER_WIDTH       = 32,
    parameter RESET_BIN_POWER     = 20,  // 2^20 is about 1M requests
    parameter ALLOWED_GAP         = 500
)
(
    input                                                       clk_in,
    input                                                       reset_in,

    input                                                       access_valid_in,
    input      [CACHE_ASSOCIATIVITY                 - 1 : 0]    hit_vec_in,

    output reg [CACHE_ASSOCIATIVITY                 - 1 : 0]    suggested_waymask_out
);

// overall request counter
reg                               access_valid_pre;
reg [CACHE_ASSOCIATIVITY - 1 : 0] hit_vec_pre;
reg [63                      : 0] access_counter;

wire reset_with_request_limit = reset_in | access_counter == 2 ** RESET_BIN_POWER;
wire request_limit            = access_counter == 2 ** RESET_BIN_POWER;

always@(posedge clk_in, posedge reset_with_request_limit)
begin
    if(reset_with_request_limit)
    begin
        access_counter      <= 0;
        access_valid_pre    <= 0;
        hit_vec_pre         <= 0;
    end

    else
    begin
        access_valid_pre    <= access_valid_in;
        hit_vec_pre         <= hit_vec_in;
        
        if(~access_valid_pre & access_valid_in)
            access_counter <= access_counter + 1'b1;
    end
end

wire [CACHE_ASSOCIATIVITY * COUNTER_WIDTH - 1 : 0] counter_flatted;
wire [CACHE_ASSOCIATIVITY * COUNTER_WIDTH - 1 : 0] post_sort_counter_flatted;

// hit counter array
generate
genvar gen;

for(gen = 0; gen < CACHE_ASSOCIATIVITY; gen = gen + 1)
begin
    reg [COUNTER_WIDTH - 1 : 0] hit_counter;
    assign counter_flatted[gen * COUNTER_WIDTH +: COUNTER_WIDTH] = hit_counter;

    always@(posedge clk_in, posedge reset_with_request_limit)
    begin
        if(reset_with_request_limit)
        begin
            hit_counter <= 0;
        end

        else if(~hit_vec_pre[gen] & hit_vec_in[gen])
        begin
            hit_counter <= hit_counter + 1'b1;
        end
    end
end

endgenerate

// sort all the hit counters
bitonic_sorter
#(
    .SINGLE_WAY_WIDTH_IN_BITS(COUNTER_WIDTH),
    .NUM_WAY(CACHE_ASSOCIATIVITY)
)
sorter
(
    .clk_in(clk_in),
    .reset_in(reset_in),
    .pre_sort_flatted_in(counter_flatted),
    .post_sort_flatted_out(post_sort_counter_flatted)
);

wire [CACHE_ASSOCIATIVITY * COUNTER_WIDTH - 1 : 0] post_calc_counter_flatted;
generate
    for(gen = 0; gen < CACHE_ASSOCIATIVITY; gen = gen + 1)
    begin
        assign post_calc_counter_flatted[gen * COUNTER_WIDTH +: COUNTER_WIDTH] =
               post_sort_counter_flatted[gen * COUNTER_WIDTH +: COUNTER_WIDTH] >> (RESET_BIN_POWER - 4);
    end
endgenerate

reg [COUNTER_WIDTH * CACHE_ASSOCIATIVITY - 1 : 0] accumulated_hit_counter;
integer accu_index;
always@(posedge clk_in, posedge reset_with_request_limit)
begin
    if(reset_with_request_limit)
    begin
        accumulated_hit_counter <= 0;
    end

    else
    begin
        for(accu_index = 0; accu_index < CACHE_ASSOCIATIVITY; accu_index = accu_index + 1)
        begin
            if(accu_index == 0)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 1)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 2)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 3)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 4)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 5)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 6)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 7)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 8)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[8 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 9)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[8 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[9 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 10)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[8 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[9 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[10 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 11)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[8 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[9 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[10 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[11 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 12)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[8 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[9 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[10 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[11 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[12 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 13)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[8 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[9 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[10 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[11 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[12 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[13 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 14)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[8 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[9 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[10 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[11 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[12 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[13 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[14 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end

            else if(accu_index == 15)
            begin
                accumulated_hit_counter[accu_index * COUNTER_WIDTH +: COUNTER_WIDTH] <=
                post_calc_counter_flatted[0 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[1 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[2 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[3 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[4 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[5 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[6 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[7 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[8 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[9 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[10 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[11 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[12 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[13 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[14 * COUNTER_WIDTH +: COUNTER_WIDTH] +
                post_calc_counter_flatted[15 * COUNTER_WIDTH +: COUNTER_WIDTH];
            end
        end
    end
end

integer loop_index;
reg [CACHE_ASSOCIATIVITY - 1 : 0] first_best_partition;

always@*
begin : Find
    first_best_partition  <= 0;

    for(loop_index = 0; loop_index < CACHE_ASSOCIATIVITY; loop_index = loop_index + 1)
    begin
        if(accumulated_hit_counter[loop_index * COUNTER_WIDTH +: COUNTER_WIDTH] + ALLOWED_GAP >=
           accumulated_hit_counter[(CACHE_ASSOCIATIVITY - 1) * COUNTER_WIDTH +: COUNTER_WIDTH])
        begin
            first_best_partition <= loop_index;
            disable Find; //TO exit the loop
        end
    end
end

always@(posedge clk_in, posedge reset_in)
begin
    if(reset_in)
    begin
        suggested_waymask_out <= 16'b1111_1111_1111_1111;
    end

    else if(request_limit)
    begin
        for(loop_index = 0; loop_index < CACHE_ASSOCIATIVITY; loop_index = loop_index + 1)
        begin
            if(first_best_partition >= loop_index)
                suggested_waymask_out[loop_index] <= 1'b1;
            else suggested_waymask_out[loop_index] <= 1'b0;
        end
    end
end

endmodule