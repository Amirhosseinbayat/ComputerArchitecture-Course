

module mux32_1_tb ();
				logic [4:0] a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15,
            a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31, s, out;  

	mux32_1_32bit #(5) mux_tb(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15,
	a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31,
	s,
	out);

	initial begin         	
	a0 = 0; a1=1; a2=2; a3=3; a4=4; a5=5; a6=6; a7=7; a8=8; a9=9; a10=10; a11=11; a12=12; a13=13; a14=14; a15=15;
	a16 = 16; a17=17; a18=18; a19=19; a20=20; a21=21; a22=22; a23=23; a24=24; a25=25; a26=26; a27=27; a28=28; a29=29; a30=30; a31=31;
	
	s=5'd0;
	#50;     
	s=5'd1;
	#50;     
	s=5'd2;
	#50;     
	s=5'd3;
	#50;     
	s=5'd8;
	#50;     
	s=5'd14;
	#50;     
	end

endmodule