// Scoreboard 
class my_scoreboard #(parameter Width = 8) extends uvm_scoreboard;
  
  `uvm_component_utils(my_scoreboard)
  
  uvm_analysis_imp #(my_seq_item, my_scoreboard) sb_imp;
  
  function new(string name = "my_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_imp = new("sb_imp", this);
  endfunction
  
  bit [Width-1 : 0] queue[$];
  bit [Width-1 : 0] exp_out;

  function void write(my_seq_item item);
    if(item.rst) begin
      queue.delete();   // Clear queue
      exp_out = 0;
      `uvm_info("SB", $sformatf("Reset Ignored"), UVM_LOW);
      return;
    end
    else begin
      if(item.wr_en && !item.full) 
        queue.push_back(item.d_in);
      if(item.rd_en && !item.empty)
      exp_out = queue.pop_front();
    end
    if(item.wr_en) begin
      `uvm_info("SB",$sformatf("WRITE PASS: ----> INPUT: d_in=%0d", item.d_in),UVM_LOW)
  end
    if((item.rd_en==1)) begin
      if (item.d_out==exp_out)
        `uvm_info("SB",$sformatf("PASS----> INPUT: wr_en=%0b|rd_en=%0d|d_in=%0d|Actual output: d_out=%0d||Expected output: exp_out=%0d", item.wr_en,item.rd_en,item.d_in,item.d_out,exp_out),UVM_LOW)
        else
    `uvm_error("SB",$sformatf("FAIL----> INPUT: wr_en=%0b|rd_en=%0d|d_in=%0d|Actual output: d_out=%0d||Expected output: exp_out=%0d", item.wr_en,item.rd_en,item.d_in,item.d_out,exp_out))
          end
          endfunction
      endclass
