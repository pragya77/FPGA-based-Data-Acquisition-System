# FPGA-based-Data-Acquisition-System

In this, Data Acquisition System is implemented using Altera Cyclone II FPGA DE1 Board to configure ADC MCP3008 as a slave, with FPGA board being master of SPI protocol.
First, configure bits are sent by FPGA to ADC,analog voltage is applied to channel 1 of ADC and then the converted digital data is sent back and stored on memory. Then, they are sent to PC on RS232 port.
ADC is triggered every 20 microseconds and trinagular and sines waves are given to the analog channel of ADC.
