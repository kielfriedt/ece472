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
 module ForwardUnit(EX_RS, EX_RT, MEM_RD, WB_RD, MEM_WB, WB_WB, Forward_A, Forward_B);
    input MEM_WB, WB_WB;
    input [4:0] EX_RS, EX_RT, MEM_RD, WB_RD;
    
    output [1:0] Forward_A, Forward_B;
    reg [1:0] Forward_A, Forward_B;
    
    always @(EX_RS or EX_RT)
    begin
       //Forward A Register
       if (WB_WB && WB_RD && MEM_RD != WB_RD && WB_RD == EX_RS)
       begin
            assign Forward_A = 2'b01;
       end
       else if (MEM_WB && MEM_RD && MEM_RD == EX_RS)
       begin
            assign Forward_A = 2'b10;
       end
       else
       begin
           assign Forward_A = 2'b00;
       end
       
       //Forward B Register
       if (WB_WB && WB_RD && MEM_RD != WB_RD && WB_RD == EX_RT)
       begin
           assign Forward_B = 2'b01;
       end
       else if (MEM_WB  && MEM_RD  && MEM_RD == EX_RT)
       begin
            assign Forward_B = 2'b10;
       end
       else
       begin
           assign Forward_B = 2'b00;
       end
    end
    
    //initial begin 
      // assign Forward_A = 2'b00; 
       //assign Forward_B = 2'b00; 
    //end 
    
endmodule