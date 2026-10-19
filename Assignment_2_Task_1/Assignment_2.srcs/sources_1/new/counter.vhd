library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port ( 
        clk     : in  STD_LOGIC;
        arst_n  : in  STD_LOGIC;
        enable  : in  STD_LOGIC;
        load    : in  STD_LOGIC;
        dir     : in  STD_LOGIC;
        data    : in  STD_LOGIC_VECTOR(3 downto 0);
        count   : out STD_LOGIC_VECTOR(3 downto 0);
        over    : out STD_LOGIC
    );
end counter;

architecture Behavioral of counter is
begin
    process(clk, arst_n)
    variable v_count : unsigned(3 downto 0);

    begin
        if arst_n = '0' then
            v_count := "0000";
            count <= "0000";
            over <= '0';
        elsif rising_edge(clk) then
            over <= '0';
            
            if enable = '1' then
                if load = '0' then
                    if dir = '0' then
                        if v_count = "1111" then
                            v_count := "0000";
                            over <= '1';
                        else
                            v_count := v_count + 1;
                        end if;
                    else 
                        if v_count = "0000" then
                            v_count := "1111";
                            over <= '1';
                        else
                            v_count := v_count - 1;
                        end if;
                    end if;
                else
                    v_count := unsigned(data);
                end if;
           end if;
           
           count <= std_logic_vector(v_count);
        end if;
    end process;

end Behavioral;