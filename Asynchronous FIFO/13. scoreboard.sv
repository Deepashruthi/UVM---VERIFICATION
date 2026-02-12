//Scoreboard
class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)

  uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) sb_imp;

  bit [7:0] ref_q[$];

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_imp = new("sb_imp",this);
  endfunction
  
  function void write(fifo_seq_item item);
    if(item.w_en) begin
      ref_q.push_back(item.data);
    end

    if(item.r_en) begin
      bit [7:0] exp = ref_q.pop_front();
      if(exp !== item.data)
        `uvm_error("FIFO_SB", $sformatf("Mismatch: exp=%0d got=%0d", exp, item.data))
      else
        `uvm_info("FIFO_SB", "MATCHED", UVM_LOW)
    end
  endfunction
endclass
