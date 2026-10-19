library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm is
    port (
        clk : in std_logic;
        dc_in : in std_logic_vector(7 downto 0);
        pwm_out : out std_logic
    );
end pwm;

architecture Behavioral of pwm is
    -- Free-running 8-bit counter.  It wraps automatically, so the PWM
    -- period is 256 clock cycles and the resolution is 8 bits.
    signal pwm_count : unsigned(7 downto 0) := (others => '0');

begin

    count_process : process(clk)
    begin
        if rising_edge(clk) then
            pwm_count <= pwm_count + 1;
        end if;
    end process;

    -- Duty cycle = dc_in / 256.
    -- dc_in = 0x00 gives 0% (always low); dc_in = 0xFF gives 255/256.
    pwm_out <= '1' when pwm_count < unsigned(dc_in) else '0';

end Behavioral;
