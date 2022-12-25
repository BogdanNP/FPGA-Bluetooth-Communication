----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2022 10:37:06 PM
-- Design Name: 
-- Module Name: HexToDecimalConverter - Behavioral
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
use ieee.numeric_std.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HexToDecimalConverter is
  Port (
    hexValue: in STD_LOGIC_VECTOR(15 downto 0);
    decValue: out STD_LOGIC_VECTOR(15 downto 0)
  );
end HexToDecimalConverter;

architecture Behavioral of HexToDecimalConverter is
signal unit : std_logic_vector(3 downto 0);
signal zeci: std_logic_vector(3 downto 0);
signal sute: std_logic_vector(3 downto 0);
signal mii: std_logic_vector(3 downto 0);
begin

unit <= std_logic_vector(to_unsigned(to_integer(unsigned(hexValue)) mod 10, 4));
zeci <= std_logic_vector(to_unsigned((to_integer(unsigned(hexValue)) / 10) mod 10, 4));
sute <= std_logic_vector(to_unsigned((to_integer(unsigned(hexValue)) / 100) mod 10, 4));
mii <= std_logic_vector(to_unsigned((to_integer(unsigned(hexValue)) / 1000) mod 10, 4));

decValue <= mii & sute & zeci & unit;

end Behavioral;
