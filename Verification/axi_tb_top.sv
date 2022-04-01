

`ifndef AXI_TB_TOP
`define AXI_TB_TOP

`include "uvm_macros.svh"
 import uvm_pkg::*;
`include "axi_test.sv"
`include "axi_environment.sv"
`include "axi_agent.sv"
`include "axi_scoreboard.sv"
`include "axi_sequence_item.sv"
`include "axi_sequence.sv"
`include "axi_sequencer.sv"
`include "axi_driver.sv"
`include "axi_monitor.sv"
`include "axi_interface.sv"



module axi_tb_top;

import axi_test_list::*;  ////test_list pkg


/////////////////////// Declaration of Local Fields //////////////////////////


parameter cycle = 10;
bit aclk;
bit aresetn;


//////////////////////////// Clock generation ////////////////////////////////

initial begin 
aclk = 0;
forever #(cycle/2) aclk = ~aclk;   //5+5 
end


/////////////////////////// Reset generation /////////////////////////////////
// change may required while generating reset for synchronous/Asynchronous ///
//////////////////////// or Active low/Active high /////////////////////////// 


initial begin
reset = 1;
#(cycle* 5) reset =0;  //10*5= 50 cycle...will reet after 50 cycle
end


///////////////////////// Interface Instantiation ////////////////////////////
/////////////////// inorder to connect DUT and testcase //////////////////////

axi_interface.slave intf intf_S1(aclk, aresetn);
axi_interface.slave intf intf_S2();

//////////////////////////// DUT Instantiation ///////////////////////////////

top DUT (
////// interface slave 1 connections//////

// write address channel signals

.s1_awaddr(intf_S1.awaddr),
.s1_awlen(intf_S1.awlen),
.s1_awsize(intf_S1.awsize),
.s1_awburst(intf_S1.awburst),
.s1_awvalid(intf_S1.awvalid),
.s1_awready(intf_S1.awready),

// write data channels

.s1_wdata(intf_S1.wdata),
.s1_wstrb(intf_S1.wstrb),
.s1_wlast(intf_S1.wlast),
.s1_wvalid(intf_S1.wvalid),
.s1_wready(intf_S1.wready),

// write response channel

.s1_bresp(intf_S1.bresp),
.s1_bvalid(intf_S1.bvalid),
.s1_bready(intf_S1.bready),

// read address channel signals

.s1_arid(intf_S1.arid),
.s1_araddr(intf_S1.araddr),
.s1_arlen(intf_S1.arlen),
.s1_arsize(intf_S1.arsize),
.s1_arburst(intf_S1.arburst),
.s1_arvalid(intf_S1.arvalid),
.s1_arready(intf_S1.arready),

// read data channel signals

.s1_rdata(intf_S1.rdata),
.s1_rresp(intf_S1.rresp),
.s1_rlast(intf_S1.rlast),
.s1_rvalid(intf_S1.rvalid),
.s1_rready(intf_S1.rready));



/////// interface slave 2 connections //////

// write address channel signals

.s2_awaddr(intf_S2.awaddr),
.s2_awlen(intf_S2.awlen),
.s2_awsize (intf_S2.awsize ),
.s2_awburst(intf_S2.awburst),
.s2_awvalid(intf_S2.awvalid),
.s2_awready(intf_S2.awready),

// write data channels

.s2_wdata(intf_S2.wdata),
.s2_wstrb(intf_S2.wstrb),
.s2_wlast(intf_S2.wlast),
.s2_wvalid(intf_S2.wvalid),
.s2_wready(intf_S2.wready),

// write response channel

.s2_bresp(intf_S2.bresp),
.s2_bvalid(intf_S2.bvalid),
.s2_bready(intf_S2.bready),

// read address channel signals

.s2_arid(intf_S2.arid),
.s2_araddr(intf_S2.araddr),
.s2_arlen(intf_S2.arlen),
.s2_arsize(intf_S2.arsize),
.s2_arburst(intf_S2.arburst),
.s2_arvalid(intf_S2.arvalid),
.s2_arready(intf_S2.arready),

// read data channel signals

.s2_rdata(intf_S2.rdata),
.s2_rresp(intf_S2.rresp),
.s2_rlast(intf_S2.rlast),
.s2_rvalid(intf_S2.rvalid),
.s2_rready(intf_S2.rready));


/////////////////////////// UVM phases execution /////////////////////////////


initial begin
    run_test();   //will run all the test case... ; if there is no test case defined//
end


////////// Set the Interface instance Using Configuration Database ///////////


initial begin
uvm_resource_db#(virtual axi_interface)::set(.scope("*")), .name("axi_interface", .val(intf_S1));
uvm_resource_db#(virtual axi_interface)::set(.scope("*")), .name("axi_interface", .val(intf_S2));
uvm_config_db#(virtual axi_interface)::set(uvm_root::get(),"*","axi_interface",intf_S1);
uvm_config_db#(virtual axi_interface)::set(uvm_root::get(),"*","axi_interface",intf_S2);
end

/* //Register #Run in configuration block
uvm_config_db#(int)::set(uvm_root::get(), "*", "count", count);

//Execute test cases
run_test("axi_testcase_00");
end*/

endmodule

`endif
