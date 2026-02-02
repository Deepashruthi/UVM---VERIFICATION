//Interface
interface mem_if;
  logic clk;
  logic wr;
  logic [7:0] d_in;
  logic [7:0] d_out;
  logic [3:0] addr;
endinterface
