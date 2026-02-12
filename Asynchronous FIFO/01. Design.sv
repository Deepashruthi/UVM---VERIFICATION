// Design
`include "synchronizer.sv"
`include "write_pointer_handler.sv"
`include "read_pointer_handler.sv"
`include "memory.sv"

module async_fifo #(parameter Depth=8, Width=8)
  ( input logic wclk, wrst_n, rclk, rrst_n, w_en, r_en,
   input logic [Width-1:0] data_in,
   output logic [Width-1:0] data_out,
   output logic full, empty);
  
  parameter Ptr_Width = $clog2(Depth);
  
  logic [Ptr_Width:0] g_wptr_sync, g_rptr_sync;
  logic [Ptr_Width:0] g_wptr, g_rptr;
  logic [Ptr_Width:0] b_wptr, b_rptr;
  
  //logic [Ptr_Width-1:0] waddr, raddr;
  
  synchronizer #(Ptr_Width) sync_wptr (rclk, rrst_n, g_wptr, g_wptr_sync);
  synchronizer #(Ptr_Width) sync_rptr (wclk, wrst_n, g_rptr, g_rptr_sync);
  
  wptr_handler #(Ptr_Width) wptr_h (wclk, wrst_n, w_en,g_rptr_sync, b_wptr, g_wptr, full);
  rptr_handler #(Ptr_Width) rptr_h (rclk, rrst_n, r_en, g_wptr_sync, b_rptr, g_rptr, empty);
  fifo_mem #(Depth, Width) fifo_m (wclk, w_en, rclk, r_en,  b_wptr, b_rptr, data_in,  full, empty, data_out);
  
endmodule
  
  
