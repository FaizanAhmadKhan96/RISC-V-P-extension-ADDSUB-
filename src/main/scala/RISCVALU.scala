package riscvALU

import chisel3._
import chisel3.util._
import ALUType._
import scala.annotation.switch

//class Adder16bits extends Module {
  //val io = IO(new Bundle {
  //  val A_in = Input(UInt(16.W))
  //  val B_in = Input(UInt(16.W))
  //  val carry_in = Input(UInt(1.W))
  //  val sum = Output(UInt(16.W))
  //  val carry_out = Output(UInt(1.W))
  //})
//
  //  val sum  = io.A_in ^ io.B_in ^ io.carry_in
  //  val cout = (io.A_in & io.B_in) | (io.A_in & io.carry_in) | (io.B_in & io.carry_in)
//
  //  io.sum  := sum
  //  io.carry_out := cout
//}

// Implementing n bit twos complement block for subtractor
class TwosComplement(N: Int) extends Module {
  val io = IO(new Bundle {
    val B_in = Input(UInt(N.W))
    val B_out = Output(UInt(N.W))
  })

    val B_temp  = ~(io.B_in ) + 1.U

    io.B_out  := B_temp
}

// Implementing n bit adder block 
class Adder(N: Int) extends Module {
  val io = IO(new Bundle {
    val A_in = Input(UInt(N.W))
    val B_in = Input(UInt(N.W))
    val sum = Output(SInt(N.W))
  })

    val sum_temp  = (io.A_in + io.B_in).asSInt

    io.sum  := sum_temp
}

class PExtALU extends Module {
  val io = IO(new Bundle {
    val operand_A = Input(UInt(32.W))
    val operand_B = Input(UInt(32.W))
    val ALU_SEL = Input(AluOP())
    val result = Output(SInt(32.W))
  })

  val A_32 = io.operand_A
  val B_32 = io.operand_B

  val Aup_16 = io.operand_A(31,16)
  val Alow_16 = io.operand_A(15,0)
  val Bup_16 = io.operand_B(31,16)
  val Blow_16 = io.operand_B(15,0)

  val result_32 = Reg(SInt(32.W))
  val resultup_16 = Reg(SInt(16.W))
  val resultlow_16 = Reg(SInt(16.W))       

  result_32 := 0.S
  resultup_16 := 0.S
  resultlow_16 := 0.S

  val two_32 = Module(new TwosComplement(32))
  val twolow_16 = Module(new TwosComplement(16))
  val twoup_16 = Module(new TwosComplement(16))

  val Add = Module(new Adder(32))
  val Addlow_16 = Module(new Adder(16))
  val Addup_16 = Module(new Adder(16))

   // Initialize all module inputs to avoid uninitialized reference errors
  two_32.io.B_in := 0.U
  twolow_16.io.B_in := 0.U
  twoup_16.io.B_in := 0.U
  Add.io.A_in := 0.U
  Add.io.B_in := 0.U
  Addlow_16.io.A_in := 0.U
  Addlow_16.io.B_in := 0.U
  Addup_16.io.A_in := 0.U
  Addup_16.io.B_in := 0.U

    switch(io.ALU_SEL) {
      is(AluOP.ADD32) {

        Add.io.A_in := A_32
        Add.io.B_in := B_32

       result_32 := Add.io.sum
      }

      is(AluOP.SUB32) {

        two_32.io.B_in := B_32

        Add.io.A_in := A_32
        Add.io.B_in := two_32.io.B_out

       result_32 := Add.io.sum
      }

      is(AluOP.ADD16) {

        Addlow_16.io.A_in := Alow_16
        Addlow_16.io.B_in := Blow_16
        resultlow_16  := Addlow_16.io.sum

        Addup_16.io.A_in := Aup_16
        Addup_16.io.B_in := Bup_16
        resultup_16  := Addup_16.io.sum

        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.SUB16) {

        twolow_16.io.B_in := Blow_16

        Addlow_16.io.A_in := Alow_16
        Addlow_16.io.B_in := twolow_16.io.B_out
        resultlow_16  := Addlow_16.io.sum

        twoup_16.io.B_in := Bup_16

        Addup_16.io.A_in := Aup_16
        Addup_16.io.B_in := twoup_16.io.B_out
        resultup_16  := Addup_16.io.sum

       result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.ADSUBC16) {

        twolow_16.io.B_in := Bup_16

        Addlow_16.io.A_in := Alow_16
        Addlow_16.io.B_in := twolow_16.io.B_out
        resultlow_16  := Addlow_16.io.sum

        Addup_16.io.A_in := Aup_16
        Addup_16.io.B_in := Blow_16
        resultup_16  := Addup_16.io.sum

        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.SUBADC16) {

        Addlow_16.io.A_in := Alow_16
        Addlow_16.io.B_in := Bup_16
        resultlow_16  := Addlow_16.io.sum

        twoup_16.io.B_in := Blow_16

        Addup_16.io.A_in := Aup_16
        Addup_16.io.B_in := twoup_16.io.B_out
        resultup_16  := Addup_16.io.sum

        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }
    }

    io.result := result_32
}


object GenerateVerilog extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new PExtALU(), Array("--target-dir", "generated"))
}