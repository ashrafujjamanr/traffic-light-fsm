#!/bin/bash
iverilog -g2012 -o traffic_sim \
    ../rtl/traffic_light_controller.v \
    ../tb/tb_traffic_light_controller.v

vvp traffic_sim
gtkwave traffic_light.vcd &

