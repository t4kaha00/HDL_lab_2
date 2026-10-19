library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Eightbitcounter is
    Port ( clk : in STD_LOGIC;
           arst_n : in STD_LOGIC;
           enable_in : in STD_LOGIC;
           load_in : in STD_LOGIC;
           dir_in : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           count_hi_out : out STD_LOGIC_VECTOR (3 downto 0);
           count_lo_out : out STD_LOGIC_VECTOR (3 downto 0);
           over_out : out STD_LOGIC);
end Eightbitcounter;

architecture Behavioral of Eightbitcounter is

begin
    process(clk, arst_n)
    variable v_count : unsigned(7 downto 0) := "00000000";
    
    begin
        if arst_n = '0' then
            v_count := "00000000";
            count_hi_out <= std_logic_vector(v_count(7 downto 4));
            count_lo_out <= std_logic_vector(v_count(3 downto 0));
            over_out <= '0';
        elsif rising_edge(clk) then
            over_out <= '0';
            
            if enable_in = '1' then
                if load_in = '0' then
                    if dir_in = '0' then
                        if v_count = "11111111" then
                            v_count := "00000000";
                            over_out <= '1';
                        else
                            v_count := unsigned(v_count) + 1;
                        end if;
                    else 
                        if v_count = "00000000" then
                            v_count := "11111111";
                            over_out <= '1';
                        else
                            v_count := v_count - 1;
                        end if;
                    end if;
                else
                    v_count := unsigned(data_in);
                end if;
           end if;
           
            count_hi_out <= std_logic_vector(v_count(7 downto 4));
            count_lo_out <= std_logic_vector(v_count(3 downto 0));
        end if;
    end process;
end Behavioral;
