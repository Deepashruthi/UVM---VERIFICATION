//Monitor
class fifo_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_monitor)

  virtual fifo_if vif;

  uvm_analysis_port #(fifo_seq_item) mon_ap;

  function new(string name, uvm_component parent);
    super.new(name,parent);
    //mon_ap = new("mon_ap", this);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);
    if(!uvm_config_db  #(virtual fifo_if)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Interface not found");
  endfunction
  
//   task run_phase(uvm_phase phase);
//     fifo_seq_item item;

//     forever begin
//       @(vif.wcb or vif.rcb);
      
//       item = fifo_seq_item #()::type_id::create("item");

//       item.w_en = vif.w_en;
//       item.r_en  = vif.r_en;
//       item.data     = (vif.w_en) ? vif.data_in : vif.data_out;

//       mon_ap.write(item);
//     end
//   endtask
  task run_phase(uvm_phase phase);
    fork
      monitor_write_side();
      monitor_read_side();
    join
  endtask

  // -----------------------------------
  // WRITE SIDE MONITOR
  // -----------------------------------
  task monitor_write_side();
    fifo_seq_item item;

    forever begin
      @(posedge vif.wclk);

      if (vif.w_en && !vif.full) begin
        item = fifo_seq_item::type_id::create("wr_item");
        item.w_en = 1;
        item.r_en  = 0;
        item.data     = vif.data_in;

        mon_ap.write(item);
      end
    end
  endtask
  
  // -----------------------------------
  // READ SIDE MONITOR
  // -----------------------------------
  task monitor_read_side();
    fifo_seq_item item;

    forever begin
      @(posedge vif.rclk);

      if (vif.r_en && !vif.empty) begin
        item = fifo_seq_item::type_id::create("rd_item");
        item.w_en = 0;
        item.r_en  = 1;
        item.data     = vif.data_out;

        mon_ap.write(item);
      end
    end
  endtask
endclass
