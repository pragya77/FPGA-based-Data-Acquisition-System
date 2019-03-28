module final_one_adc(
	input clk,
	output TxD,
	output TxD_busy,
	
	output SCK,    //1 adc
	output reg SS1=0,
    output reg MOSI,
    input MISO
    
	
);
reg TxD_start;
reg [11:0]data;

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

integer x=0;
reg [9:0] store1 [0:199];

// Assert TxD_start for (at least) one clock cycle to start transmission of TxD_data
// TxD_data is latched so that it doesn't have to stay valid while it is being sent

//reg [7:0] TxD_data;
//reg [3:0] count;
integer z=1;
integer y=1;
integer kk;

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
kk=-1;
m=0;
count2=0;
TxD_start=0;
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
txcounter1<=txcounter1+1;
if(txcounter1==75)begin//8 microseconds

s<=1;
txcounter1<=0;
end
end

always@(posedge SCK)begin
  if(count1>14 && count1<25 && i>-1)begin
 memory1[i]<=MISO;// data to be compared with table 
 
  i<=i-1;
  end
  count1<=count1+1;
  if(count1==25)begin
   SS1<=1;
   
 store1[x]=memory1;
 
  end
  txcounter<=txcounter+1;
  if(txcounter==75)begin//8 microseconds
count1<=0;
i<=9;
SS1<=0;
x<=x+1;
txcounter<=0;
end
end

//always @(posedge TxD_start)begin
 //kk<=kk+1; 
//end


always @(posedge clk)
begin
txcounter2<=txcounter2+1;
if(txcounter2==10000)begin
count2=0;
txcounter2<=0;
TxD_start=1;
kk<=kk+1; 
end
//if(count1>25 && count1<199)begin
//if(count1>25)begin
//if(kk==1)begin
  if(TxD_start==1 && kk>=0)begin
    
   if(count2==0)begin//1 adc
   //if((count2==0 && z==1))begin
   TxD_data={store1[kk][7],store1[kk][6],store1[kk][5],store1[kk][4],store1[kk][3],store1[kk][2],store1[kk][1],store1[kk][0]};
   
   //z=0;
  end 
  
 if(count2==1)begin
//else if((count2==1 && y==1))begin
  TxD_data={g,g,g,g,g,g,store1[kk][9],store1[kk][8]};
  //y=0;
  end
  
  
  if(count2>1)begin
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




