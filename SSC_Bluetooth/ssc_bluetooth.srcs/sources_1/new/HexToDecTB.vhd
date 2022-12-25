----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2022 11:15:44 PM
-- Design Name: 
-- Module Name: HexToDecTB - Behavioral
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

entity HexToDecTB is
Port (
signal clk:in std_logic;
signal btn:in std_logic_vector(4 downto 0);
signal sw:in std_logic_vector(15 downto 0);
signal led:out std_logic_vector(15 downto 0);
signal cat:out std_logic_vector(7 downto 0);
signal an:out std_logic_vector(7 downto 0);
signal RX:in std_logic;
signal TX:out std_logic;

signal TMP_SCL: inout std_logic;
signal TMP_SDA: inout std_logic
 );
end HexToDecTB;

architecture Behavioral of HexToDecTB is

component HexToDecimalConverter
  Port (
    clk: in STD_LOGIC;
    hexValue: in STD_LOGIC_VECTOR(15 downto 0);
    decValue: out STD_LOGIC_VECTOR(15 downto 0)
  );
end component;

constant CLK_PERIOD : TIME := 10 ns;

signal hexValueSgn : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal decValueSgn : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal clkSgn : STD_LOGIC := '0';

begin

conv1: HexToDecimalConverter port map(clk => clkSgn, hexValue => hexValueSgn, decValue => decValueSgn);

gen_clk: process
begin
    clkSgn <= '0';
    wait for (CLK_PERIOD/2);
    clkSgn <= '1';
    wait for (CLK_PERIOD/2);
end process gen_clk; 

test: process
    variable NrErr : INTEGER := 0;
begin
    hexValueSgn <= x"0015";
    wait for CLK_PERIOD;
    
    if decValueSgn /= x"0021" then
    	report "rezultat asteptat: 0021" &
                 "rezultat obtinut: " &
                  STD_LOGIC'image(decValueSgn(15)) &
                  STD_LOGIC'image(decValueSgn(14)) &
                  STD_LOGIC'image(decValueSgn(13)) &
                  STD_LOGIC'image(decValueSgn(12)) &
                  STD_LOGIC'image(decValueSgn(11)) &
                  STD_LOGIC'image(decValueSgn(10)) &
                  STD_LOGIC'image(decValueSgn(9)) &
                  STD_LOGIC'image(decValueSgn(8)) &
                  STD_LOGIC'image(decValueSgn(7)) &
                  STD_LOGIC'image(decValueSgn(6)) &
                  STD_LOGIC'image(decValueSgn(5)) &
                  STD_LOGIC'image(decValueSgn(4)) &
                  STD_LOGIC'image(decValueSgn(3)) &
                  STD_LOGIC'image(decValueSgn(2)) &
                  STD_LOGIC'image(decValueSgn(1)) &                                       
                  STD_LOGIC'image(decValueSgn(0)) &"; "&
                 "timp: " & TIME'image(now) & ";"
          severity ERROR;  
          NrErr := NrErr + 1;
    end if;
    
    hexValueSgn <= x"0007";
    wait for CLK_PERIOD;
    
    if decValueSgn /= x"0007" then
        report "rezultat asteptat: 0007" &
                 "rezultat obtinut: " &
                  STD_LOGIC'image(decValueSgn(15)) &
                  STD_LOGIC'image(decValueSgn(14)) &
                  STD_LOGIC'image(decValueSgn(13)) &
                  STD_LOGIC'image(decValueSgn(12)) &
                  STD_LOGIC'image(decValueSgn(11)) &
                  STD_LOGIC'image(decValueSgn(10)) &
                  STD_LOGIC'image(decValueSgn(9)) &
                  STD_LOGIC'image(decValueSgn(8)) &
                  STD_LOGIC'image(decValueSgn(7)) &
                  STD_LOGIC'image(decValueSgn(6)) &
                  STD_LOGIC'image(decValueSgn(5)) &
                  STD_LOGIC'image(decValueSgn(4)) &
                  STD_LOGIC'image(decValueSgn(3)) &
                  STD_LOGIC'image(decValueSgn(2)) &
                  STD_LOGIC'image(decValueSgn(1)) &                                       
                  STD_LOGIC'image(decValueSgn(0)) &"; "&
                 "timp: " & TIME'image(now) & ";"
          severity ERROR;  
          NrErr := NrErr + 1;
    end if;
        
    hexValueSgn <= x"000C";
    wait for CLK_PERIOD;
    
    if decValueSgn /= x"0012" then
        report "rezultat asteptat: 0012" &
                 "rezultat obtinut: " &
                  STD_LOGIC'image(decValueSgn(15)) &
                  STD_LOGIC'image(decValueSgn(14)) &
                  STD_LOGIC'image(decValueSgn(13)) &
                  STD_LOGIC'image(decValueSgn(12)) &
                  STD_LOGIC'image(decValueSgn(11)) &
                  STD_LOGIC'image(decValueSgn(10)) &
                  STD_LOGIC'image(decValueSgn(9)) &
                  STD_LOGIC'image(decValueSgn(8)) &
                  STD_LOGIC'image(decValueSgn(7)) &
                  STD_LOGIC'image(decValueSgn(6)) &
                  STD_LOGIC'image(decValueSgn(5)) &
                  STD_LOGIC'image(decValueSgn(4)) &
                  STD_LOGIC'image(decValueSgn(3)) &
                  STD_LOGIC'image(decValueSgn(2)) &
                  STD_LOGIC'image(decValueSgn(1)) &                                       
                  STD_LOGIC'image(decValueSgn(0)) &"; "&
                 "timp: " & TIME'image(now) & ";"
          severity ERROR;  
          NrErr := NrErr + 1;
    end if;
    
    if(NrErr = 0) then
        report "Testare terminata cu succes"; 
     else
        report "Testare terminata cu " &
        INTEGER'image (NrErr) & " erori";
    end if;
    wait;
end process;

end Behavioral;
