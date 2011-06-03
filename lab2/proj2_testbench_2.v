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
 module proj2_testbench_2;

   reg clk;
   wire [15:0] sum1, sum2;
   reg [15:0] A, B;
   wire cout1;
   wire cout2;
   wire P, G;
  
   add16_LA A1(A, B, 1'b0, sum1, cout1, P, G); 
   
   ripple_adder DUT1(A[7:0],B[7:0], 1'b0, sum2[7:0], add1_to_add2);
   ripple_adder DUT2(A[15:8],B[15:8], add1_to_add2, sum2[15:8], cout2);

   always
   #10 clk =~clk;

   initial begin
      clk = 1'b0;
      A = 16'h1;
      B = 16'h1;
   end

   always @(posedge clk)
   A=A+1;

endmodule
