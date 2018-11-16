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
		val port_A_access_en_in = Input(Bool()) 
		val port_A_write_en_in = Input(UInt(WRITE_MASK_LEN.W))
		val port_A_access_set_addr_in = Input(UInt(SET_PTR_WIDTH_IN_BITS.W))
		val port_A_write_entry_in = Input(UInt(SINGLE_ENTRY_SIZE_IN_BITS.W))
		val port_A_read_entry_out = Output(UInt(SINGLE_ENTRY_SIZE_IN_BITS.W))
		val port_A_read_valid_out = Output(UInt(1.W))

		val port_B_access_en_in = Input(Bool()) 
		val port_B_write_en_in = Input(UInt(WRITE_MASK_LEN.W))
		val port_B_access_set_addr_in = Input(UInt(SET_PTR_WIDTH_IN_BITS.W))
		val port_B_write_entry_in = Input(UInt(SINGLE_ENTRY_SIZE_IN_BITS.W))
		val port_B_read_entry_out = Output(UInt(SINGLE_ENTRY_SIZE_IN_BITS.W))
		val port_B_read_valid_out = Output(UInt(1.W))
	})

  //when (reset.toBool) {
  	io.port_A_read_valid_out := 0.U(1.W);
  	io.port_B_read_valid_out := 0.U(1.W);
  	io.port_A_read_entry_out := 0.U(SINGLE_ENTRY_SIZE_IN_BITS.W)
  	io.port_B_read_entry_out := 0.U(SINGLE_ENTRY_SIZE_IN_BITS.W)
  //}

  if (WITH_VALID_REG_ARRAY == "Yes") {
  	val valid_array = RegInit(VecInit(Seq.fill(NUM_SET)(0.U(1.W))))
  	when (!reset.toBool) {
  		when (io.port_A_access_en_in.toBool && io.port_A_write_en_in.orR) {
  			valid_array(io.port_A_access_set_addr_in) := 1.U(1.W)
  			when ((io.port_B_access_en_in && io.port_B_write_en_in.orR) &&
  			  (io.port_A_access_set_addr_in =/= io.port_B_access_set_addr_in)) {
	  			valid_array(io.port_B_access_set_addr_in) := 1.U(1.W)
	  		}
  		} .elsewhen(io.port_B_access_en_in && io.port_B_write_en_in.orR) {
  			valid_array(io.port_B_access_set_addr_in) := 1.U(1.W)
  		}

  		io.port_A_read_valid_out := Mux(io.port_A_access_en_in.toBool, valid_array(io.port_A_access_set_addr_in), 0.U(1.W))
  		io.port_B_read_valid_out := Mux(io.port_B_access_en_in.toBool, valid_array(io.port_B_access_set_addr_in), 0.U(1.W))
  	}
  }
  else {
  	when (!reset.toBool) {
  		io.port_A_read_valid_out := 1.U(1.W);
  		io.port_B_read_valid_out := 1.U(1.W);
  	}
  }

  val blockram = SyncReadMem(NUM_SET, Vec(WRITE_MASK_LEN, UInt(8.W)))
  if (CONFIG_MODE == "ReadFirst") {
  	when (io.port_A_access_en_in) {
		val port_A_write_en_in_vec = io.port_A_write_en_in.toBools
		val port_A_write_entry_unpack = Wire(Vec(WRITE_MASK_LEN, UInt(8.W)))
	    for (i <- 0 until WRITE_MASK_LEN) {
	      port_A_write_entry_unpack(i) := io.port_A_write_entry_in(8 * i + 7, 8 * i)
	    }
		blockram.write(io.port_A_access_set_addr_in, port_A_write_entry_unpack, port_A_write_en_in_vec)
  		val port_A_read_entry_out_unpack = VecInit(Seq.fill(WRITE_MASK_LEN)(0.U(8.W)))
  		port_A_read_entry_out_unpack := blockram.read(io.port_A_access_set_addr_in)
    	io.port_A_read_entry_out := port_A_read_entry_out_unpack.asUInt
  	}

  	when (io.port_B_access_en_in) {
		val port_B_write_en_in_vec = io.port_B_write_en_in.toBools
		val port_B_write_entry_unpack = Wire(Vec(WRITE_MASK_LEN, UInt(8.W)))
	    for (i <- 0 until WRITE_MASK_LEN) {
	      port_B_write_entry_unpack(i) := io.port_B_write_entry_in(8 * i + 7, 8 * i)
	    }
		blockram.write(io.port_B_access_set_addr_in, port_B_write_entry_unpack, port_B_write_en_in_vec)
  		val port_B_read_entry_out_unpack = VecInit(Seq.fill(WRITE_MASK_LEN)(0.U(8.W)))
  		port_B_read_entry_out_unpack := blockram.read(io.port_B_access_set_addr_in)
    	io.port_B_read_entry_out := port_B_read_entry_out_unpack.asUInt
  	}
  }

}

object dpbDriver extends App {
  chisel3.Driver.execute(args, () => new dual_port_blockram)
}