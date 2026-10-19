library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is

    signal clk    : STD_LOGIC := '0';
    signal arst_n : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '0';
    signal load   : STD_LOGIC := '0';
    signal dir    : STD_LOGIC := '0';
    signal data   : STD_LOGIC_VECTOR(3 downto 0) := "0110";
    signal count : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal count_temp : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal over   : STD_LOGIC := '0';
    
begin
    dut : entity work.counter
        port map (clk, arst_n, enable, load, dir, data, count, over);
        
    clk <= not clk after 5 ns;
  
    stimulus : process is
--        variable count_temp : std_logic_vector(3 downto 0) := "0000";
        variable over_temp : STD_LOGIC := '0';

        begin
            arst_n <= '0';
            enable <= '0';
            load <= '0';
            dir <= '0';
            count_temp <= "0000";
            over_temp := '0';
            
            wait for 20ns;
            
            assert (over = over_temp) and (count = count_temp)
                report "test failed at reset 0"
                severity error;
            
            arst_n <= '1';
            wait until rising_edge(clk);

            assert (over = over_temp) and (count = count_temp)
                report "test failed at reset 1, enable 0"
                severity error;
            
            for b in 1 to 40 loop
                wait until rising_edge(clk);
                                
                if b > 2 then
                    enable <= '1';

                    if b > 35 then
                        load <= '1';
                    elsif b > 20 then
                        dir <= '1';
                    else
                        dir <= '0';
                    end if;
                end if;
                
                if enable = '1' then
                    if load = '1' then
                        count_temp <= data;
                        assert (over = over_temp) and (count = count_temp)
                            report "test failed at reset 1, enable 1, load 1, dir 0, over 0"
                            severity error;
                    else
                        if dir = '0' then
                            if count_temp = "1111" then
                                count_temp <= "0000";
                                over_temp := '1';
                                assert (over = over_temp) and (count = count_temp)
                                    report "test failed at reset 1, enable 1, load 0, dir 0, over 1"
                                    severity error;
                            else
                                count_temp <= std_logic_vector(unsigned(count_temp) + 1);
                                over_temp := '0';
                                assert (over = over_temp) and (count = count_temp)
                                    report "test failed at reset 1, enable 1, load 0, dir 0, over 0"
                                    severity error;
                            end if;              
                        else
                            if count_temp = "0000" then
                                count_temp <= "1111";
                                over_temp := '1';
                                assert (over = over_temp) and (count = count_temp)
                                    report "test failed at reset 1, enable 1, load 0, dir 1, over 1"
                                    severity error;
                            else
                                count_temp <= std_logic_vector(unsigned(count_temp) - 1);
                                over_temp := '0';
                                assert (over = over_temp) and (count = count_temp)
                                    report "test failed at reset 1, enable 1, load 0, dir 1, over 0"
                                    severity error;
                            end if;              
                        end if;
                    end if;
                else
                    count_temp <= count_temp;
                end if;
                
                wait for 1 ns;
                
                assert (over = over_temp) and (count = count_temp)
                    report "End test failed"
                    severity error;
            end loop;
            
            report "All test cases passed"
            severity note;
        end process;
end Behavioral;
