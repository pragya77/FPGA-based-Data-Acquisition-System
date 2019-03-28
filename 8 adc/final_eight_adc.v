module final_eight_adc(
	input clk,
	output TxD,
	output TxD_busy,
	
	output SCK,    //1 adc
	output reg SS1=0,
    output reg MOSI,
    input MISO,
    
	output SCK1,//2 adc
	output reg SS2=0,
    output reg MOSI1,
    input MISO1,
    
   	output SCK2,//3 adc
	output reg SS3=0,
    output reg MOSI2,
    input MISO2, 
    
    	output SCK3,//4 adc
	output reg SS4=0,
    output reg MOSI3,
    input MISO3,
    
    	output SCK4,//5 adc
	output reg SS5=0,
    output reg MOSI4,
    input MISO4,
    
    	output SCK5,//6 adc
	output reg SS6=0,
    output reg MOSI5,
    input MISO5,
    
    	output SCK6,//7 adc
	output reg SS7=0,
    output reg MOSI6,
    input MISO6,
    
    	output SCK7,//8 adc
	output reg SS8=0,
    output reg MOSI7,
    input MISO7
    
);
reg TxD_start;
reg [11:0]data;
reg [11:0]data1;
reg [11:0]data2;
reg [11:0]data3;
reg [11:0]data4;
reg [11:0]data5;
reg [11:0]data6;
reg [11:0]data7;
reg [2:0] m;
integer g=0;
integer txcounter1=0;
integer txcounter=0;
integer txcounter2=0;
reg [27:0] counter=0;
reg [9:0] code [0:4];
reg [9:0] voltage [0:4];
reg [9:0] power [0:4];
reg [2:0] d=001;
integer s=1;
reg [9:0]p;
reg [7:0] TxD_data;
reg [7:0]count1=0;
integer i=9;
integer k=9;
integer j=4;
reg [19:0]count2;
reg [1:0]count4=0;
reg [9:0] memory1;
reg [9:0] memory2;
reg [9:0] memory3;
reg [9:0] memory4;
reg [9:0] memory5;
reg [9:0] memory6;
reg [9:0] memory7;
reg [9:0] memory8;
integer x=0;
reg [9:0] store1 [0:4];
reg [9:0] store2 [0:4];
reg [9:0] store3 [0:4];
reg [9:0] store4 [0:4];
reg [9:0] store5 [0:4];
reg [9:0] store6 [0:4];
reg [9:0] store7 [0:4];
reg [9:0] store8 [0:4];
// Assert TxD_start for (at least) one clock cycle to start transmission of TxD_data
// TxD_data is latched so that it doesn't have to stay valid while it is being sent

//reg [7:0] TxD_data;
//reg [3:0] count;
integer z=1;
integer y=1;
integer kk=0;

parameter ClkFrequency = 25000000;	// 25MHz
parameter Baud = 115200;

generate
	if(ClkFrequency<Baud*8 && (ClkFrequency % Baud!=0)) ASSERTION_ERROR PARAMETER_OUT_OF_RANGE("Frequency incompatible with requested Baud rate");
endgenerate

