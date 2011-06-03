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
 module testbench;
    
   reg clk, reset;
   
   always
      #100 clk =~clk;
      
   initial begin
      clk = 1'b0;
      reset = 1'b1;
   end
   
   mips_single A1(clk, reset);
   

   //always @(negedge clk)
     // reset = 1'b0;
      
endmodule

