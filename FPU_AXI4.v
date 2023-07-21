module FPU_AXI4(
input ACLK, ARESETn,
input [7:0] operation,
output [31:0] result
);
	wire AWREADY;
	wire [11:0] AWADRESS; //0 - add, 1 - mul, 2 - div
	wire AWVALID;
	wire [1:0] AWBURST;
	wire [3:0] AWCACHE;
	wire [2:0] AWSIZE;
	wire [7:0] AWLENGTH;
	wire [2:0] AWPROT;
   wire AWLOCK;
	wire [3:0] AWID;
	wire [3:0] AWQos;
	wire [3:0] AWREGION;///
	wire [31:0] WDATA;
	wire WVALID;
	wire WREADY;
	wire [3:0] WSTRB;
	wire WLAST;
	wire [3:0] BID;
	wire [1:0] BRESP;
	wire BVALID;
	wire BREADY;
	wire ARREADY;
	wire [11:0] ARADRESS;
	wire ARVALID;
	wire [1:0] ARBURST;
	wire [3:0] ARCACHE;
	wire [2:0] ARSIZE;
	wire [7:0] ARLENGTH;
	wire [2:0] ARPROT;
   wire ARLOCK;
	wire [3:0] ARID;
	wire [3:0] ARQos;
	wire [3:0] ARREGION;///
	wire [3:0] RID;
	wire [31:0] RDATA;
	wire [1:0] RRESP;
	wire RLAST;
	wire RVALID;
	wire RREADY;

	AXI4_master master1(
	.ACLK(ACLK),
	.ARESETn(ARESETn),
	.AWREADY(AWREADY),
	.AWADRESS(AWADRESS), //0 - add, 1 - mul, 2 - div
	.AWVALID(AWVALID),
	.AWBURST(AWBURST),
	.AWCACHE(AWCACHE),
	.AWSIZE(AWSIZE),
	.AWLENGTH(AWLENGTH),
	.AWPROT(AWPROT),
   .AWLOCK(AWLOCK),
	.AWID(AWID),
	.AWQos(AWQos),
	.AWREGION(ASREGION),///
	.WDATA(WDATA),
	.WVALID(WVALID),
	.WREADY(WREADY),
	.WSTRB(WLAST),
	.WLAST(WLAST),
	.BID(BID),
	.BRESP(BRESP),
	.BVALID(BVALID),
	.BREADY(BREADY),
	.ARREADY(ARREADY),
	.ARADRESS(ARADRESS),
	.ARVALID(ARVALID),
	.ARBURST(ARBURST),
	.ARCACHE(ARCACHE),
	.ARSIZE(ARSIZE),
	.ARLENGTH(ARLENGTH),
	.ARPROT(ARPROT),
   .ARLOCK(ARLOCK),
	.ARID(ARID),
	.ARQos(ARQos),
	.ARREGION(ARREGION),///
	.RID(RID),
	.RDATA(RDATA),
	.RRESP(RRESP),
	.RLAST(RLAST),
	.RVALID(RVALID),
	.RREADY(RREADY),
	.operation(operation),
	.result(result)
	);
	
	AXI4_slave_FPU slave_FPU(
	.ACLK(ACLK),
	.ARESETn(ARESETn),
	.AWREADY(AWREADY),
	.AWADRESS(AWADRESS), //0 - add, 1 - mul, 2 - div
	.AWVALID(AWVALID),
	.AWBURST(AWBURST),
	.AWCACHE(AWCACHE),
	.AWSIZE(AWSIZE),
	.AWLENGTH(AWLENGTH),
	.AWPROT(AWPROT),
   .AWLOCK(AWLOCK),
	.AWID(AWID),
	.AWQos(AWQos),
	.AWREGION(ASREGION),///
	.WDATA(WDATA),
	.WVALID(WVALID),
	.WREADY(WREADY),
	.WSTRB(WLAST),
	.WLAST(WLAST),
	.BID(BID),
	.BRESP(BRESP),
	.BVALID(BVALID),
	.BREADY(BREADY),
	.ARREADY(ARREADY),
	.ARADRESS(ARADRESS),
	.ARVALID(ARVALID),
	.ARBURST(ARBURST),
	.ARCACHE(ARCACHE),
	.ARSIZE(ARSIZE),
	.ARLENGTH(ARLENGTH),
	.ARPROT(ARPROT),
   .ARLOCK(ARLOCK),
	.ARID(ARID),
	.ARQos(ARQos),
	.ARREGION(ARREGION),///
	.RID(RID),
	.RDATA(RDATA),
	.RRESP(RRESP),
	.RLAST(RLAST),
	.RVALID(RVALID),
	.RREADY(RREADY)
	);
	
