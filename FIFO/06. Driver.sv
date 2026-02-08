// Driver
class my_driver extends uvm_driver#(my_seq_item );
  
  virtual intf  vif;
  my_seq_item req;
  
  `uvm_component_utils(my_driver)
    
  function new(name="my_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db  #(virtual intf)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Interface not found");
  endfunction
      
  task run_phase(uvm_phase phase);
    super.run_phase(phase); 
    forever begin
      req=my_seq_item#() ::type_id::create("req");
      seq_item_port.get_next_item(req);
      @(negedge vif.clk);
      vif.wr_en <=req.wr_en;
      vif.rd_en <=req.rd_en;
      vif.d_in <= req.d_in;
      @(posedge vif.clk);
      #10;
      vif.wr_en <= 0;
      vif.rd_en <= 0;
      seq_item_port.item_done();
    end
  endtask
  
endclass
    
