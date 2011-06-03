/*
 *	Copyright (C) 2011  Kiel Friedt
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
 //authors Kiel Friedt, Kevin McIntosh,Cody DeHaan
 // 000 AND
   // 001 OR
   // 010 ADD
   // 110 Sub
   // 111 Less than
module proj3_testbench;

   reg [2:0] opcode;
   reg [15:0] A, B;
   reg clk;
   wire [15:0] out, out2;
   
   ALU16 A1(A,B,opcode,out);
   ALU16_LA A2(A, B, opcode, out2);
   
   always
      #15 clk =~clk;

   initial begin
      clk = 1'b0;
      A = 4'h0001;
      B = 4'h0003;
      opcode = 3'b000;
   end
  
   always @(posedge clk)
   A=A+1;

endmodule

