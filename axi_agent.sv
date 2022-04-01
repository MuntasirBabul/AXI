/********************************************************

File Name:                      agent.sv
Description:                    Project_UVM_agent
Date Created:                   26 March 2022
Date progress:			27 March 2022

********************************************************/

`itndef Project_UVM_agent
`define Project_UVM_agent

class our_agent extends uvm_agent;
  
///////////////////////////////////////////////////////////////////////////////
//// Declaration of UVC components such as.. driver,monitor,sequencer..etc ////
///////////////////////////////////////////////////////////////////////////////

Project_UVM_driver driver;
Project_UVM_sequencer sequencer;
Project_UVM_monitor monitor;

///////////////////////////////////////////////////////////////////////////////
/////////////////////// Declaration of component utils ////////////////////////
///////////////////////////////////////////////////////////////////////////////

`uvm_component_utils(Project_UVM_agent)

///////////////////////////////////////////////////////////////////////////////
// Method name : new 
// Description : constructor
///////////////////////////////////////////////////////////////////////////////

function new( string name = "Project_UVM_agent", uvm_component parent = null);

    super.new(name, parent);

endfunction : new

///////////////////////////////////////////////////////////////////////////////
// Method name : build-phase 
// Description : construct driver,monitor,sequencer..etc
///////////////////////////////////////////////////////////////////////////////

function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "In the build phase", UVM_MEDIUM);
	
	sequencer = Project_UVM_sequencer::type_id::create("sequencer", this);	
	driver  = Project_UVM_driver::type_id::create("driver", this);	
	monitor  = Project_UVM_monitor::type_id::create("monitor", this);	

endfunction : build_phase

///////////////////////////////////////////////////////////////////////////////
// Method name : connect_phase 
// Description : connect tlm ports and exports (ex: analysis port/exports) 
///////////////////////////////////////////////////////////////////////////////

function void connect_phase(uvm_phase phase);
    
	driver.seq_item_port.connect(sequencer.seq_item_export);

endfunction : connect_phase


endclass : Project_UVM_agent
