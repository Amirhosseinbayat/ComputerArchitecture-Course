module decode(input  logic clk, reset,
              input  logic [6:0] Op,
              input  logic [2:0] Funct3,
              input  logic Funct7,
              output logic Branch, PCUpdate,
              output logic IRWrite, AdrSrc,
	      output logic RegWrite, MemWrite,
              output logic [1:0] ResultSrc, ALUSrcB, ALUSrcA,
              output logic [1:0] ImmSrc,
	      output logic [2:0] ALUControl);


  logic [1:0] ALUOp;

	ControlUnit cu(clk, reset,
				   Op,
				   PCUpdate, Branch, ALUOp, IRWrite, AdrSrc, ALUSrcA,
				   ResultSrc, ALUSrcB, MemWrite, RegWrite);

	always_comb
		case (Op)
			7'b0010011: ImmSrc = 2'b00;
			7'b0000011: ImmSrc = 2'b00;
			7'b0100011: ImmSrc = 2'b01;
			7'b1100011: ImmSrc = 2'b10;
			7'b1101111: ImmSrc = 2'b11;
			default: ImmSrc = 2'bXX;
		endcase



	logic [4:0] f = {funct3, op[5], funct7};
	always_comb
		case (ALUOp)
			2'b00: ALUControl = 3'b000;
			2'b01: ALUControl = 3'b001
			2'b10: begin
					case (f)
						5'b00000: ALUControl = 3'b000;
						5'b00001: ALUControl = 3'b000;
						5'b00010: ALUControl = 3'b000;
						5'b00011: ALUControl = 3'b001;
						5'b010XX: ALUControl = 3'b101;
						5'b110XX: ALUControl = 3'b011;
						5'b111XX: ALUControl = 3'b010;
					endcase
				end
		endcase


	assign PCWrite = ((Branch == 1'b1) & Zero) | PCUpdate;


endmodule
