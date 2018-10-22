import chisel3._
import chisel3.util._
import chisel3.experimental._

//To open it, execute in shell "sbt 'runMain bDriver'"

class unified_cache_bank(
  val NUM_INPUT_PORT: Int = 2,
  val NUM_SET: Int = 4, 
  val NUM_WAY: Int = 4,
  val BLOCK_SIZE_IN_BYTES: Int = 4,
  val BANK_NUM: Int = 0,
  val MODE: String = "OFF",
  val UNIFIED_CACHE_PACKET_WIDTH_IN_BITS: Int = 32,
  val BLOCK_SIZE_IN_BITS: Int = 4*8,
  val SET_PTR_WIDTH_IN_BITS: Int = 2
  ) extends Module {
  val io = IO(new Bundle {

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

  if (MODE == "OFF") {


    val intra_bank_arbiter = Module(new priority_arbiter_chisel(UNIFIED_CACHE_PACKET_WIDTH_IN_BITS, NUM_INPUT_PORT, 2))

  //intra_bank_arbiter.io.reset_in := reset.toBool
  //intra_bank_arbiter.io.clk_in := clock
  
	intra_bank_arbiter.io.request_flatted_in := io.input_request_flatted_in
	intra_bank_arbiter.io.request_valid_flatted_in := io.input_request_valid_flatted_in
	intra_bank_arbiter.io.request_critical_flatted_in := io.input_request_critical_flatted_in
	io.input_request_ack_out := intra_bank_arbiter.io.issue_ack_out
	io.miss_request_out := intra_bank_arbiter.io.request_out
	io.miss_request_valid_out := intra_bank_arbiter.io.request_valid_out 
	intra_bank_arbiter.io.issue_ack_in := io.miss_request_ack_in
  	
  	io.miss_request_critical_out := 0.U(1.W)
  	io.return_request_out := io.fetched_request_in
  	io.return_request_valid_out := io.fetched_request_valid_in
  	io.fetch_ack_out := io.return_request_ack_in
  	io.return_request_critical_out := 1.U(1.W)

  	io.writeback_request_out := 0.U(1.W)
  	io.writeback_request_valid_out := 0.U(1.W)
  	io.writeback_request_critical_out := 0.U(1.W)
	}

}

object bDriver extends App {
  chisel3.Driver.execute(args, () => new unified_cache_bank)
}