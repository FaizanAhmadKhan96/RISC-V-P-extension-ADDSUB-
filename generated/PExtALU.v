module TwosComplement(
  input  [31:0] io_B_in,
  output [31:0] io_B_out
);
  wire [31:0] _B_temp_T = ~io_B_in; // @[RISCVALU.scala 31:19]
  assign io_B_out = _B_temp_T + 32'h1; // @[RISCVALU.scala 31:31]
endmodule
module TwosComplement_1(
  input  [15:0] io_B_in,
  output [15:0] io_B_out
);
  wire [15:0] _B_temp_T = ~io_B_in; // @[RISCVALU.scala 31:19]
  assign io_B_out = _B_temp_T + 16'h1; // @[RISCVALU.scala 31:31]
endmodule
module Adder(
  input  [31:0] io_A_in,
  input  [31:0] io_B_in,
  output [31:0] io_sum
);
  assign io_sum = io_A_in + io_B_in; // @[RISCVALU.scala 44:41]
endmodule
module Adder_1(
  input  [15:0] io_A_in,
  input  [15:0] io_B_in,
  output [15:0] io_sum
);
  assign io_sum = io_A_in + io_B_in; // @[RISCVALU.scala 44:41]
endmodule
module PExtALU(
  input         clock,
  input         reset,
  input  [31:0] io_operand_A,
  input  [31:0] io_operand_B,
  input  [2:0]  io_ALU_SEL,
  output [31:0] io_result
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] two_32_io_B_in; // @[RISCVALU.scala 73:22]
  wire [31:0] two_32_io_B_out; // @[RISCVALU.scala 73:22]
  wire [15:0] twolow_16_io_B_in; // @[RISCVALU.scala 74:25]
  wire [15:0] twolow_16_io_B_out; // @[RISCVALU.scala 74:25]
  wire [15:0] twoup_16_io_B_in; // @[RISCVALU.scala 75:24]
  wire [15:0] twoup_16_io_B_out; // @[RISCVALU.scala 75:24]
  wire [31:0] Add_io_A_in; // @[RISCVALU.scala 77:19]
  wire [31:0] Add_io_B_in; // @[RISCVALU.scala 77:19]
  wire [31:0] Add_io_sum; // @[RISCVALU.scala 77:19]
  wire [15:0] Addlow_16_io_A_in; // @[RISCVALU.scala 78:25]
  wire [15:0] Addlow_16_io_B_in; // @[RISCVALU.scala 78:25]
  wire [15:0] Addlow_16_io_sum; // @[RISCVALU.scala 78:25]
  wire [15:0] Addup_16_io_A_in; // @[RISCVALU.scala 79:24]
  wire [15:0] Addup_16_io_B_in; // @[RISCVALU.scala 79:24]
  wire [15:0] Addup_16_io_sum; // @[RISCVALU.scala 79:24]
  wire [15:0] Aup_16 = io_operand_A[31:16]; // @[RISCVALU.scala 60:28]
  wire [15:0] Alow_16 = io_operand_A[15:0]; // @[RISCVALU.scala 61:29]
  wire [15:0] Bup_16 = io_operand_B[31:16]; // @[RISCVALU.scala 62:28]
  wire [15:0] Blow_16 = io_operand_B[15:0]; // @[RISCVALU.scala 63:29]
  reg [31:0] result_32; // @[RISCVALU.scala 65:22]
  reg [15:0] resultup_16; // @[RISCVALU.scala 66:24]
  reg [15:0] resultlow_16; // @[RISCVALU.scala 67:25]
  wire [31:0] _result_32_T_1 = {resultup_16,resultlow_16}; // @[RISCVALU.scala 121:52]
  wire [15:0] _GEN_0 = 3'h5 == io_ALU_SEL ? Alow_16 : 16'h0; // @[RISCVALU.scala 92:24 158:27 87:21]
  wire [15:0] _GEN_1 = 3'h5 == io_ALU_SEL ? Bup_16 : 16'h0; // @[RISCVALU.scala 92:24 159:27 88:21]
  wire [15:0] _GEN_2 = 3'h5 == io_ALU_SEL ? $signed(Addlow_16_io_sum) : $signed(16'sh0); // @[RISCVALU.scala 160:23 71:16 92:24]
  wire [15:0] _GEN_3 = 3'h5 == io_ALU_SEL ? Blow_16 : 16'h0; // @[RISCVALU.scala 92:24 162:26 84:20]
  wire [15:0] _GEN_4 = 3'h5 == io_ALU_SEL ? Aup_16 : 16'h0; // @[RISCVALU.scala 92:24 164:26 89:20]
  wire [15:0] _GEN_5 = 3'h5 == io_ALU_SEL ? twoup_16_io_B_out : 16'h0; // @[RISCVALU.scala 92:24 165:26 90:20]
  wire [15:0] _GEN_6 = 3'h5 == io_ALU_SEL ? $signed(Addup_16_io_sum) : $signed(16'sh0); // @[RISCVALU.scala 166:22 70:15 92:24]
  wire [31:0] _GEN_7 = 3'h5 == io_ALU_SEL ? $signed(_result_32_T_1) : $signed(32'sh0); // @[RISCVALU.scala 168:19 69:13 92:24]
  wire [15:0] _GEN_8 = 3'h4 == io_ALU_SEL ? Bup_16 : 16'h0; // @[RISCVALU.scala 92:24 143:27 83:21]
  wire [15:0] _GEN_9 = 3'h4 == io_ALU_SEL ? Alow_16 : _GEN_0; // @[RISCVALU.scala 92:24 145:27]
  wire [15:0] _GEN_10 = 3'h4 == io_ALU_SEL ? twolow_16_io_B_out : _GEN_1; // @[RISCVALU.scala 92:24 146:27]
  wire [15:0] _GEN_11 = 3'h4 == io_ALU_SEL ? $signed(Addlow_16_io_sum) : $signed(_GEN_2); // @[RISCVALU.scala 147:23 92:24]
  wire [15:0] _GEN_12 = 3'h4 == io_ALU_SEL ? Aup_16 : _GEN_4; // @[RISCVALU.scala 92:24 149:26]
  wire [15:0] _GEN_13 = 3'h4 == io_ALU_SEL ? Blow_16 : _GEN_5; // @[RISCVALU.scala 92:24 150:26]
  wire [15:0] _GEN_14 = 3'h4 == io_ALU_SEL ? $signed(Addup_16_io_sum) : $signed(_GEN_6); // @[RISCVALU.scala 151:22 92:24]
  wire [31:0] _GEN_15 = 3'h4 == io_ALU_SEL ? $signed(_result_32_T_1) : $signed(_GEN_7); // @[RISCVALU.scala 153:19 92:24]
  wire [15:0] _GEN_16 = 3'h4 == io_ALU_SEL ? 16'h0 : _GEN_3; // @[RISCVALU.scala 84:20 92:24]
  wire [15:0] _GEN_17 = 3'h3 == io_ALU_SEL ? Blow_16 : _GEN_8; // @[RISCVALU.scala 92:24 126:27]
  wire [15:0] _GEN_18 = 3'h3 == io_ALU_SEL ? Alow_16 : _GEN_9; // @[RISCVALU.scala 92:24 128:27]
  wire [15:0] _GEN_19 = 3'h3 == io_ALU_SEL ? twolow_16_io_B_out : _GEN_10; // @[RISCVALU.scala 92:24 129:27]
  wire [15:0] _GEN_21 = 3'h3 == io_ALU_SEL ? Bup_16 : _GEN_16; // @[RISCVALU.scala 92:24 132:26]
  wire [15:0] _GEN_22 = 3'h3 == io_ALU_SEL ? Aup_16 : _GEN_12; // @[RISCVALU.scala 92:24 134:26]
  wire [15:0] _GEN_23 = 3'h3 == io_ALU_SEL ? twoup_16_io_B_out : _GEN_13; // @[RISCVALU.scala 92:24 135:26]
  wire [15:0] _GEN_26 = 3'h2 == io_ALU_SEL ? Alow_16 : _GEN_18; // @[RISCVALU.scala 92:24 113:27]
  wire [15:0] _GEN_27 = 3'h2 == io_ALU_SEL ? Blow_16 : _GEN_19; // @[RISCVALU.scala 92:24 114:27]
  wire [15:0] _GEN_29 = 3'h2 == io_ALU_SEL ? Aup_16 : _GEN_22; // @[RISCVALU.scala 92:24 117:26]
  wire [15:0] _GEN_30 = 3'h2 == io_ALU_SEL ? Bup_16 : _GEN_23; // @[RISCVALU.scala 92:24 118:26]
  wire [15:0] _GEN_33 = 3'h2 == io_ALU_SEL ? 16'h0 : _GEN_17; // @[RISCVALU.scala 83:21 92:24]
  wire [15:0] _GEN_34 = 3'h2 == io_ALU_SEL ? 16'h0 : _GEN_21; // @[RISCVALU.scala 84:20 92:24]
  wire [31:0] _GEN_35 = 3'h1 == io_ALU_SEL ? io_operand_B : 32'h0; // @[RISCVALU.scala 103:24 82:18 92:24]
  wire [31:0] _GEN_36 = 3'h1 == io_ALU_SEL ? io_operand_A : 32'h0; // @[RISCVALU.scala 105:21 85:15 92:24]
  wire [31:0] _GEN_37 = 3'h1 == io_ALU_SEL ? two_32_io_B_out : 32'h0; // @[RISCVALU.scala 106:21 86:15 92:24]
  wire [15:0] _GEN_39 = 3'h1 == io_ALU_SEL ? 16'h0 : _GEN_26; // @[RISCVALU.scala 87:21 92:24]
  wire [15:0] _GEN_40 = 3'h1 == io_ALU_SEL ? 16'h0 : _GEN_27; // @[RISCVALU.scala 88:21 92:24]
  wire [15:0] _GEN_42 = 3'h1 == io_ALU_SEL ? 16'h0 : _GEN_29; // @[RISCVALU.scala 89:20 92:24]
  wire [15:0] _GEN_43 = 3'h1 == io_ALU_SEL ? 16'h0 : _GEN_30; // @[RISCVALU.scala 90:20 92:24]
  wire [15:0] _GEN_45 = 3'h1 == io_ALU_SEL ? 16'h0 : _GEN_33; // @[RISCVALU.scala 83:21 92:24]
  wire [15:0] _GEN_46 = 3'h1 == io_ALU_SEL ? 16'h0 : _GEN_34; // @[RISCVALU.scala 84:20 92:24]
  TwosComplement two_32 ( // @[RISCVALU.scala 73:22]
    .io_B_in(two_32_io_B_in),
    .io_B_out(two_32_io_B_out)
  );
  TwosComplement_1 twolow_16 ( // @[RISCVALU.scala 74:25]
    .io_B_in(twolow_16_io_B_in),
    .io_B_out(twolow_16_io_B_out)
  );
  TwosComplement_1 twoup_16 ( // @[RISCVALU.scala 75:24]
    .io_B_in(twoup_16_io_B_in),
    .io_B_out(twoup_16_io_B_out)
  );
  Adder Add ( // @[RISCVALU.scala 77:19]
    .io_A_in(Add_io_A_in),
    .io_B_in(Add_io_B_in),
    .io_sum(Add_io_sum)
  );
  Adder_1 Addlow_16 ( // @[RISCVALU.scala 78:25]
    .io_A_in(Addlow_16_io_A_in),
    .io_B_in(Addlow_16_io_B_in),
    .io_sum(Addlow_16_io_sum)
  );
  Adder_1 Addup_16 ( // @[RISCVALU.scala 79:24]
    .io_A_in(Addup_16_io_A_in),
    .io_B_in(Addup_16_io_B_in),
    .io_sum(Addup_16_io_sum)
  );
  assign io_result = result_32; // @[RISCVALU.scala 172:15]
  assign two_32_io_B_in = 3'h0 == io_ALU_SEL ? 32'h0 : _GEN_35; // @[RISCVALU.scala 82:18 92:24]
  assign twolow_16_io_B_in = 3'h0 == io_ALU_SEL ? 16'h0 : _GEN_45; // @[RISCVALU.scala 83:21 92:24]
  assign twoup_16_io_B_in = 3'h0 == io_ALU_SEL ? 16'h0 : _GEN_46; // @[RISCVALU.scala 84:20 92:24]
  assign Add_io_A_in = 3'h0 == io_ALU_SEL ? io_operand_A : _GEN_36; // @[RISCVALU.scala 92:24 95:21]
  assign Add_io_B_in = 3'h0 == io_ALU_SEL ? io_operand_B : _GEN_37; // @[RISCVALU.scala 92:24 96:21]
  assign Addlow_16_io_A_in = 3'h0 == io_ALU_SEL ? 16'h0 : _GEN_39; // @[RISCVALU.scala 87:21 92:24]
  assign Addlow_16_io_B_in = 3'h0 == io_ALU_SEL ? 16'h0 : _GEN_40; // @[RISCVALU.scala 88:21 92:24]
  assign Addup_16_io_A_in = 3'h0 == io_ALU_SEL ? 16'h0 : _GEN_42; // @[RISCVALU.scala 89:20 92:24]
  assign Addup_16_io_B_in = 3'h0 == io_ALU_SEL ? 16'h0 : _GEN_43; // @[RISCVALU.scala 90:20 92:24]
  always @(posedge clock) begin
    if (3'h0 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      result_32 <= Add_io_sum; // @[RISCVALU.scala 98:18]
    end else if (3'h1 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      result_32 <= Add_io_sum; // @[RISCVALU.scala 108:18]
    end else if (3'h2 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      result_32 <= _result_32_T_1; // @[RISCVALU.scala 121:19]
    end else if (3'h3 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      result_32 <= _result_32_T_1; // @[RISCVALU.scala 138:18]
    end else begin
      result_32 <= _GEN_15;
    end
    if (3'h0 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      resultup_16 <= 16'sh0; // @[RISCVALU.scala 70:15]
    end else if (3'h1 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      resultup_16 <= 16'sh0; // @[RISCVALU.scala 70:15]
    end else if (3'h2 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      resultup_16 <= Addup_16_io_sum; // @[RISCVALU.scala 119:22]
    end else if (3'h3 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      resultup_16 <= Addup_16_io_sum; // @[RISCVALU.scala 136:22]
    end else begin
      resultup_16 <= _GEN_14;
    end
    if (3'h0 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      resultlow_16 <= 16'sh0; // @[RISCVALU.scala 71:16]
    end else if (3'h1 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      resultlow_16 <= 16'sh0; // @[RISCVALU.scala 71:16]
    end else if (3'h2 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      resultlow_16 <= Addlow_16_io_sum; // @[RISCVALU.scala 115:23]
    end else if (3'h3 == io_ALU_SEL) begin // @[RISCVALU.scala 92:24]
      resultlow_16 <= Addlow_16_io_sum; // @[RISCVALU.scala 130:23]
    end else begin
      resultlow_16 <= _GEN_11;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  result_32 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  resultup_16 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  resultlow_16 = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
