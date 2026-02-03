// Sequence 
class my_sequence extends uvm_sequence #(my_seq_item);
  
  `uvm_object_utils(my_sequence)
  
  function new(string name = "sequence");
    super.new(name);
  endfunction
  
  task body();
    my_seq_item req;
    `uvm_info("SEQ", "Sequence Starts", UVM_LOW)
    repeat(20) begin
      req = my_seq_item::type_id::create("req");
      start_item(req);
      if(!req.randomize())
        `uvm_error("SEQ","Randomization failed");
      finish_item(req);
    end
  endtask
  
endclass
