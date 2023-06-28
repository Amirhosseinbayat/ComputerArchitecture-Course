module controller(input logic clk,
                  input logic reset,
                  input logic [31:0] Instr,
                  input logic  Zero,
                  output logic PCWrite,
                  output logic MemWrite,
                  output logic RegWrite,
                  output logic IRWrite,
                  output logic AdrSrc,
                  output logic [1:0] ALUSrcA,
                  output logic [1:0] ALUSrcB,
                  output logic [1:0] ResultSrc,
                  output logic [1:0] ImmSrc,
                  output logic [2:0] ALUControl);


  logic Branch, PCUpdate;

  decode dec(clk, reset, Instr[6:0], Instr[14:12], Instr[30],
             Branch, PCUpdate,
             IRWrite, AdrSrc, ALUSrcA, ResultSrc,
             ALUSrcB, ImmSrc, ALUControl, RegWrite, MemWrite);
endmodule
