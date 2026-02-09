//Testbench
import uvm_pkg::*;          
`include "uvm_macros.svh"

`include "Interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

module top;
  
  parameter W = 8, D = 8;
  intf #(W,D) vif();
  
  sync_fifo #(W,D) dut(.clk(vif.clk),
                       .rst(vif.rst),
                       .wr_en(vif.wr_en),
                       .rd_en(vif.rd_en),
                       .d_in(vif.d_in),
                       .d_out(vif.d_out),
                       .full(vif.full),
                       .empty(vif.empty)
        );
  
  initial begin  
    uvm_config_db#(virtual intf #(W))::set(null,"*","vif",vif);   
    run_test ("my_test");
  end
  
  always #5 vif.clk=~vif.clk;
  
  initial begin
    vif.rst = 1;
    #50; vif.rst = 0;
  end
  
  initial begin    
    $dumpfile("my_uvm.vcd");
    $dumpvars;
    vif.clk=0; 
    #500;    
    $finish;   
  end
  
  
  
endmodule
