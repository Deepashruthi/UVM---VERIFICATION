//Driver
class my_driver extends uvm_driver #(seq_item);
  
  seq_item req;
  virtual inter inf;// Handle to interface used to drive dut pins
  
  //Factory Registration
  `uvm_component_utils(my_driver)
  
  function new(string name = "Driver" , uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual inter) :: get(this,"","vif",inf))
      `uvm_fatal("DRV","Interface not found")
  endfunction
  
    
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      req = seq_item::type_id::create("req");
      seq_item_port.get_next_item(req);
      inf.a = req.a;
      inf.b = req.b;
      inf.c = req.c;
      #10;
      seq_item_port.item_done();
    end
  endtask
  
endclass
