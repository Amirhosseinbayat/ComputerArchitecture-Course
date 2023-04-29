module riscvsingle (input logic clk,reset,
            output  logic   [31:0]   PC,
				input   logic   [31:0]    Instr, 
				output  logic              MemWrite, 
				output  logic  [31:0]   ALUResult, WriteData, 
				input     logic  [31:0]  ReadData); 
	logic           ALUSrc, RegWrite, Jump, Zero; 
	logic [1:0] ResultSrc, ImmSrc; 
	logic [2:0] ALUControl; 
	controller c(Instr[6:0], Instr[14:12], Instr[30], Zero, 
                 ResultSrc, MemWrite, PCSrc, 				
			ALUSrc, RegWrite, Jump, ImmSrc,  ALUControl,PCResultSrc); 	// changed by me for jalr
	datapath dp(clk, reset, ResultSrc, PCSrc, 
			ALUSrc,  RegWrite, ImmSrc,  
			ALUControl, Zero, PC, Instr, 
			ALUResult, WriteData, ReadData,PCResultSrc);				// changed by me for jalr
endmodule




module controller(input     logic [6:0] op,
                      input     logic [2:0] funct3,
                      input     logic           funct7b5,
                      input     logic           Zero,
                      output logic [1:0] ResultSrc,
                      output logic           MemWrite, ALUSrc,
                  	  output logic        	 PCSrc,			
                      output logic           RegWrite, Jump,
                      output logic [1:0] ImmSrc,
                  output logic [2:0] ALUControl,
                  	  output logic PCResultSrc); 				// changed by me for jalr
	logic [1:0] ALUOp; 
	logic           Branch; 
	
	maindec md(op, ResultSrc, MemWrite, Branch,
                   ALUSrc, RegWrite, Jump, ImmSrc, ALUOp,jalr); // changed by me for jalr

	aludec   ad(op[5], funct3, funct7b5, ALUOp, ALUControl); 

  assign PCSrc = Branch & Zero | Jump;	
  assign PCResultSrc = jalr;										// changed by me for jalr
endmodule


module maindec(input     logic [6:0] op,output logic [1:0] ResultSrc,
              output logic           MemWrite,
              output logic           Branch, ALUSrc,
	      output logic           RegWrite, Jump,
               output logic [1:0] ImmSrc,output logic [1:0] ALUOp,output logic jalr);	// changed by me for jalr
  logic [11:0] controls;								// changed by me for jalr
    assign {RegWrite, ImmSrc, ALUSrc, MemWrite,
    ResultSrc, Branch, ALUOp, Jump,jalr} = controls;	// changed by me for jalr
    always_comb       									// changed by me for jalr
	case(op)       
		// RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump
		7'b0000011: controls = 11'b1_00_1_0_01_0_00_0x; // lw
	        7'b0100011: controls = 11'b0_01_1_1_00_0_00_0x; // sw
	        7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0x; // R?type
	        7'b1100011: controls = 11'b0_10_0_0_00_1_01_00; // beq 
	        7'b0010011: controls = 11'b1_00_1_0_00_0_10_0x; // I?type ALU  //addi already supported (also check ALU).
	        7'b1101111: controls = 11'b1_11_0_0_10_0_00_10; // jal				// jalr already supported
	        7'b1100111: controls = 11'b1_11_0_0_10_0_00_11; // jalr
		default:        controls = 11'bx_xx_x_x_xx_x_xx_xx; // ???           
	endcase
endmodule

module aludec(input     logic           opb5,
		input     logic [2:0] funct3,
		input     logic           funct7b5,
		input     logic [1:0] ALUOp,
		output logic [2:0] ALUControl);

    logic   RtypeSub;
    assign RtypeSub = funct7b5 & opb5;  // TRUE for R?type subtract    

	always_comb       
	case(ALUOp)
              2'b00:  ALUControl = 3'b000; // addition
              2'b01:ALUControl = 3'b001; // subtraction
              default: case(funct3) // R?type or I?type ALU
              		3'b000:    if (RtypeSub)
			        	ALUControl = 3'b001; // sub    
				   else
   					ALUControl = 3'b000; // add, addi
                        3'b010:       ALUControl = 3'b101; // slt, slti
                        3'b110:       ALUControl = 3'b011; // or, ori 
                        3'b111:       ALUControl = 3'b010; // and, andi 
                        default:        ALUControl = 3'bxxx; // ??? 
	              endcase            
	endcase

endmodule



