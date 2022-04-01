`include "axi_interconnect_interface.sv"

module axi_interconnect #(addr_wid_axi = 32, data_wid =32, asize=$clog2(data_wid/8), stroblen=(data_wid/8))

( 
  input logic aclk,
  input logic aresetn
);  

//////////////////////////////////////////////////////////////////////////
////////////////////// INTERFACE_INSTANTIATION ///////////////////////////
//////////////////////////////////////////////////////////////////////////
  
  axi_interconnect_interface S1();
  axi_interconnect_interface S2();
  axi_interconnect_interface M1();
  axi_interconnect_interface M2();

/////////////////////////////////////////////////////////
//*************** write data channels *****************//
       
       logic [addr_wid_axi-1:0] awaddr;
       logic [7:0] awlen;
       logic [asize-1:0] awsize;
       logic [1:0] awburst;
       logic awvalid;
       logic awready;
       
/////////////////////////////////////////////////////////
//***************write data channels*******************//

       logic [data_wid-1:0] wdata;
       logic [stroblen-1:0] wstrb;
       logic wlast;
       logic wvalid;
       logic wready;

////////////////////////////////////////////////////////
//**************write response channel****************//

       logic [1:0] bresp;
       logic bvalid;
       logic bready;

///////////////////////////////////////////////////////
//***********read address channel signals************//

       logic [1:0] arid;
       logic [addr_wid_axi-1:0] araddr;
       logic [7:0] arlen;
       logic [asize-1:0] arsize;
       logic [1:0] arburst;
       logic arvalid;
       logic arready;

//////////////////////////////////////////////////////
//************read data channel signals*************//

       logic [data_wid-1:0] rdata;
       logic [1:0] rresp;
       logic rlast;
       logic rvalid;
       logic rready;  
  
//////////////////////////////////////////////////////////////////////////
/////////////////////////// TASK_DECLARATION /////////////////////////////
//////////////////////////////////////////////////////////////////////////

task master1_slave1_connect();
	         
	               S1.awready=M1.awready;
                 S1.wready=M1.wready;
                 S1.bresp=M1.bresp;
                 S1.bvalid=M1.bvalid;
                 S1.arready=M1.arready;
                 S1.rdata=M1.rdata;
                 S1.rresp=M1.rresp;
                 S1.rlast=M1.rlast;
                 S1.rvalid=M1.rvalid;

                 M1.awaddr=S1.awaddr;
                 M1.awlen=S1.awlen;
                 M1.awsize=S1.awsize;
                 M1.awburst=S1.awburst;
                 M1.awvalid=S1.awvalid;
                 M1.wdata=S1.wdata;
                 M1.wstrb=S1.wstrb;
                 M1.wlast=S1.wlast;
                 M1.wvalid=S1.wvalid;
                 M1.bready=S1.bready;
                 M1.arid=S1.arid;
                 M1.araddr=S1.araddr;
                 M1.arlen=S1.arlen;
                 M1.arsize=S1.arsize;
                 M1.arburst=S1.arburst;
                 M1.arvalid=S1.arvalid;
                 M1.rready=S1.rready;

endtask : master1_slave1_connect



task master1_slave2_connect();

	             S2.awready=M1.awready;
                 S2.wready=M1.wready;
                 S2.bresp=M1.bresp;
                 S2.bvalid=M1.bvalid;
                 S2.arready=M1.arready;
                 S2.rdata=M1.rdata;
                 S2.rresp=M1.rresp;
                 S2.rlast=M1.rlast;
                 S2.rvalid=M1.rvalid;

                 M1.awaddr=S2.awaddr;
                 M1.awlen=S2.awlen;
                 M1.awsize=S2.awsize;
                 M1.awburst=S2.awburst;
                 M1.awvalid=S2.awvalid;
                 M1.wdata=S2.wdata;
                 M1.wstrb=S2.wstrb;
                 M1.wlast=S2.wlast;
                 M1.wvalid=S2.wvalid;
                 M1.bready=S2.bready;
                 M1.arid=S2.arid;
                 M1.araddr=S2.araddr;
                 M1.arlen=S2.arlen;
                 M1.arsize=S2.arsize;
                 M1.arburst=S2.arburst;
                 M1.arvalid=S2.arvalid;
                 M1.rready=S2.rready;

endtask: master1_slave2_connect

task slave_1_default();

                 S1.awready=0;
                 S1.wready=0;
                 S1.bresp=0;
                 S1.bvalid=0;
                 S1.arready=0;
                 S1.rdata=0;
                 S1.rresp=0;
                 S1.rlast=0;
                 S1.rvalid=0;

endtask : slave_1_default                 

task slave_2_default();

                 S2.awready=0;
                 S2.wready=0;
                 S2.bresp=0;
                 S2.bvalid=0;
                 S2.arready=0;
                 S2.rdata=0;
                 S2.rresp=0;
                 S2.rlast=0;
                 S2.rvalid=0;
			   
endtask : slave_2_default
     
task master_1_default();

		 M1.awaddr=0;
                 M1.awlen=0;
                 M1.awsize=0;
                 M1.awburst=0;
                 M1.awvalid=0;
                 M1.wdata=0;
                 M1.wstrb=0;
                 M1.wlast=0;
                 M1.wvalid=0;
                 M1.bready=0;
                 M1.arid=0;
                 M1.araddr=0;
                 M1.arlen=0;
                 M1.arsize=0;
                 M1.arburst=0;
                 M1.arvalid=0;
                 M1.rready=0;

endtask : master_1_default

//////////////////////////////////////////////////////////////////////////
///////////////////////// END OF TASK_DECLARATION ////////////////////////
//////////////////////////////////////////////////////////////////////////  
  
parameter idle=3'b000, master_1_write=3'b001, master_1_read=3'b010, master_2_write=3'b100, master_2_read=3'b101;
logic [2:0] state;

always @(negedge aresetn) begin
                state<=idle; end

always @(posedge aclk) begin
  
  case(state) 

    idle: begin
         
         if((S1.awvalid && (!(|S1.awaddr[31:26]))) || (S1.arvalid && (!(|S1.araddr[31:26])))) begin    //____________CHECKING_REQUEST_FROM_MASTER_1_____________//

             if(S1.awvalid && (!(|S1.awaddr[31:26]))) begin //_______CHECKING_WRITE_REQUEST_FROM_MASTER_1_______//                 
                  state=master_1_write; // GIVING THE NEXT STATE
                  slave_2_default();           // SLAVE INTERFACE 2 IN DEFAULT MODE
                  master1_slave1_connect();    // SLAVE INTERFACE 1 CONNECTS TO THE MASTER INTERFACE 1
                  end

             else if(S1.arvalid && (!(|S1.araddr[31:26]))) begin
                  state= master_1_read; // GIVING THE NEXT STATE
                  slave_2_default();           // SLAVE INTERFACE 2 IN DEFAULT MODE
                  master1_slave1_connect();    // SLAVE INTERFACE 1 CONNECTS TO THE MASTER INTERFACE 1
                  end
         end

         else if((S2.awvalid && (!(|S2.awaddr[31:26]))) || (S2.arvalid && (!(|S2.araddr[31:26])))) begin
           
           if(S2.awvalid && (!(|S2.awaddr[31:26]))) begin //_______CHECKING_WRITE_REQUEST_FROM_MASTER_2_______//
                 
                  state = master_2_write; // GIVING THE NEXT STATE

                  slave_1_default();          // SLAVE INTERFACE 1 IN DEFAULT MODE
                  master1_slave2_connect();   // SLAVE INTERFACE 2 CONNECTS TO THE MASTER INTERFACE 1
                  end

             else if(S2.arvalid && (!(|S2.araddr[31:26]))) begin
                  state = master_2_read; // GIVING THE NEXT STATE
                  slave_1_default();          // SLAVE INTERFACE 1 IN DEFAULT MODE
                  master1_slave2_connect();   // SLAVE INTERFACE 2 CONNECTS TO THE MASTER INTERFACE 1
                  end
         end

         else begin // ALL SLAVE AND MASTER INTERFACES ARE IN DEFAULT MODE                
                  slave_1_default();
		              slave_2_default();
		              master_1_default();
                  end
    end

    master_1_write: begin
                  master1_slave1_connect(); // SLAVE INTERFACE 1 CONNECTS TO THE MASTER INTERFACE 1

                  if(M1.bvalid && S1.bready) begin
                   state=idle; end
    end

    master_1_read: begin
		              master1_slave1_connect(); // SLAVE INTERFACE 1 CONNECTS TO THE MASTER INTERFACE 1
               
                  if(M1.rlast && S1.rready) begin
                   state=idle; end
    end

    master_2_write: begin
                  master1_slave2_connect(); // SLAVE INTERFACE 2 CONNECTS TO THE MASTER INTERFACE 1
                 
                  if(M1.bvalid && S2.bready) begin
                   state=idle; end
    end

    master_2_read: begin  
                  master1_slave2_connect(); // SLAVE INTERFACE 2 CONNECTS TO THE MASTER INTERFACE 1

                  if(M1.rlast && S2.rready) begin
                   state=idle; end
    end

    default: state=idle;
  endcase
end
endmodule
 
 

