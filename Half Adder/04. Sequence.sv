//Sequence
class my_seq extends uvm_sequence #(seq_item);
  seq_item req;
  
  //Factory registration
  `uvm_object_utils(my_seq)
  
  //Constructor
  function new(string name = "my_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_info("SEQ","Sequence starts", UVM_LOW)
    
    repeat(20) begin
      req = seq_item :: type_id :: create("req");
      start_item(req);
      if(!req.randomize())
        `uvm_error("SEQ", "Randomization Failed")
      finish_item(req);
    end
  endtask
  
endclass
