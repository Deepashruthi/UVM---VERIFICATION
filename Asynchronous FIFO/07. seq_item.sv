//Sequence item 
class fifo_seq_item #(parameter Width = 8) extends uvm_sequence_item;
  rand bit w_en;
  rand bit r_en;
  rand bit [Width-1:0] data;

  `uvm_object_utils(fifo_seq_item)

  function new(string name="fifo_seq_item");
    super.new(name);
  endfunction
endclass
