library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
        clk_100MHz      : in  STD_LOGIC;                    -- clock
        arst_n          : in  STD_LOGIC;                    -- SW0
        enable_in       :in  STD_LOGIC;                     -- SW1
        load_in         : in  STD_LOGIC;                    -- SW2
        dir_in          : in  STD_LOGIC;                    -- SW3
        data_in         : in  STD_LOGIC_VECTOR(7 downto 0); -- SW4 to SW7
        led_pwm_out : out std_logic;                        -- LED1
        led_over    : out std_logic                         -- LED2
    );
end top;

architecture Behavioral of top is
    signal clk_100KHz : STD_LOGIC;

begin

    freq_div_inst: entity work.freq_divider
        port map (
            clk_in  => clk_100MHz,
            arst_n   => arst_n,
            clk_out => clk_100KHz
        );

    Eightbitcounter_inst: entity work.Eightbitcounter
        port map (
            clk => clk_100KHz,
            arst_n => arst_n,
            enable_in => enable_in,
            load_in => load_in,
            dir_in => dir_in,
            data_in => data_in,
            count_hi_out => count_hi_out,
            count_lo_out => count_lo_out,
            over_out => open --over_out
        );
        
    PWM_inst: entity work.pwm
        port map (
            clk => clk_100KHz,
            dc_in => 
            pwm_out =>

        )

end Behavioral;