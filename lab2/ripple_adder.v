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
 module ripple_adder(a,b,c_in, sum, cout);
   input [7:0] a,b;
   input c_in;
   output [7:0] sum;
   output cout;

   wire [7:0] c;
   fulladder  f0(a[0], b[0], c_in, sum[0], c[1]);
   fulladder  f1(a[1], b[1], c[1], sum[1], c[2]);
   fulladder  f2(a[2], b[2], c[2], sum[2], c[3]);
   fulladder  f3(a[3], b[3], c[3], sum[3], c[4]);
   fulladder  f4(a[4], b[4], c[4], sum[4], c[5]);
   fulladder  f5(a[5], b[5], c[5], sum[5], c[6]);
   fulladder  f6(a[6], b[6], c[6], sum[6], c[7]);
   fulladder  f7(a[7], b[7], c[7], sum[7], cout);

endmodule
