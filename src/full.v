`include "timescale.vh"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2025 09:42:20 PM
// Design Name: 
// Module Name: full
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module full
#(parameter WIDTH = 4,
  parameter DEPTH = 8)
(
  input wire w_clk,
  input wire rst_n,
  input wire wr_rq,
  input wire [$clog2(DEPTH):0] wsync_ptr2,
  output reg [$clog2(DEPTH)-1:0] waddr,
  output reg [$clog2(DEPTH):0] wptr,
  output reg full
);

  reg [$clog2(DEPTH):0] bin, binnext, graynext;
  reg fulln;


  always @(posedge w_clk or negedge rst_n) begin
    if (!rst_n) begin
      wptr <= 'd0;
      bin <= 'd0;
      full <= 0;
    end else begin
      wptr <= graynext; 
      bin <= binnext;  
      full <= fulln;    
    end
  end


  always @(*) begin
   
    waddr = bin[$clog2(DEPTH)-1:0];


    binnext = bin + (~full & wr_rq);


    graynext = (binnext >> 1) ^ binnext;


    fulln = (graynext == {~wsync_ptr2[$clog2(DEPTH):$clog2(DEPTH)-1], wsync_ptr2[$clog2(DEPTH)-2:0]});
  end

endmodule
