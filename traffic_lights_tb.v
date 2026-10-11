`timescale 1ns/1ps

module traffic_light_tb;
  reg clk;
  reg reset;
  
  wire red;
  wire yellow;
  wire green;
  
  
  traffic_light dut(
    .clk(clk),
    .reset(reset),
    .red(red),
    .yellow(yellow),
    .green(green)
  );
  
  initial begin
    clk =0;
    forever #5 clk = ~clk;
    end
  initial begin
    reset=1;
    #10;
    
    reset=0;
    #300;
    $finish;
  end
  
  initial begin
    $monitor("Time=%0t ,red=%d,yellow=%d,green = %d",$time,red,yellow,green);
  end
endmodule