`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 17:02:08
// Design Name: 
// Module Name: fifo
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


module fifo#(parameter depth=8, width=16)  //depth is no of data entries, width is the size(bits) of each entry
(
    input rst,
    input clk,
    input wr_en,
    input rd_en,
    input [width-1:0] din,
    output reg [width-1:0] dout,
    output empty,
    output full
    );
     reg [$clog2(depth)-1:0] wptr,rptr;   //log2(8)=3 and 3-1=2 so 2:0, 3 bits
     reg [width-1:0] fifo [depth-1:0];  //2d array named fifo with depth no of elements each width long
     reg [$clog2(depth+1)-1:0] count;   //+1 so that we include depth (last one) too,,to chek for full case
     
     always @ (posedge clk)
     begin
     if (~rst)
     begin
     wptr <= 0;
     rptr <=0;
     count <= 0;
     end
     else 
     begin
     if (wr_en&&~full)
     begin
     fifo [wptr] <= din;
     wptr <= (wptr==depth-1) ? 0: wptr+1;
     count <= count+1;
     end
     if (rd_en&&~empty)
     begin
     dout <= fifo[rptr];
     rptr <= (rptr==depth-1) ? 0: rptr+1;
     count <= count-1;
     end
     end
     end
     
     //Stats flags
     assign empty = (count==0);
     assign full = (count==depth);
   
     
endmodule
