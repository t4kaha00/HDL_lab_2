# ----------------------------------------------------------------------------
# Clock Source - Bank 13
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN Y9 [get_ports {clk_100MHz}];  # "GCLK"
# Set the bank voltage for IO Bank 34 to 1.8V by default.
set_property IOSTANDARD LVCMOS33 [get_ports {clk_100MHz}];
create_clock -period 10.000 -name sys_clk_pin [get_ports {clk_100MHz}]

#create_generated_clock -name clk_100KHz \
#    -source [get_ports {clk_100MHz}] \
#    -divide_by 1000 \
#    [get_pins {freq_divider_inst/clk_temp_reg/Q}]

# ----------------------------------------------------------------------------
# User LEDs - Bank 33
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN T22 [get_ports {count_lo_out[0]}];  # "LD0"
set_property PACKAGE_PIN T21 [get_ports {count_lo_out[1]}];  # "LD1"
set_property PACKAGE_PIN U22 [get_ports {count_lo_out[2]}];  # "LD2"
set_property PACKAGE_PIN U21 [get_ports {count_lo_out[3]}];  # "LD3"
set_property PACKAGE_PIN V22 [get_ports {count_hi_out[0]}]
set_property PACKAGE_PIN W22 [get_ports {count_hi_out[1]}]
set_property PACKAGE_PIN U19 [get_ports {count_hi_out[2]}]
set_property PACKAGE_PIN U14 [get_ports {count_hi_out[3]}]
# Set the bank voltage for IO Bank 35 to 1.8V by default.
set_property IOSTANDARD LVCMOS33 [get_ports {count_hi_out[*]}];
set_property IOSTANDARD LVCMOS33 [get_ports {count_lo_out[*]}];

# ----------------------------------------------------------------------------
# User Push Buttons - Bank 34
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN P16 [get_ports {arst_n}];      # "BTNC"
#set_property PACKAGE_PIN R16 [get_ports {BTND}];        # "BTND"
set_property PACKAGE_PIN N15 [get_ports {load_in}];     # "BTNL"
set_property PACKAGE_PIN R18 [get_ports {dir_in}];      # "BTNR"
set_property PACKAGE_PIN T18 [get_ports {enable_in}];   # "BTNU"
# set_property IOSTANDARD LVCMOS25 [get_ports -of_objects [get_iobanks 34]];
set_property IOSTANDARD LVCMOS18  [get_ports {arst_n}];
set_property IOSTANDARD LVCMOS18  [get_ports {enable_in}];
set_property IOSTANDARD LVCMOS18  [get_ports {load_in}];
set_property IOSTANDARD LVCMOS18  [get_ports {dir_in}];

## ----------------------------------------------------------------------------
## User DIP Switches - Bank 35
## ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN F22 [get_ports {data_in[0]}];    # SW0
set_property PACKAGE_PIN G22 [get_ports {data_in[1]}];    # SW1
set_property PACKAGE_PIN H22 [get_ports {data_in[2]}];    # SW2
set_property PACKAGE_PIN F21 [get_ports {data_in[3]}];    # SW3
set_property PACKAGE_PIN H19 [get_ports {data_in[4]}];    # SW4
set_property PACKAGE_PIN H18 [get_ports {data_in[5]}];    # SW5
set_property PACKAGE_PIN H17 [get_ports {data_in[6]}];    # SW6
set_property PACKAGE_PIN M15 [get_ports {data_in[7]}];    # SW7
set_property IOSTANDARD LVCMOS18 [get_ports {data_in[*]}]