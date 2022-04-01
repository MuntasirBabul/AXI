`timescale 1ns/1ps
module axi_slave #(parameter addr_wid_axi = 32, addr_wid_mem=26, data_wid=32, asize=$clog2(data_wid/8), stroblen=(data_wid/8))
                   
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
       input logic rready,
       
       //mem_controller signal
       output logic [addr_wid_mem-1:0] maddr,
       output logic [data_wid-1:0] mdata,
       output logic [stroblen-1:0] mwstrb,
       input logic [data_wid-1:0] sdata,
       output logic mread,mwrite,
       //output logic ce,
       output logic gclken);
       
       
      
       parameter idle=2'b00, write_burst=2'b01, write_resp=2'b10, read_burst=2'b11;

       parameter fixed=2'b00, incr= 2'b01, wrap = 2'b10, reserved= 2'b11;

      //logic ce;
       logic [7:0] len;
	logic [stroblen-1:0] size;
       logic [1:0] burst_type;
      // logic [stroblen-1:0] strb;
       logic [addr_wid_mem-1:0] addr;
       
       logic [1:0] state;
       
      //assign ce = mread | mwrite; 

        //next state logic 


       always_ff @(negedge aresetn)
                    begin 
                        if(!aresetn) begin
                            state <= idle;
                             end
                    end
                    
	always @(posedge aclk) begin
                           
                      case(state) 
                            
                            idle: begin
                                                
                                    rvalid = 0;
                                    bvalid = 0;
                                    arready = 1;
                                    awready = 1;
                                    wready = 1;
//                                    rready = 1;//edited
                                    mread = 0;
                                    mwrite =0;
                                    len = 0;
                                    size = 0;
                                    mwstrb = 'b0;
                                    rlast = 0;	

                              if(awvalid)
                                    begin 
                                    state = write_burst;
                                    mwrite=1;
                                    mread=0;
                                    awready = 0;
                                    maddr = awaddr;
                                    addr = awaddr;
                                    len = awlen+1;
                                    size = 2**awsize;
                                    burst_type = awburst; 
                                    end

                              else if(arvalid) 
                                    begin
                                    state = read_burst;
                                    mread=1;
                                    mwrite=0;
//                                    arready = 1;//edited
                                    maddr = araddr;
                                    addr = araddr;
                                    len = arlen+1;
                                    size = 2**arsize;
                                    burst_type = arburst; end
                                                   
                                  end


                           write_burst: begin
                                
                             if (wvalid) begin
                                                
                            case(burst_type) 
                                                
                           fixed:   begin
                                    mwstrb = wstrb;
                                    mdata = wdata;
                                    len = len -1;
                                    maddr = addr; 
                                    if(len==0) begin
                                    wready = 0;
                                    state = write_resp; end
                           end

                           incr:    begin   
                                    mwstrb =wstrb;
                                    mdata = wdata;
                                    maddr=addr;
//                                    $display("len value is %0d at %t and mdata is %h maddr is %h",len,$time,mdata,maddr);
                                    len = len-1;
                                    
                                    if(len==0) begin
                                    wready = 0;
                                   
                                    state = write_resp; end
                                    else addr = addr + size;
                                    end

                           default: state =idle ;
                                    
                                    endcase
                                    end
                                    end
                                    

                           write_resp: begin
                                    //mwrite=0;
                                    
                                    bresp=2'b00;
                                    bvalid =1;
                                    if(bready)
                                    state = idle;
                                   end
                                            

                           read_burst: //read_burst_case
                         
                                                
                                    case(burst_type) 

                           fixed: begin
                                    
                                    rdata=sdata;
                                    maddr=addr;
                                    rvalid=1;
                                    rresp=2'b00;
                                    if(len==1) begin
                                      rlast=1;
                                    end
                                                       
                             if(rready) begin
                               len=len-1; end
                                                       
                             if(len==0) begin
                               state=idle;
                                end
                                
                           end

                           incr:   begin 
                                    rdata=sdata;                        
                                    
                                    //$display("reading incr sdata=%h at %t",sdata); 
                                    rvalid=1;
                                    rresp=2'b00; 
                                    $display("len value is %0d at %t and sdata is %h addr is %h ",len,$time,sdata,maddr);
                                    if(len==1) rlast=1;
                                   if(rready) begin
                                    len=len-1;
                                    
                                    if(len==0)
                                    state=idle;
                                    
                                    
                                    else begin
                                    addr=addr+size;
                                    maddr=addr; 
                                    end
                           end
                           end
                                                    
                           default: state =idle;
                      
               endcase
                        endcase
                        end

      endmodule   