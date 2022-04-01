//////////////////////////////////////////////////////////////////////////////////
// Company: DSi
// Engineer: Fariya
// 
// Create Date: 03/28/2022 04:29:50 PM
// Design Name: 
// Module Name: Project_UVM_scoreboard
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`ifndef PROJECT_UVM_SCOREBOARD
`define PROJECT_UVM_SCOREBOARD

//checker//

class Project_UVM_scoreboard extends uvm_scoreboard;

  axi_seq_item pkt_qu[$];

  bit [7:0] sc_axi [4];

  uvm_analysis_imp#(axi_seq_item, Project_UVM_scoreboard) item_collected_export;  ///from exp
  `uvm_component_utils(Project_UVM_scoreboard)

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new(“item_collected_export”, this);
    foreach(sc_axi[i]) sc_axi[i] = 8’hFF;
  endfunction: build_phase

  virtual function void write(axi_seq_item pkt);
    //pkt.print();
    pkt_qu.push_back(pkt);   //push back = data insert
  endfunction : write

  virtual task run_phase(uvm_phase phase);
    axi_seq_item axi_pkt;

    forever begin
      wait(pkt_qu.size() > 0);
      axi_pkt = pkt_qu.pop_front();  //pop= data take

      if(axi_pkt.wr_en) begin
        sc_axi[axi_pkt.addr] = axi_pkt.wdata;
        `uvm_info(get_type_name(),$sformatf(“—— :: WRITE DATA :: ——“),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf(“Addr: %0h”,axi_pkt.addr),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf(“Data: %0h”,axi_pkt.wdata),UVM_LOW)
        `uvm_info(get_type_name(),”————————————“,UVM_LOW)
      end
      else if(axi_pkt.rd_en) begin
        if(sc_axi[axi_pkt.addr] == axi_pkt.rdata) begin
          `uvm_info(get_type_name(),$sformatf(“—— :: READ DATA Match :: ——“),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf(“Addr: %0h”,axi_pkt.addr),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf(“Expected Data: %0h Actual Data: %0h”,sc_axi[axi_pkt.addr],axi_pkt.rdata),UVM_LOW)
          `uvm_info(get_type_name(),”————————————“,UVM_LOW)
        end
        else begin
          `uvm_error(get_type_name(),”—— :: READ DATA MisMatch :: ——“)
          `uvm_info(get_type_name(),$sformatf(“Addr: %0h”,axi_pkt.addr),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf(“Expected Data: %0h Actual Data: %0h”,sc_axi[axi_pkt.addr],axi_pkt.rdata),UVM_LOW)
          `uvm_info(get_type_name(),”————————————“,UVM_LOW)
        end
      end
    end
  endtask : run_phase
endclass : Project_UVM_scoreboard
