import chisel3._
import chisel3.experimental.ChiselEnum

package ALUType {

  object AluOP extends ChiselEnum {
//    type AluOP = Value
    val ADD32, SUB32, ADD16, SUB16, ADSUBC16, SUBADC16 = Value
  }

}