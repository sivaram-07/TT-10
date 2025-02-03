`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2025 10:08:53 PM
// Design Name: 
// Module Name: top_with_clock_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// This top module integrates a clock divider and the asynchronous FIFO modules.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tt_um_reemashivva_fifo
#(parameter WIDTH = , 
  parameter DEPTH = 8
)
(
    input wire clk_in,          // Input clock for clock divider
    input wire rst_n,           // Active-low reset
    input wire wr_rq,           // Write request
    input wire rd_rq,           // Read request
    input wire [WIDTH-1:0] wdata, // Write data
    output wire full,           // FIFO full flag
    output wire empty,          // FIFO empty flag
    output wire [WIDTH-1:0] rdata // Read data
);

    // Internal clock signals generated by clock divider
    wire w_clk; // Write clock
    wire r_clk; // Read clock

    // Internal wires for FIFO control and synchronization
    wire [$clog2(DEPTH)-1:0] waddr;    // Write address
    wire [$clog2(DEPTH)-1:0] raddr;    // Read address
    wire [$clog2(DEPTH):0] wptr;       // Write pointer
    wire [$clog2(DEPTH):0] rptr;       // Read pointer
    wire [$clog2(DEPTH):0] wsync_ptr2; // Synchronized read pointer in write clock domain
    wire [$clog2(DEPTH):0] rsync_ptr2; // Synchronized write pointer in read clock domain

    // Instantiate the clock divider
    clock_divider clk_div_inst (
        .clk_in(clk_in),
        .reset(~rst_n),
        .w_clk(w_clk),
        .r_clk(r_clk)
    );

    // Instantiate synchronization and FIFO modules

    sync_r2w #(.DEPTH(DEPTH)) sync_r2w_inst (
        .rptr(rptr),
        .w_clk(w_clk),
        .rst_n(rst_n),
        .wsync_ptr2(wsync_ptr2)
    );

    sync_w2r #(.DEPTH(DEPTH)) sync_w2r_inst (
        .wptr(wptr),
        .r_clk(r_clk),
        .rst_n(rst_n),
        .rsync_ptr2(rsync_ptr2)
    );

    fifo_mem #(.WIDTH(WIDTH), .DEPTH(DEPTH)) fifomem_inst (
        .w_clk(w_clk),
        .r_clk(r_clk),
        .wr_rq(wr_rq),
        .rd_rq(rd_rq),
        .full(full),
        .empty(empty),
        .waddr(waddr),
        .raddr(raddr),
        .wdata(wdata),
        .rdata(rdata)
    );

    full #(.WIDTH(WIDTH), .DEPTH(DEPTH)) full_inst (
        .w_clk(w_clk),
        .rst_n(rst_n),
        .wr_rq(wr_rq),
        .wsync_ptr2(wsync_ptr2),
        .waddr(waddr),
        .wptr(wptr),
        .full(full)
    );

    empty #(.WIDTH(WIDTH), .DEPTH(DEPTH)) empty_inst (
        .r_clk(r_clk),
        .rst_n(rst_n),
        .rd_rq(rd_rq),
        .rsync_ptr2(rsync_ptr2),
        .raddr(raddr),
        .rptr(rptr),
        .empty(empty)
    );

endmodule
