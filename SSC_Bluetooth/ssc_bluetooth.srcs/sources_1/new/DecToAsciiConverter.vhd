----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2022 12:54:33 AM
-- Design Name: 
-- Module Name: DecToAsciiConverter - Behavioral
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

entity DecToAsciiConverter is
  Port (
  decDigit: in STD_LOGIC_VECTOR(3 downto 0);
  asciiValue: out STD_LOGIC_VECTOR(7 downto 0)
   );
end DecToAsciiConverter;

architecture Behavioral of DecToAsciiConverter is

begin

asciiValue <= x"30" when decDigit = x"0"
           else x"31" when decDigit = x"1"
           else x"32" when decDigit = x"2"
           else x"33" when decDigit = x"3"
           else x"34" when decDigit = x"4"
           else x"35" when decDigit = x"5"
           else x"36" when decDigit = x"6"
           else x"37" when decDigit = x"7"
           else x"38" when decDigit = x"8"
           else x"39" when decDigit = x"9"
           else x"00";

end Behavioral;
