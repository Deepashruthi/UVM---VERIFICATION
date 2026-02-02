// Sequence Item
class my_seq_item extends uvm_sequence_item;
  
  `uvm_object_utils(my_seq_item)
  
  bit clk;
  rand bit wr;
  rand bit [7:0] d_in;
  rand bit [3:0] addr;
  bit [7:0] d_out;
  
  
  function new(name="my_seq_item");
    super.new(name);
  endfunction
  
  constraint c1{ wr dist{0:=3 , 1:=7};}
  
  constraint c2 { addr inside {[0:10]}; }
  
endclass
