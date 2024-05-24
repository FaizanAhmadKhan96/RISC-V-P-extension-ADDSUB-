circuit PExtALU :
  module TwosComplement :
    input clock : Clock
    input reset : Reset
    output io : { flip B_in : UInt<32>, B_out : UInt<32>}

    node _B_temp_T = not(io.B_in) @[RISCVALU.scala 31:19]
    node _B_temp_T_1 = add(_B_temp_T, UInt<1>("h1")) @[RISCVALU.scala 31:31]
    node B_temp = tail(_B_temp_T_1, 1) @[RISCVALU.scala 31:31]
    io.B_out <= B_temp @[RISCVALU.scala 33:15]

  module TwosComplement_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip B_in : UInt<16>, B_out : UInt<16>}

    node _B_temp_T = not(io.B_in) @[RISCVALU.scala 31:19]
    node _B_temp_T_1 = add(_B_temp_T, UInt<1>("h1")) @[RISCVALU.scala 31:31]
    node B_temp = tail(_B_temp_T_1, 1) @[RISCVALU.scala 31:31]
    io.B_out <= B_temp @[RISCVALU.scala 33:15]

  module TwosComplement_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip B_in : UInt<16>, B_out : UInt<16>}

    node _B_temp_T = not(io.B_in) @[RISCVALU.scala 31:19]
    node _B_temp_T_1 = add(_B_temp_T, UInt<1>("h1")) @[RISCVALU.scala 31:31]
    node B_temp = tail(_B_temp_T_1, 1) @[RISCVALU.scala 31:31]
    io.B_out <= B_temp @[RISCVALU.scala 33:15]

  module Adder :
    input clock : Clock
    input reset : Reset
    output io : { flip A_in : UInt<32>, flip B_in : UInt<32>, sum : SInt<32>}

    node _sum_temp_T = add(io.A_in, io.B_in) @[RISCVALU.scala 44:30]
    node _sum_temp_T_1 = tail(_sum_temp_T, 1) @[RISCVALU.scala 44:30]
    node sum_temp = asSInt(_sum_temp_T_1) @[RISCVALU.scala 44:41]
    io.sum <= sum_temp @[RISCVALU.scala 46:13]

  module Adder_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip A_in : UInt<16>, flip B_in : UInt<16>, sum : SInt<16>}

    node _sum_temp_T = add(io.A_in, io.B_in) @[RISCVALU.scala 44:30]
    node _sum_temp_T_1 = tail(_sum_temp_T, 1) @[RISCVALU.scala 44:30]
    node sum_temp = asSInt(_sum_temp_T_1) @[RISCVALU.scala 44:41]
    io.sum <= sum_temp @[RISCVALU.scala 46:13]

  module Adder_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip A_in : UInt<16>, flip B_in : UInt<16>, sum : SInt<16>}

    node _sum_temp_T = add(io.A_in, io.B_in) @[RISCVALU.scala 44:30]
    node _sum_temp_T_1 = tail(_sum_temp_T, 1) @[RISCVALU.scala 44:30]
    node sum_temp = asSInt(_sum_temp_T_1) @[RISCVALU.scala 44:41]
    io.sum <= sum_temp @[RISCVALU.scala 46:13]

  module PExtALU :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip operand_A : UInt<32>, flip operand_B : UInt<32>, flip ALU_SEL : UInt<3>, result : SInt<32>}

    node Aup_16 = bits(io.operand_A, 31, 16) @[RISCVALU.scala 60:28]
    node Alow_16 = bits(io.operand_A, 15, 0) @[RISCVALU.scala 61:29]
    node Bup_16 = bits(io.operand_B, 31, 16) @[RISCVALU.scala 62:28]
    node Blow_16 = bits(io.operand_B, 15, 0) @[RISCVALU.scala 63:29]
    reg result_32 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), result_32) @[RISCVALU.scala 65:22]
    reg resultup_16 : SInt<16>, clock with :
      reset => (UInt<1>("h0"), resultup_16) @[RISCVALU.scala 66:24]
    reg resultlow_16 : SInt<16>, clock with :
      reset => (UInt<1>("h0"), resultlow_16) @[RISCVALU.scala 67:25]
    result_32 <= asSInt(UInt<1>("h0")) @[RISCVALU.scala 69:13]
    resultup_16 <= asSInt(UInt<1>("h0")) @[RISCVALU.scala 70:15]
    resultlow_16 <= asSInt(UInt<1>("h0")) @[RISCVALU.scala 71:16]
    inst two_32 of TwosComplement @[RISCVALU.scala 73:22]
    two_32.clock <= clock
    two_32.reset <= reset
    inst twolow_16 of TwosComplement_1 @[RISCVALU.scala 74:25]
    twolow_16.clock <= clock
    twolow_16.reset <= reset
    inst twoup_16 of TwosComplement_2 @[RISCVALU.scala 75:24]
    twoup_16.clock <= clock
    twoup_16.reset <= reset
    inst Add of Adder @[RISCVALU.scala 77:19]
    Add.clock <= clock
    Add.reset <= reset
    inst Addlow_16 of Adder_1 @[RISCVALU.scala 78:25]
    Addlow_16.clock <= clock
    Addlow_16.reset <= reset
    inst Addup_16 of Adder_2 @[RISCVALU.scala 79:24]
    Addup_16.clock <= clock
    Addup_16.reset <= reset
    two_32.io.B_in <= UInt<1>("h0") @[RISCVALU.scala 82:18]
    twolow_16.io.B_in <= UInt<1>("h0") @[RISCVALU.scala 83:21]
    twoup_16.io.B_in <= UInt<1>("h0") @[RISCVALU.scala 84:20]
    Add.io.A_in <= UInt<1>("h0") @[RISCVALU.scala 85:15]
    Add.io.B_in <= UInt<1>("h0") @[RISCVALU.scala 86:15]
    Addlow_16.io.A_in <= UInt<1>("h0") @[RISCVALU.scala 87:21]
    Addlow_16.io.B_in <= UInt<1>("h0") @[RISCVALU.scala 88:21]
    Addup_16.io.A_in <= UInt<1>("h0") @[RISCVALU.scala 89:20]
    Addup_16.io.B_in <= UInt<1>("h0") @[RISCVALU.scala 90:20]
    node _T = asUInt(UInt<1>("h0")) @[RISCVALU.scala 92:24]
    node _T_1 = asUInt(io.ALU_SEL) @[RISCVALU.scala 92:24]
    node _T_2 = eq(_T, _T_1) @[RISCVALU.scala 92:24]
    when _T_2 : @[RISCVALU.scala 92:24]
      Add.io.A_in <= io.operand_A @[RISCVALU.scala 95:21]
      Add.io.B_in <= io.operand_B @[RISCVALU.scala 96:21]
      result_32 <= Add.io.sum @[RISCVALU.scala 98:18]
    else :
      node _T_3 = asUInt(UInt<1>("h1")) @[RISCVALU.scala 92:24]
      node _T_4 = asUInt(io.ALU_SEL) @[RISCVALU.scala 92:24]
      node _T_5 = eq(_T_3, _T_4) @[RISCVALU.scala 92:24]
      when _T_5 : @[RISCVALU.scala 92:24]
        two_32.io.B_in <= io.operand_B @[RISCVALU.scala 103:24]
        Add.io.A_in <= io.operand_A @[RISCVALU.scala 105:21]
        Add.io.B_in <= two_32.io.B_out @[RISCVALU.scala 106:21]
        result_32 <= Add.io.sum @[RISCVALU.scala 108:18]
      else :
        node _T_6 = asUInt(UInt<2>("h2")) @[RISCVALU.scala 92:24]
        node _T_7 = asUInt(io.ALU_SEL) @[RISCVALU.scala 92:24]
        node _T_8 = eq(_T_6, _T_7) @[RISCVALU.scala 92:24]
        when _T_8 : @[RISCVALU.scala 92:24]
          Addlow_16.io.A_in <= Alow_16 @[RISCVALU.scala 113:27]
          Addlow_16.io.B_in <= Blow_16 @[RISCVALU.scala 114:27]
          resultlow_16 <= Addlow_16.io.sum @[RISCVALU.scala 115:23]
          Addup_16.io.A_in <= Aup_16 @[RISCVALU.scala 117:26]
          Addup_16.io.B_in <= Bup_16 @[RISCVALU.scala 118:26]
          resultup_16 <= Addup_16.io.sum @[RISCVALU.scala 119:22]
          node result_32_lo = asUInt(resultlow_16) @[Cat.scala 33:92]
          node result_32_hi = asUInt(resultup_16) @[Cat.scala 33:92]
          node _result_32_T = cat(result_32_hi, result_32_lo) @[Cat.scala 33:92]
          node _result_32_T_1 = asSInt(_result_32_T) @[RISCVALU.scala 121:52]
          result_32 <= _result_32_T_1 @[RISCVALU.scala 121:19]
        else :
          node _T_9 = asUInt(UInt<2>("h3")) @[RISCVALU.scala 92:24]
          node _T_10 = asUInt(io.ALU_SEL) @[RISCVALU.scala 92:24]
          node _T_11 = eq(_T_9, _T_10) @[RISCVALU.scala 92:24]
          when _T_11 : @[RISCVALU.scala 92:24]
            twolow_16.io.B_in <= Blow_16 @[RISCVALU.scala 126:27]
            Addlow_16.io.A_in <= Alow_16 @[RISCVALU.scala 128:27]
            Addlow_16.io.B_in <= twolow_16.io.B_out @[RISCVALU.scala 129:27]
            resultlow_16 <= Addlow_16.io.sum @[RISCVALU.scala 130:23]
            twoup_16.io.B_in <= Bup_16 @[RISCVALU.scala 132:26]
            Addup_16.io.A_in <= Aup_16 @[RISCVALU.scala 134:26]
            Addup_16.io.B_in <= twoup_16.io.B_out @[RISCVALU.scala 135:26]
            resultup_16 <= Addup_16.io.sum @[RISCVALU.scala 136:22]
            node result_32_lo_1 = asUInt(resultlow_16) @[Cat.scala 33:92]
            node result_32_hi_1 = asUInt(resultup_16) @[Cat.scala 33:92]
            node _result_32_T_2 = cat(result_32_hi_1, result_32_lo_1) @[Cat.scala 33:92]
            node _result_32_T_3 = asSInt(_result_32_T_2) @[RISCVALU.scala 138:51]
            result_32 <= _result_32_T_3 @[RISCVALU.scala 138:18]
          else :
            node _T_12 = asUInt(UInt<3>("h4")) @[RISCVALU.scala 92:24]
            node _T_13 = asUInt(io.ALU_SEL) @[RISCVALU.scala 92:24]
            node _T_14 = eq(_T_12, _T_13) @[RISCVALU.scala 92:24]
            when _T_14 : @[RISCVALU.scala 92:24]
              twolow_16.io.B_in <= Bup_16 @[RISCVALU.scala 143:27]
              Addlow_16.io.A_in <= Alow_16 @[RISCVALU.scala 145:27]
              Addlow_16.io.B_in <= twolow_16.io.B_out @[RISCVALU.scala 146:27]
              resultlow_16 <= Addlow_16.io.sum @[RISCVALU.scala 147:23]
              Addup_16.io.A_in <= Aup_16 @[RISCVALU.scala 149:26]
              Addup_16.io.B_in <= Blow_16 @[RISCVALU.scala 150:26]
              resultup_16 <= Addup_16.io.sum @[RISCVALU.scala 151:22]
              node result_32_lo_2 = asUInt(resultlow_16) @[Cat.scala 33:92]
              node result_32_hi_2 = asUInt(resultup_16) @[Cat.scala 33:92]
              node _result_32_T_4 = cat(result_32_hi_2, result_32_lo_2) @[Cat.scala 33:92]
              node _result_32_T_5 = asSInt(_result_32_T_4) @[RISCVALU.scala 153:52]
              result_32 <= _result_32_T_5 @[RISCVALU.scala 153:19]
            else :
              node _T_15 = asUInt(UInt<3>("h5")) @[RISCVALU.scala 92:24]
              node _T_16 = asUInt(io.ALU_SEL) @[RISCVALU.scala 92:24]
              node _T_17 = eq(_T_15, _T_16) @[RISCVALU.scala 92:24]
              when _T_17 : @[RISCVALU.scala 92:24]
                Addlow_16.io.A_in <= Alow_16 @[RISCVALU.scala 158:27]
                Addlow_16.io.B_in <= Bup_16 @[RISCVALU.scala 159:27]
                resultlow_16 <= Addlow_16.io.sum @[RISCVALU.scala 160:23]
                twoup_16.io.B_in <= Blow_16 @[RISCVALU.scala 162:26]
                Addup_16.io.A_in <= Aup_16 @[RISCVALU.scala 164:26]
                Addup_16.io.B_in <= twoup_16.io.B_out @[RISCVALU.scala 165:26]
                resultup_16 <= Addup_16.io.sum @[RISCVALU.scala 166:22]
                node result_32_lo_3 = asUInt(resultlow_16) @[Cat.scala 33:92]
                node result_32_hi_3 = asUInt(resultup_16) @[Cat.scala 33:92]
                node _result_32_T_6 = cat(result_32_hi_3, result_32_lo_3) @[Cat.scala 33:92]
                node _result_32_T_7 = asSInt(_result_32_T_6) @[RISCVALU.scala 168:52]
                result_32 <= _result_32_T_7 @[RISCVALU.scala 168:19]
    io.result <= result_32 @[RISCVALU.scala 172:15]

