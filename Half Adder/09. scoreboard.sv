// Scoreboard
class my_score extends uvm_scoreboard;
  
  uvm_analysis_imp #(seq_item, my_score) sb_imp;
  
  //Factory Registration
  `uvm_component_utils(my_score)
  
  //Constructor
  function new(string name = "Scoreboard" , uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    sb_imp = new("sb_imp", this);
  endfunction
  
  function void write(seq_item item);
    bit exp_sum;
    bit exp_carry;
    bit [1:0] exp;
    
    exp = item.a + item.b;
    
    {exp_carry, exp_sum} = { exp[1:0] };
    
    if(exp_sum == item.sum && exp_carry == item.carry)
      `uvm_info("SB", $sformatf("PASS--------> INPUT: a=%d | b=%d | Actual output: sum=%d | carry=%d | Expected output: sum=%d | carry=%d",item.a,item.b,item.sum,item.carry,exp_sum,exp_carry),UVM_LOW)
    else
      `uvm_error("SB", $sformatf("FAIL--------> INPUT: a=%d | b=%d | Actual output: sum=%d | carry=%d | Expected output: sum=%d | carry=%d",item.a,item.b,item.sum,item.carry,exp_sum,exp_carry))
  endfunction
endclass
