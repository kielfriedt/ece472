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
 module proj2_testbench_3;

   wire [15:0] sum;
   wire [3:0] cout;
   wire P, G;
   reg [15:0] A, B;
   reg clk;
  
   add4_LA A1(A[3:0], B[3:0], 1'b0, sum[3:0], cout[0], P, G); 
   add4_LA A2(A[7:4], B[7:4], cout[0], sum[7:4], cout[1], P, G);
   add4_LA A3(A[11:8], B[11:8], cout[1], sum[11:8], cout[2], P, G);
   add4_LA A4(A[15:12], B[15:12], cout[2], sum[15:12], cout[3], P, G);
   
   always
   #5 clk =~clk;

   initial begin
      clk = 1'b0;
      A = 4'h0;
      B = 4'h1;
   end

   always @(posedge clk)
   A=A+1;

endmodule

