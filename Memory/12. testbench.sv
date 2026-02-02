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
  
  mem_if vif();
  
  sram dut(.clk(vif.clk),
           .wr(vif.wr),
           .d_in(vif.d_in),
           .addr(vif.addr),
           .d_out(vif.d_out)
        );
  
  initial begin    
    uvm_config_db#(virtual mem_if)::set(null,"*","vif",vif);   
    run_test ("my_test");
  end
  
  always #5 vif.clk=~vif.clk;
  
  initial begin    
    $dumpfile("my_uvm.vcd");
    $dumpvars;
    vif.clk=0; 
    #400;    
    $finish;   
  end
  
endmodule
