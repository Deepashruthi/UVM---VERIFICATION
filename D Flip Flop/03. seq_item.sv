// Sequence item
class my_seq_item extends uvm_sequence_item;
  
  `uvm_object_utils(my_seq_item)
  
  bit clk;
  rand bit rst;
  rand bit d;
  bit q;
  
  function new(name="my_seq_item");
    super.new(name);
  endfunction
  
  constraint c1{ rst dist{0:=5 , 1:=5};}
  constraint c2{ d dist{0:=5 , 1:=5};}
  
endclass
