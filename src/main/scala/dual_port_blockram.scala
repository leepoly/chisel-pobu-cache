import chisel3._
import chisel3.util._

//To execute, type in shell "sbt 'runMain sDriver'"

class dual_port_blockram(
 	val SINGLE_ENTRY_SIZE_IN_BITS: Int = 64,
 	val NUM_SET: Int = 64,
 	val SET_PTR_WIDTH_IN_BITS: Int = log2Up(64), //log2Up(NUM_SET)
 	val WRITE_MASK_LEN: Int = 64 / 8, //SINGLE_ENTRY_SIZE_IN_BITS / 8
 	val CONFIG_MODE: String = "ReadFirst",
 	val WITH_VALID_REG_ARRAY: String = "Yes"
 	) extends Module {
	val io = IO(new Bundle {
		val write_port_access_en_in = Input(Bool()) 
		val write_port_write_en_in = Input(UInt(WRITE_MASK_LEN.W))
		val write_port_access_set_addr_in = Input(UInt(SET_PTR_WIDTH_IN_BITS.W))
		val write_port_data_in = Input(UInt(SINGLE_ENTRY_SIZE_IN_BITS.W))
		
		val read_port_access_en_in = Input(Bool()) 
		val read_port_access_set_addr_in = Input(UInt(SET_PTR_WIDTH_IN_BITS.W))
		val read_port_data_out = Output(UInt(SINGLE_ENTRY_SIZE_IN_BITS.W))
		val read_port_valid_out = Output(UInt(1.W))
	})

  //when (reset.toBool) {
  io.read_port_valid_out := 0.U(1.W);
  io.read_port_data_out := 0.U(SINGLE_ENTRY_SIZE_IN_BITS.W)
  //}

  if (WITH_VALID_REG_ARRAY == "Yes") {
  	val valid_array = RegInit(VecInit(Seq.fill(NUM_SET)(0.U(1.W))))
  	when (!reset.toBool) {
  		when (io.write_port_access_en_in && io.write_port_write_en_in.orR) {
  			valid_array(io.write_port_access_set_addr_in) := 1.U(1.W)
  		}

  		io.read_port_valid_out := Mux(io.read_port_access_en_in, valid_array(io.read_port_access_set_addr_in), 0.U(1.W))
  	}
  }
  else {
  	when (!reset.toBool) {
  		io.read_port_valid_out := 1.U(1.W);
  	}
  }

  val blockram = SyncReadMem(NUM_SET, Vec(WRITE_MASK_LEN, UInt(8.W)))
  when (io.write_port_access_en_in) {
	val write_en_in_seq = io.write_port_write_en_in.toBools
	val write_entry_unpack = Wire(Vec(WRITE_MASK_LEN, UInt(8.W)))
    for (i <- 0 until WRITE_MASK_LEN) {
      write_entry_unpack(i) := io.write_port_data_in(8 * i + 7, 8 * i)
    }
	blockram.write(io.write_port_access_set_addr_in, write_entry_unpack, write_en_in_seq)
  }
  when (io.read_port_access_en_in) {
	val read_entry_out_unpack = VecInit(Seq.fill(WRITE_MASK_LEN)(0.U(8.W)))
	read_entry_out_unpack := blockram.read(io.read_port_access_set_addr_in)
	io.read_port_data_out := read_entry_out_unpack.asUInt
  }

}

object dpbDriver extends App {
  chisel3.Driver.execute(args, () => new dual_port_blockram)
}