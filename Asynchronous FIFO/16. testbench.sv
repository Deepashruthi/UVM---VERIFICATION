//Testbench
import uvm_pkg::*;          
`include "uvm_macros.svh"

`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"


module tb_top;

  logic wclk=0, rclk=0;

  fifo_if vif(wclk, rclk);

  async_fifo dut (
    .wclk(wclk),
    .wrst_n(vif.wrst_n),
    .rclk(rclk),
    .rrst_n(vif.rrst_n),
    .w_en(vif.w_en),
    .r_en(vif.r_en),
    .data_in(vif.data_in),
    .data_out(vif.data_out),
    .full(vif.full),
    .empty(vif.empty)
  );

  always #5 wclk = ~wclk;
  always #7 rclk = ~rclk;

  initial begin
    vif.wrst_n = 0;
    vif.rrst_n = 0;
    #20;
    vif.wrst_n = 1;
    vif.rrst_n = 1;
    #300;
    $finish;
  end

  initial begin
    uvm_config_db#(virtual fifo_if)::set(null,"*","vif",vif); 
    run_test("fifo_test");
  end

endmodule
