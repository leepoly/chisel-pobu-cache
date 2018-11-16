import chisel3._
import chisel3.util._
import chisel3.experimental._

//To execute, type in shell "sbt 'runMain pDriver'"

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
	val request_out_reg = RegInit(0.U(SINGLE_REQUEST_WIDTH_IN_BITS.W))
	val request_valid_out_reg = RegInit(0.U(1.W))
	val issue_ack_out_vec = Wire(Vec(NUM_REQUEST, UInt(1.W)))

	val NUM_REQUEST_LOG2 = log2Up(NUM_REQUEST)

	val request_packed_in = Wire(Vec(NUM_REQUEST, UInt(SINGLE_REQUEST_WIDTH_IN_BITS.W)))
	val arbiter_ack_flatted_to_request_queue = Wire(Vec(NUM_REQUEST, UInt(1.W)))
	val request_packed_from_request_queue = Wire(Vec(NUM_REQUEST, UInt(SINGLE_REQUEST_WIDTH_IN_BITS.W)))
	val request_valid_flatted_from_request_queue = Wire(Vec(NUM_REQUEST, UInt(1.W)))
	val request_queue_full = Wire(Vec(NUM_REQUEST, UInt(1.W)))
	val request_critical_flatted_from_request_queue = Wire(Vec(NUM_REQUEST, UInt(BYTE_PADDING_WIDTH.W)))
	
	for (request_index <- 0 until NUM_REQUEST) {
		request_packed_in(request_index) := io.request_flatted_in((request_index + 1) * SINGLE_REQUEST_WIDTH_IN_BITS - 1, request_index * SINGLE_REQUEST_WIDTH_IN_BITS)

		val request_queue = Module(new fifo_queue(QUEUE_SIZE = INPUT_QUEUE_SIZE, 
												QUEUE_PTR_WIDTH_IN_BITS =log2Up(INPUT_QUEUE_SIZE), 
												SINGLE_ENTRY_WIDTH_IN_BITS = SINGLE_REQUEST_WIDTH_IN_BITS + BYTE_PADDING_WIDTH, 
												WRITE_MASK_LEN = (SINGLE_REQUEST_WIDTH_IN_BITS + BYTE_PADDING_WIDTH) / 8
												))
		request_queue_full(request_index) := request_queue.io.is_full_out
		when (io.request_critical_flatted_in(request_index)) {
			request_queue.io.request_in := Cat((1.U<<BYTE_PADDING_WIDTH) - 1.U, io.request_critical_flatted_in(request_index))
		} .otherwise {
			request_queue.io.request_in := Cat(0.U(BYTE_PADDING_WIDTH.W), request_packed_in(request_index))
		}
		//request_queue.io.request_in := Cat(io.request_critical_flatted_in(request_index), request_packed_in(request_index))
		request_queue.io.request_valid_in := io.request_valid_flatted_in(request_index)
		issue_ack_out_vec(request_index) := request_queue.io.issue_ack_out

		request_critical_flatted_from_request_queue(request_index) := request_queue.io.request_out(SINGLE_REQUEST_WIDTH_IN_BITS + BYTE_PADDING_WIDTH - 1, SINGLE_REQUEST_WIDTH_IN_BITS)
		request_packed_from_request_queue(request_index) := request_queue.io.request_out(SINGLE_REQUEST_WIDTH_IN_BITS - 1, 0)
		request_valid_flatted_from_request_queue(request_index) := request_queue.io.request_valid_out
		request_queue.io.issue_ack_in := arbiter_ack_flatted_to_request_queue(request_index)
	}

	val request_critical_final = Wire(UInt(NUM_REQUEST.W))
	request_critical_final := request_critical_flatted_from_request_queue.asUInt | request_queue_full.asUInt
	val last_send_index = RegInit(0.U(NUM_REQUEST_LOG2.W))

	// shift the request valid/critical flatted wire
	val request_valid_flatted_shift_left = Wire(UInt(NUM_REQUEST.W))
	val request_critical_flatted_shift_left = Wire(UInt(NUM_REQUEST.W))
	request_valid_flatted_shift_left := (request_valid_flatted_from_request_queue.asUInt >> last_send_index + 1.U) | 
										(request_valid_flatted_from_request_queue.asUInt << (NUM_REQUEST.U - last_send_index - 1.U))
	request_critical_flatted_shift_left := (request_critical_final >> last_send_index + 1.U) | 
										   (request_critical_final << (NUM_REQUEST.U - last_send_index - 1.U))

	// find the first valid requests
	val valid_sel = WireInit(0.U(NUM_REQUEST_LOG2.W))
	valid_sel := 0.U(NUM_REQUEST_LOG2.W)
	for (valid_find_index <- NUM_REQUEST - 1 to 0 by -1) {
		when (request_valid_flatted_shift_left(valid_find_index)) {
			when (last_send_index + valid_find_index.U + 1.U >= NUM_REQUEST.U) {
				valid_sel := last_send_index + valid_find_index.U + 1.U - NUM_REQUEST.U
			} .otherwise {
				valid_sel := last_send_index + valid_find_index.U + 1.U
			}
		}
	}

	val critical_sel = WireInit(0.U(NUM_REQUEST_LOG2.W))
	critical_sel := 0.U(NUM_REQUEST_LOG2.W)
	for (critical_find_index <- NUM_REQUEST - 1 to 0 by -1) {
		when (request_critical_flatted_shift_left(critical_find_index) && request_valid_flatted_shift_left(critical_find_index)) {
			when (last_send_index + critical_find_index.U + 1.U >= NUM_REQUEST.U) {
				critical_sel := last_send_index + critical_find_index.U + 1.U - NUM_REQUEST.U
			} .otherwise {
				critical_sel := last_send_index + critical_find_index.U + 1.U
			}
		}
	}

	// fill the valid/critical mask
	val valid_mask = Wire(Vec(NUM_REQUEST, UInt(1.W)))
	val critical_mask = Wire(Vec(NUM_REQUEST, UInt(1.W)))
	for (request_index <- 0 until NUM_REQUEST) {
		when (valid_sel === request_index.U) {
			valid_mask(request_index) := 1.U(1.W)
		} .otherwise {
			valid_mask(request_index) := 0.U(1.W)
		}
		when (critical_sel === request_index.U) {
			critical_mask(request_index) := 1.U(1.W)
		} .otherwise {
			critical_mask(request_index) := 0.U(1.W)
		}
		//valid_mask(request_index) := (valid_sel === request_index.U).asUInt
		//critical_mask(request_index) := (critical_sel === request_index.U).asUInt
	}
	for (request_index <- 0 until NUM_REQUEST) {
		when ((io.issue_ack_in & (last_send_index === request_index.U)).toBool) {
			arbiter_ack_flatted_to_request_queue(request_index) := 1.U(1.W)
		} .otherwise {
			arbiter_ack_flatted_to_request_queue(request_index) := 0.U(1.W)
		}
		//arbiter_ack_flatted_to_request_queue(request_index) := (io.issue_ack_in & (last_send_index === request_index.U)).asUInt
	}

	//arbiter logic
	when (reset.toBool) {
		request_out_reg := 0.U(SINGLE_REQUEST_WIDTH_IN_BITS.W)
		request_valid_out_reg := 0.U(1.W)
		last_send_index := 0.U(NUM_REQUEST_LOG2.W)
	} .elsewhen (((io.issue_ack_in & request_valid_out_reg) | (~request_valid_out_reg)).toBool) {
		when (!request_valid_out_reg.toBool) {
			when ((request_critical_final(critical_sel) & request_valid_flatted_from_request_queue(critical_sel)).toBool) {
				request_out_reg := request_packed_from_request_queue(critical_sel) 
				request_valid_out_reg := 1.U(1.W)
				last_send_index := critical_sel
			} .elsewhen (request_valid_flatted_from_request_queue(valid_sel).toBool) {
				request_out_reg := request_packed_from_request_queue(valid_sel)
				request_valid_out_reg := 1.U(1.W)
				last_send_index := valid_sel
			} 
		} .otherwise {
			request_out_reg := 0.U(SINGLE_REQUEST_WIDTH_IN_BITS.W)
			request_valid_out_reg := 0.U(1.W)
			last_send_index := last_send_index
		}
	} .otherwise {
		request_out_reg := request_out_reg
		request_valid_out_reg := request_valid_out_reg
		last_send_index := last_send_index
	}

	io.request_out := request_out_reg
	io.request_valid_out := request_valid_out_reg
	io.issue_ack_out := issue_ack_out_vec.asUInt
}

object pDriver extends App {
  chisel3.Driver.execute(args, () => new priority_arbiter)
}