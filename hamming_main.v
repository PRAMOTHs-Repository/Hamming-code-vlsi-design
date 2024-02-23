module hamming_main(mess,rst,out,clk);

input [7:0]mess;
output [11:0]out;
input clk,rst;

reg [4:0]r1;//positions for parity bit 1
reg [4:0]r2;//positions for parity bit 2

reg [3:0]r3;//positions for parity bit 3
reg [3:0]r4;//positions for parity bit 4

//p1
parity_gen5 u1(r1,clk,rst,out[0],);

//p2
parity_gen5 u2(r2,clk,rst,out[1]);

//p3
parity_gen4 u3(r3,clk,rst,out[3]);

//p4
parity_gen4 u4(r4,clk,rst,out[7]);

//transmitted output
  assign out[2]=mess[0];
  assign out[4]=mess[1];
  assign out[5]=mess[2];
  assign out[6]=mess[3];
  assign out[8]=mess[4];
  assign out[9]=mess[5];
  assign out[10]=mess[6];
  assign out[11]=mess[7];
 

always@(posedge clk)
begin
if(rst)
begin
 r1[0]<=mess[0];
 r1[1]<=mess[1];
 r1[2]<=mess[3];
 r1[3]<=mess[4];
 r1[4]<=mess[6];

//r2
 r2[0]<=mess[0];
 r2[1]<=mess[2];
 r2[2]<=mess[3];
 r2[3]<=mess[5];
 r2[4]<=mess[6];

//r3
 r3[0]<=mess[1];
 r3[1]<=mess[2];
 r3[2]<=mess[3];
 r3[3]<=mess[7];
 
 //r4
 r4[0]<=mess[4];
 r4[1]<=mess[5];
 r4[2]<=mess[6];
 r4[3]<=mess[7];
end
else
begin
r1<=4'b0000;
r2<=4'b0000;
r3<=4'b0000;
r4<=4'b0000;
end
end
endmodule

//parity_gen4
module parity_gen4(a,clk,rst,out);
input [3:0]a;
input clk,rst;
output reg out;
reg w1,w2;
always @(posedge clk)
begin
if(rst)
begin
w1<=a[0]^a[1];
w2<=a[2]^a[3];
out<=w1^w2;
end

else 
begin
w1<=0;
w2<=0;
out<=0;
end
end
endmodule


//parity_gen5
module parity_gen5(a,clk,rst,out);
input [4:0]a;
input clk,rst;
output reg out;
reg w1,w2,w3;
always @(posedge clk)
begin
if(rst)
begin
w1<=a[0]^a[1];
w2<=a[2]^a[3];
w3<=w1^w2;
out<=w3^a[4];
end
else 
begin
w1<=0;
w2<=0;
w3<=0;
out<=0;
end
end
endmodule

