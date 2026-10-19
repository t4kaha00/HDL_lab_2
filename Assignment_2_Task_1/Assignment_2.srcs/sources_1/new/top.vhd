library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
        clk_100MHz : in  STD_LOGIC;                    -- clock
        arst_n     : in  STD_LOGIC;                    -- SW0
        enable     : in  STD_LOGIC;                    -- SW1
        load       : in  STD_LOGIC;                    -- SW2
        dir        : in  STD_LOGIC;                    -- SW3
        data       : in  STD_LOGIC_VECTOR(3 downto 0); -- SW4 to SW7
        count      : out STD_LOGIC_VECTOR(3 downto 0); -- LD1 to LD3
        over       : out STD_LOGIC                     -- LD 4
    );
end top;

architecture Behavioral of top is
    signal slow_clk : STD_LOGIC;

begin

    freq_div_inst: entity work.freq_divider
        port map (
            clk_in  => clk_100MHz,
            arst_n   => arst_n,
            clk_out => slow_clk
        );

    counter_inst: entity work.counter
        port map (
            clk    => slow_clk,
            arst_n => arst_n,
            enable => enable,
            load   => load,
            dir    => dir,
            data   => data,
            count  => count,
            over   => over
        );

end Behavioral;