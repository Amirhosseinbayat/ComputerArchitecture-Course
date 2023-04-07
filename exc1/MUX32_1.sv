module mux2_assign
     #(parameter width = 32)
     (input      logic [4:0] a0, a1,
	  input       logic             s,
	  output      logic [4:0] out);
	  
	  assign out = s ? a0 : a1;
endmodule


module mux2_if
     #(parameter width = 32)
     (input      logic [4:0] a0, a1,
	  input       logic             s,
	  output      logic [4:0] out);
	  
	  always @ (*)
		begin
		if (s)
			out = a0;
		else
			out = a1;
	  end
endmodule



module mux2_case
     #(parameter width = 32)
     (input      logic [4:0] a0, a1,
	  input       logic             s,
	  output      logic [4:0] out);
	  
	  always @ (*)
		begin
		case (s)
		1:	out = a0;
		0:	out = a1;
		default: out = 1'bx;
		endcase
	  end
endmodule


module mux4 

     #(parameter width = 32)
				(input    logic [4:0] a0, a1, a2, a3,
            input    logic [1:0]    s,                         
				output logic [4:0] out);     
				logic [4:0] low, hi;     
				
				mux2_case #(width) lowmux(a0, a1, s[0], low);     
				mux2_assign #(width) himux(a2, a3, s[0], hi);     
				mux2_if #(width) outmux(low, hi, s[1], out);
endmodule


module mux8

     #(parameter width = 32)
				(input    logic [4:0] a0, a1, a2, a3, a4, a5, a6, a7,
            input    logic [2:0]    s,                         
				output logic [4:0] out);     
				logic [4:0] low, hi;     
				
				mux4 #(width) lowmux(a0, a1, a2, a3, s[1:0], low);     
				mux4 #(width) himux(a4, a5, a6, a7, s[1:0], hi);     
				mux2_if #(width) outmux(low, hi, s[2], out);
endmodule
module mux16

     #(parameter width = 32)
				(input    logic [4:0] a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15,
            input    logic [3:0]    s,                         
				output logic [4:0] out);     
				logic [4:0] low, hi;     
				
				mux8 #(width) lowmux(a0, a1, a2, a3,a4, a5, a6, a7, s[2:0], low);     
				mux8 #(width) himux(a8, a9, a10, a11, a12, a13, a14, a15, s[2:0], hi);     
				mux2_if #(width) outmux(low, hi, s[3], out);
endmodule

module mux32_1_32bit

     #(parameter width = 32)
				(input    logic [4:0] a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15,
            input    logic [4:0] a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
				input    logic [4:0]    s,                         
				output logic [4:0] out);     
				logic [4:0] low, hi;     
				
				mux16 #(width) lowmux(a0, a1, a2, a3,a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, s[3:0], low);     
				mux16 #(width) himux(a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,s[3:0], hi);     
				mux2_if #(width) outmux(low, hi, s[4], out);
endmodule










