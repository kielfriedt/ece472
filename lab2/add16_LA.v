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
 module add16_LA(a, b, c_in, sum, c_out, P, G); 
 input [15:0] a, b;
 input c_in;
 
 output [15:0] sum;
 output c_out;
 output P, G;
 
 wire [2:0] c;
 wire [3:0] p, g;
 wire [3:0] c_null;
 
 add4_LA A1(a[3:0], b[3:0], c_in, sum[3:0], c_null[0], p[0], g[0]); 
 add4_LA A2(a[7:4], b[7:4], c[0], sum[7:4], c_null[1], p[1], g[1]);
 add4_LA A3(a[11:8], b[11:8], c[1], sum[11:8], c_null[2], p[2], g[2]);
 add4_LA A4(a[15:12], b[15:12], c[2], sum[15:12], c_null[3], p[3], g[3]);
  
 lookahead l1(c_in, c_out, c, p, g, P, G);
endmodule
