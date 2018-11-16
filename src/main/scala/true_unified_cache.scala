import chisel3._
import chisel3.util._
import chisel3.experimental._

//To open it, execute in shell "sbt 'runMain bDriver'"

//priority_arbiter blackbox has been predefined in unified_cache_bank.scala
/*
class unified_cache_bank(
  val NUM_INPUT_PORT: Int = 2,
  val NUM_SET: Int = 4, 
  val NUM_WAY: Int = 4,
  val BLOCK_SIZE_IN_BYTES: Int = 4,
  val BANK_NUM: Int = 0,
  val MODE: String = "OFF",
  val UNIFIED_CACHE_PACKET_WIDTH_IN_BITS: Int = 32
  ) extends BlackBox(Map("NUM_INPUT_PORT" -> NUM_INPUT_PORT,
                         "NUM_SET" -> NUM_SET,
                         "NUM_WAY" -> NUM_WAY,
                         "BLOCK_SIZE_IN_BYTES" -> BLOCK_SIZE_IN_BYTES,
                         "BANK_NUM" -> BANK_NUM,
                         "MODE" -> MODE,
                         "UNIFIED_CACHE_PACKET_WIDTH_IN_BITS" -> UNIFIED_CACHE_PACKET_WIDTH_IN_BITS,
                         "BLOCK_SIZE_IN_BITS" -> BLOCK_SIZE_IN_BYTES * 8,
                         "SET_PTR_WIDTH_IN_BITS" -> log2Up(NUM_SET)))  {
      val io = IO(new Bundle {
        val clk_in = Input(Clock())
        val reset_in = Input(Bool())

        val input_request_flatted_in = Input(UInt((NUM_INPUT_PORT * UNIFIED_CACHE_PACKET_WIDTH_IN_BITS).W))
        val input_request_valid_flatted_in  = Input(UInt(NUM_INPUT_PORT.W))
        val input_request_critical_flatted_in = Input(UInt(NUM_INPUT_PORT.W))
        val input_request_ack_out = Output(UInt(NUM_INPUT_PORT.W))

        val fetched_request_in = Input(UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W))
        val fetched_request_valid_in = Input(UInt(1.W))
        val fetch_ack_out = Output(UInt(1.W))

        val miss_request_out = Output(UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W))
        val miss_request_valid_out = Output(UInt(1.W))
        val miss_request_critical_out = Output(UInt(1.W))
        val miss_request_ack_in = Input(UInt(1.W))

        val writeback_request_out = Output(UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W))
        val writeback_request_valid_out = Output(UInt(1.W))
        val writeback_request_critical_out = Output(UInt(1.W))
        val writeback_request_ack_in = Input(UInt(1.W))

        val return_request_out = Output(UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W))
        val return_request_valid_out = Output(UInt(1.W))
        val return_request_critical_out = Output(UInt(1.W))
        val return_request_ack_in = Input(UInt(1.W))
     })
  }
*/
/*class priority_arbiter(
  val SINGLE_REQUEST_WIDTH_IN_BITS: Int = 64,
  val NUM_REQUEST: Int = 3,
  val INPUT_QUEUE_SIZE: Int = 2
  ) extends BlackBox(Map("SINGLE_REQUEST_WIDTH_IN_BITS" -> SINGLE_REQUEST_WIDTH_IN_BITS,
                                  "NUM_REQUEST" -> NUM_REQUEST,
                                  "INPUT_QUEUE_SIZE" -> INPUT_QUEUE_SIZE))  {
      val io = IO(new Bundle {
        val reset_in = Input(Bool())
        val clk_in = Input(Clock())

        val request_flatted_in = Input(UInt((SINGLE_REQUEST_WIDTH_IN_BITS * NUM_REQUEST).W))
        val request_valid_flatted_in = Input(UInt(NUM_REQUEST.W))
        val request_critical_flatted_in = Input(UInt(NUM_REQUEST.W))
        val issue_ack_out = Output(UInt(NUM_REQUEST.W))
        val request_out = Output(UInt(SINGLE_REQUEST_WIDTH_IN_BITS.W))
        val request_valid_out = Output(UInt(1.W))
        val issue_ack_in = Input(UInt(1.W))
     })
  }*/

