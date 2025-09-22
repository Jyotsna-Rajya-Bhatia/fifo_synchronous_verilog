`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 23:23:32
// Design Name: 
// Module Name: fifo_testbench
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


module fifo_testbench;
parameter depth=8, width=16;
    reg rst;          //gave active low rst
    reg clk;
    reg wr_en;
    reg rd_en;
    reg [width-1:0] din;
    wire [width-1:0] dout;
    wire empty;
    wire full;
    
    fifo #(.depth(depth), .width(width)) dut ( .rst(rst), .clk(clk), .wr_en(wr_en), .rd_en(rd_en), .din(din), .dout(dout), .empty(empty), .full(full));
    
    initial 
    begin
    clk = 1'b0;
    forever #5 clk=~clk;
    end
    
    initial
    begin
    rst = 0;   //active low so it is reseted
    wr_en = 0;
    rd_en = 0;
    din = 0;
    
    #10;
    rst = 1'b1;     //normal operation
    //write
    repeat (2) begin
   @(posedge clk);
   wr_en = 1;
   din = $random;
   @(posedge clk);
   wr_en = 0;
   end
    
   //reading
   repeat (2) begin
   @(posedge clk);
   rd_en = 1;    
   @(posedge clk);
   rd_en = 0;   
   end
    
    //full condition
    
    repeat (depth) begin
    @ (posedge clk);
    wr_en=1;
    din = $random;
    end
    //full flag
    @ (posedge clk);
    wr_en=0;
    
    //empty condition
    repeat (depth) begin
    @ (posedge clk)
    rd_en = 1;     //reading decrements count so we read depth times to make it empty
    end
    
    @ (posedge clk);
    rd_en =0;
    
    end
    
    
endmodule
