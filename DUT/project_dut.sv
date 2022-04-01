`timescale 1ns/1ps


module project_dut # 
(
addr_wid = 32,
data_wid =32,
asize=$clog2(data_wid/8),
stroblen=(data_wid/8)
)

(
  input logic aclk,aresetn,
/////////////////////////////////////////////////////////////
////////////// interface slave 1 connections ////////////////
/////////////////////////////////////////////////////////////

// write address channel signals
 
  input logic [addr_wid-1:0] s1_awaddr,
  input logic [7:0] s1_awlen,
  input logic [asize-1:0] s1_awsize ,
  input logic [1:0] s1_awburst,
  input logic s1_awvalid,
  output logic s1_awready,

// write data channels

  input logic [data_wid-1:0] s1_wdata,
  input logic [stroblen-1:0] s1_wstrb,
  input logic s1_wlast,
  input logic s1_wvalid,
  output logic s1_wready,

// write response channel

  output logic [1:0] s1_bresp,
  output logic s1_bvalid,
  input logic s1_bready,

// read address channel signals

  input logic [1:0] s1_arid,
  input logic [addr_wid-1:0] s1_araddr,
  input logic [7:0] s1_arlen,
  input logic [asize-1:0] s1_arsize ,
  input logic [1:0] s1_arburst,
  input logic s1_arvalid,
  output logic s1_arready,

// read data channel signals

  output logic [data_wid-1:0] s1_rdata,
  output logic [1:0] s1_rresp,
  output logic s1_rlast,
  output logic s1_rvalid,
  input logic s1_rready,

////////////////////////////////////////////////////////////////////   
/////////////// interface slave 2 connections //////////////////////
////////////////////////////////////////////////////////////////////

// write address channel signals

  input logic [addr_wid-1:0] s2_awaddr,
  input logic [7:0] s2_awlen,
  input logic [asize-1:0] s2_awsize ,
  input logic [1:0] s2_awburst,
  input logic s2_awvalid,
  output logic s2_awready,

// write data channels

  input logic [data_wid-1:0] s2_wdata,
  input logic [stroblen-1:0] s2_wstrb,
  input logic s2_wlast,
  input logic s2_wvalid,
  output logic s2_wready,

// write response channel

  output logic [1:0] s2_bresp,
  output logic s2_bvalid,
  input logic s2_bready,

// read address channel signals

  input logic [1:0] s2_arid,
  input logic [addr_wid-1:0] s2_araddr,
  input logic [7:0] s2_arlen,
  input logic [asize-1:0] s2_arsize ,
  input logic [1:0] s2_arburst,
  input logic s2_arvalid,
  output logic s2_arready,

// read data channel signals

  output logic [data_wid-1:0] s2_rdata,
  output logic [1:0] s2_rresp,
  output logic s2_rlast,
  output logic s2_rvalid,
  input logic s2_rready);


//////////////////////////////////////////////////////////////////////
///////////////// Master 1 pseudo temp wire //////////////////////////
//////////////////////////////////////////////////////////////////////


// write address channels
  
   logic [addr_wid-1:0] m1_awaddr;
   logic [7:0] m1_awlen;
   logic [asize-1:0] m1_awsize;
   logic [1:0] m1_awburst;
   logic m1_awvalid;
   logic m1_awready;

// write data channels


   logic [data_wid-1:0] m1_wdata;
   logic [stroblen-1:0] m1_wstrb;
   logic m1_wlast;
   logic m1_wvalid;
   logic m1_wready;

// write response channel

   logic [1:0] m1_bresp;
   logic m1_bvalid;
   logic m1_bready;

// read address channel signals

   logic [1:0] m1_arid;
   logic [addr_wid-1:0] m1_araddr;
   logic [7:0] m1_arlen;
   logic [asize-1:0] m1_arsize;
   logic [1:0] m1_arburst;
   logic m1_arvalid;
   logic m1_arready;

// read data channel signals

   logic [data_wid-1:0] m1_rdata;
   logic [1:0] m1_rresp;
   logic m1_rlast;
   logic m1_rvalid;
   logic m1_rready;

//////////////////////////////////////////////////////////////////////
///////////////// Master 2 pseudo temp wire //////////////////////////
//////////////////////////////////////////////////////////////////////

   logic [addr_wid-1:0] m2_awaddr;
   logic [7:0] m2_awlen;
   logic [asize-1:0] m2_awsize;
   logic [1:0] m2_awburst;
   logic m2_awvalid;
   logic m2_awready;



   logic [data_wid-1:0] m2_wdata;
   logic [stroblen-1:0] m2_wstrb;
   logic m2_wlast;
   logic m2_wvalid;
   logic m2_wready;


   logic [1:0] m2_bresp;
   logic m2_bvalid;
   logic m2_bready;

   logic [1:0] m2_arid;
   logic [addr_wid-1:0] m2_araddr;
   logic [7:0] m2_arlen;
   logic [asize-1:0] m2_arsize;
   logic [1:0] m2_arburst;
   logic m2_arvalid;
   logic m2_arready;

   logic [data_wid-1:0] m2_rdata;
   logic [1:0] m2_rresp;
   logic m2_rlast;
   logic m2_rvalid;
   logic m2_rready;

   axi_interconnect d0(	
            .aclk(aclk),
	   		.aresetn(aresetn),			
			.s1_awaddr(s1_awaddr),
			.s1_awlen(s1_awlen),
			.s1_awsize(s1_awsize),
			.s1_awburst(s1_awburst),
			.s1_awvalid(s1_awvalid),
   			.s1_awready(s1_awready),
   			.s1_wdata(s1_wdata),
			.s1_wstrb(s1_wstrb),
			.s1_wlast(s1_wlast),
			.s1_wvalid(s1_wvalid),
			.s1_wready(s1_wready),
			.s1_bresp(s1_bresp),
			.s1_bvalid(s1_bvalid),
   			.s1_bready(s1_bready),
			.s1_arid(s1_arid),
			.s1_araddr(s1_araddr),
			.s1_arlen(s1_arlen),
			.s1_arsize(s1_arsize),
			.s1_arburst(s1_arburst),
			.s1_arvalid(s1_arvalid),
			.s1_arready(s1_arready),
   			.s1_rdata(s1_rdata),
   			.s1_rresp(s1_rresp),
			.s1_rlast(s1_rlast),
			.s1_rvalid(s1_rvalid),
			.s1_rready(s1_rready),
			
			.s2_awaddr(s2_awaddr),
			.s2_awlen(s2_awlen),
			.s2_awsize(s2_awsize),
   			.s2_awburst(s2_awburst),
			.s2_awvalid(s2_awvalid),
   			.s2_awready(s2_awready),
			.s2_wdata(s2_wdata),
			.s2_wstrb(s2_wstrb),
			.s2_wlast(s2_wlast),
			.s2_wvalid(s2_wvalid),
			.s2_wready(s2_wready),
			.s2_bresp(s2_bresp),
			.s2_bvalid(s2_bvalid),
   			.s2_bready(s2_bready),
			.s2_arid(s2_arid),
			.s2_araddr(s2_araddr),
			.s2_arlen(s2_arlen),
			.s2_arsize(s2_arsize),
			.s2_arburst(s2_arburst),
			.s2_arvalid(s2_arvalid),
			.s2_arready(s2_arready),
   			.s2_rdata(s2_rdata),
			.s2_rresp(s2_rresp),
			.s2_rlast(s2_rlast),
			.s2_rvalid(s2_rvalid),
			.s2_rready(s2_rready),
			
			.m1_awaddr(m1_awaddr),
			.m1_awlen(m1_awlen),
			.m1_awsize(m1_awsize),
			.m1_awburst(m1_awburst),
   			.m1_awvalid(m1_awvalid),
			.m1_awready(m1_awready),
			.m1_wdata(m1_wdata),
			.m1_wstrb(m1_wstrb),
			.m1_wlast(m1_wlast),
			.m1_wvalid(m1_wvalid),
			.m1_wready(m1_wready),
			.m1_bresp(m1_bresp),
			.m1_bvalid(m1_bvalid),
   			.m1_bready(m1_bready),
			.m1_arid(m1_arid),
			.m1_araddr(m1_araddr),
			.m1_arlen(m1_arlen),
			.m1_arsize(m1_arsize),
			.m1_arburst(m1_arburst),
			.m1_arvalid(m1_arvalid),
			.m1_arready(m1_arready),
			.m1_rdata(m1_rdata),
   			.m1_rresp(m1_rresp),
			.m1_rlast(m1_rlast),
			.m1_rvalid(m1_rvalid),
			.m1_rready(m1_rready),
   
			.m2_awaddr(m2_awaddr),
			.m2_awlen(m2_awlen),
			.m2_awsize(m2_awsize),
			.m2_awburst(m2_awburst),
   			.m2_awvalid(m2_awvalid),
			.m2_awready(m2_awready),
			.m2_wdata(m2_wdata),
			.m2_wstrb(m2_wstrb),
			.m2_wlast(m2_wlast),
			.m2_wvalid(m2_wvalid),
			.m2_wready(m2_wready),
			.m2_bresp(m2_bresp),
			.m2_bvalid(m2_bvalid),
   			.m2_bready(m2_bready),
			.m2_arid(m2_arid),
			.m2_araddr(m2_araddr),
			.m2_arlen(m2_arlen),
			.m2_arsize(m2_arsize),
			.m2_arburst(m2_arburst),
			.m2_arvalid(m2_arvalid),
			.m2_arready(m2_arready),
			.m2_rdata(m2_rdata),
   			.m2_rresp(m2_rresp),
			.m2_rlast(m2_rlast),
			.m2_rvalid(m2_rvalid),
			.m2_rready(m2_rready));

   integrated_sram_memory_controller d1(
	   		.aclk(aclk),
			.aresetn(aresetn),
			.awaddr(m1_awaddr),
			.awlen(m1_awlen),
			.awsize(m1_awsize),
			.awburst(m1_awburst),
			.awvalid(m1_awvalid),
			.awready(m1_awready),
			.wdata(m1_wdata),
   			.wstrb(m1_wstrb),
			.wlast(m1_wlast),
			.wvalid(m1_wvalid),
			.wready(m1_wready),
			.bresp(m1_bresp),
			.bvalid(m1_bvalid),
			.bready(m1_bready),
			.arid(m1_arid),
			.araddr(m1_araddr),
			.arlen(m1_arlen),
			.arsize(m1_arsize),
   			.arburst(m1_arburst),
			.arvalid(m1_arvalid),
			.arready(m1_arready),
			.rdata(m1_rdata),
			.rresp(m1_rresp),
			.rlast(m1_rlast),
			.rvalid(m1_rvalid),
			.rready(m1_rready));

   axi_slave_2 d2 (	.aclk(aclk),
	   		.aresetn(aresetn),
			.awaddr(m2_awaddr),
			.awlen(m2_awlen),
			.awsize(m2_awsize),
			.awburst(m2_awburst),
			.awvalid(m2_awvalid),
			.awready(m2_awready),
			.wdata(m2_wdata),
   			.wstrb(m2_wstrb),
			.wlast(m2_wlast),
			.wvalid(m2_wvalid),
			.wready(m2_wready),
			.bresp(m2_bresp),
			.bvalid(m2_bvalid),
			.bready(m2_bready),
			.arid(m2_arid),
			.araddr(m2_araddr),
			.arlen(m2_arlen),
			.arsize(m2_arsize),
   			.arburst(m2_arburst),
			.arvalid(m2_arvalid),
			.arready(m2_arready),
			.rdata(m2_rdata),
			.rresp(m2_rresp),
			.rlast(m2_rlast),
			.rvalid(m2_rvalid),
			.rready(m2_rready));
   

endmodule
