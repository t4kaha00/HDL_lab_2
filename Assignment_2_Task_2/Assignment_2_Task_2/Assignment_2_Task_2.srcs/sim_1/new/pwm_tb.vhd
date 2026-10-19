library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.ENV.ALL;

entity pwm_tb is
end entity pwm_tb;

architecture Behavioral of pwm_tb is

    constant CLK_PERIOD : time := 10 ns;

    signal clk     : std_logic := '0';
    signal dc_in   : std_logic_vector(7 downto 0) := (others => '0');
    signal pwm_out : std_logic;

begin

    -- Device under test
    dut : entity work.pwm
        port map (
            clk     => clk,
            dc_in   => dc_in,
            pwm_out => pwm_out
        );

    -- Free-running clock
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stimulus : process

        variable high_cycles : natural;

        -- Count the high cycles of pwm_out over exactly one PWM period
        -- (256 clock cycles) and compare the result with dc_in.
        procedure check_duty_cycle (constant duty : in natural) is
        begin
            for i in 0 to 255 loop
                wait until rising_edge(clk);
                -- Allow the combinational output to settle after the edge.
                wait for 1 ns;
                if pwm_out = '1' then
                    high_cycles := high_cycles + 1;
                end if;
            end loop;

            assert high_cycles = duty
                report "Duty-cycle mismatch: dc_in = " & integer'image(duty) &
                       ", expected " & integer'image(duty) &
                       " high cycles out of 256, but observed " &
                       integer'image(high_cycles)
                severity failure;
        end procedure;

    begin
        -- Let the PWM counter start running.
        wait for CLK_PERIOD * 2;

        -- Verify every possible 8-bit duty-cycle value.
        for duty in 0 to 255 loop
            dc_in <= std_logic_vector(to_unsigned(duty, dc_in'length));
            -- Give dc_in one clock cycle to take effect before measuring.
            wait until rising_edge(clk);
            high_cycles := 0;
            check_duty_cycle(duty);
        end loop;

        report "PWM testbench PASSED: duty cycle correct for all 256 dc_in values."
            severity note;

        finish;
    end process;

end architecture Behavioral;
