`timescale 1ns/1ps

module tb_traffic_light_controller;

    reg clk = 0;
    reg rst_n = 0;

    wire NS_red, NS_yellow, NS_green;
    wire EW_red, EW_yellow, EW_green;

    // Clock
    always #5 clk = ~clk; // 100 MHz -> 10ns period (example)

    traffic_light_controller dut (
        .clk(clk),
        .rst_n(rst_n),
        .NS_red(NS_red), .NS_yellow(NS_yellow), .NS_green(NS_green),
        .EW_red(EW_red), .EW_yellow(EW_yellow), .EW_green(EW_green)
    );

    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, tb_traffic_light_controller);

        rst_n = 0;
        #20;
        rst_n = 1;

        #1000; // run long enough to see cycles
        $finish;
    end

endmodule
