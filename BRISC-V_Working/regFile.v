/** @module : regFile
 *  @author : Adaptive & Secure Computing Systems (ASCS) Laboratory

 *  Copyright (c) 2019 BRISC-V (ASCS/ECE/BU)
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.

 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

// Parameterized register file
module regFile #(
  parameter REG_DATA_WIDTH = 32,
  parameter REG_SEL_BITS = 5
) (
  input clock,
  input reset,
  input wEn,
  input [REG_DATA_WIDTH-1:0] write_data,
  input [REG_SEL_BITS-1:0] read_sel1,
  input [REG_SEL_BITS-1:0] read_sel2,
  input [REG_SEL_BITS-1:0] write_sel,
  output[REG_DATA_WIDTH-1:0] read_data1,
  output[REG_DATA_WIDTH-1:0] read_data2,
  output led
);

(* ram_style = "distributed" *)
reg [REG_DATA_WIDTH-1:0] register_file[0:(1<<REG_SEL_BITS)-1];

reg ledReg;
integer x;
always @(posedge reset) begin
    
    for (x = 0; x < 1<<REG_SEL_BITS; x=x+1) begin : RESET_REGS
        register_file[x] = 32'h0;
    end
end

always @(posedge clock) begin
  if(reset==1)
    register_file[0] <= 0;
  else begin
    if (wEn & write_sel != 0) begin
        register_file[write_sel] <= write_data;
        if (write_sel == 5'b00010 || ledReg == 1'b1) begin
            ledReg <= 1'b1;
        end
    end
  end
end


assign led = ledReg;

//----------------------------------------------------
// Drive the outputs
//----------------------------------------------------
assign  read_data1 = register_file[read_sel1];
assign  read_data2 = register_file[read_sel2];

endmodule
