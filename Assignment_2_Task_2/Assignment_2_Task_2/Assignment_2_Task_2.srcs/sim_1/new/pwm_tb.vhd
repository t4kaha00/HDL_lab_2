library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_tb is
end entity pwm_tb;

architecture test of pwm_tb is

    component pwm is
        port (
            clk     : in  std_logic;
            dc_in   : in  std_logic_vector(7 downto 0);
            pwm_out : out std_logic
        );
    end component;

    signal clk     : std_logic := '0';
    signal dc_in   : std_logic_vector(7 downto 0) := (others => '0');
    signal pwm_out : std_logic;

    constant CLK_PERIOD : time := 10 ns;

    -- Helper procedure to count high pulses in a full PWM period (256 clocks)
    procedure verify_duty_cycle (
        signal clk_sig     : in std_logic;
        signal pwm_sig     : in std_logic;
        expected_high_cnt : in integer
    ) is
        variable high_count : integer := 0;
    begin
        high_count := 0;
        for i in 0 to 255 loop
            wait until rising_edge(clk_sig);
            if pwm_sig = '1' then
                high_count := high_count + 1;
            end if;
        end loop;
        
        assert high_count = expected_high_cnt
            report "ERROR: Duty cycle mismatch! Expected high count: " & 
                   integer'image(expected_high_cnt) & 
                   ", Got: " & integer'image(high_count)
            severity failure;
    end procedure;

begin

    -- Instantiate DUT
    uut : pwm
        port map (
            clk     => clk,
            dc_in   => dc_in,
            pwm_out => pwm_out
        );

    -- Clock process
    p_clk : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    p_stim : process
    begin
        -- Wait for initial stabilization
        wait for CLK_PERIOD * 5;

        -- Test Case 1: 0% Duty Cycle (dc_in = 0x00 -> 0 high cycles)
        dc_in <= x"00";
        verify_duty_cycle(clk, pwm_out, 0);

        -- Test Case 2: ~25% Duty Cycle (dc_in = 0x40 = 64 -> 64 high cycles)
        dc_in <= x"40";
        verify_duty_cycle(clk, pwm_out, 64);

        -- Test Case 3: 50% Duty Cycle (dc_in = 0x80 = 128 -> 128 high cycles)
        dc_in <= x"80";
        verify_duty_cycle(clk, pwm_out, 128);

        -- Test Case 4: ~75% Duty Cycle (dc_in = 0xC0 = 192 -> 192 high cycles)
        dc_in <= x"C0";
        verify_duty_cycle(clk, pwm_out, 192);

        report "PWM ALL TEST CASES PASSED SUCCESSFULLY!";
        wait;
    end process;

end architecture test;