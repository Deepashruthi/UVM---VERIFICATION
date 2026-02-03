//Agent 
class my_agent extends uvm_agent;
  
  my_driver drvr;
  my_monitor mntr;
  my_sequencer sqcr;
  
  //Factory Registration
  `uvm_component_utils(my_agent)
  
  //Constructor
  function new(string name = "Agent", uvm_component parent );
    super.new(name, parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    sqcr = my_sequencer :: type_id :: create("sqcr", this);
    drvr = my_driver :: type_id :: create("drvr",this);
    mntr = my_monitor :: type_id :: create("mntr", this);
  endfunction
  
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    drvr.seq_item_port.connect(sqcr.seq_item_export);
  endfunction
  
endclass
    
