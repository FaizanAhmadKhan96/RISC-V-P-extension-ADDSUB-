package riscvALU

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import ALUType._

class RISCVALUTest extends AnyFlatSpec with
ChiselScalatestTester {
"DUT" should "pass" in {
test(new PExtALU ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
dut.io.operand_A.poke(30.U)
dut.io.operand_B.poke(20.U)
dut.io.Width.poke(32.U)
dut.io.ALU_SEL.poke(AluOP.ADD32)
dut.clock.step()
println("Result is: " + dut.io.result.peekInt())
dut.io.operand_A.poke(30.U)
dut.io.operand_B.poke(20.U)
dut.io.Width.poke(32.U)
dut.io.ALU_SEL.poke(AluOP.SUB32)
dut.clock.step()
println("Result is: " + dut.io.result.peekInt())
dut.io.operand_A.poke(30.U)
dut.io.operand_B.poke(20.U)
dut.io.Width.poke(16.U)
dut.io.ALU_SEL.poke(AluOP.ADD16)
dut.clock.step()
println("Result is: " + dut.io.result.peekInt())
dut.io.operand_A.poke(30.U)
dut.io.operand_B.poke(20.U)
dut.io.Width.poke(16.U)
dut.io.ALU_SEL.poke(AluOP.SUB16)
dut.clock.step()
println("Result is: " + dut.io.result.peekInt())
dut.io.operand_A.poke(30.U)
dut.io.operand_B.poke(20.U)
dut.io.Width.poke(16.U)
dut.io.ALU_SEL.poke(AluOP.ADSUBC16)
dut.clock.step()
println("Result is: " + dut.io.result.peekInt())
dut.io.operand_A.poke(30.U)
dut.io.operand_B.poke(20.U)
dut.io.Width.poke(16.U)
dut.io.ALU_SEL.poke(AluOP.SUBADC16)
dut.clock.step()
println("Result is: " + dut.io.result.peekInt())
}
}
}