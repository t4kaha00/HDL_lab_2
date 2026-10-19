# ----------------------------------------------------------------------------
# Clock Source - Bank 13
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y9 [get_ports {clk_100MHz}];  # "GCLK"
set_property IOSTANDARD LVCMOS33 [get_ports {clk_100MHz}];
create_clock -period 10.000 -name sys_clk_pin [get_ports {clk_100MHz}]

# ----------------------------------------------------------------------------
# User LEDs - Bank 33
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN T22 [get_ports {led_pwm_out}];  # "LD0"
set_property PACKAGE_PIN T21 [get_ports {led_over}];     # "LD1"
set_property IOSTANDARD LVCMOS33 [get_ports {led_pwm_out}];
set_property IOSTANDARD LVCMOS33 [get_ports {led_over}];

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34 (active-high)
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN P16 [get_ports {btnc}];        # "BTNC" - reset
set_property PACKAGE_PIN T18 [get_ports {enable_in}];   # "BTNU" - enable
set_property PACKAGE_PIN N15 [get_ports {load_in}];     # "BTNL" - load
set_property PACKAGE_PIN R18 [get_ports {dir_in}];      # "BTNR" - direction
set_property IOSTANDARD LVCMOS18 [get_ports {btnc}];
set_property IOSTANDARD LVCMOS18 [get_ports {enable_in}];
set_property IOSTANDARD LVCMOS18 [get_ports {load_in}];
set_property IOSTANDARD LVCMOS18 [get_ports {dir_in}];

# ----------------------------------------------------------------------------
# User DIP Switches - Bank 35
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN F22 [get_ports {data_in[0]}];  # SW0
set_property PACKAGE_PIN G22 [get_ports {data_in[1]}];  # SW1
set_property PACKAGE_PIN H22 [get_ports {data_in[2]}];  # SW2
set_property PACKAGE_PIN F21 [get_ports {data_in[3]}];  # SW3
set_property PACKAGE_PIN H19 [get_ports {data_in[4]}];  # SW4
set_property PACKAGE_PIN H18 [get_ports {data_in[5]}];  # SW5
set_property PACKAGE_PIN H17 [get_ports {data_in[6]}];  # SW6
set_property PACKAGE_PIN M15 [get_ports {data_in[7]}];  # SW7
set_property IOSTANDARD LVCMOS18 [get_ports {data_in[*]}];
