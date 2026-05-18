## Clock 100 MHz
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Switches
set_property PACKAGE_PIN V17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

set_property PACKAGE_PIN V16 [get_ports sw_sel]
set_property IOSTANDARD LVCMOS33 [get_ports sw_sel]

## LED indicador de medición
set_property PACKAGE_PIN U16 [get_ports led_medida]
set_property IOSTANDARD LVCMOS33 [get_ports led_medida]

## PMOD JA
## JA1 -> trigger HC-SR04
set_property PACKAGE_PIN J1 [get_ports trigger]
set_property IOSTANDARD LVCMOS33 [get_ports trigger]

## JA2 -> echo HC-SR04
set_property PACKAGE_PIN L2 [get_ports echo]
set_property IOSTANDARD LVCMOS33 [get_ports echo]

## JA3 -> PWM servomotor
set_property PACKAGE_PIN J2 [get_ports pwm_out]
set_property IOSTANDARD LVCMOS33 [get_ports pwm_out]

## Display de 7 segmentos
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]

set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]

set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]

set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]

set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]

set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

## Ánodos del display
set_property PACKAGE_PIN U2 [get_ports {anodo[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anodo[0]}]

set_property PACKAGE_PIN U4 [get_ports {anodo[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anodo[1]}]

set_property PACKAGE_PIN V4 [get_ports {anodo[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anodo[2]}]

set_property PACKAGE_PIN W4 [get_ports {anodo[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anodo[3]}]