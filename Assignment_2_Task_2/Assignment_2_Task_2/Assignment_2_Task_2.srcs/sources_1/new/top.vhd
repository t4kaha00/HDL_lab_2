library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
        clk_100MHz  : in  STD_LOGIC;                     -- 100 MHz system clock
        btnc        : in  STD_LOGIC;                     -- BTNC, active-high push button (reset)
        enable_in   : in  STD_LOGIC;                     -- BTNU, active-high push button
        load_in     : in  STD_LOGIC;                     -- BTNL, active-high push button
        dir_in      : in  STD_LOGIC;                     -- BTNR, active-high push button
        data_in     : in  STD_LOGIC_VECTOR(7 downto 0);  -- SW0 to SW7
        led_pwm_out : out STD_LOGIC;                     -- LD0
        led_over    : out STD_LOGIC                      -- LD1
    );
end top;

architecture Behavioral of top is

    -- The counter uses the 100 kHz divided clock so its value changes at a
    -- measurable rate. PWM uses the full 100 MHz clock, giving a 390.6 kHz
    -- PWM frequency (100 MHz / 256) which is fast enough to avoid visible
    -- flicker.
    signal clk_100KHz   : STD_LOGIC;
    signal arst_n       : STD_LOGIC;
    signal count_hi_out : STD_LOGIC_VECTOR(3 downto 0);
    signal count_lo_out : STD_LOGIC_VECTOR(3 downto 0);
    signal dc_in        : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- BTNC is active high on the Zedboard, while the counter expects an
    -- asynchronous active-low reset.
    arst_n <= not btnc;

    freq_div_inst : entity work.freq_divider
        port map (
            clk_in  => clk_100MHz,
            arst_n  => arst_n,
            clk_out => clk_100KHz
        );

    Eightbitcounter_inst : entity work.Eightbitcounter
        port map (
            clk          => clk_100KHz,
            arst_n       => arst_n,
            enable_in    => enable_in,
            load_in      => load_in,
            dir_in       => dir_in,
            data_in      => data_in,
            count_hi_out => count_hi_out,
            count_lo_out => count_lo_out,
            over_out     => led_over
        );

    -- Combine the two 4-bit counter outputs into the 8-bit duty-cycle input.
    dc_in <= count_hi_out & count_lo_out;

    PWM_inst : entity work.pwm
        port map (
            clk     => clk_100MHz,
            dc_in   => dc_in,
            pwm_out => led_pwm_out
        );

end Behavioral;
