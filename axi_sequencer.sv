/********************************************************

File Name:                      sequencer.sv
Description:                    template for learning UVM
Author:                         Muntasir Babul
Date Created:                   19 March 2022

********************************************************/

class our_sequencer extends uvm_sequencer #(our_packet);

        `uvm_component_utils(our_sequencer);

        function new( string name = "our_sequencer", uvm_component parent = null);
                super.new(name, parent);

        endfunction : new

//Build Phase//

function void build_phase(uvm_phase phase);
        //   Build Other Components  //
	`uvm_info(get_type_name(), "In the build phase", UVM_MEDIUM);
endfunction

//Connect Phase//

function void connect_phase(uvm_phase phase);
        //   Nessessary Connections  //

endfunction

//   Run Phase                                             //

task run_phase(uvm_phase phase);

endtask

	
	
	
	//main_logic//

endclass : our_sequencer

