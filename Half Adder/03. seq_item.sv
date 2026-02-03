// Sequence item

class seq_item extends uvm_sequence_item;
  
  //Factory Registration
  `uvm_object_utils(seq_item)
  
  //Declaring stimulus fields
  rand bit a;
  rand bit b;
  bit sum;
  bit carry;
  
  //Constructor
  function new(string name = "Seq_item");
    super.new(name);
  endfunction
  
endclass
  
  
