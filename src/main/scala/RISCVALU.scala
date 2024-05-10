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

  val result_32 = Wire(SInt(32.W))
  val resultup_16 = Wire(SInt(16.W))
  val resultlow_16 = Wire(SInt(16.W))       

  result_32 := 0.S
  resultup_16 := 0.S
  resultlow_16 := 0.S

    switch(io.ALU_SEL) {
      is(AluOP.ADD32) {

        //val Addlow = Module(new Adder16bits)
        //Addlow.io.A_in := Alow_16
        //Addlow.io.B_in := Blow_16
        //Addlow.io.carry_in := 0.U
        //resultlow_16 := Addlow.io.sum 
//
        //val Addup = Module(new Adder16bits)
        //Addup.io.A_in := Aup_16
        //Addup.io.B_in := Bup_16
        //Addup.io.carry_in := Addlow.io.carry_out
        //resultup_16 := Addup.io.sum 

        val Add = Module(new Adder(32))
        Add.io.A_in := A_32
        Add.io.B_in := B_32

       result_32 := Add.io.sum
      }

      is(AluOP.SUB32) {

        //result_32 := (A_32 + (~(B_32) + 1.U)).asSInt

        val two_32 = Module(new TwosComplement(32))
        two_32.io.B_in := B_32

        val Add = Module(new Adder(32))
        Add.io.A_in := A_32
        Add.io.B_in := two_32.io.B_out

       result_32 := Add.io.sum
      }

      is(AluOP.ADD16) {

        val Addlow = Module(new Adder(16))
        Addlow.io.A_in := Alow_16
        Addlow.io.B_in := Blow_16
        resultlow_16  := Addlow.io.sum

        val Addup = Module(new Adder(16))
        Addup.io.A_in := Aup_16
        Addup.io.B_in := Bup_16
        resultup_16  := Addup.io.sum

        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.SUB16) {

        val two_16low = Module(new TwosComplement(16))
        two_16low.io.B_in := Blow_16

        val Addlow = Module(new Adder(16))
        Addlow.io.A_in := Alow_16
        Addlow.io.B_in := two_16low.io.B_out
        resultlow_16  := Addlow.io.sum

        val two_16up = Module(new TwosComplement(16))
        two_16up.io.B_in := Bup_16

        val Addup = Module(new Adder(16))
        Addup.io.A_in := Aup_16
        Addup.io.B_in := two_16up.io.B_out
        resultup_16  := Addup.io.sum

       result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.ADSUBC16) {

        val two_16up = Module(new TwosComplement(16))
        two_16up.io.B_in := Bup_16

        val Addlow = Module(new Adder(16))
        Addlow.io.A_in := Alow_16
        Addlow.io.B_in := two_16up.io.B_out
        resultlow_16  := Addlow.io.sum

        val Addup = Module(new Adder(16))
        Addup.io.A_in := Aup_16
        Addup.io.B_in := Blow_16
        resultup_16  := Addup.io.sum

        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }

      is(AluOP.SUBADC16) {

        val Addlow = Module(new Adder(16))
        Addlow.io.A_in := Alow_16
        Addlow.io.B_in := Bup_16
        resultlow_16  := Addlow.io.sum

        val two_16up = Module(new TwosComplement(16))
        two_16up.io.B_in := Blow_16

        val Addup = Module(new Adder(16))
        Addup.io.A_in := Aup_16
        Addup.io.B_in := two_16up.io.B_out
        resultup_16  := Addup.io.sum

        result_32 := Cat(resultup_16,resultlow_16).asSInt
      }
    }

    io.result := result_32
}