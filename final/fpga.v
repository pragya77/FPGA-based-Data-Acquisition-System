module fpga(SCK,MISO,MOSI,SS1);

output reg SCK;
output reg SS1;
output reg MOSI;
reg [11:0]data;

input MISO;

//reg [9:0] voltage [0:4];
//reg [9:0] power [0:4];
reg [2:0] d=001;
integer s=1;
reg [9:0]memory1;
reg [7:0]count1=0;
integer i=9;
//integer j=4;
//reg [9:0] p;
initial begin
SS1=0;

//voltage[0]=10'd45;
//voltage[1]=10'd50;
//voltage[2]=10'd75;h
//voltage[3]=10'd75;
//voltage[4]=10'd56;
//power[0]=10'd45;
//power[1]=10'd50;
//power[2]=10'd75;
//power[3]=10'd75;
//power[4]=10'd20;
end

always@(negedge SCK)
begin
if(s==1)begin
if(d==000)begin
data=12'b000000011000;
end
else if(d==001)begin
data=12'b000000011001;
end
else if(d==010)begin
data=12'b000000011010;
end

else if(d==011)begin
data=12'b000000011011;
end
else if(d==100)begin
data=12'b000000011100;
end
else if(d==101)begin
data=12'b000000011101;
end
else if(d==110)begin
data=12'b000000011110;
end
else if(d==111)begin
data=12'b000000011111;
end


s=0;
end
MOSI = data[11];
data = data<<1;
if(count1>=13)begin
MOSI=1'bx;
end
end

always@(posedge SCK)begin
  if(count1>13 && count1<24 && i>-1)begin
  memory1[i]<=MISO;// data to be compared with table 
  i<=i-1;
  end
  count1<=count1+1;
  if(count1==24)begin
   SS1<=1;
  end
end

endmodule




