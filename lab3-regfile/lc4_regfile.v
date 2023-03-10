/* TODO: name and PennKeys of all group members here
 * Ali Alaoui - alaoui, Robert Zhang - 
 * lc4_regfile.v
 * Implements an 8-register register file parameterized on word size.
 *
 */

`timescale 1ns / 1ps

// Prevent implicit wire declaration
`default_nettype none

module lc4_regfile #(parameter n = 16)
   (input  wire         clk,
    input  wire         gwe,
    input  wire         rst,
    input  wire [  2:0] i_rs,      // rs selector
    output wire [n-1:0] o_rs_data, // rs contents
    input  wire [  2:0] i_rt,      // rt selector
    output wire [n-1:0] o_rt_data, // rt contents
    input  wire [  2:0] i_rd,      // rd selector
    input  wire [n-1:0] i_wdata,   // data to write
    input  wire         i_rd_we    // write enable
    );

   /***********************
    * TODO YOUR CODE HERE *
    ***********************/
    wire [n-1:0] r0v, r1v, r2v, r3v, r4v, r5v, r6v, r7v;

    Nbit_reg #(n) r0 (.in(i_wdata), .out(r0v), .clk(clk), .we(i_rd == 3'd0 & i_rd_we), .gwe(gwe), .rst(rst));
    Nbit_reg #(n) r1 (.in(i_wdata), .out(r1v), .clk(clk), .we(i_rd == 3'd1 & i_rd_we), .gwe(gwe), .rst(rst));
    Nbit_reg #(n) r2 (.in(i_wdata), .out(r2v), .clk(clk), .we(i_rd == 3'd2 & i_rd_we), .gwe(gwe), .rst(rst));
    Nbit_reg #(n) r3 (.in(i_wdata), .out(r3v), .clk(clk), .we(i_rd == 3'd3 & i_rd_we), .gwe(gwe), .rst(rst));
    Nbit_reg #(n) r4 (.in(i_wdata), .out(r4v), .clk(clk), .we(i_rd == 3'd4 & i_rd_we), .gwe(gwe), .rst(rst));
    Nbit_reg #(n) r5 (.in(i_wdata), .out(r5v), .clk(clk), .we(i_rd == 3'd5 & i_rd_we), .gwe(gwe), .rst(rst));
    Nbit_reg #(n) r6 (.in(i_wdata), .out(r6v), .clk(clk), .we(i_rd == 3'd6 & i_rd_we), .gwe(gwe), .rst(rst));
    Nbit_reg #(n) r7 (.in(i_wdata), .out(r7v), .clk(clk), .we(i_rd == 3'd7 & i_rd_we), .gwe(gwe), .rst(rst));

    Nbit_mux8to1 #(n) mux1 (.S(i_rs), .r0(r0v), .r1(r1v), .r2(r2v), .r3(r3v), .r4(r4v), .r5(r5v), .r6(r6v), .r7(r7v), .Out(o_rs_data));
    Nbit_mux8to1 #(n) mux2 (.S(i_rt), .r0(r0v), .r1(r1v), .r2(r2v), .r3(r3v), .r4(r4v), .r5(r5v), .r6(r6v), .r7(r7v), .Out(o_rt_data));

endmodule

module Nbit_mux8to1 #(parameter n=16)
    (input wire [2:0] S,
    input wire [n-1:0] r0,
    input wire [n-1:0] r1,
    input wire [n-1:0] r2,
    input wire [n-1:0] r3,
    input wire [n-1:0] r4,
    input wire [n-1:0] r5,
    input wire [n-1:0] r6,
    input wire [n-1:0] r7,
    output wire [n-1:0] Out
    );

    assign Out = (S == 3'b000) ? r0 :
                 (S == 3'b001) ? r1 :
                 (S == 3'b010) ? r2 :
                 (S == 3'b011) ? r3 :
                 (S == 3'b100) ? r4 :
                 (S == 3'b101) ? r5 :
                 (S == 3'b110) ? r6 : r7;
endmodule       