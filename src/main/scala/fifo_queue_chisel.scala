import chisel3._
import chisel3.util._

//To execute, type in shell "sbt 'runMain Driver'"

class fifo_queue(
 	val QUEUE_SIZE: Int = 16,
 	val QUEUE_PTR_WIDTH_IN_BITS: Int = log2Up(16), //log2Up(QUEUE_SIZE)
 	val SINGLE_ENTRY_WIDTH_IN_BITS: Int = 64,
 	val WRITE_MASK_LEN: Int = 64 / 8, //SINGLE_ENTRY_WIDTH_IN_BITS / 8
 	val STORAGE_TYPE: String = "LUTRAM"
 	) extends Module {
	val io = IO(new Bundle {
		val is_empty_out = Output(Bool())
		val is_full_out = Output(Bool())

		val request_in = Input(UInt(SINGLE_ENTRY_WIDTH_IN_BITS.W))
		val request_valid_in = Input(Bool())
		val issue_ack_out = Output(Bool())

		val request_out = Output(UInt(SINGLE_ENTRY_WIDTH_IN_BITS.W))
		val request_valid_out = Output(Bool())
		val issue_ack_in = Input(Bool())
	})

	val queue = Module(new Queue(UInt(SINGLE_ENTRY_WIDTH_IN_BITS.W), QUEUE_SIZE))

	queue.io.enq.bits := io.request_in
	queue.io.enq.valid := io.request_valid_in
	io.issue_ack_out := queue.io.enq.ready

	io.request_out := queue.io.deq.bits
	io.request_valid_out := queue.io.deq.valid
	queue.io.deq.ready := io.issue_ack_in

	io.is_empty_out := queue.io.count === 0.U
	io.is_full_out := queue.io.count === QUEUE_SIZE.U

}

object fDriver extends App {
  chisel3.Driver.execute(args, () => new fifo_queue)
}