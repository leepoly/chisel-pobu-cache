/*`timescale 10ns/1ns
`include "sim_addr.h"
`include "parameters.h"

module sim_testbench();

reg                                                                 clk_in;
reg                                                                 reset_in;

reg     [(`BYTE_LEN_IN_BITS)                - 1 : 0]                sim_main_memory_reg  [(`MEM_SIZE) - 1 : 0];

reg     [(`OFF_CORE_ACCESS_WIDTH_IN_BITS)   - 1 : 0]                payload_from_sim_main_memory_to_cpu_reg;
reg                                                                 payload_from_sim_main_memory_to_cpu_ready_reg;
wire    [(`CPU_WORD_LEN_IN_BITS)            - 1 : 0]                payload_addr_from_cpu_to_main_memory;
wire                                                                payload_addr_from_cpu_to_main_memory_valid;

generate
    genvar i;
    for(i = 0; i < (`OFF_CORE_ACCESS_WIDTH_IN_BYTES); i = i + 1)
    begin : payload_delivery
        always@(posedge clk_in, posedge reset_in)
        begin
            if(reset_in)
            begin
                payload_from_sim_main_memory_to_cpu_reg[(i+1) * (`BYTE_LEN_IN_BITS) - 1 : i * (`BYTE_LEN_IN_BITS)]  <= {(`BYTE_LEN_IN_BITS){1'b0}};
                payload_from_sim_main_memory_to_cpu_ready_reg                                                       <= 1'b0;
            end
            
            else if(payload_addr_from_cpu_to_main_memory_valid)
            begin
                payload_from_sim_main_memory_to_cpu_reg[(i+1) * (`BYTE_LEN_IN_BITS) - 1 : i * (`BYTE_LEN_IN_BITS)]  <= sim_main_memory_reg[payload_addr_from_cpu_to_main_memory - (`MEM_OFFSET) + i];
                payload_from_sim_main_memory_to_cpu_ready_reg                                                       <= 1'b1;
            end
        end
    end
endgenerate

pumpkin_cpu_top pumpkin_cpu
(
    .clk_in                             (clk_in),
    .reset_in                           (reset_in),
    .off_core_access_payload_inout      (payload_from_sim_main_memory_to_cpu_reg),
    .off_core_access_ready_inout        (payload_from_sim_main_memory_to_cpu_ready_reg),
    .off_core_access_addr_inout         (payload_addr_from_cpu_to_main_memory), 
    .off_core_access_addr_valid_inout   (payload_addr_from_cpu_to_main_memory_valid),
    .off_core_access_is_write_out       (payload_is_write),
    .inout_ctrl_out                     (inout_ctrl)
);


initial
begin
        $display("simulation start!");
        $readmemh(`MEM_FILE_PATH, sim_main_memory_reg);
        `ifdef VCS
        $fsdbDumpvars(0, pumpkin_cpu,"+fsdbfile+result.fsdb");
        `endif
        clk_in   = 1'b0;
        reset_in = 1'b0;
#1      reset_in = 1'b1;
#1      reset_in = 1'b0;
#30     $finish;
end

always begin #1 clk_in <= ~clk_in; end;

