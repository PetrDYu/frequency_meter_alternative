
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module frequency_meter(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	inout 		    [35:0]		GPIO
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire count_clk;
reg [24:0] del_count;
reg del;
wire aload_w;
wire [3:0] data4;
reg reg_0_1;
reg [3:0] reg_0_4;

wire [9:0][3:0] freq;
wire [9:0] cout;

wire add_w;
wire [3:0] add_d;

reg sclr;
wire cout_clk;

assign aload_w = reg_0_1;
assign data4 = reg_0_4;
assign count_clk = del;
//=======================================================
//  Structural coding
//=======================================================

initial
begin

	reg_0_1 = 1'b0;
	del_count = 25'b0;
	del = 1'b0;
	reg_0_4 = 4'd0;
	sclr = 1'b0;

end

Base_counter bc_clk
(
	
	.aclr(~KEY[0]),
	.clock(CLOCK_50),
	.cout(cout_clk),
	.q(del_count)
	
);

always @(negedge cout_clk)
begin
	
	del = del + 1'b1;
	
end

always @(cout_clk)
begin
	sclr = sclr + 1'b1;
end

assign LEDR[0] = del;

/*always @(posedge CLOCK_50)
begin

	del_count = del_count + 1'b1;
	sclr = 1'b0;
	
	if (del_count == 25'd25000000)
	begin
	
		del = del + 1'b1;
		del_count = 25'b0;
		
	end
	
	if(del_count == 25'd50000000)
	begin
		
		sclr = 1'b1;
		
	end
	
end*/

always @(negedge KEY[3])
begin
	
	reg_0_1 = reg_0_1 + 1'b1;
	
end

wire clk_mes, clk_op;

PLL_temp u_pll
(
	
	.refclk(CLOCK_50),
	.rst(KEY[0]),
	.outclk_1(clk_mes)
	
);

Counter u0
(
	.clock(CLOCK_50),
	.cout(cout[0]),
	.q(freq[0]),
	.aload(sclr),
	.data(4'b01),
	.aclr(~KEY[0]),
	.sclr(1'b0)
);

Counter u1
(
	.clock(~cout[0]),
	.cout(cout[1]),
	.q(freq[1]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

Counter u2
(
	.clock(~cout[1]),
	.cout(cout[2]),
	.q(freq[2]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

Counter u3
(
	.clock(~cout[2]),
	.cout(cout[3]),
	.q(freq[3]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

Counter u4
(
	.clock(~cout[3]),
	.cout(cout[4]),
	.q(freq[4]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

Counter u5
(
	.clock(~cout[4]),
	.cout(cout[5]),
	.q(freq[5]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

Counter u6
(
	.clock(~cout[5]),
	.cout(cout[6]),
	.q(freq[6]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

Counter u7
(
	.clock(~cout[6]),
	.cout(cout[7]),
	.q(freq[7]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

Counter u8
(
	.clock(~cout[7]),
	.cout(cout[8]),
	.q(freq[8]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

Counter u9
(
	.clock(~cout[8]),
	.cout(cout[9]),
	.q(freq[9]),
	.aload(aload_w),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(sclr)
);

SEG_HEX i0
(
	.iDIG(freq[3]),
	.oHEX_D(HEX0),
	.lock(count_clk)
);

SEG_HEX i1
(
	.iDIG(freq[4]),
	.oHEX_D(HEX1),
	.lock(count_clk)
);

SEG_HEX i2
(
	.iDIG(freq[5]),
	.oHEX_D(HEX2),
	.lock(count_clk)
);

SEG_HEX i3
(
	.iDIG(freq[6]),
	.oHEX_D(HEX3),
	.lock(count_clk)
);
SEG_HEX i4
(
	.iDIG(freq[7]),
	.oHEX_D(HEX4),
	.lock(count_clk)
);

SEG_HEX i5
(
	.iDIG(freq[8]),
	.oHEX_D(HEX5),
	.lock(count_clk)
);

//реализация SPI

wire done, ss_ind;
reg [7:0] tdata;
reg rstb;

/*if (done == 1)
begin

	rstb = 1'b0

end*/

/*initial
begin
	rstb = 1'b0;
end*/

/*always @(GPIO[3])
begin
	
	//rstb = rstb + 1'b1;
	
	if (GPIO[3] == 0)
		tdata = 8'd152;
	else
		tdata = 8'b0;
	
end*/

reg [3:0] i;
reg [9:0][3:0] freq_mem;

always @(negedge count_clk)
begin
	
	freq_mem = freq;
	
end

always @(posedge done)
begin
	
	tdata = freq_mem[i];
	
end

Counter count_n_freq
 (
	
	.clock(done),
	.q(i),
	.aload(1'b0),
	.data(data4),
	.aclr(1'b0),
	.sclr(1'b0)
	
 );

//assign LEDR[1] = ~GPIO[3];
//assign LEDR[2] = GPIO[1];
//assign LEDR[3] = rstb;

spi_slave spi
(
	
	.rstb(1'b1),
	.ten(1'b1),
	.tdata(tdata),
	.mlb(1'b1),
	.ss(GPIO[3]),
	.sck(GPIO[1]),
	.sdin(GPIO[5]),
	.sdout(GPIO[7]),
	.done(done),
	
);

 //отладка SPI
 
 //wire [3:0] count_sck;
 
/* Counter u_sck
 (
	
	.clock(GPIO[1]),
	.q(count_sck),
	.aload(1'b0),
	.data(data4),
	.aclr(~KEY[0]),
	.sclr(1'b0)
	
 );*/
 
 /*SEG_HEX i0
(
	.iDIG(count_sck),
	.oHEX_D(HEX0),
	.lock(CLOCK_50)
);*/




endmodule