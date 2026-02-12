// Read pointer Handler
module rptr_handler #(parameter Ptr_Width = 3) 
  ( input logic rclk, rrst_n, r_en, 
   input logic [Ptr_Width:0] g_wptr_sync,
   output logic [Ptr_Width:0] b_rptr, g_rptr,
   output logic empty);
  
  logic [Ptr_Width:0] b_rptr_next;
  logic [Ptr_Width:0] g_rptr_next;
  
  logic rempty;
  
  assign b_rptr_next = b_rptr +(r_en && !empty);
  assign g_rptr_next = (b_rptr_next>>1)^b_rptr_next;
  
  always_ff @(posedge rclk or negedge rrst_n) begin
    if(!rrst_n) begin
      b_rptr <= 0;
      g_rptr <= 0;
      empty <= 1;
    end
    else begin
      b_rptr <= b_rptr_next;
      g_rptr <= g_rptr_next;
      empty <= rempty;
    end
  end
  
  assign rempty = (g_wptr_sync == g_rptr_next);
endmodule
