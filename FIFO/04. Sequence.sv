// Sequence
class my_sequence extends uvm_sequence#(my_seq_item );
  
  `uvm_object_utils(my_sequence)
  
  function new(name="my_sequence");
    super.new(name);
  endfunction
  
  task body();    
    my_seq_item req;    
    `uvm_info("SEQ","Sequence starts",UVM_LOW)    
    repeat(30) begin   
      req= my_seq_item #()::type_id::create("req");
    start_item(req);
    if(!req.randomize()) `uvm_error("SEQ", "Randomize failed");
      finish_item(req);
    end    
  endtask
  
endclass
    
    
  
  
