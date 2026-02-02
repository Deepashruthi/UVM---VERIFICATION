// Design 
module sram(
  input logic clk,
  input logic wr,
  input logic [7:0] d_in,
  input logic [3:0] addr,
  output logic [7:0] d_out);
  
  logic [7:0] mem [15:0];
  
  always @(posedge clk) begin
    if (wr)
      mem[addr] <= d_in;
    else
      d_out <= mem[addr];
  end
endmodule
