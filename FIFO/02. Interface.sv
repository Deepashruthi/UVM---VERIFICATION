//Interface
interface intf #(parameter Width=8);
  logic clk;
  logic rst;
  logic wr_en;
  logic rd_en;
  logic [Width-1 : 0] d_in;
  
  logic [Width-1 : 0] d_out;
  logic full;
  logic empty;
  
endinterface
