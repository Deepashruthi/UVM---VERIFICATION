//Monitor

class my_monitor extends uvm_monitor;
  
  my_seq_item item;
  virtual cnt_if vif;
  uvm_analysis_port #(my_seq_item) mon_ap;
  
  `uvm_component_utils(my_monitor)
  
  function new(string name = "Monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);
    if(!uvm_config_db  #(virtual cnt_if)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Interface not found");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge vif.clk);
      #1;
      item = my_seq_item :: type_id::create("item");
      item.rst = vif.rst;
      item.en = vif.en;
      item.count = vif.count;
      mon_ap.write(item);
    end
  endtask
endclass