endmodule

module AXI4_master(
	input ACLK,
	input ARESETn,
	input AWREADY,
	output [11:0] AWADRESS, //0 - add, 1 - mul, 2 - div
	output AWVALID,
	output [1:0] AWBURST,
	output [3:0] AWCACHE,
	output [2:0] AWSIZE,
	output [7:0] AWLENGTH,
	output [2:0] AWPROT,
   output AWLOCK,
	output [3:0] AWID,
	output [3:0] AWQos,
	output [3:0] AWREGION,///
	output [31:0] WDATA,
	output WVALID,
	input WREADY,
	output [3:0] WSTRB,
	output WLAST,
	input [3:0] BID,
	input [1:0] BRESP,
	input BVALID,
	output BREADY,
	input ARREADY,
	output [11:0] ARADRESS,
	output ARVALID,
	output [1:0] ARBURST,
	output [3:0] ARCACHE,
	output [2:0] ARSIZE,
	output [7:0] ARLENGTH,
	output [2:0] ARPROT,
   output ARLOCK,
	output [3:0] ARID,
	output [3:0] ARQos,
	output [3:0] ARREGION,///
	input [3:0] RID,
	input [31:0] RDATA,
	input [1:0] RRESP,
	input RLAST,
	input RVALID,
	output RREADY,
	input [7:0] operation, //0 = add, 1 = mul, 2 = div, FF - no operation
	output [31:0] result
);

reg [31:0] op1, op2, result_reg;
reg [7:0] counter;
reg [1:0] state;
reg read_or_write;// 0 - write, 1 - read
reg [31:0] w_data;
reg w_valid, r_ready;
reg [3:0] w_strb;
reg w_last;
reg [11:0] aw_adress, ar_adress;
reg aw_valid, ar_valid; 
reg [1:0] aw_burst, ar_burst;
reg [3:0] aw_cache, ar_cache;
reg [3:0] aw_region, ar_region;
reg [3:0] aw_qos, ar_qos;
reg aw_lock, ar_lock;
reg [2:0] aw_size, ar_size;
reg [7:0] aw_length, ar_length;
reg [2:0] aw_prot, ar_prot;
reg [3:0] aw_id, ar_id;
reg b_ready;


assign AWADRESS = aw_adress;
assign AWREGION = aw_region;
assign AWID = aw_id;
assign AWVALID = aw_valid; 
assign AWPROT = aw_prot;
assign AWID = aw_id;
assign AWBURST = aw_burst;
assign AWCACHE = aw_cache;
assign AWSIZE = aw_size;
assign AWLENGTH = aw_length;
assign AWLOCK = aw_lock; 
assign BREADY = b_ready;
assign WDATA = w_data;
assign WVALID = w_valid;
assign WLAST = w_last;
assign WSTRB = w_strb;
assign ARADRESS = ar_adress;
assign ARLOCK = ar_lock;
assign ARSIZE = ar_size;
assign ARLENGTH = ar_length;
assign ARBURST = ar_burst;
assign ARCACHE = ar_cache;
assign ARQos = ar_qos;
assign ARPROT = ar_prot;
assign ARREGION = ar_region;
assign ARVALID = ar_valid;
assign ARID = ar_id;
assign ARVALID = ar_valid;
assign result = result_reg;
assign RREADY = r_ready;

