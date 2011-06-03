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
 module ALU16(A, B, sel, out);
		input [15:0] A, B;
		input [2:0] sel;
		output [15:0] out;
		assign less = 1'b0;;
		//Still need to account for less
		wire [15:0] c;
		wire set;
       
       alu_slice a1(A[0], B[0], sel[2], set, sel, c[0], out[0]); 
       alu_slice a2(A[1], B[1], c[0], less, sel, c[1], out[1]); 
       alu_slice a3(A[2], B[2], c[1], less, sel, c[2], out[2]); 
       alu_slice a4(A[3], B[3], c[2], less, sel, c[3], out[3]); 
       alu_slice a5(A[4], B[4], c[3], less, sel, c[4], out[4]); 
       alu_slice a6(A[5], B[5], c[4], less, sel, c[5], out[5]); 
       alu_slice a7(A[6], B[6], c[5], less, sel, c[6], out[6]); 
       alu_slice a8(A[7], B[7], c[6], less, sel, c[7], out[7]); 
       alu_slice a9(A[8], B[8], c[7], less, sel, c[8], out[8]); 
       alu_slice a10(A[9], B[9], c[8], less, sel, c[9], out[9]); 
       alu_slice a11(A[10], B[10], c[9], less, sel, c[10], out[10]); 
       alu_slice a12(A[11], B[11], c[10], less, sel,  c[11], out[11]); 
       alu_slice a13(A[12], B[12], c[11], less, sel,  c[12], out[12]); 
       alu_slice a14(A[13], B[13], c[12], less, sel,  c[13], out[13]); 
       alu_slice a15(A[14], B[14], c[13], less, sel,  c[14], out[14]); 
       alu_slice_msb a16(A[15], B[15], c[14], less, sel,  c[15], out[15],set); 
endmodule
