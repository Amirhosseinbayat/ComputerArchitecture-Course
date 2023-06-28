module ControlUnit(input logic clk, reset,
				   input logic [6:0] Op,
				   output logic Branch, PCUpdate,
				   output logic RegWrite, MemWrite, IRWrite, AdrSrc,
				   output logic [1:0] ResultSrc, ALUSrcA, ALUSrcB, ALUOp);

	SequentialLogic sl(clk, reset, Op, nextAdr, adr);

	ControlMemory cmem(adr, controlWord);

	ControlBufferRegister cbr(controlWord, nextAdr, PCUpdate, Branch, ALUOp, RegWrite,
	MemWrite, IRWrite, ALUSrcA, ALUSrcB, ResultSrc, AdrSrc);


endmodule
