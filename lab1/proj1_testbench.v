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
 module proj1_testbench;
   //Inputs: Regs
   //Out: Wires
   reg A;
   reg B;
   wire out;
   reg select;

   reg clk;

   toplevel DUT(A, B, select, out, clk);

	always
	#5 clk=~clk;

   initial begin
      select = 1'b0; 
      clk = 1'b0;
      A = 1'b0;
      B = 1'b0;
   end
   
   always @(posedge clk)
   begin
       if (select) select <= 0;
       else select <= 1;
   end

endmodule	

