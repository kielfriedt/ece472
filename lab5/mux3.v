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
module mux3( sel, a, b, c, y );
    input [1:0] sel;
    input  [31:0] a, b, c;
    output  y;
    
    reg [31:0] y;

 	always @(a or b or c or sel) 
 	begin
     case (sel)
    	2'b00:y = a;
    	2'b10:y = b;
    	2'b01:y = c;
	  endcase 
   end
endmodule