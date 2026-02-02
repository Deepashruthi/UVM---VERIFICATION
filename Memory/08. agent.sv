// Agent

class my_agent extends uvm_agent;
  
  `uvm_component_utils(my_agent)
  
  my_driver drvr;
  my_monitor montr;
  my_sequencer seqncr;
  
  function new(string name="agent", uvm_component parent);
    super.new(name, parent);    
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);    
    seqncr=my_sequencer:: type_id :: create("seqncr", this);    
    drvr=my_driver::type_id::create("drvr",this);
    montr=my_monitor:: type_id :: create("montr",this);    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drvr.seq_item_port.connect(seqncr.seq_item_export);
  endfunction
  
endclass
