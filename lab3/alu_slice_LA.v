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
module alu_slice_LA(a, b, c, less, sel, out, p, g);    
	
	input a, b, c, less; 
	input [2:0] sel;

	output out;
	output p, g;
	wire sum, cout, ANDresult,less, ORresult, b_inv, p, g;

	reg out;

	assign  b_inv = sel[2] ^ b;
	assign  ANDresult = a & b;
	assign  ORresult = a | b;
   
	fulladder_LA f1(a, b_inv, c, sum, p, g);

	always @(a or b or c or less or sel)
	   begin
		   case(sel[1:0])
			   2'b00: out = ANDresult;
            2'b01: out = ORresult;
            2'b10: out = sum;
            2'b11: out = less;
		   endcase
	   end
   
endmodule

