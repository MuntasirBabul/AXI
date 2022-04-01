

interface axi_interconnect_interface #(parameter addr_wid_axi = 32, data_wid=32, asize=$clog2(data_wid/8), stroblen=(data_wid/8));
  

///////////////////////////////////////////////////////
// ************* Extra temp variables*************** //
///////////////////////////////////////////////////////


//*************** write data channels *****************//
       
       logic [addr_wid_axi-1:0] awaddr;
       logic [7:0] awlen;
       logic [asize-1:0] awsize;
       logic [1:0] awburst;
       logic awvalid;
       logic awready;

//***************write data channels*******************//

       logic [data_wid-1:0] wdata;
       logic [stroblen-1:0] wstrb;
       logic wlast;
       logic wvalid;
       logic wready;

//************** write response channel ***************//

       logic [1:0] bresp;
       logic bvalid;
       logic bready;

//************read address channel signals*************//

       logic [1:0] arid;
       logic [addr_wid_axi-1:0] araddr;
       logic [7:0] arlen;
       logic [asize-1:0] arsize;
       logic [1:0] arburst;
       logic arvalid;
       logic arready;

//************ read data channel signals *************//

       logic [data_wid-1:0] rdata;
       logic [1:0] rresp;
       logic rlast;
       logic rvalid;
       logic rready;  
	
	
///////////////////////////////////////////////////////////////////////////////
//*********************** MODPORT_SLAVE DECLARATION *************************//  
///////////////////////////////////////////////////////////////////////////////

	modport slave
  
  (
// write address channel signals

       input   awaddr,
       input   awlen,
       input   awsize,
       input   awburst,
       input   awvalid,
       output  awready,

//write data channels

       input   wdata,
       input   wstrb,
       input   wlast,
       input   wvalid,
       output  wready,

//write response channel

       output  bresp,
       output  bvalid,
       input   bready,

//read address channel signals

       input   arid,
       input   araddr,
       input   arlen,
       input   arsize,
       input   arburst,
       input   arvalid,
       output  arready,

//read data channel signals

       output   rdata,
       output   rresp,
       output   rlast,
       output   rvalid,
       input    rready
       
  );
  
///////////////////////////////////////////////////////////////////////////////////////  
//*************************** MODPORT_MASTER_DECLARATION ****************************//    
///////////////////////////////////////////////////////////////////////////////////////

    modport master
  
  (
// write address channel signals

        output   awaddr,
        output   awlen,
        output   awsize,
        output   awburst,
        output   awvalid,
        input    awready,
      
//write data channels

       output   wdata,
       output   wstrb,
       output   wlast,
       output   wvalid,
       input    wready,
      
//write response channel

       input   bresp,
       input   bvalid,
       output  bready,
    
//read address channel signals

       output   arid,
       output   araddr,
       output   arlen,
       output   arsize,
       output   arburst,
       output   arvalid,
       input    arready,         
      
//read data channel signals

       input   rdata,
       input   rresp,
       input   rlast,
       input   rvalid,
       output  rready  
         
       );
  
endinterface : axi_interconnect_interface
