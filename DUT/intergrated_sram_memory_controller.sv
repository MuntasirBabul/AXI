`timescale 1ns / 1ps

module integrated_sram_memory_controller #(parameter addr_wid_axi = 32, addr_wid_mem=26, data_wid=32, asize=$clog2(data_wid/8), stroblen=(data_wid/8))
       
       (
       
       // Global signals

       input logic aclk,aresetn,

       // write address channel signals

       input logic [addr_wid_axi-1:0] awaddr,
       input logic [7:0] awlen,
       input logic [asize-1:0] awsize ,
       input logic [1:0] awburst,
       input logic awvalid,
       output logic awready,

       //write data channels

       input logic [data_wid-1:0] wdata,
       input logic [stroblen-1:0] wstrb,
       input logic wlast,
       input logic wvalid,
       output logic wready,

       //write response channel

       output logic [1:0] bresp,
       output logic bvalid,
       input logic bready,

       //read address channel signals

       input logic [1:0] arid,
       input logic [addr_wid_axi-1:0] araddr,
       input logic [7:0] arlen,
       input logic [asize-1:0] arsize ,
       input logic [1:0] arburst,
       input logic arvalid,
       output logic arready,

       //read data channel signals

       output logic [data_wid-1:0] rdata,
       output logic [1:0] rresp,
       output logic rlast,
       output logic rvalid,
       input logic rready);
       
       //mem_controller signal
       /*output logic [addr_wid_mem-1:0] maddr,
       output logic [data_wid-1:0] mdata,
       output logic [stroblen-1:0] mwstrb,
       input logic [data_wid-1:0] sdata,
       output logic mread,mwrite,
       //output logic ce,
       output logic gclken*/
       
       //internal logic declartion
       
       logic m1write,m1read,ce;
       logic [addr_wid_mem-1:0] m1addr ;
       logic [data_wid-1:0] m1data;
       logic [stroblen-1:0] m1strobe;
       logic[data_wid-1:0] s1data;
      
       
       assign ce= m1read | m1write;
     
       axi_slave dut0(
	       .aclk(aclk),
	       .aresetn(aresetn),
	       .awaddr(awaddr),
	       .awlen(awlen),
	       .awsize(awsize),
	       .awburst(awburst),
	       .awvalid(awvalid),
	       .awready(awready),
	       .wdata(wdata),
	       .wstrb(wstrb),
	       .wlast(wlast), 
	       .wvalid(wvalid),
	       .wready(wready),
	       .bresp(bresp),
	       .bvalid(bvalid),
	       .bready(bready),
	       .arid(arid),
	       .araddr(araddr),
	       .arlen(arlen),
	       .arsize(arsize ),
	       .arburst(arburst), 
	       .arvalid(arvalid), 
	       .arready(arready),
	       .rdata(rdata),
	       .rresp(rresp),
	       .rlast(rlast), 
	       .rvalid(rvalid), 
	       .rready(rready), 
	       .maddr(m1addr), 
	       .mdata(m1data), 
	       .mwstrb(m1strobe),
	       .sdata(s1data),
	       .mread(m1read),
	       .mwrite(m1write));
       
       sram dut1(
	       .ceb(ce), 
	       .wen(m1write),
	       .addr(m1addr),
	       .d(m1data),
	       .be(m1strobe), 
	       .q(s1data), 
	       .aclk(aclk));    
       
       
endmodule
