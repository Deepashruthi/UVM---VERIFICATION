//Sequence 
class fifo_sequence extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(fifo_sequence)

  function new(string name="fifo_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;

    repeat(100) begin
      req = fifo_seq_item #()::type_id::create("req");
      start_item(req);
      if(!req.randomize())
        `uvm_error("SEQ","Randomization failed");
      finish_item(req);
    end
  endtask
endclass
