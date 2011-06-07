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
 module HazardDetect(clk, reset, EX_MemRead, EX_Rt, EX_Rs, ID_Rt, ID_Rs, MuxCtl, PCWrite); 
    input EX_MemRead, clk, reset; 
    input [4:0] EX_Rt, ID_Rt, ID_Rs, EX_Rs; 
    output MuxCtl, PCWrite; 
    
    reg MuxCtl, PCWrite; 
    
    //set wires and registers 
    always @(clk or EX_Rs or EX_Rt or ID_Rs or ID_Rt )
    begin 
      if(((EX_Rt == ID_Rt) && (EX_Rt != 0)) || ((EX_Rs == ID_Rs) && (EX_Rs != 0)))
      begin 
        assign MuxCtl = 1; 
        assign PCWrite = 1;       
      end 
      else 
      begin 
        assign MuxCtl = 0; 
        assign PCWrite = 0; 
      end 
    end 
    
    initial begin 
    assign MuxCtl = 0; 
    assign PCWrite = 0; 
    end 
    
endmodule 