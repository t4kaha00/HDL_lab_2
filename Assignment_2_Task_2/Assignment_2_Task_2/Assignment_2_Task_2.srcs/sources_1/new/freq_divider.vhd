library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity freq_divider is
    Port (
        clk_in  : in  STD_LOGIC;
        arst_n   : in  STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end freq_divider;

architecture Behavioral of freq_divider is
    -- 100 MHz / (2 * 500) = 100 kHz
    constant MAX_COUNT : integer := 500_000 - 1;
    signal divider : integer range 0 to MAX_COUNT := 0;
    signal clk_temp : std_logic := '0';

begin
    process(clk_in, arst_n)
    begin
        if arst_n = '0' then
            divider <= 0;
            clk_temp <= '0';
        elsif rising_edge(clk_in) then
            if divider = MAX_COUNT then
                divider <= 0;
                    clk_temp <= not clk_temp;
            else 
                divider <= divider + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_temp;

end Behavioral;