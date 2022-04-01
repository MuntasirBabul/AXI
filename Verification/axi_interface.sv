

`ifndef AXI_INTERFACE
`define AXI_INTERFACE

interface axi_interface #(parameter addr_wid_axi = 32, data_wid=32, asize=$clog2(data_wid/8), stroblen=(data_wid/8))
  (
  input logic aclk; 	// GLOBAL_CLOCK
  input logic aresetn; 	// RESET 
  );


///////////////////////////////////////////////////////////////////////////////  
//////////////////////////// WIRE_INSTATIATION ////////////////////////////////  
///////////////////////////////////////////////////////////////////////////////


///////////////// WRITE_ADDRESS_CHANNEL /////////////////
/*******************************************************/
       
       logic [addr_wid_axi-1:0] awaddr ;
       logic [7:0] awlen ;
       logic [asize-1:0] awsize ;
       logic [1:0] awburst ;
       logic awvalid ;
       logic awready ;

////////////////// WRITE_DATA_CHANNEL ///////////////////
/*******************************************************/

       logic [data_wid-1:0] wdata ;
       logic [stroblen-1:0] wstrb ;
       logic wlast ;
       logic wvalid ;
       logic wready ;

//////////////// WRITE_RESPONSE_CHANNEL /////////////////
/*******************************************************/

       logic [1:0] bresp ;
       logic bvalid ;
       logic bready ;

///////////////// READ_ADDRESS_CHANNEL //////////////////
/*******************************************************/

       logic [1:0] arid ;
       logic [addr_wid_axi-1:0] araddr ;
       logic [7:0] arlen ;
       logic [asize-1:0] arsize ;
       logic [1:0] arburst ;
       logic arvalid ;
       logic arready ;

////////////////// READ_DATA_CHANNEL ////////////////////
/*******************************************************/

       logic [data_wid-1:0] rdata ;
       logic [1:0] rresp ;
       logic rlast ;
       logic rvalid ;
       logic rready ;  


///////////////////////////////////////////////////////////////////////////////  
//////////////////////// CLOCKING_BLOCK_INSTANTIATION /////////////////////////  
///////////////////////////////////////////////////////////////////////////////


	clocking ckb_1@(posedge aclk)

//PORT_DIRECTION_WITH_RESPECT_TO_TESTBENCH	
	 
	output awaddr,
		awlen,
		awsize,
		awburst,
		awvalid,
		wdata,
		wstrb,
		wlast,
		wvalid,
		bready,
		arid,
		araddr,
		arlen,
		arsize,
		arburst,
		arvalid,
		rready;

	input 	awready,
		wready,
		bresp,
		bvalid,
		arready,
		rdata,
		rresp,
		rlast,
		rvalid;

endclocking

///////////////////////////////////////////////////////////////////////////////  
//////////////////////// MODPORT_SLAVE_1 DECLARATION //////////////////////////  
///////////////////////////////////////////////////////////////////////////////
 
  modport slave (

///////////////// WRITE_ADDRESS_CHANNEL /////////////////
/*******************************************************/

       input awaddr,
       input awlen,
       input awsize,
       input awburst,
       input awvalid,
       output awready,

////////////////// WRITE_DATA_CHANNEL ///////////////////
/*******************************************************/

       input logic wdata,
       input logic wstrb,
       input logic wlast,
       input logic wvalid,
       output logic wready,

//////////////// WRITE_RESPONSE_CHANNEL /////////////////
/*******************************************************/

       output logic bresp,
       output logic bvalid,
       input logic bready,

///////////////// READ_ADDRESS_CHANNEL //////////////////
/*******************************************************/

       input logic arid,
       input logic araddr,
       input logic arlen,
       input logic arsize,
       input logic arburst,
       input logic arvalid,
       output logic arready,

////////////////// READ_DATA_CHANNEL ////////////////////
/*******************************************************/

       output logic rdata,
       output logic rresp,
       output logic rlast,
       output logic rvalid,
       input logic rready
       
  );
  
///////////////////////////////////////////////////////////////////////////////  
//////////////////////// MODPORT_MASTER_1 DECLARATION /////////////////////////  
///////////////////////////////////////////////////////////////////////////////
  
   modport master (

///////////////// WRITE_ADDRESS_CHANNEL /////////////////
/*******************************************************/


       output logic awaddr,
       output logic awlen,
       output logic awsize,
       output logic awburst,
       output logic awvalid,
       input logic awready,
      
////////////////// WRITE_DATA_CHANNEL ///////////////////
/*******************************************************/

       output logic wdata,
       output logic wstrb,
       output logic wlast,
       output logic wvalid,
       input logic wready,
      
//////////////// WRITE_RESPONSE_CHANNEL /////////////////
/*******************************************************/

       input logic bresp,
       input logic bvalid,
       output logic bready,
    
///////////////// READ_ADDRESS_CHANNEL //////////////////
/*******************************************************/

       output logic arid,
       output logic araddr,
       output logic arlen,
       output logic arsize,
       output logic arburst,
       output logic arvalid,
       input logic arready,         
      
////////////////// READ_DATA_CHANNEL ////////////////////
/*******************************************************/

       input logic rdata,
       input logic rresp,
       input logic rlast,
       input logic rvalid,
       output logic rready  
         
       );   
  
endinterface  :  axi_interface

`endif
