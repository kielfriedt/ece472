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
 module lookahead(c_in, c_out, c, p, g, P, G);
   input [3:0] p, g;
   input c_in;
   
   output [2:0] c;
   output c_out;
   output P, G;
   
   assign #2 c[0] = g[0] | (p[0] & c_in); 
   assign #3 c[1] = g[1] | (g[0] & p[1]) | (p[1] & p[0] & c_in); 
   assign #4 c[2] = g[2] | (g[1] & p[2]) | (g[0] & p[1] & p[2]) | (p[2] & p[1] & p[0] & c_in); 
   assign #5 c_out = g[3] | (g[2] & p[3]) | (g[1] & p[2] & p[3]) | (g[0] & p[1] & p[2] & p[3]) | (p[3] & p[2] & p[1] & p[0] & c_in);  
   
   assign #4 G = g[3] | (g[2] & p[3]) | (g[1] & p[2] & p[3]) | (p[3] & p[2] & p[1] & g[0]);
   assign #3 P = p[3] & p[2] & p[1] & p[0];
   
endmodule
