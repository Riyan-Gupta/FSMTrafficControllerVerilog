`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2024 22:49:48
// Design Name: 
// Module Name: TrafficControllerTestbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TrafficControllerTestbench;
    parameter CLK_PER = 10;

    reg clkr;
    reg resetr;
    reg [1:0] indata;
    wire north_south_RED;
    wire north_south_GREEN;
    wire east_west_RED;
    wire east_west_GREEN;

    TrafficController dut (
        .clka(clkr),
        .reseta(resetr),
        .indata(indata),
        .north_south_RED(north_south_RED),
        .north_south_GREEN(north_south_GREEN),
        .east_west_RED(east_west_RED),
        .east_west_GREEN(east_west_GREEN)
    );

    // Generate clock signal with half period of CLK_PER
    always #((CLK_PER / 2)) begin
    clkr <= ~clkr; // Toggle the clock signal
end


    // Drive reset signal
    initial begin
        clkr = 0;
        resetr = 1;
        indata = 2'b00;
        #20 resetr = 0; // De-assert reset after 20 time units
        #20 indata = 2'b01;
        #20 indata = 2'b10;
        #20 indata = 2'b00;
        #100 $finish; // End simulation after 100 time units
    end

    // Monitor module to continuously check the values of the signals
    always @(posedge clkr) begin
        // Log or display the values of the signals
        $display("north_south_RED = %b, north_south_GREEN = %b, east_west_RED = %b, east_west_GREEN = %b",
                 north_south_RED, north_south_GREEN, east_west_RED, east_west_GREEN);
        
        // Check for specific conditions and trigger actions based on the signals
        if (north_south_GREEN && !east_west_GREEN) begin
            // Add any action here, e.g., log a message or set a flag
            $display("North-South traffic is green while East-West traffic is red");
        end
         if (north_south_RED && !east_west_RED) begin
            // Add any action here, e.g., log a message or set a flag
            $display("North-South traffic is red while East-West traffic is green");
        end
    end

endmodule
