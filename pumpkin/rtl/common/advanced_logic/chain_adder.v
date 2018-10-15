// with 8 elements, this module will be syntheWIDTHd into 4-layer of logic
module chain_adder
#(
    parameter NUM_WAY                   = 16, // currently support 16-elements at most
	parameter WAY_PTR_WIDTH_IN_BITS     = $clog2(NUM_WAY) + 1,
	parameter SINGLE_WAY_WIDTH_IN_BITS  = 4
)
(
	input  [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY     - 1 : 0]	way_flatted_in,
    input  [NUM_WAY                                - 1 : 0] condition_in,
	output [SINGLE_WAY_WIDTH_IN_BITS               - 1 : 0]	select_out
);

generate
    genvar i;
    wire [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY - 1 : 0] values_layer1;

    if(NUM_WAY != 0)
    begin : layer1
        for(i = 0; i < NUM_WAY; i = i + 1)
        begin
            assign values_layer1[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS] =
            	    condition_in[i] ? way_flatted_in[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS] : {SINGLE_WAY_WIDTH_IN_BITS{1'b0}};
        end
    end
endgenerate

generate
    wire [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY / 2 - 1 : 0] values_layer2;

    if(NUM_WAY / 2 > 0)
    begin : layer2
        for(i = 0; i < NUM_WAY / 2; i = i + 1)
        begin
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value1 = values_layer1[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value2 = values_layer1[(i + (NUM_WAY / 2)) * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];

            assign values_layer2[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS] = value1 > value2 ? value1 : value2;
        end
    end

    else if(NUM_WAY == 1)
    begin
    	assign select_out = way_flatted_in[ptrs_layer1[1 * WAY_PTR_WIDTH_IN_BITS - 1 : 0] * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
    end
endgenerate

generate
    wire [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY / 4 - 1 : 0] values_layer3;
    wire [WAY_PTR_WIDTH_IN_BITS    * NUM_WAY / 4 - 1 : 0]   ptrs_layer3;

    if(NUM_WAY / 4 > 0)
    begin : layer3
        for(i = 0; i < NUM_WAY / 4; i = i + 1)
        begin
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value1 = values_layer2[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value2 = values_layer2[(i + (NUM_WAY / 4)) * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire    [WAY_PTR_WIDTH_IN_BITS - 1 : 0]   ptr1 =   ptrs_layer2[i * WAY_PTR_WIDTH_IN_BITS +: WAY_PTR_WIDTH_IN_BITS];
            wire    [WAY_PTR_WIDTH_IN_BITS - 1 : 0]   ptr2 =   ptrs_layer2[(i + (NUM_WAY / 4)) * WAY_PTR_WIDTH_IN_BITS +: WAY_PTR_WIDTH_IN_BITS];

            assign values_layer3[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS] = value1 > value2 ? value1 : value2;
            assign   ptrs_layer3[i * WAY_PTR_WIDTH_IN_BITS    +: WAY_PTR_WIDTH_IN_BITS]    = value1 > value2 ? ptr1 : ptr2;
        end
    end

    else if(NUM_WAY == 2)
    begin
    	assign select_out = way_flatted_in[ptrs_layer2[1 * WAY_PTR_WIDTH_IN_BITS - 1 : 0] * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
    end
endgenerate

generate
    wire [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY / 8 - 1 : 0] values_layer4;
    wire     [WAY_PTR_WIDTH_IN_BITS * NUM_WAY / 8 - 1 : 0]   ptrs_layer4;

    if(NUM_WAY / 8 > 0)
    begin : layer4
        for(i = 0; i < NUM_WAY / 8; i = i + 1)
        begin
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value1 = values_layer3[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value2 = values_layer3[(i + (NUM_WAY / 8)) * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire     [WAY_PTR_WIDTH_IN_BITS - 1 : 0]   ptr1 =   ptrs_layer3[i * WAY_PTR_WIDTH_IN_BITS +: WAY_PTR_WIDTH_IN_BITS];
            wire     [WAY_PTR_WIDTH_IN_BITS - 1 : 0]   ptr2 =   ptrs_layer3[(i + (NUM_WAY / 8)) * WAY_PTR_WIDTH_IN_BITS +: WAY_PTR_WIDTH_IN_BITS];

            assign values_layer4[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS] = value1 > value2 ? value1 : value2;
            assign   ptrs_layer4[i * WAY_PTR_WIDTH_IN_BITS    +: WAY_PTR_WIDTH_IN_BITS]    = value1 > value2 ?   ptr1 : ptr2;
        end
    end

    else if(NUM_WAY == 4)
    begin
    	assign select_out = way_flatted_in[ptrs_layer3[1 * WAY_PTR_WIDTH_IN_BITS - 1 : 0] * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
    end
endgenerate

generate
    wire [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY / 16 - 1 : 0] values_layer5;
    wire     [WAY_PTR_WIDTH_IN_BITS * NUM_WAY / 16 - 1 : 0]   ptrs_layer5;

    if(NUM_WAY / 16 > 0)
    begin : layer5
        for(i = 0; i < NUM_WAY / 16; i = i + 1)
        begin
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value1 = values_layer4[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value2 = values_layer4[(i + (NUM_WAY / 16)) * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire    [WAY_PTR_WIDTH_IN_BITS - 1 : 0]   ptr1 =   ptrs_layer4[i * WAY_PTR_WIDTH_IN_BITS +: WAY_PTR_WIDTH_IN_BITS];
            wire    [WAY_PTR_WIDTH_IN_BITS - 1 : 0]   ptr2 =   ptrs_layer4[(i + (NUM_WAY / 16)) * WAY_PTR_WIDTH_IN_BITS +: WAY_PTR_WIDTH_IN_BITS];

            assign values_layer5[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS] = value1 > value2 ? value1 : value2;
            assign   ptrs_layer5[i * WAY_PTR_WIDTH_IN_BITS    +: WAY_PTR_WIDTH_IN_BITS]    = value1 > value2 ?   ptr1 : ptr2;
        end
    end

    else if(NUM_WAY == 8)
    begin
    	assign select_out = way_flatted_in[ptrs_layer4[1 * WAY_PTR_WIDTH_IN_BITS - 1 : 0] * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
    end
endgenerate

generate
    wire [SINGLE_WAY_WIDTH_IN_BITS * NUM_WAY / 32 - 1 : 0] values_layer6;
    wire     [WAY_PTR_WIDTH_IN_BITS * NUM_WAY / 32 - 1 : 0]   ptrs_layer6;

    if(NUM_WAY / 32 > 0)
    begin : layer6
        for(i = 0; i < NUM_WAY / 32; i = i + 1)
        begin
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value1 = values_layer5[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire [SINGLE_WAY_WIDTH_IN_BITS - 1 : 0] value2 = values_layer5[(i + (NUM_WAY / 32)) * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
        	wire     [WAY_PTR_WIDTH_IN_BITS - 1 : 0]   ptr1 =   ptrs_layer5[i * WAY_PTR_WIDTH_IN_BITS +: WAY_PTR_WIDTH_IN_BITS];
            wire     [WAY_PTR_WIDTH_IN_BITS - 1 : 0]   ptr2 =   ptrs_layer5[(i + (NUM_WAY / 32)) * WAY_PTR_WIDTH_IN_BITS +: WAY_PTR_WIDTH_IN_BITS];

            assign values_layer6[i * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS] = value1 > value2 ? value1 : value2;
            assign   ptrs_layer6[i * WAY_PTR_WIDTH_IN_BITS    +: WAY_PTR_WIDTH_IN_BITS]    = value1 > value2 ?   ptr1 : ptr2;
        end
    end

    else if(NUM_WAY == 16)
    begin
    	assign select_out = way_flatted_in[ptrs_layer5[1 * WAY_PTR_WIDTH_IN_BITS - 1 : 0] * SINGLE_WAY_WIDTH_IN_BITS +: SINGLE_WAY_WIDTH_IN_BITS];
    end
endgenerate

endmodule
