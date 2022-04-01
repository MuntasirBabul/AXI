

class axi_driver extends uvm_driver #(axi_packet);

        `uvm_component_utils(axi_driver);

	axi_interface intf;
	axi_packet    pkt;
        function new( string name = "axi_driver", uvm_component parent = null);
                super.new(name, parent);

        endfunction 


//   Data Members (interface declaration)                  //	
	virtual interface axi_interface intf;
	
	
//   Build Phase                                           //

function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "In the build phase", UVM_MEDIUM);
	//   Build Other Components  //
	pkt = axi_packet::type_id::create("packet");
	//   get method              //
	uvm_config_db #(virtual axi_interface)::get(null, "*", "intf", intf);
endfunction

//   Connect Phase                                         //

function void connect_phase(uvm_phase phase);
        //   Nessessary Connections  //

endfunction

//   Run Phase                                             //

task run_phase(uvm_phase phase);

	forever begin
		@(posedge aclk)
		seq_item_port.get_next_item(pkt);
		intf.input_1 <= pkt.input_1;
		intf.input_2 <= pkt.input_2;

		seq_item_port.item_done();


endtask 




endclass : axi_driver



