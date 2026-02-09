// Monitor 
class my_monitor extends uvm_monitor;
  
  virtual intf vif;
  my_seq_item item;
  
  `uvm_component_utils(my_monitor)
  
  uvm_analysis_port #(my_seq_item) mon_ap;

  function new(string name = "my_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);
    if(!uvm_config_db #(virtual intf)::get(this, "", "vif", vif))
       `uvm_fatal("MNTR","Interface not found")
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge vif.clk);
      #1;
      item = my_seq_item#() ::type_id::create("item");
      item.rst = vif.rst;
      item.wr_en = vif.wr_en;
      item.rd_en = vif.rd_en;
      item.d_in = vif.d_in;
      item.d_out = vif.d_out;
      item.full = vif.full;
      item.empty = vif.empty;
      mon_ap.write(item);
    end
  endtask
endclass
    