////////////////////////////////
`ifdef SIMULATION
wire BitTick = 1'b1;  // output one bit per clock cycle
`else
wire BitTick;
BaudTickGen #(ClkFrequency, Baud) tickgen(.clk(clk), .enable(TxD_busy), .tick(BitTick));
`endif

reg [3:0] TxD_state = 0;
wire TxD_ready = (TxD_state==0);
assign TxD_busy = ~TxD_ready;

reg [7:0] TxD_shift = 0;

/*always @(posedge clk & count==0)
begin
	TxD_data<=8'b01010101;
	count<=4'd10;
end*/
initial begin
SS1=0;
SS2=0;
SS3=0;
SS4=0;
SS5=0;
SS6=0;
SS7=0;
SS8=0;
m=0;
count2=0;
TxD_start=1;
//voltage[0]=10'd5;
//voltage[1]=10'd4;
//voltage[2]=10'd3;
//voltage[3]=10'd2;
//voltage[4]=10'd1;
//code[0]=10'b1111111111;
//code[1]=10'b1100110011;
//code[2]=10'b1001100110;
//code[3]=10'b0110011001;
//code[4]=10'b0011001100;
//power[0]=10'd45;
//power[1]=10'd50;
//power[2]=10'd75;
//power[3]=10'd80;
//power[4]=10'd20;
end

always @(posedge clk)begin
m<=m+1;
end
assign SCK=m[2];
assign SCK1=m[2];
assign SCK2=m[2];
assign SCK3=m[2];
assign SCK4=m[2];
assign SCK5=m[2];
assign SCK6=m[2];
assign SCK7=m[2];

always@(negedge SCK)
begin
if(s==1)begin
if(d==000)begin
data=12'b000000011000;
data1=12'b000000011000;
data2=12'b000000011000;
data3=12'b000000011000;
data4=12'b000000011000;
data5=12'b000000011000;
data6=12'b000000011000;
data7=12'b000000011000;
end
else if(d==001)begin
data=12'b000000011001;
data1=12'b000000011001;
data2=12'b000000011001;
data3=12'b000000011001;
data4=12'b000000011001;
data5=12'b000000011001;
data6=12'b000000011001;
data7=12'b000000011001;
end
else if(d==010)begin
data=12'b000000011010;
data1=12'b000000011010;
data2=12'b000000011010;
data3=12'b000000011010;
data4=12'b000000011010;
data5=12'b000000011010;
data6=12'b000000011010;
data7=12'b000000011010;
end

else if(d==011)begin
data=12'b000000011011;
data1=12'b000000011011;
data2=12'b000000011011;
data3=12'b000000011011;
data4=12'b000000011011;
data5=12'b000000011011;
data6=12'b000000011011;
data7=12'b000000011011;
end
else if(d==100)begin
data=12'b000000011100;
data1=12'b000000011100;
data2=12'b000000011100;
data3=12'b000000011100;
data4=12'b000000011100;
data5=12'b000000011100;
data6=12'b000000011100;
data7=12'b000000011100;
end
else if(d==101)begin
data=12'b000000011101;
data1=12'b000000011101;
data2=12'b000000011101;
data3=12'b000000011101;
data4=12'b000000011101;
data5=12'b000000011101;
data6=12'b000000011101;
data7=12'b000000011101;
end
else if(d==110)begin
data=12'b000000011110;
data1=12'b000000011110;
data2=12'b000000011110;
data3=12'b000000011110;
data4=12'b000000011110;
data5=12'b000000011110;
data6=12'b000000011110;
data7=12'b000000011110;
end
else if(d==111)begin
data=12'b000000011111;
data1=12'b000000011111;
data2=12'b000000011111;
data3=12'b000000011111;
data4=12'b000000011111;
data5=12'b000000011111;
data6=12'b000000011111;
data7=12'b000000011111;
end

s=0;

end
MOSI = data[11];
MOSI1=data1[11];
MOSI2=data1[11];
MOSI3=data1[11];
MOSI4=data1[11];
MOSI5=data1[11];
MOSI6=data1[11];
MOSI7=data1[11];
data = data<<1;
data1 = data1<<1;
data2 = data1<<1;
data3 = data1<<1;
data4 = data1<<1;
data5 = data1<<1;
data6 = data1<<1;
data7 = data1<<1;
if(count1>=13)begin
MOSI=1'bx;
MOSI1=1'bx;
MOSI2=1'bx;
MOSI3=1'bx;
MOSI4=1'bx;
MOSI5=1'bx;
MOSI6=1'bx;
MOSI7=1'bx;

end
txcounter1<=txcounter1+1;
if(txcounter1==33750)begin//10ms(337500/100)

s<=1;
txcounter1<=0;
end
end

always@(posedge SCK)begin
  if(count1>14 && count1<25 && i>-1)begin
 memory1[i]<=MISO;// data to be compared with table 
 memory2[i]<=MISO1;
  memory3[i]<=MISO2;
   memory4[i]<=MISO3;
    memory5[i]<=MISO4;
     memory6[i]<=MISO5;
      memory7[i]<=MISO6;
       memory8[i]<=MISO7;
  i<=i-1;
  end
  count1<=count1+1;
  if(count1==25)begin
   SS1<=1;
   SS2<=1;
   SS3<=1;
   SS4<=1;
   SS5<=1;
   SS6<=1;
   SS7<=1;
   SS8<=1;
 store1[x]=memory1;
 store2[x]=memory2;
 store3[x]=memory3;
 store4[x]=memory4;
 store5[x]=memory5;
 store6[x]=memory6;
 store7[x]=memory7;
 store8[x]=memory8;
  end
  txcounter<=txcounter+1;
  if(txcounter==33750)begin
count1<=0;
i<=9;
SS1<=0;
SS2<=0;
SS3<=0;
SS4<=0;
SS5<=0;
SS6<=0;
SS7<=0;
SS8<=0;
txcounter<=0;
x<=x+1;

end
end


always @(posedge clk)
begin
txcounter2<=txcounter2+1;
if(txcounter2==270000)begin
count2=0;
txcounter2<=0;
end
//if(count1>25 && count1<199)begin
if(count1>25)begin
//if(kk==1)begin
  TxD_start=1;
   if(count2==0)begin//1 adc
   //if((count2==0 && z==1))begin
   TxD_data={store1[x][7],store1[x][6],store1[x][5],store1[x][4],store1[x][3],store1[x][2],store1[x][1],store1[x][0]};
   
   //z=0;
  end 
  
 if(count2==1)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store1[x][9],store1[x][8]};
  //y=0;
  end
  if(count2==2)begin//2 adc
   //if((count2==0 && z==1))begin
   TxD_data={store2[x][7],store2[x][6],store2[x][5],store2[x][4],store2[x][3],store2[x][2],store2[x][1],store2[x][0]};
   
   //z=0;
  end 
   if(count2==3)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store2[x][9],store2[x][8]};
  //y=0;
  end
  
  if(count2==4)begin//3 adc
   //if((count2==0 && z==1))begin
   TxD_data={store3[x][7],store3[x][6],store3[x][5],store3[x][4],store3[x][3],store3[x][2],store3[x][1],store3[x][0]};
   
   //z=0;
  end 
   if(count2==5)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store3[x][9],store3[x][8]};
  //y=0;
  end
  
  if(count2==6)begin//4 adc
   //if((count2==0 && z==1))begin
   TxD_data={store4[x][7],store4[x][6],store4[x][5],store4[x][4],store4[x][3],store4[x][2],store4[x][1],store4[x][0]};
   
   //z=0;
  end 
   if(count2==7)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store4[x][9],store4[x][8]};
  //y=0;
  end
  
  if(count2==8)begin//5 adc
   //if((count2==0 && z==1))begin
   TxD_data={store5[x][7],store5[x][6],store5[x][5],store5[x][4],store5[x][3],store5[x][2],store5[x][1],store5[x][0]};
   
   //z=0;
  end 
   if(count2==9)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store5[x][9],store5[x][8]};
  //y=0;
  end
  
  if(count2==10)begin//6 adc
   //if((count2==0 && z==1))begin
   TxD_data={store6[x][7],store6[x][6],store6[x][5],store6[x][4],store6[x][3],store6[x][2],store6[x][1],store6[x][0]};
   
   //z=0;
  end 
   if(count2==11)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store6[x][9],store6[x][8]};
  //y=0;
  end
  
  if(count2==12)begin//7 adc
   //if((count2==0 && z==1))begin
   TxD_data={store7[x][7],store7[x][6],store7[x][5],store7[x][4],store7[x][3],store7[x][2],store7[x][1],store7[x][0]};
   
   //z=0;
  end 
   if(count2==13)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store7[x][9],store7[x][8]};
  //y=0;
  end
  
  if(count2==14)begin//8 adc
   //if((count2==0 && z==1))begin
   TxD_data={store8[x][7],store8[x][6],store8[x][5],store8[x][4],store8[x][3],store8[x][2],store8[x][1],store8[x][0]};
   
   //z=0;
  end 
   if(count2==15)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store8[x][9],store8[x][8]};
  //y=0;
  end
  
  if(count2>15)begin
		TxD_start=0;
		end
  
	if(TxD_ready & TxD_start)
		TxD_shift <= TxD_data;
	
	else
	if(TxD_state[3] & BitTick)
		TxD_shift <= (TxD_shift >> 1);

	case(TxD_state)
		4'b0000: if(TxD_start) begin
		          TxD_state <= 4'b0100;
		          end
		4'b0100: if(BitTick)begin
		         TxD_state <= 4'b1000;  // start bit
		         end
		4'b1000: if(BitTick) begin
		         TxD_state <= 4'b1001;  // bit 0
		         end
		4'b1001: if(BitTick)begin
		 TxD_state <= 4'b1010;  // bit 1
		 end
		4'b1010: if(BitTick)begin
		 TxD_state <= 4'b1011;  // bit 2
		 end
		4'b1011: if(BitTick)begin 
		TxD_state <= 4'b1100;  // bit 3
		end
		4'b1100: if(BitTick)begin
		 TxD_state <= 4'b1101;  // bit 4
		 end
		4'b1101: if(BitTick)begin TxD_state <= 4'b1110;  // bit 5
		end
		4'b1110: if(BitTick)begin
		 TxD_state <= 4'b1111;  // bit 6
		 end
		4'b1111: if(BitTick)begin
		 TxD_state <= 4'b0010;  // bit 7
		  
		end
		4'b0010: if(BitTick)begin
		 TxD_state <= 4'b0011;  // stop1
		 end
		4'b0011: if(BitTick) begin
		        
		         TxD_state <= 4'b0000;  // stop2
		         count2<=count2+1;
		         
		         end
		default: if(BitTick) TxD_state <= 4'b0000;
	endcase
end
end

assign TxD = (TxD_state<4) | (TxD_state[3] & TxD_shift[0]);  // put together the start, data and stop bits

endmodule 

module BaudTickGen(
	input clk, enable,
	output tick  // generate a tick at the specified baud rate * oversampling
);
parameter ClkFrequency = 25000000;
parameter Baud = 115200;
parameter Oversampling = 1;

function integer log2(input integer v); begin log2=0; while(v>>log2) log2=log2+1; end endfunction
localparam AccWidth = log2(ClkFrequency/Baud)+8;  // +/- 2% max timing error over a byte
reg [AccWidth:0] Acc = 0;
localparam ShiftLimiter = log2(Baud*Oversampling >> (31-AccWidth));  // this makes sure Inc calculation doesn't overflow
localparam Inc = ((Baud*Oversampling << (AccWidth-ShiftLimiter))+(ClkFrequency>>(ShiftLimiter+1)))/(ClkFrequency>>ShiftLimiter);
always @(posedge clk) if(enable) Acc <= Acc[AccWidth-1:0] + Inc[AccWidth:0]; else Acc <= Inc[AccWidth:0];
assign tick = Acc[AccWidth];
endmodule 



