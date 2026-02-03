//Monitor 

class my_monitor extends uvm_monitor;
  
  seq_item item;
  virtual inter inf;
  
  uvm_analysis_port #(seq_item) mon_ap;
  
  //Factory Registration
  `uvm_component_utils(my_monitor)
  
  function new(string name = "monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap" , this);
    if(!uvm_config_db #(virtual inter) :: get(this, "", "vif", inf))
      `uvm_fatal("MTR", "Interface not found")
  endfunction
      
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      #10;
      item = seq_item::type_id::create("item");
      
      item.a = inf.a;
      item.b = inf.b;07
      item.sum = inf.sum;
      item.carry = inf.carry;
      
      mon_ap.write(item);
    end
  endtask
    
endclass    
