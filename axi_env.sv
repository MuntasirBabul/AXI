

`ifndef AXI_ENV
`define AXI_ENV

class axi_env extends uvm_env;

	`uvm_component_utils(axi_env);	
	
  ////////////////////////////////////////////////////////////////////
  ///////////////////// Agent Instantiation //////////////////////////
  ////////////////////////////////////////////////////////////////////
	
	axi_env agent_1;
	axi_env agent_2;
	axi_scoreboard scrbd;

  ////////////////////////////////////////////////////////////////////
  /////////////////////////// Constructor ////////////////////////////
  ////////////////////////////////////////////////////////////////////		
	
	function new( string name = "axi_env", uvm_component parent = null);
		
		super.new(name, parent);
	
	endfunction : new

  ////////////////////////////////////////////////////////////////////
  // Method name : build_phase 
  // Decription: Construct the components and objects 
  ////////////////////////////////////////////////////////////////////

	function void build_phase(uvm_phase phase);

	`uvm_info(get_type_name(), "In the build phase", UVM_MEDIUM);
	agent_1 = axi_agent::type_id::create("agent_0", this); 
	agent_2 

	endfunction

//   Connect Phase                                         //

function void connect_phase(uvm_phase phase);
        //   Nessessary Connections  //

endfunction

//   Run Phase                                             //

task run_phase(uvm_phase phase);

	//   Main Logic  	     //

endtask



endclass : our_env
`endif