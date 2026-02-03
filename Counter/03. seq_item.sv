//Sequence item
class my_seq_item extends uvm_sequence_item;
  
  `uvm_object_utils(my_seq_item)
  
  bit clk;
  bit rst;
  rand bit en;
  bit [3:0] count;
  
  function new(string name ="my_seq_item");
    super.new(name);
  endfunction
  
  //constraint c1 {rst dist { 0:=5, 1:=5};}
  constraint c2 {en dist {0:=3, 1:=7};}
endclass
