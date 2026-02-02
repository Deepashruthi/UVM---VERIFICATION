// Driver
class my_driver extends uvm_driver#(my_seq_item);
  
  virtual dff_if vif;
  my_seq_item req;
  
  `uvm_component_utils(my_driver)
    
  function new(name="my_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db  #(virtual dff_if)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Interface not found");
  endfunction
      
  task run_phase(uvm_phase phase);
    super.run_phase(phase);    
    forever begin
      req=my_seq_item::type_id::create("req");
      seq_item_port.get_next_item(req);
      @(negedge vif.clk);
      vif.rst <=req.rst;
      vif.d <=req.d;
      #5;
      seq_item_port.item_done();
    end
  endtask
  
endclass
    
        
