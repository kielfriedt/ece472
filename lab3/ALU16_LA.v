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
 module ALU16_LA(A, B, sel, out);
   input [15:0] A, B;
   input [2:0] sel;
   wire [3:0] p, g;
   
   output [15:0] out;
   
   assign less = 1'b0;
   
   wire [2:0] c;
   wire P_NULL, G_NULL, overflow, c_out;
   wire C_NULL[3:0];
       
    //(a, b, c_in, c_out, less, sel, out, P, G);   
    ALU4_LA a1(A[3:0],   B[3:0],   sel[2], C_NULL[0], overflow, sel, out[3:0], p[0], g[0]); 
    ALU4_LA a2(A[7:4],   B[7:4],   c[0],  C_NULL[1], less,  sel,  out[7:4], p[1], g[1]); 
    ALU4_LA a3(A[11:8],  B[11:8],  c[1],  C_NULL[2], less,  sel,  out[11:8], p[2], g[2]); 
    ALU4_LA a4(A[15:12], B[15:12], c[2],  C_NULL[3], less,  sel,  out[15:12], p[3], g[3]); 
  
    lookahead l1(sel[2], c_out, c, p, g, P_NULL, G_NULL);
    
    assign overflow =~ out[15] ^ c_out;

endmodule