// Code your design here

`timescale 1ns / 1ps

module axi_interconnect # 
(
addr_wid = 32,
data_wid =32,
asize=$clog2(data_wid/8),
stroblen=(data_wid/8)
)

(
  input logic aclk,aresetn,

// interface slave 1 connections

   // write address channel signals

 
  input logic [addr_wid-1:0] s1_awaddr,
  input logic [7:0] s1_awlen,
  input logic [asize-1:0] s1_awsize ,
  input logic [1:0] s1_awburst,
  input logic s1_awvalid,
  output logic s1_awready,

//write data channels


  input logic [data_wid-1:0] s1_wdata,
  input logic [stroblen-1:0] s1_wstrb,
  input logic s1_wlast,
  input logic s1_wvalid,
  output logic s1_wready,

  //write response channel

   output logic [1:0] s1_bresp,
   output logic s1_bvalid,
   input logic s1_bready,

//read address channel signals

  input logic [1:0] s1_arid,
  input logic [addr_wid-1:0] s1_araddr,
  input logic [7:0] s1_arlen,
  input logic [asize-1:0] s1_arsize ,
  input logic [1:0] s1_arburst,
  input logic s1_arvalid,
  output logic s1_arready,

  //read data channel signals

  output logic [data_wid-1:0] s1_rdata,
  output logic [1:0] s1_rresp,
  output logic s1_rlast,
  output logic s1_rvalid,
  input logic s1_rready,

  
  // interface slave 2 connections

   // write address channel signals

 
  input logic [addr_wid-1:0] s2_awaddr,
  input logic [7:0] s2_awlen,
  input logic [asize-1:0] s2_awsize ,
  input logic [1:0] s2_awburst,
  input logic s2_awvalid,
  output logic s2_awready,

//write data channels


  input logic [data_wid-1:0] s2_wdata,
  input logic [stroblen-1:0] s2_wstrb,
  input logic s2_wlast,
  input logic s2_wvalid,
  output logic s2_wready,

  //write response channel

  output logic [1:0] s2_bresp,
  output logic s2_bvalid,
  input logic s2_bready,


//read address channel signals

  input logic [1:0] s2_arid,
  input logic [addr_wid-1:0] s2_araddr,
  input logic [7:0] s2_arlen,
  input logic [asize-1:0] s2_arsize ,
  input logic [1:0] s2_arburst,
  input logic s2_arvalid,
  output logic s2_arready,

  //read data channel signals

  output logic [data_wid-1:0] s2_rdata,
  output logic [1:0] s2_rresp,
  output logic s2_rlast,
  output logic s2_rvalid,
  input logic s2_rready,

  
  
  //master interface 1 PIN INSTANTIATION


// write address channel signals

  
  output logic [addr_wid-1:0] m1_awaddr,
  output logic [7:0] m1_awlen,
  output logic [asize-1:0] m1_awsize ,
  output logic [1:0] m1_awburst,
  output logic m1_awvalid,
  input logic m1_awready,

//write data channels


  output logic [data_wid-1:0] m1_wdata,
  output logic [stroblen-1:0] m1_wstrb,
  output logic m1_wlast,
  output logic m1_wvalid,
  input logic m1_wready,

   //write response channel

  input logic [1:0] m1_bresp,
  input logic m1_bvalid,
  output logic m1_bready,

//read address channel signals

  output logic [1:0] m1_arid,
  output logic [addr_wid-1:0] m1_araddr,
  output logic [7:0] m1_arlen,
  output logic [asize-1:0] m1_arsize ,
  output logic [1:0] m1_arburst,
  output logic m1_arvalid,
  input logic m1_arready,

  //read data channel signals

  input logic [data_wid-1:0] m1_rdata,
  input logic [1:0] m1_rresp,
  input logic m1_rlast,
  input logic m1_rvalid,
  output logic m1_rready,


  //master interface 2 PIN INSTANTIATION


// write address channel signals

  
  output logic [addr_wid-1:0] m2_awaddr,
  output logic [7:0] m2_awlen,
  output logic [asize-1:0] m2_awsize ,
  output logic [1:0] m2_awburst,
  output logic m2_awvalid,
  input logic m2_awready,

//write data channels


  output logic [data_wid-1:0] m2_wdata,
  output logic [stroblen-1:0] m2_wstrb,
  output logic m2_wlast,
  output logic m2_wvalid,
  input logic m2_wready,

   //write response channel

  input logic [1:0] m2_bresp,
  input logic m2_bvalid,
  output logic m2_bready,

//read address channel signals

  output logic [1:0] m2_arid,
  output logic [addr_wid-1:0] m2_araddr,
  output logic [7:0] m2_arlen,
  output logic [asize-1:0] m2_arsize ,
  output logic [1:0] m2_arburst,
  output logic m2_arvalid,
  input logic m2_arready,

  //read data channel signals

  input logic [data_wid-1:0] m2_rdata,
  input logic [1:0] m2_rresp,
  input logic m2_rlast,
  input logic m2_rvalid,
  output logic m2_rready

);
  

logic [addr_wid-1:0] awaddr;
logic [7:0] awlen;
logic [asize-1:0] awsize;
logic [1:0] awburst;
logic awvalid;
logic awready;

//write data channels


  logic [data_wid-1:0] wdata;
  logic [stroblen-1:0] wstrb;
  logic wlast;
  logic wvalid;
  logic wready;

  //write response channel

   logic [1:0] bresp;
   logic bvalid;
   logic bready;

//read address channel signals

  logic [1:0] arid;
  logic [addr_wid-1:0] araddr;
  logic [7:0] arlen;
  logic [asize-1:0] arsize;
  logic [1:0] arburst;
  logic arvalid;
  logic arready;

  //read data channel signals

  logic [data_wid-1:0] rdata;
  logic [1:0] rresp;
  logic rlast;
  logic rvalid;
  logic rready;


parameter idle=3'b000, master_1_write=3'b001, master_1_read=3'b010, master_2_write=3'b100, master_2_read=3'b101;
logic [2:0] state;


always @(negedge aresetn) begin
            if(!aresetn) begin
                state<=idle;
            end
            
end



always @(posedge aclk) begin
  
  case(state) 

    idle: begin
         
         if(s1_awvalid || s1_arvalid) begin    //____________CHECKING_REQUEST_FROM_MASTER_1_____________//
             
                    $display("s1_awvalid = %b and s1_arvalid = %b", s1_awvalid, s1_arvalid);
                  //SLAVE INTERFACE 2 OUTPUT INITIALIZATION

                  s2_awready=1;
                  s2_wready=1;
                  s2_bvalid=0;
                  s2_arready=1;
                  s2_rdata=0;
                  s2_rlast=0;
                  s2_rvalid=0;

             if(s1_awvalid) begin //_______CHECKING_WRITE_REQUEST_FROM_MASTER_1_______//
                 
                 state=master_1_write; // GIVING THE NEXT STATE

                 awaddr=s1_awaddr;
                 awlen = s1_awlen;
                 awsize=s1_awsize;
                 awburst=s1_awburst;
                 awvalid=s1_awvalid;

                 //WRITE DATA CHANNELS

                 wdata=s1_wdata;
                 wstrb=s1_wstrb;
                 wlast=s1_wlast;
                 wvalid=s1_wvalid;

                //WRITE RESPONSE CHANNEL
                 bready=s1_bready;
                 
               if(!(|awaddr[31:26])) begin   //__________CHECKING_REQUEST_FOR_SLAVE_1___________//



                  //MASTER 2 INTERFACE OUTPUT INITIALIZATION

                      m2_awaddr=0;
                      m2_awlen=0;
                      m2_awsize=0;
                      m2_awburst=0;
                      m2_awvalid=0;
                      m2_wdata=0;
                      m2_wstrb=0;
                      m2_wlast=0;
                      m2_wvalid=0;
                      m2_bready=0;
                      m2_arid=0;
                      m2_araddr=0;
                      m2_arlen=0;
                      m2_arsize=0;
                      m2_arburst=0;
                      m2_arvalid=0;
                      m2_rready=0;
                     
                     
                     awready=m1_awready;
                     wready=m1_wready;
                     bresp=m1_bresp;
                     bvalid=m1_bvalid;
                     s1_awready=awready;
                     s1_wready=wready;
                     s1_bresp=bresp;
                     s1_bvalid=bvalid;
                     m1_awaddr=awaddr;
                     m1_awlen = awlen;
                     m1_awsize=awsize;
                     m1_awburst=awburst;
                     m1_awvalid=awvalid;
                     m1_wdata=wdata;
                     m1_wstrb=wstrb;
                     m1_wlast=wlast;
                     m1_wvalid=wvalid;
                     m1_bready=bready;
                 
                 end

                 else begin     //__________ELSE_REQUEST_FOR_SLAVE_2___________//

                  //MASTER 1 INTERFACE OUTPUT INITIALIZATION

                          m1_awaddr=0;
                          m1_awlen=0;
                          m1_awsize=0;
                          m1_awburst=0;
                          m1_awvalid=0;
                          m1_wdata=0;
                          m1_wstrb=0;
                          m1_wlast=0;
                          m1_wvalid=0;
                          m1_bready=0;
                          m1_arid=0;
                          m1_araddr=0;
                          m1_arlen=0;
                          m1_arsize=0;
                          m1_arburst=0;
                          m1_arvalid=0;
                          m1_rready=0;
                     
                     
                         awready=m2_awready;
                         wready=m2_wready;
                         bresp=m2_bresp;
                         bvalid=m2_bvalid;
                         s1_awready=awready;
                         s1_wready=wready;
                         s1_bresp=bresp;
                         s1_bvalid=bvalid;
                         m2_awaddr=awaddr;
                         m2_awlen = awlen;
                         m2_awsize=awsize;
                         m2_awburst=awburst;
                         m2_awvalid=awvalid;
                         m2_wdata=wdata;
                         m2_wstrb=wstrb;
                         m2_wlast=wlast;
                         m2_wvalid=wvalid;
                         m2_bready=bready;
                 end

             end

             else begin     //__________ELSE_REQUEST_FOR_READ_TRANSACTION_MASTER_1___________//
                       
                       state=master_1_read; //GIVING THE NEXT STATE
                       arid= s1_arid;
                       araddr=s1_araddr;
                       arlen=s1_arlen;
                       arsize=s1_arsize;
                       arburst=s1_arburst;
                       arvalid=s1_arvalid;
                       rready=s1_rready;

               if(!(|araddr[31:26])) begin     //__________REQUEST_FOR_SLAVE_1___________//

               //MASTER 2 INTERFACE OUTPUT INTIALIZATION 
                       $display(" we are in master 1 read");
                           m2_awaddr=0;
                           m2_awlen=0;
                           m2_awsize=0;
                           m2_awburst=0;
                           m2_awvalid=0;
                           m2_wdata=0;
                           m2_wstrb=0;
                           m2_wlast=0;
                           m2_wvalid=0;
                           m2_bready=0;
                           m2_arid=0;
                           m2_araddr=0;
                           m2_arlen=0;
                           m2_arsize=0;
                           m2_arburst=0;
                           m2_arvalid=0;
                           m2_rready=0;
                  
                           m1_awvalid=0; //  need to be changed //

                           arready=m1_arready;
                           rdata=m1_rdata;
                           rresp=m1_rresp;
                           rlast=m1_rlast;
                           rvalid=m1_rvalid;
                           s1_arready=arready;
                           s1_rdata=rdata;
                           s1_rresp=rresp;
                           s1_rlast=rlast;
                           s1_rvalid=rvalid;
                           m1_arid= arid;
                           m1_araddr=araddr;
                           m1_arlen=arlen;
                           m1_arsize=arsize;
                           m1_arburst=arburst;
                           m1_arvalid=arvalid;
                           
           
                           m1_rready=rready;
                      end
                      else                          //__________ELSE_REQUEST_FOR_SLAVE_2___________//
                             begin 
                                $display(" we are in master 2 read");
                               //MASTER 1 INTERFACE OUTPUT INITIALIZATION

                                m1_awaddr=0;
                                m1_awlen=0;
                                m1_awsize=0;
                                m1_awburst=0;
                                m1_awvalid=0;
                                m1_wdata=0;
                                m1_wstrb=0;
                                m1_wlast=0;
                                m1_wvalid=0;
                                m1_bready=0;
                                m1_arid=0;
                                m1_araddr=0;
                                m1_arlen=0;
                                m1_arsize=0;
                                m1_arburst=0;
                                m1_arvalid=0;
                                m1_rready=0;
                                
                                m2_awvalid=0;  //  need to be changed //

                                arready=m2_arready;
                                rdata=m2_rdata;
                                rresp=m2_rresp;
                                rlast=m2_rlast;
                                rvalid=m2_rvalid;
                                s1_arready=arready;
                                s1_rdata=rdata;
                                s1_rresp=rresp;
                                s1_rlast=rlast;
                                s1_rvalid=rvalid;
                                m2_arid= arid;
                                m2_araddr=araddr;
                                m2_arlen=arlen;
                                m2_arsize=arsize;
                                m2_arburst=arburst;
                                m2_arvalid=arvalid;
                                m2_rready=rready;
                      end
                end
         end



         else if(s2_awvalid || s2_arvalid)begin //_______CHECKING_REQUEST_FROM_MASTER_2_______//
             
             //INITIALIZING THE SLAVE INTERFACE 1 OUTPUT

                  s1_awready=1;
                  s1_wready=1;
                  s1_bvalid=0;
                  s1_arready=1;
                  s1_rdata=0;
                  s1_rlast=0;
                  s1_rvalid=0;
             
             if(s2_awvalid) begin //_______CHECKING_WRITE_REQUEST_FROM_MASTER_2_______//
                 
                 state=master_2_write; //GIVING THE NEXT STATE
                 awaddr=s2_awaddr;
                 awlen = s2_awlen;
                 awsize=s2_awsize;
                 awburst=s2_awburst;
                 awvalid=s2_awvalid;

                 //write data channels

                 wdata=s2_wdata;
                 wstrb=s2_wstrb;
                 wlast=s2_wlast;
                 wvalid=s2_wvalid;

                //write response channel
                 bready=s2_bready;
                 
               if(!(|awaddr[31:26])) begin   //__________CHECKING_REQUEST_FOR_SLAVE_1___________//

               // INITIALIZING THE MASTER 2 INTERFACE OUTPUT

                     m2_awaddr=0;
                     m2_awlen=0;
                     m2_awsize=0;
                     m2_awburst=0;
                     m2_awvalid=0;
                     m2_wdata=0;
                     m2_wstrb=0;
                     m2_wlast=0;
                     m2_wvalid=0;
                     m2_bready=0;
                     m2_arid=0;
                     m2_araddr=0;
                     m2_arlen=0;
                     m2_arsize=0;
                     m2_arburst=0;
                     m2_arvalid=0;
                     m2_rready=0;


                     
                     awready=m1_awready;
                     wready=m1_wready;
                     bresp=m1_bresp;
                     bvalid=m1_bvalid;
                     s2_awready=awready;
                     s2_wready=wready;
                     s2_bresp=bresp;
                     s2_bvalid=bvalid;
                     m1_awaddr=awaddr;
                     m1_awlen = awlen;
                     m1_awsize=awsize;
                     m1_awburst=awburst;
                     m1_awvalid=awvalid;
                     m1_wdata=wdata;
                     m1_wstrb=wstrb;
                     m1_wlast=wlast;
                     m1_wvalid=wvalid;
                     m1_bready=bready;
                 
                 end

                 else begin     //__________ELSE_REQUEST_FOR_SLAVE_2___________//


                 // INITIALIZING THE MASTER INTERFACE 1 OUTPUT 

                                m1_awaddr=0;
                                m1_awlen=0;
                                m1_awsize=0;
                                m1_awburst=0;
                                m1_awvalid=0;
                                m1_wdata=0;
                                m1_wstrb=0;
                                m1_wlast=0;
                                m1_wvalid=0;
                                m1_bready=0;
                                m1_arid=0;
                                m1_araddr=0;
                                m1_arlen=0;
                                m1_arsize=0;
                                m1_arburst=0;
                                m1_arvalid=0;
                                m1_rready=0;
                     
                                awready=m2_awready;
                                wready=m2_wready;
                                bresp=m2_bresp;
                                bvalid=m2_bvalid;
                                s2_awready=awready;
                                s2_wready=wready;
                                s2_bresp=bresp;
                                s2_bvalid=bvalid;
                                m2_awaddr=awaddr;
                                m2_awlen = awlen;
                                m2_awsize=awsize;
                                m2_awburst=awburst;
                                m2_awvalid=awvalid;
                                m2_wdata=wdata;
                                m2_wstrb=wstrb;
                                m2_wlast=wlast;
                                m2_wvalid=wvalid;
                                m2_bready=bready;
                 end

             end

             else begin     //__________ELSE_REQUEST_FOR_READ_TRANSACTION_MASTER_2___________//
                       state=master_2_read; // GIVING THE NEXT STATE
                       arid= s2_arid;
                       araddr=s2_araddr;
                       arlen=s2_arlen;
                       arsize=s2_arsize;
                       arburst=s2_arburst;
                       arvalid=s2_arvalid;
                       rready=s2_rready;

               if(!(|araddr[31:26])) begin     //__________REQUEST_FOR_SLAVE_1___________//


               // INITIALIZING THE MASTER INTERFACE 2 OUTPUT 
                     
                     m2_awaddr=0;
                     m2_awlen=0;
                     m2_awsize=0;
                     m2_awburst=0;
                     m2_awvalid=0;
                     m2_wdata=0;
                     m2_wstrb=0;
                     m2_wlast=0;
                     m2_wvalid=0;
                     m2_bready=0;
                     m2_arid=0;
                     m2_araddr=0;
                     m2_arlen=0;
                     m2_arsize=0;
                     m2_arburst=0;
                     m2_arvalid=0;
                     m2_rready=0;


                           arready=m1_arready;
                           rdata=m1_rdata;
                           rresp=m1_rresp;
                           rlast=m1_rlast;
                           rvalid=m1_rvalid;
                           s2_arready=arready;
                           s2_rdata=rdata;
                           s2_rresp=rresp;
                           s2_rlast=rlast;
                           s2_rvalid=rvalid;
                           m1_arid= arid;
                           m1_araddr=araddr;
                           m1_arlen=arlen;
                           m1_arsize=arsize;
                           m1_arburst=arburst;
                           m1_arvalid=arvalid;
                           m1_rready=rready;
                      end
                      else                          //__________ELSE_REQUEST_FOR_SLAVE_2___________//
                             begin 

                               //INITIALIZING THE MASTER 1 INTERFACE
                                
                                m1_awaddr=0;
                                m1_awlen=0;
                                m1_awsize=0;
                                m1_awburst=0;
                                m1_awvalid=0;
                                m1_wdata=0;
                                m1_wstrb=0;
                                m1_wlast=0;
                                m1_wvalid=0;
                                m1_bready=0;
                                m1_arid=0;
                                m1_araddr=0;
                                m1_arlen=0;
                                m1_arsize=0;
                                m1_arburst=0;
                                m1_arvalid=0;
                                m1_rready=0;

                           arready=m2_arready;
                           rdata=m2_rdata;
                           rresp=m2_rresp;
                           rlast=m2_rlast;
                           rvalid=m2_rvalid;
                           s2_arready=arready;
                           s2_rdata=rdata;
                           s2_rresp=rresp;
                           s2_rlast=rlast;
                           s2_rvalid=rvalid;
                           m2_arid= arid;
                           m2_araddr=araddr;
                           m2_arlen=arlen;
                           m2_arsize=arsize;
                           m2_arburst=arburst;
                           m2_arvalid=arvalid;
                           m2_rready=rready;
                      end
                end
         end

              else begin
                  //Initial signals for idle state

                  s1_awready=1;
                  s1_wready=1;
                  s1_bvalid=0;
                  s1_arready=1;
                  s1_rdata=0;
                  s1_rlast=0;
                  s1_rvalid=0;

                  s2_awready=1;
                  s2_wready=1;
                  s2_bvalid=0;
                  s2_arready=1;
                  s2_rdata=0;
                  s2_rlast=0;
                  s2_rvalid=0;

                  m1_awaddr=0;
                  m1_awlen=0;
                  m1_awsize=0;
                  m1_awburst=0;
                  m1_awvalid=0;
                  m1_wdata=0;
                  m1_wstrb=0;
                  m1_wlast=0;
                  m1_wvalid=0;
                  m1_bready=0;
                  m1_arid=0;
                  m1_araddr=0;
                  m1_arlen=0;
                  m1_arsize=0;
                  m1_arburst=0;
                  m1_arvalid=0;
                  m1_rready=0;

                  m2_awaddr=0;
                  m2_awlen=0;
                  m2_awsize=0;
                  m2_awburst=0;
                  m2_awvalid=0;
                  m2_wdata=0;
                  m2_wstrb=0;
                  m2_wlast=0;
                  m2_wvalid=0;
                  m2_bready=0;
                  m2_arid=0;
                  m2_araddr=0;
                  m2_arlen=0;
                  m2_arsize=0;
                  m2_arburst=0;
                  m2_arvalid=0;
                  m2_rready=0;

              end
    end
                  



 

    master_1_write: begin 
                 $display("we in master_1_write"); 
                 wdata=s1_wdata;
                 wstrb=s1_wstrb;
                 wlast=s1_wlast;
                 wvalid=s1_wvalid;

                //write response channel
                 bready=s1_bready;
                 
      if(!(|awaddr[31:26])) begin   //__________CHECKING_REQUEST_FOR_SLAVE_1___________//
                     awready=m1_awready;
                     wready=m1_wready;
                     bresp=m1_bresp;
                     bvalid=m1_bvalid;
                     s1_wready=wready;
                     s1_bresp=bresp;
                     s1_bvalid=bvalid;
                     s1_awready=awready;
                     
                     m1_wdata=wdata;
                     m1_wstrb=wstrb;
                     m1_wlast=wlast;
                     m1_wvalid=wvalid;
                     m1_bready=bready;
                 
                 
                 end

                 else begin     //__________ELSE_REQUEST_FOR_SLAVE_2___________//
                     
                     awready=m2_awready;
                     wready=m2_wready;
                     bresp=m2_bresp;
                     bvalid=m2_bvalid;
                     s1_wready=wready;
                     s1_bresp=bresp;
                     s1_bvalid=bvalid;
                     s1_awready=awready;
                     m2_wdata=wdata;
                     m2_wstrb=wstrb;
                     m2_wlast=wlast;
                     m2_wvalid=wvalid;
                     m2_bready=bready;
                 end

                   if(bvalid && bready) begin 
                     $display("bvalid = %b and bready = %b",bvalid,bready);
                     state=idle;
                     $display("state = %b",state);
                                     
                 end
                    
                    
             end
                    
                   

    master_1_read: begin
                    
                     $display("we in master_1_read");
                      rready=s1_rready;

      if(!(|araddr[31:26])) begin     //__________REQUEST_FOR_SLAVE_1___________//
                    
                           arready=m1_arready;
                           
                           rdata=m1_rdata;
                           rresp=m1_rresp;
                           rlast=m1_rlast;
                           rvalid=m1_rvalid;
                           s1_arready=arready;
                           s1_rdata=rdata;
                           s1_rresp=rresp;
                           s1_rlast=rlast;
                           s1_rvalid=rvalid;
                           m1_rready=rready;
                           
                      end
                      else                          //__________ELSE_REQUEST_FOR_SLAVE_2___________//
                             begin 
                           arready=m2_arready;
                           rdata=m2_rdata;
                           rresp=m2_rresp;
                           rlast=m2_rlast;
                           rvalid=m2_rvalid;
                           s1_arready=arready;
                           s1_rdata=rdata;
                           s1_rresp=rresp;
                           s1_rlast=rlast;
                           s1_rvalid=rvalid;
                           m2_rready=rready;
                      end
                
                    if(rlast && rready) begin
                        state=idle;
                        
                        end
                   
    end

    
    master_2_write: begin  $display("we in master_2_write"); 
                 wdata=s2_wdata;
                 wstrb=s2_wstrb;
                 wlast=s2_wlast;
                 wvalid=s2_wvalid;

                //write response channel
                 bready=s2_bready;
                 
      if(!(|awaddr[31:26])) begin   //__________CHECKING_REQUEST_FOR_SLAVE_1___________//
                     
                     awready=m1_awready;
                     wready=m1_wready;
                     bresp=m1_bresp;
                     bvalid=m1_bvalid;
                     s2_awready=awready;
                     s2_wready=wready;
                     s2_bresp=bresp;
                     s2_bvalid=bvalid;
                     m1_wdata=wdata;
                     m1_wstrb=wstrb;
                     m1_wlast=wlast;
                     m1_wvalid=wvalid;
                     m1_bready=bready;
                 
                 
                 end

                 else begin     //__________ELSE_REQUEST_FOR_SLAVE_2___________//
                     
                     awready=m2_awready;
                     wready=m2_wready;
                     bresp=m2_bresp;
                     bvalid=m2_bvalid;
                     s2_awready=awready;
                     s2_wready=wready;
                     s2_bresp=bresp;
                     s2_bvalid=bvalid;
                     m2_wdata=wdata;
                     m2_wstrb=wstrb;
                     m2_wlast=wlast;
                     m2_wvalid=wvalid;
                     m2_bready=bready;
                 end

                   if(bvalid && bready) begin
                     state=idle;
                 end

             end

    master_2_read: begin   $display("we in master_2_read");
                    
                    
                           rready=s1_rready;

      if(!(|araddr[31:26])) begin     //__________REQUEST_FOR_SLAVE_1___________//
                           arready=m1_arready;
                           rdata=m1_rdata;
                           rresp=m1_rresp;
                           rlast=m1_rlast;
                           rvalid=m1_rvalid;
                           s2_arready=arready;
                           s2_rdata=rdata;
                           s2_rresp=rresp;
                           s2_rlast=rlast;
                           s2_rvalid=rvalid;
                           m1_rready=rready;
                      end
                      else                          //__________ELSE_REQUEST_FOR_SLAVE_2___________//
                             begin 
                           arready=m2_arready;
                           rdata=m2_rdata;
                           rresp=m2_rresp;
                           rlast=m2_rlast;
                           rvalid=m2_rvalid;
                           s2_arready=arready;
                           s2_rdata=rdata;
                           s2_rresp=rresp;
                           s2_rlast=rlast;
                           s2_rvalid=rvalid;
                           m2_rready=rready;
                      end
                
                    if(rlast && rready) begin
                        state=idle;
                    end
    end
  endcase

end
endmodule

