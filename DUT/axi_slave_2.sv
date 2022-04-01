`timescale 1ns/1ps




module axi_slave_2 #(parameter addr_wid_axi = 32, data_wid=32, asize=$clog2(data_wid/8), stroblen=(data_wid/8))
                   
(


         // axi interface signals
           
           
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
       
       always@(posedge aclk) begin
           if(awvalid==1) begin $display("I am slave_2");
           end
           end
       
  
endmodule
