

`ifndef AXI_BASIC_TEST
`define AXI_BASIC_TEST

class axi_test extends uvm_test;
 
  ////////////////////////////////////////////////////////////////////
  //declaring component utils for the basic test-case 
  ////////////////////////////////////////////////////////////////////
  
  `uvm_component_utils (axi_test)
 
  axi_environment     env;        //obj of environment
  axi_sequence        seq;        //obj of sequence
  ////////////////////////////////////////////////////////////////////
  // Method name : new
  // Decription: Constructor 
  ////////////////////////////////////////////////////////////////////
  
  function new(string name = "axi_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  ////////////////////////////////////////////////////////////////////
  // Method name : build_phase 
  // Decription: Construct the components and objects 
  ////////////////////////////////////////////////////////////////////
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    env = environment::type_id::create(.name("env"), .parent(this));
    seq = sequence::type_id::create(.name("seq"), .parent(this));
  endfunction : build_phase
  /////////////      ///////////////////////////////////////////////////////
  // Method name : run_phase 
  // Decription: Trigger the sequences to run 
  ////////////////////////////////////////////////////////////////////
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
     seq.start(axi_env.agent_0.sequencer);
    phase.drop_objection(this);    axi_scoreboard
  endtask : run_phase
 
endclass : axi_test

`endif
