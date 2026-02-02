// Scoreboard
class my_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(my_scoreboard)
  
  uvm_analysis_imp #(my_seq_item,my_scoreboard) sb_imp;
  
  function new(string name="scoreboard", uvm_component parent);
    super.new(name,parent);    
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    sb_imp=new("sb_imp",this);
  endfunction
  
  function void write(my_seq_item item);
    
    if(((item.q==item.d)&&(!item.rst)) || ((item.q==0)&&(item.rst)))
      `uvm_info("SB",$sformatf("PASS----> INPUT:clk=%0b |rst=%0b|d=%0b|Actual output: q=%0b||", item.clk,item.rst,item.d,item.q),UVM_LOW)
    else
      `uvm_error("SB",$sformatf("FAIL----> INPUT:clk=%0b |rst=%0b|d=%0b|Actual output: q=%0b||", item.clk,item.rst,item.d,item.q))
  endfunction
  
endclass
