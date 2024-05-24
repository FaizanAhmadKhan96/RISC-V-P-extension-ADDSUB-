package riscvALU

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import ALUType._
import scala.util.Random
import scala.math._

class RISCVALUTest extends AnyFlatSpec with ChiselScalatestTester with Matchers {

  val IT_Max = 1000 //max number of random tests
  val max_input_value:Int = math.pow(2.toDouble, 32).toInt

   behavior of "RiscV ALU"

  it should "output correct results" in {
//"DUT" should "pass" in {
test(new PExtALU ).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

    for (i <- 0 until IT_Max) {
  val a = Random.nextInt(max_input_value)
  val b = Random.nextInt(max_input_value)

  // Test ADD32
  val expected_ADD32result = (a + b) % max_input_value
  dut.io.operand_A.poke(a.U)
  dut.io.operand_B.poke(b.U)
  dut.io.ALU_SEL.poke(AluOP.ADD32)

  dut.clock.step()

  dut.io.result.expect(expected_ADD32result.asSInt)

  // Test SUB32
  val expected_SUB32result = (a - b) % max_input_value
  dut.io.operand_A.poke(a.U)
  dut.io.operand_B.poke(b.U)
  dut.io.ALU_SEL.poke(AluOP.SUB32)

  dut.clock.step()

  dut.io.result.expect(expected_SUB32result.asSInt)

  // Test ADD16
   val lower16_a = a & 0xFFFF
   val lower16_b = b & 0xFFFF
   val upper16_a = (a >> 16) & 0xFFFF
   val upper16_b = (b >> 16) & 0xFFFF   
   val lower16_ADDresult = (lower16_a + lower16_b) & 0xFFFF
   val upper16_ADDresult = (upper16_a + upper16_b) & 0xFFFF
   val expected_ADD16result = (upper16_ADDresult << 16) | lower16_ADDresult   
   dut.io.operand_A.poke(a.U)
   dut.io.operand_B.poke(b.U)
   dut.io.ALU_SEL.poke(AluOP.ADD16)

   dut.clock.step(2)

   dut.io.result.expect(expected_ADD16result.asSInt)

   // Test SUB16 
   val lower16_SUBresult = (lower16_a - lower16_b) & 0xFFFF
   val upper16_SUBresult = (upper16_a - upper16_b) & 0xFFFF
   val expected_SUB16result = (upper16_SUBresult << 16) | lower16_SUBresult   
   dut.io.operand_A.poke(a.U)
   dut.io.operand_B.poke(b.U)
   dut.io.ALU_SEL.poke(AluOP.SUB16)

   dut.clock.step(2)

   dut.io.result.expect(expected_SUB16result.asSInt)

   // Test ADSUB16 
   val lower16_ADSUBresult = (lower16_a - upper16_b) & 0xFFFF
   val upper16_ADSUBresult = (upper16_a + lower16_b) & 0xFFFF
   val expected_ADSUB16result = (upper16_ADSUBresult << 16) | lower16_ADSUBresult   
   dut.io.operand_A.poke(a.U)
   dut.io.operand_B.poke(b.U)
   dut.io.ALU_SEL.poke(AluOP.ADSUBC16)

   dut.clock.step(2)

   dut.io.result.expect(expected_ADSUB16result.asSInt)

   // Test SUBAD16 
   val lower16_SUBADresult = (lower16_a + upper16_b) & 0xFFFF
   val upper16_SUBADresult = (upper16_a - lower16_b) & 0xFFFF
   val expected_SUBAD16result = (upper16_SUBADresult << 16) | lower16_SUBADresult   
   dut.io.operand_A.poke(a.U)
   dut.io.operand_B.poke(b.U)
   dut.io.ALU_SEL.poke(AluOP.SUBADC16)

   dut.clock.step(2)

   dut.io.result.expect(expected_SUBAD16result.asSInt)
}
}
}
}