// Driver
class fifo_driver extends uvm_driver #(fifo_seq_item);
  `uvm_component_utils(fifo_driver)

  virtual fifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual fifo_if)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Interface not found");
  endfunction

  task run_phase(uvm_phase phase);
    fifo_seq_item req;
    super.run_phase(phase);

    forever begin
      req = fifo_seq_item::type_id::create("req");
      seq_item_port.get_next_item(req);

      // write side
      @(vif.wcb);
      vif.wcb.w_en <= req.w_en;
      vif.wcb.data_in <= req.data;

      // read side
      @(vif.rcb);
      vif.rcb.r_en <= req.r_en;

      seq_item_port.item_done();
    end
  endtask
endclass
