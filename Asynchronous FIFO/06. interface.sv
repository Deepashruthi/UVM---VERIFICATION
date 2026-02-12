//Interface
interface fifo_if #(parameter Width = 8) (input wclk, input rclk); 
  //logic wclk;
  //logic rclk;
  logic wrst_n;
  logic rrst_n;
  logic r_en;
  logic w_en;
  logic [Width-1:0] data_in;
  logic [Width-1:0] data_out;
  logic full;
  logic empty;
  
  //Clocking Block for write
  clocking wcb @(posedge wclk);
    output w_en, data_in;
    input full;
  endclocking 
  
  //Clocking Block for read 
  clocking rcb @(posedge rclk);
    output r_en;
    input data_out, empty;
  endclocking
endinterface
