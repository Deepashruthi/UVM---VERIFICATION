//Synchronizer
module synchronizer #(parameter Width = 3)
  ( input logic clk, rst_n, [Width:0] d_in,
   output logic [Width:0] d_out);
  
  logic [Width:0] q1;
  
  always_ff @ (posedge clk) begin
    if(!rst_n) begin
      q1 <= 0;
      d_out <= 0;
    end
    else begin
      q1 <= d_in;
      d_out <= q1;
    end
  end
endmodule
