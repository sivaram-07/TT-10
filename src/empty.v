`include "timescale.vh"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2025 09:38:09 PM
// Design Name: 
// Module Name: empty
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


module empty
#(
    parameter WIDTH = 4,   
    parameter DEPTH = 8  
)
(
    input wire r_clk,             
    input wire rst_n,              
    input wire rd_rq,              
    input wire [$clog2(DEPTH):0] rsync_ptr2, 
    output reg [$clog2(DEPTH)-1:0] raddr,    
    output reg [$clog2(DEPTH):0] rptr,       
    output reg empty                          
);

    
    reg [$clog2(DEPTH):0] bin, binnext, graynext;
    reg emptyn;

    
    always @(posedge r_clk or negedge rst_n) begin
        if (~rst_n) begin
            rptr <= 'd0;       
            bin <= 'd0;        
            empty <= 1;       
        end else begin
            rptr <= graynext;  
            bin <= binnext;    
            empty <= emptyn;   
        end
    end

    
    always @(*) begin
        
        raddr = bin[$clog2(DEPTH)-1:0];

        
        binnext = bin + (~empty & rd_rq);

        
        graynext = (binnext >> 1) ^ binnext;

        
        emptyn = (graynext == rsync_ptr2);
    end

endmodule