/*class fifo_queue(
  val QUEUE_SIZE: Int = 16,
  val QUEUE_PTR_WIDTH_IN_BITS: Int = 4,
  val SINGLE_ENTRY_WIDTH_IN_BITS: Int = 32,
  val STORAGE_TYPE: String = "LUTRAM"
  ) extends BlackBox(Map("QUEUE_SIZE" -> QUEUE_SIZE,
                         "QUEUE_PTR_WIDTH_IN_BITS" -> QUEUE_PTR_WIDTH_IN_BITS,
                         "SINGLE_ENTRY_WIDTH_IN_BITS" -> SINGLE_ENTRY_WIDTH_IN_BITS,
                         "STORAGE_TYPE" -> STORAGE_TYPE))  {
      val io = IO(new Bundle {
        val clk_in = Input(Clock())
        val reset_in = Input(Bool())
        val is_empty_out = Output(UInt(1.W))
        val is_full_out = Output(UInt(1.W))
        val request_in = Input(UInt(SINGLE_ENTRY_WIDTH_IN_BITS.W))
        val request_valid_in = Input(UInt(1.W))
        val issue_ack_out = Output(UInt(1.W))
        val request_out = Output(UInt(SINGLE_ENTRY_WIDTH_IN_BITS.W))
        val request_valid_out = Output(UInt(1.W))
        val issue_ack_in = Input(UInt(1.W))
     })
  }*/

