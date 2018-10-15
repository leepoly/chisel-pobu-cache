import chisel3._
import chisel3.util._

//To open it, execute in shell "sbt 'runMain Driver'"

class single_port_blockram(
  //These arguments are thrown in code due to their long names
  val SINGLE_ENTRY_SIZE_IN_BITS: Int = 64,
  val NUM_SET: Int = 64, 
  val SET_PTR_WIDTH_IN_BITS: Int = log2Down(64),
  val WRITE_MASK_LEN: Int = 64 / 8
  ) extends Module {
  val io = IO(new Bundle {
    val access_en_in = Input(Bool())
    val write_en_in  = Input(UInt(8.W))
    val access_set_addr_in = Input(UInt(64.W))
    val write_entry_in = Input(UInt(64.W))
    val read_entry_out = Output(UInt(64.W))
  })

  val blockram = Mem(64, Vec(8, UInt(8.W))) 
  val read_entry_out_unpack = VecInit(Seq.fill(8)(0.U(8.W)))
  val write_en_in_vec = io.write_en_in.toBools
  //Split write_entry: 64bit into (8, 8) Vec
  val write_entry_unpack = Wire(Vec(8, UInt(8.W)))
  for (i <- 0 until 8) {
    write_entry_unpack(i) := io.write_entry_in(8 * i + 7, 8 * i)
  }

  when (io.access_en_in) {
    blockram.write(io.access_set_addr_in, write_entry_unpack, write_en_in_vec)
    read_entry_out_unpack := blockram.read(io.access_set_addr_in)
    //Repack from Vec(8) to UInt
    io.read_entry_out := read_entry_out_unpack.asUInt
    //io.read_entry_out := Cat(read_entry_out_unpack(7), read_entry_out_unpack(6), read_entry_out_unpack(5), read_entry_out_unpack(4), read_entry_out_unpack(3), read_entry_out_unpack(2), read_entry_out_unpack(1), read_entry_out_unpack(0))
  } .otherwise {
    io.read_entry_out := 0.U(64.W)
  }

}


object Driver extends App {
  chisel3.Driver.execute(args, () => new single_port_blockram)
}