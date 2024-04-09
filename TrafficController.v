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

module TrafficController(
    input wire clka,
    input wire reseta,
    input wire [1:0] indata,  // Ensure all bits are assigned
    output reg north_south_RED,
    output reg north_south_GREEN,
    output reg east_west_RED,
    output reg east_west_GREEN
);

    // Declare internal signals to hold the state
    reg [1:0] current_state, next_state;

    // Declare parameter for state values
    parameter [1:0] A = 2'b00;
    parameter [1:0] B = 2'b01;
    parameter [1:0] C = 2'b10;

    // State transition and output logic
    always @(posedge clka or posedge reseta) begin
        if (reseta) begin
            current_state <= A; // Reset to initial state A
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    always @* begin
        // Determine next state based on current state and input data
        case (current_state)
            A: begin
                if (indata == 2'b01) begin
                    next_state = B;
                end else if (indata == 2'b10) begin
                    next_state = C;
                end else begin
                    next_state = A; // Assign next state for unassigned input
                end
            end
            B: begin
                if (indata == 2'b10) begin
                    next_state = C;
                end else if (indata == 2'b00) begin
                    next_state = A;
                end else begin
                    next_state = B; // Assign next state for unassigned input
                end
            end
            C: begin
                if (indata == 2'b00) begin
                    next_state = A;
                end else if (indata == 2'b01) begin
                    next_state = B;
                end else begin
                    next_state = C; // Assign next state for unassigned input
                end
            end
            default: next_state = A; // Default case to handle any unexpected values
        endcase
    end

    // Output assignment based on current state
    always @* begin
        case (current_state)
            A: begin
                north_south_RED = 1'b1;
                north_south_GREEN = 1'b0;
                east_west_RED = 1'b1;
                east_west_GREEN = 1'b0;
            end
            B: begin
                north_south_RED = 1'b1;
                north_south_GREEN = 1'b0;
                east_west_RED = 1'b0;
                east_west_GREEN = 1'b1;
            end
            C: begin
                north_south_RED = 1'b0;
                north_south_GREEN = 1'b1;
                east_west_RED = 1'b1;
                east_west_GREEN = 1'b0;
            end
            default: begin
                north_south_RED = 1'b1;
                north_south_GREEN = 1'b0;
                east_west_RED = 1'b1;
                east_west_GREEN = 1'b0;
            end
        endcase
    end

endmodule

