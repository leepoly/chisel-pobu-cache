import chisel3._
import chisel3.util._

//To open it, execute in shell "sbt 'runMain Driver'"

class tri_port_regfile(
	val SINGLE_ENTRY_SIZE_IN_BITS: Int = 8,
	val NUM_ENTRY: Int = 4
 	) extends Module {
	val io = IO(new Bundle {
		val read_en_in = Input(Bool())
		val write_en_in = Input(Bool())
		val cam_en_in = Input(Bool())

		val read_entry_addr_decoded_in = Input(UInt(4.W))
		val write_entry_addr_decoded_in = Input(UInt(4.W))
		val cam_entry_in = Input(UInt(8.W))

		val write_entry_in = Input(UInt(8.W))
		val read_entry_out = Output(UInt(8.W))
		val cam_result_decoded_out = Output(UInt(4.W))
	})
	//val entry_packed = Wire(Vec(4, UInt(8.W)))
	val entry_reg = RegInit(VecInit(Seq.fill(4)(0.U(8.W))))
	val read_entry_out_reg = RegInit(0.U(8.W))
	val cam_result_decoded_out_reg = VecInit(Seq.fill(4)(0.U(1.W)))
	
	for (gen <- 0 until 4) {
		//entry_packed(gen) := entry_reg(gen)

		when (reset.toBool) {
			entry_reg(gen) := 0.U(8.W)

		} .otherwise {
			when (io.write_en_in && io.write_entry_addr_decoded_in(gen)) {
				entry_reg(gen) := io.write_entry_in
			} .otherwise {
				entry_reg(gen) := entry_reg(gen)
			}
			when (io.cam_en_in && entry_reg(gen) === io.cam_entry_in) {
				//io.cam_result_decoded_out(gen) := Mux(entry_reg(gen) === io.cam_entry_in, 1.U, 0.U)
				cam_result_decoded_out_reg(gen) := 1.U
			} .otherwise {
				cam_result_decoded_out_reg(gen) := 0.U
			}
		}
	}

	val read_index = Wire(UInt((log2Up(4) + 1).W))
	val find_read_index = Module(new find_first_one_index(NUM_ENTRY, log2Up(NUM_ENTRY) + 1))
	find_read_index.io.vector_in := io.read_entry_addr_decoded_in
	read_index := find_read_index.io.first_one_index_out

	when (reset.toBool) {
		read_entry_out_reg := 0.U(8.W)
	} .elsewhen(io.read_en_in) {
		read_entry_out_reg := entry_reg(read_index)
	} .otherwise {
		read_entry_out_reg := 0.U(8.W)
	}

	io.read_entry_out := read_entry_out_reg
	io.cam_result_decoded_out := cam_result_decoded_out_reg.asUInt
}

object tDriver extends App {
  chisel3.Driver.execute(args, () => new tri_port_regfile)
}