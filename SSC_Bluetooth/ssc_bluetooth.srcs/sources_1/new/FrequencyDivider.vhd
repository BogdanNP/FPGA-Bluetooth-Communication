----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2023 09:42:00 PM
-- Design Name: 
-- Module Name: FrequencyDivider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FrequencyDivider is
    port(
        CLK: in STD_LOGIC;
        CLK_1_sec: out STD_LOGIC
);
end FrequencyDivider;

architecture Behavioral of FrequencyDivider is

signal num: Integer := 0;

begin
    process(CLK)
    begin
        if (rising_edge(CLK)) then
            if num = 100_000_000 then   -- Clock frequency is 100MHz
                CLK_1_sec <= '1';
                num <= 0;
            else 
                CLK_1_sec <= '0';
                num <= num + 1;
            end if;
        end if;
    end process;

end Behavioral;