always @(posedge ACLK or negedge ARESETn)
if(!ARESETn)
	begin
		op1 <= 32'b0;
		op2 <= 32'b0;
		result_reg <= 32'b0;
		counter <= 8'b0;
		read_or_write <= 1'b0;
		w_data <= 32'b0;
		w_valid <= 1'b0;
		r_ready <= 1'b0;
		w_strb <= 4'b0;
		w_last <= 1'b0;
		aw_adress <= 12'b0;
		ar_adress <= 12'b0;
		aw_valid <= 1'b0;
		ar_valid <= 1'b0;
		aw_burst <= 2'b0;
		ar_burst <= 2'b0;
		aw_cache <= 4'b0;
		ar_cache <= 4'b0;
		aw_region <= 4'b0;
		ar_region <= 4'b0;
		aw_qos <= 4'b0;
		ar_qos <= 4'b0;
		aw_lock <= 1'b0;
		ar_lock <= 1'b0;
		aw_size <= 3'b0;
		ar_size <= 3'b0;
		aw_length <= 8'b0;
		ar_length <= 8'b0;
		aw_prot <= 3'b0;
		ar_prot <= 3'b0;
		aw_id <= 4'b0;
		ar_id <= 4'b0;
		b_ready <= 1'b0;
		state <= 2'b0;
	end
	else
	begin
		op1 <= {12'b010000001100, 20'd0};
		op2 <= {12'b010000010010, 20'd0};
		if(!read_or_write) begin
		case(state)
			2'b00 : begin
					aw_valid <= (aw_valid & AWREADY)? 1'b0 : 1'b1;
					aw_id <= 4'b0;
					aw_size <= 3'b010;
					aw_length <= 7'h02;
					aw_adress <= {4'b0, operation};
					aw_burst <= 2'b01;
					aw_region <= 4'd0;
					aw_qos <= 4'd0;
					aw_lock <= 1'd0;
					aw_prot <= 3'b000;
					counter <= 8'b0;
					if(AWREADY & aw_valid) state <= 2'b01;
					else state <= state;
				end
			2'b01 : begin
					counter <= counter + {7'b0, w_valid & WREADY};
					w_valid <= (WREADY & w_valid)? 1'b0 : 1'b1;
					w_data <= (counter == 8'b0)? op1 : op2;
					w_strb <= (w_valid & WREADY)? 4'h0 : 4'hF;
					w_last <= (counter == 8'h01)? 1'b1 : 1'b0;
					state <= ((counter == 8'h01) && (w_valid & WREADY))? 2'b10 : 2'b01;
				end
			2'b10 : begin 
					counter <= 8'b0;
					b_ready <= (b_ready & BVALID)? 1'b0 : 1'b1;
					state <= (b_ready & BVALID)? 2'b00 : 2'b10;
					read_or_write <= b_ready & BVALID;
				end
			default : state <= 2'b00;
		endcase
		end
		else
		case(state)
			2'b00: 	begin			
					ar_id <= 4'b0;
					ar_size <= 3'b010;
					ar_length <= 7'h01;
					ar_adress <= {4'b0, operation};
					ar_burst <= 2'b01;
					ar_valid <= (ARREADY & ar_valid)? 1'b0 : 1'b1;
					ar_region <= 4'd0;
					ar_qos <= 4'd0;
					ar_lock <= 1'd0;
					ar_prot <= 3'b000;
					if(ARREADY & ar_valid) state <= 2'b01;
					else state <= state;
				end
			2'b01: begin 
					result_reg <= (RVALID & r_ready)? RDATA : result_reg;
					r_ready <= (RVALID & r_ready)? 1'b0 : 1'b1;
					state <= (RVALID & r_ready)? 2'b00 : 2'b01;
					read_or_write <= (RVALID & r_ready)? 1'b0 : 1'b1;
				end
			default: begin result_reg <= result_reg; state <= 2'b00; end
		endcase
	end
endmodule 

module AXI4_slave_FPU(
	input ACLK,
	input ARESETn,
	output AWREADY,
	input [11:0] AWADRESS,
	input AWVALID,
	input [1:0] AWBURST,
	input [3:0] AWCACHE,
	input [2:0] AWSIZE,
	input [7:0] AWLENGTH,
	input [2:0] AWPROT,
   input AWLOCK,
	input	[3:0] AWID,
	input [3:0] AWQos,
	input [3:0] AWREGION,///
	input [31:0] WDATA,
	input WVALID,
	output WREADY,
	input [1:0] WSTRB,
	input WLAST,
	output [3:0] BID,
	output [1:0] BRESP,
	output BVALID,
	input BREADY,
	output ARREADY,
	input [11:0] ARADRESS,
	input ARVALID,
	input [1:0] ARBURST,
	input [3:0] ARCACHE,
	input [2:0] ARSIZE,
	input [7:0] ARLENGTH,
	input [2:0] ARPROT,
   input ARLOCK,
	input [3:0] ARID,
	input [3:0] ARQos,
	input [3:0] ARREGION,///
	output [3:0] RID,
	output [31:0] RDATA,
	output [1:0] RRESP,
	output RLAST,
	output RVALID,
	input RREADY
);

reg [2:0] clk_en;
reg [31:0] op1, op2; 
reg aw_ready;
reg w_ready;
reg r_valid;
reg r_last;
reg [3:0] b_id;
reg [1:0] b_resp;
reg b_valid;
reg ar_ready;
reg [3:0] r_id;
reg [1:0] r_resp;
reg [7:0] operation1, operation2;
reg [7:0] counter1, counter2, counter3;
reg sign_of_clock;
wire [31:0] add_result, mul_result, div_result;
wire div_ready;
wire division_by_zero;

assign RDATA = (operation2 == 8'h00)? add_result :
					(operation2 == 8'h01)? mul_result :
					(operation2 == 8'h02)? div_result : 32'b0;
assign AWREADY = aw_ready;
assign WREADY = w_ready;
assign RVALID = r_valid;
assign RLAST = r_last;
assign BID = b_id;
assign BRESP = b_resp;
assign BVALID = b_valid;
assign ARREADY = ar_ready;
assign RID = r_id;
assign RRESP = r_resp;
assign RLAST = r_last;
assign RVALID = r_valid;					
					
FPAdd adder(
.n_reset(ARESETn),
.clk(ACLK),
.clk_en(clk_en[0]),
.term1(op1),
.term2(op2),
.sum(add_result)
);

FPMul multiplier(
.n_reset(ARESETn),
.clk(ACLK),
.clk_en(clk_en[1]),
.mult1(op1),
.mult2(op2),
.product(mul_result)
);

FPDiv divider(
.n_reset(ARESETn),
.clk(ACLK),
.clk_en(clk_en[2]),
.dividend(op1),
.divisor(op2),
.quotient(div_result),
.ready_out(div_ready),
.division_by_zero(division_by_zero)
);

always @(posedge ACLK or negedge ARESETn)
if(!ARESETn)
	begin
		clk_en <= 3'b0;
		op1 <= 32'b0;
		op2 <= 32'b0;
		aw_ready <= 1'b0;
		w_ready <= 1'b0;
		r_id <=4'b0;
		ar_ready <= 1'b0;
		b_resp <= 2'b0;
		b_valid <= 1'b0;
		b_id <= 4'b0;
		r_valid <= 1'b0;
		r_last <= 1'b0;
		r_resp <= 2'b0;
		operation1 <= 8'h03;
		operation2 <= 8'h03;
		counter1 <= 8'b0;
		counter2 <= 8'b0;
		counter3 <= 8'b0;
		sign_of_clock <= 1'b0;
	end
else if(ACLK)
	begin
		
		
		
		if(AWVALID) begin
			aw_ready <= !aw_ready? 1'b1 : 1'b0;
			operation1 <= AWADRESS[7:0];
			counter1 <= aw_ready? counter1 + 8'h01 : counter1;
			b_id <= AWID;
		end
		else if (WVALID)
		begin
			w_ready <= w_ready? 1'b0 : 1'b1;
			op1 <= (counter1 == 8'h01)? WDATA : op1;
			op2 <= (counter1 == 8'h02)? WDATA : op2;
			counter1 <= counter1 +8'h01;
		end
		else if (BREADY)
		begin
			b_valid <= (b_valid)? 1'b0 : 1'b1;
			b_resp <= (operation1 <= 8'h02)? 2'b0 : 2'b11;
			counter1 <= 8'b0;
			sign_of_clock <= b_valid? ACLK : sign_of_clock;
		end
		
		if(ARVALID)
		begin
			ar_ready <= ar_ready? 1'b0 : 1'b1;
			operation2 <= ARADRESS[7:0];
			counter2 <= ar_ready? counter2 + 8'h01 : counter2;
			r_id <= ARID;
			r_valid <= 1'b0;
		end
		else 
		if(RREADY) begin
			r_valid <= (r_valid || ((clk_en != 3'b0) && (operation1 == operation2)))? 1'b0 : 1'b1;
			r_last <= r_valid? 1'b0 : 1'b1;
			r_resp <= (operation2 <= 8'h02)? 2'b0 : 2'b11; 
			counter2 <= 8'b0;
		end
		
		
		case (operation1)
		8'h00 : begin counter3 <= !clk_en[0]? 8'b0 : ACLK? counter3 + 8'h01 : counter3;
					if(sign_of_clock)
						   clk_en[0] <= (BREADY & b_valid)? 1'b1 : (counter3 == 8'h01)? 1'b0 : clk_en[0]; 
						else
							clk_en[0] <= (BREADY & b_valid)? 1'b1 : (counter3 == 8'h02)? 1'b0 : clk_en[0];
				end
		8'h01 : begin counter3 <= counter3;
						   clk_en[1] <= (BREADY & b_valid)? 1'b1 : !ACLK? 1'b0 : clk_en[1];
				end
		8'h02 : begin counter3 <= !clk_en[2]? 8'b0 : (ACLK & div_ready)? counter3 + 8'h01 : counter3;
					if(sign_of_clock)
						   clk_en[2] <= (BREADY & b_valid)? 1'b1 : (counter3 == 8'h02)? 1'b0 : clk_en[2];
					else 
							clk_en[2] <= (BREADY & b_valid)? 1'b1 : (counter3 == 8'h03)? 1'b0 : clk_en[2];
				end
		default : begin counter3 <= 8'b0; clk_en <= 3'b0; end
		endcase 
	end 
endmodule 
