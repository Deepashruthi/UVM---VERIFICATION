// Design 
module counter(
  input logic clk,
  input logic rst,
  input logic en,  // enable for upcount
  output logic [3:0]count);
  
  always_ff @ (posedge clk or posedge rst) begin
    if(rst)
      count <= '0;
    else if(en)
      count <= count+1;
    else 
      count <= count;
  end
endmodule
