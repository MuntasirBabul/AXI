/********************************************************

File Name:                      agent.sv
Description:                    Project_UVM_agent
Date Created:                   26 March 2022
Date progress:                  27 March 2022

********************************************************/

`ifndef PROJECT_UVM_AGENT_PKG
`define PROJECT_UVM_AGENT_PKG

package Project_UVM_agent_pkg;
 
import uvm_pkg::*;
`include "uvm_macros.svh"

//////////////////////////////////////////////////////////
// include Agent components : driver,monitor,sequencer ///
//////////////////////////////////////////////////////////
 
`include "defines.svh"
`include "transaction.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"

endpackage

`endif
