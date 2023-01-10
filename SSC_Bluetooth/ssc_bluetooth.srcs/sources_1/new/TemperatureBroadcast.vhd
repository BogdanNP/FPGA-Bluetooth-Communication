----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2023 09:48:24 PM
-- Design Name: 
-- Module Name: TemperatureBroadcast - Behavioral
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

entity TemperatureBroadcast is
    port(
        CLK: in STD_LOGIC;
        CurrTemp: in STD_LOGIC_VECTOR(15 downto 0);
        Broadcast: out STD_LOGIC
);
end TemperatureBroadcast;

architecture Behavioral of TemperatureBroadcast is

signal prevTemp: STD_LOGIC_VECTOR(15 downto 0) := x"0000";

begin

    process(CLK)
    begin
        if (rising_edge(CLK)) then
            if prevTemp = CurrTemp then
                Broadcast <= '0';
            else 
                Broadcast <= '1';
            end if;
            prevTemp <= CurrTemp;
        end if;           
    end process;

end Behavioral;
