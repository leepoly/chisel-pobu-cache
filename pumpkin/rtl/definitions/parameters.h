//`include "sim_config.h"

`define COD_UCAS

`ifdef COD_UCAS
    `include "parameters_cod_ucas.h"
`else
    `ifndef PARAMETERS
        `define PARAMETERS

        // General - Architecture
        `define BYTE_LEN_IN_BITS                                8
        `ifdef SIMULATION
            `define CPU_DATA_LEN_IN_BITS                        32
            `define CPU_ADDR_LEN_IN_BITS                        32
        `else
            `define CPU_DATA_LEN_IN_BITS                        64
            `define CPU_ADDR_LEN_IN_BITS                        32
        `endif
        `define CPU_INST_LEN_IN_BITS                            32

        `define NUM_INSTS_FETCH_PER_CYCLE 						4

        // General - Misc.
        `define CPU_DATA_LEN_IN_BYTES                           (`CPU_DATA_LEN_IN_BITS / `BYTE_LEN_IN_BITS)
        `define CPU_ADDR_LEN_IN_BYTES                           (`CPU_ADDR_LEN_IN_BITS / `BYTE_LEN_IN_BITS)
        `define CPU_INST_LEN_IN_BYTES                           (`CPU_INST_LEN_IN_BITS / `BYTE_LEN_IN_BITS)
        `define INSTS_FETCH_WIDTH_IN_BITS 						(`NUM_INSTS_FETCH_PER_CYCLE * `CPU_INST_LEN_IN_BITS)

        // Unified Cache - Architecture
        `define UNIFIED_CACHE_BANK_ARCHITECTURE                 "OFF" /* option: OFF, BASIC, ADVANCED*/

        `define UNIFIED_CACHE_SIZE_IN_BYTES                     128 * 1024 // Bytes, must be a power of 2
        `define UNIFIED_CACHE_SET_ASSOCIATIVITY                 8 // must be a power of 2
        `ifdef SIMULATION
            `define UNIFIED_CACHE_BLOCK_SIZE_IN_BYTES           4 // must be a power of 2, and should be small enough to avoid pin allocation failure
        `else
            `define UNIFIED_CACHE_BLOCK_SIZE_IN_BYTES           64 // must be 4 or multiplier of 8, to connect with AXI port
        `endif
        `define UNIFIED_CACHE_NUM_SETS                          (`UNIFIED_CACHE_SIZE_IN_BYTES / `UNIFIED_CACHE_SET_ASSOCIATIVITY / `UNIFIED_CACHE_BLOCK_SIZE_IN_BYTES)
        `define UNIFIED_CACHE_NUM_BANK                          4 // must be greater than num of sets, musht be a power of 2                 

        `define UNIFIED_CACHE_INPUT_QUEUE_SIZE                  2 // must be a power of 2
        `define UNIFIED_CACHE_WRITEBACK_BUFFER_SIZE             4 // must be a power of 2
        `define UNIFIED_CACHE_MISS_BUFFER_SIZE 				    8
        `define UNIFIED_CACHE_RETURN_QUEUE_SIZE 				16

        `define MAX_NUM_INPUT_PORT                              16

        // Unified Cache - Misc.
        `define UNIFIED_CACHE_BLOCK_SIZE_IN_BITS                (`UNIFIED_CACHE_BLOCK_SIZE_IN_BYTES * `BYTE_LEN_IN_BITS)
        `define UNIFIED_CACHE_BLOCK_OFFSET_LEN_IN_BITS          ($clog2(`UNIFIED_CACHE_BLOCK_SIZE_IN_BYTES))
        `define UNIFIED_CACHE_BLOCK_OFFSET_POS_HI               (`UNIFIED_CACHE_BLOCK_OFFSET_LEN_IN_BITS - 1)
        `define UNIFIED_CACHE_BLOCK_OFFSET_POS_LO               0
        `define UNIFIED_CACHE_INDEX_LEN_IN_BITS                 ($clog2(`UNIFIED_CACHE_SIZE_IN_BYTES / `UNIFIED_CACHE_BLOCK_SIZE_IN_BYTES / `UNIFIED_CACHE_SET_ASSOCIATIVITY))
        `define UNIFIED_CACHE_INDEX_POS_HI                      (`UNIFIED_CACHE_BLOCK_OFFSET_LEN_IN_BITS + `UNIFIED_CACHE_INDEX_LEN_IN_BITS - 1)
        `define UNIFIED_CACHE_INDEX_POS_LO                      (`UNIFIED_CACHE_BLOCK_OFFSET_LEN_IN_BITS)
        `define UNIFIED_CACHE_TAG_LEN_IN_BITS                   (`CPU_ADDR_LEN_IN_BITS - `UNIFIED_CACHE_BLOCK_OFFSET_LEN_IN_BITS - `UNIFIED_CACHE_INDEX_LEN_IN_BITS)
        `define UNIFIED_CACHE_TAG_POS_HI                        (`UNIFIED_CACHE_BLOCK_OFFSET_LEN_IN_BITS + `UNIFIED_CACHE_INDEX_LEN_IN_BITS + `UNIFIED_CACHE_TAG_LEN_IN_BITS - 1)
        `define UNIFIED_CACHE_TAG_POS_LO                        (`UNIFIED_CACHE_BLOCK_OFFSET_LEN_IN_BITS + `UNIFIED_CACHE_INDEX_LEN_IN_BITS)

        `define UNIFIED_CACHE_PACKET_BYTE_MASK_LEN              (`UNIFIED_CACHE_BLOCK_SIZE_IN_BYTES)
        `define UNIFIED_CACHE_PACKET_PORT_ID_WIDTH              ($clog2(`MAX_NUM_INPUT_PORT) + 1)
        `define UNIFIED_CACHE_PACKET_TYPE_WIDTH                 4 // must be greater than 4

        // Unified Cache - Type Info
        `define TYPE_INST_LOAD                                	((`UNIFIED_CACHE_PACKET_TYPE_WIDTH)'b1000)
        `define TYPE_DATA_LOAD                                	((`UNIFIED_CACHE_PACKET_TYPE_WIDTH)'b0001)
        `define TYPE_DATA_PREFETCH_FROM_L1D 					((`UNIFIED_CACHE_PACKET_TYPE_WIDTH)'b0010)
        `define TYPE_DATA_RFO 									((`UNIFIED_CACHE_PACKET_TYPE_WIDTH)'b0011)
        `define TYPE_DATA_WRITEBACK 							((`UNIFIED_CACHE_PACKET_TYPE_WIDTH)'b0100)

        // Unified Cache - Packet
        `define UNIFIED_CACHE_PACKET_ADDR_POS_LO                0
        `define UNIFIED_CACHE_PACKET_ADDR_POS_HI                (`UNIFIED_CACHE_PACKET_ADDR_POS_LO  + `CPU_ADDR_LEN_IN_BITS - 1)
        `define UNIFIED_CACHE_PACKET_DATA_POS_LO                (`UNIFIED_CACHE_PACKET_ADDR_POS_HI  + 1)
        `define UNIFIED_CACHE_PACKET_DATA_POS_HI                (`UNIFIED_CACHE_PACKET_DATA_POS_LO  + `UNIFIED_CACHE_BLOCK_SIZE_IN_BITS - 1)
        `define UNIFIED_CACHE_PACKET_TYPE_POS_LO                (`UNIFIED_CACHE_PACKET_DATA_POS_HI  + 1)
        `define UNIFIED_CACHE_PACKET_TYPE_POS_HI                (`UNIFIED_CACHE_PACKET_TYPE_POS_LO  + `UNIFIED_CACHE_PACKET_TYPE_WIDTH - 1)
        `define UNIFIED_CACHE_PACKET_BYTE_MASK_POS_LO           (`UNIFIED_CACHE_PACKET_TYPE_POS_HI  + 1)
        `define UNIFIED_CACHE_PACKET_BYTE_MASK_POS_HI           (`UNIFIED_CACHE_PACKET_BYTE_MASK_POS_LO + `UNIFIED_CACHE_PACKET_BYTE_MASK_LEN - 1)
        `define UNIFIED_CACHE_PACKET_PORT_NUM_LO                (`UNIFIED_CACHE_PACKET_BYTE_MASK_POS_HI + 1)
        `define UNIFIED_CACHE_PACKET_PORT_NUM_HI                (`UNIFIED_CACHE_PACKET_PORT_NUM_LO  + `UNIFIED_CACHE_PACKET_PORT_ID_WIDTH - 1)
        `define UNIFIED_CACHE_PACKET_VALID_POS                  (`UNIFIED_CACHE_PACKET_PORT_NUM_HI  + 1)
        `define UNIFIED_CACHE_PACKET_IS_WRITE_POS               (`UNIFIED_CACHE_PACKET_VALID_POS    + 1)
        `define UNIFIED_CACHE_PACKET_CACHEABLE_POS              (`UNIFIED_CACHE_PACKET_IS_WRITE_POS + 1)

        `define UNIFIED_CACHE_PACKET_WIDTH_IN_BITS              (`UNIFIED_CACHE_PACKET_CACHEABLE_POS - `UNIFIED_CACHE_PACKET_ADDR_POS_LO + 1)
    `endif
`endif

