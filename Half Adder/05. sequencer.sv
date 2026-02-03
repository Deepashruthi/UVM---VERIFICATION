//Sequencer
class my_sequencer extends uvm_sequencer #(seq_item);
  
  // Factory registration
  `uvm_component_utils(my_sequencer)
  
  //Constructor
  function new( string name = "Sequencer", uvm_component parent );
    super.new(name, parent);
  endfunction 
  
endclass
