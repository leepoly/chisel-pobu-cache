import chisel3._
import chisel3.util._

//To execute, type in shell "sbt 'runMain Driver'"

class fifo_queue(
 	val QUEUE_SIZE: Int = 16,
 	val QUEUE_PTR_WIDTH_IN_BITS: Int = 4,
 	val SINGLE_ENTRY_WIDTH_IN_BITS: Int = 32,
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

	val issue_ack_out_reg = RegInit(0.U(1.W))
	val request_out_reg = RegInit(0.U(SINGLE_ENTRY_WIDTH_IN_BITS.W))
	val request_valid_out_reg = RegInit(0.U(1.W))

	val write_qualified = Wire(Vec(QUEUE_SIZE, UInt(1.W)))
	val read_qualified = Wire(Vec(QUEUE_SIZE, UInt(1.W)))

	//val fifo_entry_valid_packed = Wire(Vec(QUEUE_SIZE, UInt(1.W)))
	//val fifo_entry_packed = Wire(Vec(QUEUE_SIZE, UInt(SINGLE_ENTRY_WIDTH_IN_BITS.W)))

	val write_ptr = RegInit(0.U(QUEUE_PTR_WIDTH_IN_BITS.W))
	val read_ptr = RegInit(0.U(QUEUE_PTR_WIDTH_IN_BITS.W))

	val entry_vec = RegInit(VecInit(Seq.fill(QUEUE_SIZE)(0.U(SINGLE_ENTRY_WIDTH_IN_BITS.W))))
	val entry_valid_vec = RegInit(VecInit(Seq.fill(QUEUE_SIZE)(0.U(1.W))))
	//fifo_entry_valid_packed <> entry_valid_vec

	io.is_full_out := entry_valid_vec.asUInt.andR
	io.is_empty_out := (~(entry_valid_vec.asUInt)).andR

	for (gen <- 0 until QUEUE_SIZE) {
		//fifo_entry_packed(gen) := entry_vec(gen)
		//fifo_entry_valid_packed(gen) := entry_valid_vec(gen)
		write_qualified(gen) := (~io.is_full_out | (io.issue_ack_in & io.is_full_out & gen.asUInt === read_ptr)) & ~issue_ack_out_reg & io.request_valid_in & gen.asUInt === write_ptr;
		read_qualified(gen) := ~io.is_empty_out & io.issue_ack_in & entry_valid_vec(gen) & gen.asUInt === read_ptr;

		when (reset.toBool) {
			entry_vec(gen) := 0.U(SINGLE_ENTRY_WIDTH_IN_BITS.W)
			entry_valid_vec(gen) := 0.U
		} .otherwise {
			when (write_qualified(gen).toBool && read_qualified(gen).toBool) {
				entry_vec(gen) := io.request_in
				entry_valid_vec(gen) := 1.U
			} .otherwise {
				when (read_qualified(gen).toBool) {
					entry_vec(gen) := 0.U(SINGLE_ENTRY_WIDTH_IN_BITS.W)
					entry_valid_vec(gen) := 0.U
				} .elsewhen (write_qualified(gen).toBool) {
					entry_vec(gen) := io.request_in
					entry_valid_vec(gen) := 1.U
				} .otherwise {
					entry_vec(gen) := entry_vec(gen)
					entry_valid_vec(gen) := entry_valid_vec(gen)
				}
			}
		}
	}


	when (reset.toBool) {
		write_ptr := 0.U(QUEUE_PTR_WIDTH_IN_BITS.W)
		issue_ack_out_reg := 0.U
		read_ptr := 0.U(QUEUE_PTR_WIDTH_IN_BITS.W)
		request_out_reg := 0.U(SINGLE_ENTRY_WIDTH_IN_BITS.W)
		request_valid_out_reg := 0.U
	} .otherwise {
		when (write_qualified.asUInt.orR) {

			when (write_ptr === (1.U<<QUEUE_PTR_WIDTH_IN_BITS.U - 1.U)) {
				write_ptr := 0.U(QUEUE_PTR_WIDTH_IN_BITS.W)
			} .otherwise {
				write_ptr := write_ptr + 1.U
			}
			//write_ptr := Mux(write_ptr === (1.U<<4.U - 1.U), 0.U(4.W), write_ptr + 1.U)
			issue_ack_out_reg := 1.U
		} .otherwise {
			write_ptr := write_ptr
			issue_ack_out_reg := 0.U
		}

		when (read_qualified.asUInt.orR) {
			when (read_ptr === (1.U<<QUEUE_PTR_WIDTH_IN_BITS.U - 1.U)) {
				read_ptr := 0.U(QUEUE_PTR_WIDTH_IN_BITS.W)
			} .otherwise {
				read_ptr := read_ptr + 1.U
			}
			request_out_reg := 0.U(SINGLE_ENTRY_WIDTH_IN_BITS.W)
			request_valid_out_reg := 0.U
		} .elsewhen (entry_valid_vec(read_ptr).toBool) {
			read_ptr := read_ptr
			request_out_reg := entry_vec(read_ptr)
			request_valid_out_reg := 1.U
		} .otherwise {
			read_ptr := read_ptr
			request_out_reg := 0.U(SINGLE_ENTRY_WIDTH_IN_BITS.W)
			request_valid_out_reg := 0.U
		}
	}
	
	io.issue_ack_out := issue_ack_out_reg
	io.request_out := request_out_reg
	io.request_valid_out := request_valid_out_reg
}

object fDriver extends App {
  chisel3.Driver.execute(args, () => new fifo_queue)
}