class true_unified_cache(
  val NUM_INPUT_PORT: Int = 2,
  val NUM_SET: Int = 64, 
  val NUM_BANK: Int = 4,
  val NUM_WAY: Int = 4,
  val BLOCK_SIZE_IN_BYTES: Int = 4,
  val UNIFIED_CACHE_PACKET_WIDTH_IN_BITS: Int = 80,
  val PORT_ID_WIDTH: Int = 2, 
  val BANK_BITS: Int = 2
  ) extends Module {
  val io = IO(new Bundle {
    val input_packet_flatted_in = Input(UInt((NUM_INPUT_PORT * UNIFIED_CACHE_PACKET_WIDTH_IN_BITS).W))
    val input_packet_ack_flatted_out = Output(UInt(NUM_INPUT_PORT.W))
    val return_packet_flatted_out = Output(UInt((NUM_INPUT_PORT * UNIFIED_CACHE_PACKET_WIDTH_IN_BITS).W))
    val return_packet_ack_flatted_in = Input(UInt(NUM_INPUT_PORT.W))
    val from_mem_packet_in = Input(UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W))
    val from_mem_packet_ack_out = Output(UInt(1.W))
    val to_mem_packet_out = Output(UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W))
    val to_mem_packet_ack_in = Input(UInt(1.W))
  })

  //parameters defining
  // val h_UNIFIED_CACHE_PACKET_WIDTH_IN_BITS = 620 //80
  // val h_UNIFIED_CACHE_INPUT_QUEUE_SIZE = 4 //4
  // val h_UNIFIED_CACHE_PACKET_VALID_POS = 617 //77
  // val h_CPU_ADDR_LEN_IN_BITS = 32 //32
  // val h_UNIFIED_CACHE_INDEX_POS_LO = 6 //2
  // val h_UNIFIED_CACHE_PACKET_ADDR_POS_LO = 0 //0
  // val h_UNIFIED_CACHE_PACKET_ADDR_POS_HI = 31 //31
  // val h_UNIFIED_CACHE_PACKET_PORT_NUM_LO = 612 //72
  //SIMULATION MODE
  val h_UNIFIED_CACHE_PACKET_WIDTH_IN_BITS = 80
  val h_UNIFIED_CACHE_INPUT_QUEUE_SIZE = 4
  val h_UNIFIED_CACHE_PACKET_VALID_POS = 77
  val h_CPU_ADDR_LEN_IN_BITS = 32
  val h_UNIFIED_CACHE_INDEX_POS_LO = 2
  val h_UNIFIED_CACHE_PACKET_ADDR_POS_LO = 0
  val h_UNIFIED_CACHE_PACKET_ADDR_POS_HI = 31
  val h_UNIFIED_CACHE_PACKET_PORT_NUM_LO = 72


  val input_packet_ack_flatted_out_vec = Wire(Vec(NUM_INPUT_PORT, UInt(1.W)))
  val return_packet_flatted_out_vec = Wire(Vec(NUM_INPUT_PORT, UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W)))

  val input_packet_packed = Wire(Vec(NUM_INPUT_PORT, UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W)))
  val is_input_queue_full_flatted = Wire(Vec(NUM_INPUT_PORT, UInt(1.W)))
  val input_packet_to_cache_packed = Wire(Vec(NUM_INPUT_PORT, UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W)))
  val input_packet_to_cache_flatted = Wire(Vec(NUM_INPUT_PORT, UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W)))
  val input_packet_valid_to_cache_flatted = Wire(Vec(NUM_INPUT_PORT, UInt(1.W)))
  val input_packet_critical_to_cache_flatted = Wire(Vec(NUM_INPUT_PORT, UInt(1.W)))
  val cache_to_input_queue_ack_merged = Wire(Vec(NUM_INPUT_PORT, UInt(1.W)))

  val input_queue_vec = Vec.fill(NUM_INPUT_PORT) {Module(new fifo_queue(h_UNIFIED_CACHE_INPUT_QUEUE_SIZE, log2Up(h_UNIFIED_CACHE_INPUT_QUEUE_SIZE), UNIFIED_CACHE_PACKET_WIDTH_IN_BITS)).io }
  for (port_index <- 0 until NUM_INPUT_PORT) {
    //input_queue_vec(port_index).clk_in := clock
    //input_queue_vec(port_index).reset_in := reset.toBool

    input_packet_packed(port_index) := io.input_packet_flatted_in((port_index + 1) * UNIFIED_CACHE_PACKET_WIDTH_IN_BITS - 1, port_index * UNIFIED_CACHE_PACKET_WIDTH_IN_BITS)
    is_input_queue_full_flatted(port_index) := input_queue_vec(port_index).is_full_out
    input_queue_vec(port_index).request_in := input_packet_packed(port_index)
    input_queue_vec(port_index).request_valid_in := input_packet_packed(port_index)(h_UNIFIED_CACHE_PACKET_VALID_POS)
    input_packet_ack_flatted_out_vec(port_index) := input_queue_vec(port_index).issue_ack_out
    input_packet_to_cache_packed(port_index) := input_queue_vec(port_index).request_out
    input_packet_valid_to_cache_flatted(port_index) := input_queue_vec(port_index).request_valid_out
    input_queue_vec(port_index).issue_ack_in := cache_to_input_queue_ack_merged(port_index)


    input_packet_critical_to_cache_flatted(port_index) := is_input_queue_full_flatted(port_index)
    input_packet_to_cache_flatted(port_index) := input_packet_to_cache_packed(port_index)
  }

  val cache_to_input_queue_ack_flatted = Wire(Vec(NUM_BANK, UInt(NUM_INPUT_PORT.W)))
  val from_mem_packet_ack_flatted = Wire(Vec(NUM_BANK, UInt(1.W)))
  val miss_request_flatted = Wire(Vec(NUM_BANK, UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W)))
  val miss_request_valid_flatted = Wire(Vec(NUM_BANK, UInt(1.W)))
  val miss_request_critical_flatted = Wire(Vec(NUM_BANK, UInt(1.W)))
  val miss_request_ack_flatted = Wire(UInt(NUM_BANK.W))

  val writeback_request_flatted = Wire(Vec(NUM_BANK, UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W)))
  val writeback_request_valid_flatted = Wire(Vec(NUM_BANK, UInt(1.W)))
  val writeback_request_critical_flatted = Wire(Vec(NUM_BANK, UInt(1.W)))
  val writeback_request_ack_flatted = Wire(UInt(NUM_BANK.W))

  val return_request_flatted = Wire(Vec(NUM_BANK, UInt(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W)))
  val return_request_valid_flatted = Wire(Vec(NUM_BANK, UInt(1.W)))
  val return_request_critical_flatted = Wire(Vec(NUM_BANK, UInt(1.W)))
  val return_request_ack_merged = Wire(Vec(NUM_BANK, UInt(1.W)))

  for (bank_index <- 0 until NUM_BANK) {
    val input_full_addr = Wire(Vec(NUM_INPUT_PORT, UInt(h_CPU_ADDR_LEN_IN_BITS.W)))
    val input_is_right_bank = Wire(Vec(NUM_INPUT_PORT, UInt(1.W)))
    val input_is_valid_final = Wire(Vec(NUM_INPUT_PORT, UInt(1.W)))
    for (port_index <- 0 until NUM_INPUT_PORT) {
      input_full_addr(port_index) := input_packet_to_cache_flatted(port_index)
      input_is_right_bank(port_index) := (input_full_addr(port_index)(h_UNIFIED_CACHE_INDEX_POS_LO + BANK_BITS - 1, h_UNIFIED_CACHE_INDEX_POS_LO) === bank_index.U)
      input_is_valid_final(port_index) := input_packet_valid_to_cache_flatted(port_index) & input_is_right_bank(port_index)
    }

    val fetched_full_addr = Wire(UInt(h_CPU_ADDR_LEN_IN_BITS.W))
    val fetched_is_right_bank = Wire(UInt(1.W))
    val fetched_is_valid_final = Wire(UInt(1.W))
    fetched_full_addr := io.from_mem_packet_in(h_UNIFIED_CACHE_PACKET_ADDR_POS_HI, h_UNIFIED_CACHE_PACKET_ADDR_POS_LO)
    fetched_is_right_bank := (fetched_full_addr(h_UNIFIED_CACHE_INDEX_POS_LO + BANK_BITS - 1, h_UNIFIED_CACHE_INDEX_POS_LO) === bank_index.U)
    fetched_is_valid_final := io.from_mem_packet_in(h_UNIFIED_CACHE_PACKET_VALID_POS) & fetched_is_right_bank
    
    val cache_bank = Module(new unified_cache_bank(NUM_INPUT_PORT, NUM_SET, NUM_WAY, BLOCK_SIZE_IN_BYTES, bank_index, "OFF", UNIFIED_CACHE_PACKET_WIDTH_IN_BITS))
    //cache_bank.io.clk_in := clock
    //cache_bank.io.reset_in := reset.toBool

    when (input_is_valid_final.asUInt > 0.U) {
      cache_bank.io.input_request_flatted_in := input_packet_to_cache_flatted.asUInt
    } .otherwise {
      cache_bank.io.input_request_flatted_in := 0.U((NUM_INPUT_PORT * UNIFIED_CACHE_PACKET_WIDTH_IN_BITS).W)
    }
    //cache_bank.io.input_request_flatted_in := Mux(input_is_valid_final.asUInt > 0.U, input_packet_to_cache_flatted, 0.U((NUM_INPUT_PORT * UNIFIED_CACHE_PACKET_WIDTH_IN_BITS).W))
    cache_bank.io.input_request_valid_flatted_in := input_is_valid_final.asUInt
    cache_bank.io.input_request_critical_flatted_in := input_packet_critical_to_cache_flatted.asUInt
    cache_to_input_queue_ack_flatted(bank_index) := cache_bank.io.input_request_ack_out

    when (fetched_is_valid_final.toBool) {
      cache_bank.io.fetched_request_in := io.from_mem_packet_in
    } .otherwise {
      cache_bank.io.fetched_request_in := 0.U(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W)
    }
    //cache_bank.io.fetched_request_in := Mux(fetched_is_valid_final.toBool, from_mem_packet_in, 0.U(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS.W))
    cache_bank.io.fetched_request_valid_in := fetched_is_valid_final
    from_mem_packet_ack_flatted(bank_index) := cache_bank.io.fetch_ack_out

    miss_request_flatted(bank_index) := cache_bank.io.miss_request_out
    miss_request_valid_flatted(bank_index) := cache_bank.io.miss_request_valid_out
    miss_request_critical_flatted(bank_index) := cache_bank.io.miss_request_critical_out
    cache_bank.io.miss_request_ack_in := miss_request_ack_flatted(bank_index)

    writeback_request_flatted(bank_index) := cache_bank.io.writeback_request_out
    writeback_request_valid_flatted(bank_index) := cache_bank.io.writeback_request_valid_out
    writeback_request_critical_flatted(bank_index) := cache_bank.io.writeback_request_critical_out
    cache_bank.io.writeback_request_ack_in := writeback_request_ack_flatted(bank_index)

    return_request_flatted(bank_index) := cache_bank.io.return_request_out
    return_request_valid_flatted(bank_index) := cache_bank.io.return_request_valid_out
    return_request_critical_flatted(bank_index) := cache_bank.io.return_request_critical_out
    cache_bank.io.return_request_ack_in := return_request_ack_merged(bank_index)

  }

  io.from_mem_packet_ack_out := from_mem_packet_ack_flatted.asUInt.orR
  val cache_to_input_queue_ack_packed = Wire(Vec(NUM_INPUT_PORT, Vec(NUM_BANK, UInt(1.W))))
  for (port_index <- 0 until NUM_INPUT_PORT) {
    for (bank_index <- 0 until NUM_BANK) {
      cache_to_input_queue_ack_packed(port_index)(bank_index) := cache_to_input_queue_ack_flatted(bank_index)(port_index)
    }
    cache_to_input_queue_ack_merged(port_index) := cache_to_input_queue_ack_packed(port_index).asUInt.orR
  }

  val to_mem_arbiter = Module(new priority_arbiter(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS, NUM_BANK * 2, 2))
  //to_mem_arbiter.io.reset_in := reset.toBool
  //to_mem_arbiter.io.clk_in := clock

  to_mem_arbiter.io.request_flatted_in := Cat(miss_request_flatted.asUInt, writeback_request_flatted.asUInt)
  to_mem_arbiter.io.request_valid_flatted_in := Cat(miss_request_valid_flatted.asUInt, writeback_request_valid_flatted.asUInt)
  to_mem_arbiter.io.request_critical_flatted_in := Cat(miss_request_critical_flatted.asUInt, writeback_request_critical_flatted.asUInt)
  miss_request_ack_flatted := to_mem_arbiter.io.issue_ack_out(NUM_BANK * 2 - 1, NUM_BANK)
  writeback_request_ack_flatted := to_mem_arbiter.io.issue_ack_out(NUM_BANK - 1, 0)
  io.to_mem_packet_out := to_mem_arbiter.io.request_out
  to_mem_arbiter.io.issue_ack_in := io.to_mem_packet_ack_in


  val return_request_ack_flatted = Wire(Vec(NUM_INPUT_PORT, UInt(NUM_BANK.W)))
  val return_request_ack_packed = Wire(Vec(NUM_BANK, Vec(NUM_INPUT_PORT, UInt(1.W))))
  for (bank_index <- 0 until NUM_BANK) {
    for (port_index <- 0 until NUM_INPUT_PORT) {
      return_request_ack_packed(bank_index)(port_index) := return_request_ack_flatted(port_index)(bank_index)
    }
    return_request_ack_merged(bank_index) := return_request_ack_packed(bank_index).asUInt.orR
  }

  for (port_index <- 0 until NUM_INPUT_PORT) {
    val is_right_port = Wire(Vec(NUM_BANK, UInt(1.W)))
    for (bank_index <- 0 until NUM_BANK) {
      is_right_port(bank_index) := (return_request_flatted(bank_index)(h_UNIFIED_CACHE_PACKET_PORT_NUM_LO + PORT_ID_WIDTH - 1, h_UNIFIED_CACHE_PACKET_PORT_NUM_LO) === port_index.U) & 
                                    return_request_flatted(bank_index)(h_UNIFIED_CACHE_PACKET_VALID_POS);
    }

    val return_arbiter = Module(new priority_arbiter(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS, NUM_BANK, 2))
    //return_arbiter.io.reset_in := reset.toBool
    //return_arbiter.io.clk_in := clock

    return_arbiter.io.request_flatted_in := return_request_flatted.asUInt
    return_arbiter.io.request_valid_flatted_in := return_request_valid_flatted.asUInt & is_right_port.asUInt
    return_arbiter.io.request_critical_flatted_in := return_request_critical_flatted.asUInt
    return_request_ack_flatted(port_index) := return_arbiter.io.issue_ack_out
    return_packet_flatted_out_vec(port_index) := return_arbiter.io.request_out
    return_arbiter.io.issue_ack_in := io.return_packet_ack_flatted_in(port_index)
  }


  io.input_packet_ack_flatted_out := input_packet_ack_flatted_out_vec.asUInt
  io.return_packet_flatted_out := return_packet_flatted_out_vec.asUInt
}

object cacheDriver extends App {
  chisel3.Driver.execute(args, () => new true_unified_cache)
}