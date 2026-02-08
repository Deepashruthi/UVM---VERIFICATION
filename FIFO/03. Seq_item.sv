// Sequence item
class my_seq_item #( parameter Width = 8) extends uvm_sequence_item;
  
  `uvm_object_utils(my_seq_item)
  
  bit rst;
  rand bit wr_en;
  rand bit rd_en;
  rand bit [Width-1 :0] d_in;
  
  bit [Width-1 : 0] d_out;
  bit full;
  bit empty;
  
  function new(name="my_seq_item");
    super.new(name);
  endfunction
  
  
  constraint c1 { 
    wr_en -> d_in inside { [0 : (1<<Width)-1] };
    !wr_en -> d_in == 0;
  }
  
  constraint c2 {
    wr_en dist { 1:=50, 0:=50 }; 
    rd_en dist { 1:=50, 0:=50 };
  }
  
  constraint c3{ 
    wr_en != rd_en;
  }
  
endclass
