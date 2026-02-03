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

module top;
  inter inf();
  half_adder dut(.a(inf.a), .b(inf.b), .sum(inf.sum), .carry(inf.carry));
  
  initial begin
    uvm_config_db #(virtual inter) :: set( null, "*", "vif" , inf);
    run_test ("my_test");
  end
  
  initial begin
    $dumpfile("my_uvm.vcd");
    $dumpvars;
    #200;
    $finish;
  end
endmodule
