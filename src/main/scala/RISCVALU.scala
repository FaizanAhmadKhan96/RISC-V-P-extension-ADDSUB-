package riscvALU

import chisel3._
import chisel3.util._
import ALUType._
import scala.annotation.switch

class PExtALU extends Module {
  val io = IO(new Bundle {
    val operand_A = Input(UInt(32.W))
    val operand_B = Input(UInt(32.W))
    val ALU_SEL = Input(AluOP())
    val result = Output(SInt(32.W))
  })

  val A_32 = io.operand_A
  val B_32 = io.operand_B

  val Aup_16 = io.operand_A(31,16)//.asSInt
  val Alow_16 = io.operand_A(15,0)//.asSInt
  val Bup_16 = io.operand_B(31,16)//.asSInt
  val Blow_16 = io.operand_B(15,0)//.asSInt

  val result_32 = Wire(SInt(32.W))
  val resultup_16 = Wire(UInt(16.W))
  val resultlow_16 = Wire(UInt(16.W))

  result_32 := 0.S
  resultup_16 := 0.U
  resultlow_16 := 0.U

    switch(io.ALU_SEL) {
      is(AluOP.ADD32) {

       result_32 := (A_32 + B_32).asSInt
      }

      is(AluOP.SUB32) {

        result_32 := (A_32 + (~(B_32) + 1.U)).asSInt
      }

      is(AluOP.ADD16) {

        resultup_16 := Aup_16 + Bup_16
        resultlow_16 := Alow_16 + Blow_16
        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.SUB16) {

        resultup_16 := Aup_16 + (~(Bup_16) + 1.U)
        resultlow_16 := Alow_16 + (~(Blow_16) + 1.U)
        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.ADSUBC16) {

        resultup_16 := Aup_16 + Blow_16
        resultlow_16 := Alow_16 + (~(Bup_16) + 1.U)
        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.SUBADC16) {

        resultup_16 := Aup_16 + (~(Blow_16) + 1.U)
        resultlow_16 := Alow_16 + Bup_16
        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }
    }

    io.result := result_32
}