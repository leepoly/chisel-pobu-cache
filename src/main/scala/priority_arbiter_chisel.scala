import chisel3._
import chisel3.util._
import chisel3.experimental._

//To execute, type in shell "sbt 'runMain pDriver'"

// def all_one(val width: Int) : (1<<width) - 1

class priority_arbiter(
	val SINGLE_REQUEST_WIDTH_IN_BITS: Int = 64,
 	val NUM_REQUEST: Int = 3,
 	val INPUT_QUEUE_SIZE: Int = 2,
 	val BYTE_PADDING_WIDTH: Int = 8
	) extends Module {
	val io = IO(new Bundle {
		val request_flatted_in = Input(UInt((SINGLE_REQUEST_WIDTH_IN_BITS * NUM_REQUEST).W))
		val request_valid_flatted_in = Input(UInt(NUM_REQUEST.W))
		val request_critical_flatted_in = Input(UInt(NUM_REQUEST.W))
		val issue_ack_out = Output(UInt(NUM_REQUEST.W))

		val request_out = Output(UInt(SINGLE_REQUEST_WIDTH_IN_BITS.W))
		val request_valid_out = Output(UInt(1.W))
		val issue_ack_in = Input(UInt(1.W))
	})
	val issue_ack_out_vec = Wire(Vec(NUM_REQUEST, UInt(1.W)))	
	val arbiter = Module(new RRArbiter(UInt(SINGLE_REQUEST_WIDTH_IN_BITS.W), NUM_REQUEST))

	val arbiter_in = Wire(Flipped(Vec(NUM_REQUEST, Decoupled(UInt(SINGLE_REQUEST_WIDTH_IN_BITS.W)))))
	for (request_idx <- 0 until NUM_REQUEST) {
		val fifo_queue = Module(new Queue(UInt(SINGLE_REQUEST_WIDTH_IN_BITS.W), INPUT_QUEUE_SIZE))
		fifo_queue.io.enq.bits := io.request_flatted_in((request_idx + 1) * SINGLE_REQUEST_WIDTH_IN_BITS - 1, request_idx * SINGLE_REQUEST_WIDTH_IN_BITS)
		fifo_queue.io.enq.valid := io.request_valid_flatted_in(request_idx)
		issue_ack_out_vec(request_idx) := fifo_queue.io.enq.ready

		arbiter_in(request_idx) <> fifo_queue.io.deq
	}
	arbiter.io.in <> arbiter_in

	io.request_out := arbiter.io.out.bits
	io.request_valid_out := arbiter.io.out.valid
	arbiter.io.out.ready := io.issue_ack_in

	io.issue_ack_out := issue_ack_out_vec.asUInt
	
}

object pDriver extends App {
  chisel3.Driver.execute(args, () => new priority_arbiter)
}