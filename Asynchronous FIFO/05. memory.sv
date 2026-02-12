// Memory
module fifo_mem #(parameter Depth = 8, Width = 8, Ptr_Width = 3)
  (input logic wclk, w_en, rclk, r_en,
   input logic [Ptr_Width:0] b_wptr, b_rptr,
   input logic [Width-1:0] data_in,
   input logic full, empty,
   output logic [Width-1:0] data_out);
  
  logic [Width-1:0] fifo [Depth];
  
  always_ff @(posedge wclk) begin
    if(w_en && !full) begin
      fifo[b_wptr] <= data_in;
    end
  end
  
  always_ff @(posedge rclk) begin
    if(r_en && !empty) begin
      data_out <= fifo[b_rptr];
    end
  end
  
endmodule
