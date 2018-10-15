import chisel3._
import chisel3.util._

//To run, execute "sbt 'runMain Driver'"

class find_first_one_index(
	//There may be one cycle slower than Pobu's version because I'm not sure how to write a parallel 'for'
	//breakable code seems ineligible
	val VECTOR_LENGTH: Int = 8,
	val MAX_OUTPUT_WIDTH: Int = 16
 	) extends Module {
	val io = IO(new Bundle {
		val vector_in = Input(UInt(8.W))
		val first_one_index_out = Output(UInt(16.W))
		val one_is_found_out = Output(Bool())
	})
	val vector_in_sum = Wire(Vec(8, Bool()))
	io.first_one_index_out := 0.U(16.W)
	val one_is_found_out_reg = RegInit(false.B)
	io.one_is_found_out := one_is_found_out_reg

	vector_in_sum(0) := io.vector_in(0)
	for (loop_index <- 0 until 8) {
		if (loop_index > 0) {
			vector_in_sum(loop_index) := vector_in_sum(loop_index - 1) || io.vector_in(loop_index)
		}
		when(io.vector_in(loop_index) && vector_in_sum(loop_index) && !one_is_found_out_reg) {
			io.first_one_index_out := loop_index.U
			one_is_found_out_reg := true.B
		}
	}

}
/*
object Driver extends App {
  chisel3.Driver.execute(args, () => new find_first_one_index)
}*/
