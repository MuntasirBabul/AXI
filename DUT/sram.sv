`timescale 1ns/1ps
module sram #(parameter addr_wid = 26, data_wid=32,stroblen=data_wid/8)
              (input logic aclk,  
              input logic [data_wid -1:0] d,                       //INPUT DATA
              input logic [addr_wid-1:0] addr,            //ADDRESS
              input logic wen,                            //WRITE_ENABLE                           //CLOCK
              output logic [data_wid -1:0] q,                       //Q >> S_DATA
              input logic [stroblen-1:0] be,                             //BYTE_ENABLE >> mwstrb
              input logic ceb);                            //CHIP_ENABLE << mread_mwrite
              
  int i,j;           
   
  logic [7:0] mem[2**addr_wid];      //MEMORY_DECLARATION
  								
  logic [addr_wid-1:0] addr_temp = 0;    //register for temporary address


  //write and read transaction

  //little endian data structure

  always@(posedge aclk)
  begin
  //$display(" wen is %b and ceb is %b at %t",wen, ceb,$time);
    if (wen == 1'b1) begin
      addr_temp = addr;
       //$display("addr_temp at write %h at %t", addr_temp,$time);
       for(i=1;i<stroblen+1;i++) begin
         if(be[i-1]) begin
            mem[addr_temp]= {d[8*i-1],d[8*i-2],d[8*i-3],d[8*i-4],d[8*i-5],d[8*i-6],d[8*i-7], d[8*i-8]}; //$display("hi");
           addr_temp=addr_temp+1;
         end 
         
       else addr_temp = addr_temp+1;
       end
    end

       else if(ceb) begin
         //addr_temp <= addr;
         addr_temp = addr;
        
         //$display(" addr_temp at read %h at %t", addr_temp,$time);
         for (j=1;j<stroblen+1;j++)begin
          {q[8*j-1],q[8*j-2],q[8*j-3],q[8*j-4],q[8*j-5],q[8*j-6],q[8*j-7], q[8*j-8]} =mem[addr_temp];
           //$display("hi read");
          addr_temp = addr_temp+1;
          //$display("data=%d from sram",q);
         end
          //$display("memory content at %t is mem[%h]= %h",$time,addr_temp, mem[addr_temp]);
          $display("q is %h at time %t",q,$time);
       end
  end
endmodule