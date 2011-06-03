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
 module ALU4_LA(a, b, c_in, c_out, less, sel, out, P, G);
    
    input less;
    input [3:0] a, b;
    input [2:0] sel;
    input c_in;
    
    output [3:0] out;
    output P,G;
    output c_out;
    
    wire [2:0] c;
    wire [3:0] p, g;
       
    alu_slice_LA a1(a[0], b[0], c_in, less, sel, out[0], p[0], g[0]); 
    alu_slice_LA a2(a[1], b[1], c[0], 1'b0, sel, out[1], p[1], g[1]); 
    alu_slice_LA a3(a[2], b[2], c[1], 1'b0, sel, out[2], p[2], g[2]); 
    alu_slice_LA a4(a[3], b[3], c[2], 1'b0, sel, out[3], p[3], g[3]); 
    
    lookahead l1(c_in, c_out, c, p, g, P, G);
    
endmodule