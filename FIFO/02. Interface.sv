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
  
  //Drives Dut 
  clocking driv_cb @(posedge clk);
    // output default to #1 step after clk edge 
    output wr_en;
    output rd_en;
    output d_in;
  endclocking
  
  // Sample from dut
  clocking mon_cb @(posedge clk);
    // input default to #0 step
    input rst;
    input wr_en;
    input rd_en;
    input d_in;
    input d_out;
    input empty;
    input full;
  endclocking
endinterface
