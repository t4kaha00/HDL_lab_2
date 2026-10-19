library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Eightbitcounter_tb is
--  Port ( );
end Eightbitcounter_tb;

architecture Behavioral of Eightbitcounter_tb is
    signal clk : STD_LOGIC := '0';
    signal arst_n : STD_LOGIC := '0';
    signal enable_in : STD_LOGIC := '0';
    signal load_in : STD_LOGIC := '0';
    signal dir_in : STD_LOGIC := '0';
    signal data_in : STD_LOGIC_VECTOR (7 downto 0) := "01010101";
    signal count_hi_out : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal count_lo_out : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal over_out : STD_LOGIC := '0';
    signal count_temp : std_logic_vector(7 downto 0) := (others => '0');
    
begin
    dut : entity work.Eightbitcounter
        port map (
            clk => clk,
            arst_n => arst_n,
            enable_in => enable_in,
            load_in => load_in,
            dir_in => dir_in,
            data_in => data_in,
            count_hi_out => count_hi_out,
            count_lo_out => count_lo_out,
            over_out => over_out
        );
        
    clk <= not clk after 5 ns;
    
    stimulus : process is
--        variable count_temp : std_logic_vector(7 downto 0) := (others => '0');
        variable over_temp : STD_LOGIC := '0';
    
    begin
        arst_n <= '0';
        enable_in <= '0';
        load_in <= '0';
        dir_in <= '0';        
        count_temp <= (others => '0');
        over_temp := '0';
        
        wait for 20ns;
        
        assert (over_out = over_temp) and (count_lo_out = count_temp (3 downto 0)) and (count_hi_out = count_temp (7 downto 4))
            report "test failed at reset 0"
            severity error;
        
        arst_n <= '1';
        wait until rising_edge(clk);
        
        assert (over_out = over_temp) and (count_lo_out = count_temp (3 downto 0)) and (count_hi_out = count_temp (7 downto 4))
            report "test failed at reset 1, enable 0"
            severity error;
        
        for b in 1 to 1000 loop
            wait until rising_edge(clk);
                            
            if b > 2 then
                enable_in <= '1';
                
                if b > 530 then
                    load_in <= '1';
                elsif b > 260 then
                    dir_in <= '1';
                else
                    dir_in <= '0';
                end if;
            end if;
            
            if enable_in = '1' then
                if load_in = '1' then
                    count_temp <= data_in;
                    assert (over_out = over_temp) and (count_lo_out = count_temp (3 downto 0)) and (count_hi_out = count_temp (7 downto 4))
                        report "test failed at reset 1, enable 1, load 0, dir 0, over 0"
                        severity error;
                else
                    if dir_in = '0' then
                        if count_temp = "11111111" then
                            count_temp <= (others => '0');
                            over_temp := '1';
                            assert (over_out = over_temp) and (count_lo_out = count_temp (3 downto 0)) and (count_hi_out = count_temp (7 downto 4))
                                report "test failed at reset 1, enable 1, load 0, dir 0, over 1"
                                severity error;
                        else
                            count_temp <= std_logic_vector(unsigned(count_temp) + 1);
                            over_temp := '0';
                            assert (over_out = over_temp) and (count_lo_out = count_temp (3 downto 0)) and (count_hi_out = count_temp (7 downto 4))
                                report "test failed at reset 1, enable 1, load 0, dir 0, over 0"
                                severity error;
                        end if;
                    else
                        if count_temp = "00000000" then
                            count_temp <= (others => '1');
                            over_temp := '1';
                            assert (over_out = over_temp) and (count_lo_out = count_temp (3 downto 0)) and (count_hi_out = count_temp (7 downto 4))
                                    report "test failed at reset 1, enable 1, load 0, dir 1, over 1"
                                    severity error;
                        else
                            count_temp <= std_logic_vector(unsigned(count_temp) - 1);
                                over_temp := '0';
                                assert (over_out = over_temp) and (count_lo_out = count_temp (3 downto 0)) and (count_hi_out = count_temp (7 downto 4))
                                    report "test failed at reset 1, enable 1, load 0, dir 1, over 0"
                                    severity error;
                        end if;
                    end if;
                end if;
            else
                count_temp <= count_temp;
            end if;
            
            wait for 1 ns;
            
        assert (over_out = over_temp) and (count_lo_out = count_temp (3 downto 0)) and (count_hi_out = count_temp (7 downto 4))
                report "Final test failed"
                severity error;
        end loop;
        
        report "All test cases passed"
        severity note;
    end process;
end Behavioral;