/********************************************************

File Name:                      monitor.sv
Description:                    template for learning UVM
Author:                         Muntasir Babul
Date Created:                   19 March 2022

********************************************************/

class our_monitor extends uvm_monitor;

        `uvm_component_utils(our_monitor);
	our_interface intf;
	our_packet    pkt;


        function new( string name = "our_monitor", uvm_component parent = null);
                super.new(name, parent);

        endfunction : new

//   Build Phase                                           //

function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "In the build phase", UVM_MEDIUM);
	//Build Other Components//
	pkt = our_packet::type_id::create("Our_packet");
	//get_method//
	uvm_config_db #(virtual our_interface)::get(null, "*", "intf", intf);
	mon_port = new("Monitor Port", this);
endfunction

//   Connect Phase                                         //

function void connect_phase(uvm_phase phase);
        //   Nessessary Connections  //

endfunction

//   Run Phase                                             //

task run_phase(uvm_phase phase);
	forever begin
	@(posedge intf.aclk)
		pkt.input_1 <= intf.input_1;
		pkt.input_2 <= intf.input_2;
	end
endtask

endclass : our_monitor

