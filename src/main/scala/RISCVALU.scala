package riscvALU

import chisel3._
import chisel3.util._
import ALUType._
import scala.annotation.switch

class PExtALU extends Module {
  val io = IO(new Bundle {
    val operand_A = Input(UInt(32.W))
    val operand_B = Input(UInt(32.W))
    val Width = Input(UInt(6.W))
    val ALU_SEL = Input(AluOP())
    val result = Output(UInt(32.W))
  })

  val A_32 = io.operand_A(31,0)
  val B_32 = io.operand_B(31,0)

  val Aup_16 = io.operand_A(31,16)
  val Alow_16 = io.operand_A(15,0)
  val Bup_16 = io.operand_B(31,16)
  val Blow_16 = io.operand_B(15,0)

  val result_32 = Wire(UInt(32.W))
  val resultup_16 = Wire(UInt(16.W))
  val resultlow_16 = Wire(UInt(16.W))

  result_32 := 0.U
  resultup_16 := 0.U
  resultlow_16 := 0.U


  when(io.Width === 32.U) {

    switch(io.ALU_SEL) {
      is(AluOP.ADD32) {

       result_32 := A_32 + B_32
      }

      is(AluOP.SUB32) {

        result_32 := A_32 + (~(B_32) + 1.U)
      }
    }
  }.elsewhen(io.Width === 16.U) {

    switch(io.ALU_SEL) {
      is(AluOP.ADD16) {

        resultup_16 := Aup_16 + Bup_16
        resultlow_16 := Alow_16 + Blow_16
        result_32 := Cat(resultup_16,resultlow_16)
      }

      is(AluOP.SUB16) {

        resultup_16 := Aup_16 + (~(Bup_16) + 1.U)
        resultlow_16 := Alow_16 + (~(Blow_16) + 1.U)
        result_32 := Cat(resultup_16,resultlow_16)
      }

      is(AluOP.ADSUBC16) {

        resultup_16 := Aup_16 + Blow_16
        resultlow_16 := Alow_16 + (~(Bup_16) + 1.U)
        result_32 := Cat(resultup_16,resultlow_16)
      }

      is(AluOP.SUBADC16) {

        resultup_16 := Aup_16 + (~(Blow_16) + 1.U)
        resultlow_16 := Alow_16 + Bup_16
        result_32 := Cat(resultup_16,resultlow_16)
      }
    }
  }.otherwise { 

    result_32 := 0.U
    
    printf("Warning: Width is neither 32 nor 16.\n")
  }

    io.result := result_32
}