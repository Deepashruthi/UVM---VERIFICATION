// Scoreboard 
class my_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(my_scoreboard)
  
  uvm_analysis_imp #(my_seq_item, my_scoreboard) sb_imp;
  
  function new(string name = "Scoreboard" ,uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_imp = new("sb_imp",this);
  endfunction
  
  bit [3:0] exp_count;
  function void write(my_seq_item item);
    
    if(item.en && !item.rst)
        exp_count += 1;
    else if( !item.rst && !item.en)
        exp_count = exp_count;
      else 
        exp_count = 0;
    
    if(exp_count == item.count)
      `uvm_info("SB",$sformatf("PASS----> INPUT:clk=%0b |rst=%0b|en=%0b|Actual output: count=%0d || Exp output=%0d", item.clk,item.rst,item.en,item.count,exp_count),UVM_LOW)
    else
      `uvm_error("SB",$sformatf("FAIL----> INPUT:clk=%0b |rst=%0b|en=%0b|Actual output: count=%0d || Exp output=%0d", item.clk,item.rst,item.en,item.count,exp_count))
  endfunction
  
endclass