module datapath(input     logic             clk,
		reset,input     logic [1:0]    ResultSrc,
		input     logic PCSrc, ALUSrc, 
		input     logic             RegWrite, 
		input     logic [1:0]     ImmSrc, 
		input     logic [2:0]     ALUControl, 
		output logic Zero, output logic [31:0] PC, 
		input     logic  [31:0]  Instr, 
		output logic [31:0] ALUResult, WriteData, 
        input     logic  [31:0]  ReadData,
                input	logic	PCResultSrc);			// changed by me for jalr
  
    logic [31:0] PCNext, PCPlus4, PCTarget;
    logic [31:0] ImmExt;
    logic [31:0] SrcA, SrcB;
    logic [31:0] Result;    // next PC logic    
	
	flopr #(32) pcreg(clk, reset, PCNext, PC);    
	
	adder           pcadd4(PC, 32'd4, PCPlus4);    
	adder           pcaddbranch(PC, ImmExt, PCTarget);    
	
	mux2 #(32)     pcmux(PCPlus4, PCResultTarget, PCSrc, PCNext);    // register file logic    // changed by me for jalr
	
	regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20],
			Instr[11:7], Result, SrcA, WriteData);     
	
	extend         ext(Instr[31:7], ImmSrc, ImmExt);    // ALU logic    
	
	mux2 #(32)   srcbmux(WriteData, ImmExt, ALUSrc, SrcB);    
  
  mux2 #(32)   pcsrcmux( ALUResult,PCTarget, PCResultSrc,PCResultTarget );    // changed by me for jalr
	
	alu              alu(SrcA, SrcB, ALUControl, ALUResult, Zero);      
	mux3 #(32)   resultmux( ALUResult, ReadData, PCPlus4,ResultSrc, Result);
	
endmodule




module adder(input   [31:0] a, b,output [31:0] y);
      assign y = a + b;
endmodule






module extend(input   logic [31:7] instr,
		input   logic [1:0]   immsrc,
                output logic [31:0] immext);
    always_comb       
	case(immsrc)
                       // I?type
           2'b00:      immext = {{20{instr[31]}},instr[31:20]};
                       // S?type (stores)
			  2'b01:     immext = {{20{instr[31]}},instr[31:25],instr[11:7]} ;
                       // B?type (branches)
           2'b10:      immext = {{20{instr [31] }},instr [7],instr[30:25],instr[11:8],1'b0};
                       // J?type (jal)
           2'b11:      immext = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};
           default: immext = 32'bx; // undefined           

	endcase

endmodule

module flopr #(parameter WIDTH = 8)(input     logic                     clk, reset,
				    input     logic [WIDTH-1:0] d,output logic [WIDTH-1:0] q);
    always_ff @(posedge clk, posedge reset)
 	if (reset) q <= 0;
        else       q <= d;

endmodule

module flopenr #(parameter WIDTH = 8)
               (input     logic                     clk, reset, en,
		input     logic [WIDTH-1:0] d,
		output logic [WIDTH-1:0] q); 
always_ff @(posedge clk, posedge reset)
      if (reset)      q <= 0;
      else if (en) q <= d;

endmodule

module mux2 #(parameter WIDTH = 8)(input     logic [WIDTH-1:0] d0, d1,
	      input     logic                     s,
	      output logic [WIDTH-1:0] y);      
	assign y = s ? d1 : d0;

endmodule

module mux3 #(parameter WIDTH = 8)
             (input     logic [WIDTH-1:0] d0, d1, d2,
	      input     logic [1:0] s,
	      output logic [WIDTH-1:0] y);

      assign y = s[1] ? d2 : (s[0] ? d1 : d0);

endmodule



module regfile(input  logic   clk,
               input  logic    we3,
               input  logic  [4:0]  a1, a2, a3,
               input  logic  [31:0] wd3, 
               output logic  [31:0] rd1, rd2);
  logic [31:0] rf[31:0];// three ported register file// read two ports combinationally (A1/RD1, A2/RD2)// write third port on rising edge of clock (A3/WD3/WE3)// register 0 hardwired to 0
  always_ff @(posedge clk) 
    if (we3) rf[a3] <= wd3;
  assign rd1 = (a1 != 0) ? rf[a1] : 0;
  assign rd2 = (a2 != 0) ? rf[a2] : 0;
endmodule



module alu(input      logic   [31:0]SrcA,
           input      logic   [31:0]SrcB,
           input      logic   [2:0] ALUControl,
           output     logic   [31:0]ALUResult,
           output     logic   		Zero);  

	parameter S0 = 3'b000; //ADD
	parameter S1 = 3'b001; //SUB
	parameter S2 = 3'b010; //AND
	parameter S3 = 3'b011; //OR
	parameter S4 = 3'b100; //
	parameter S5 = 3'b101; //SET LESS THAN
	parameter S6 = 3'b110; //
	parameter S7 = 3'b111; //
  
	always
	case(ALUControl)
	S0: ALUResult = SrcA + SrcB;
	S1: ALUResult = SrcA - SrcB;
	S2: ALUResult = SrcA & SrcB;
	S3: ALUResult = SrcA | SrcB;
   S5: if (SrcA < SrcB)
			ALUResult = 32'd1;    
		else
   		ALUResult = 32'd0;
	endcase
endmodule
