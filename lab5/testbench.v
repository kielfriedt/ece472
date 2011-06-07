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
      reset = 1'b0;
      #20 assign reset= 1'b1;
      #100 assign reset = 1'b0;
   end
   
   mips_pipeline A1(clk, reset);
   

   //always @(negedge clk)
     // reset = 1'b0;
      
endmodule





/* testbench for testing adders 
module lab5_testbench;

reg clk;
reg reset;

// instantiate an instance of the mips_single module
mips_pipeline the_Mips(clk, reset);

// Generate a clock that changes ever 50 time units (a period of 100)
always
#50 clk = ~clk;
// Initialize signals
initial begin
clk = 1'b0; //initalize clk value to 0 at t=0
reset = 1'b1; // initialize clock value to 0
#100 reset = 1'b0;

end
endmodule
*/