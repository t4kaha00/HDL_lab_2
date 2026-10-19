library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pwm is
    port (
        clk : in std_logic;
        dc_in : in std_logic_vector(7 downto 0);
        pwm_out : out std_logic
    );
end pwm;

architecture Behavioral of pwm is

begin


end Behavioral;
