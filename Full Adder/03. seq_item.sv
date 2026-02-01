//Sequence Item
class seq_item extends uvm_sequence_item;
  
  //Factory Registration
  `uvm_object_utils(seq_item)  
  
  //Declare stimulus fields
  rand bit a;
  rand bit b;
  rand bit c;
  bit sum;
  bit carry;
  
  
  //Constructor
  function new ( string name = "seq_item");
    super.new(name);
  endfunction
  
endclass
