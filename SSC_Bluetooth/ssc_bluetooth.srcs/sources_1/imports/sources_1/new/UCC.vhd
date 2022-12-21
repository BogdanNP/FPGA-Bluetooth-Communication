----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2022 09:16:17 PM
-- Design Name: 
-- Module Name: UCC - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UCC is
Port 
(
signal clk:in std_logic;
signal rst:in std_logic;

-- ce primesc
signal btn_start:in std_logic;
signal date_intrare:in std_logic_vector(15 downto 0);
signal activ:in std_logic;
signal done:in std_logic;

-- ce dau
signal date_iesire:out std_logic_vector(7 downto 0);
signal start:out std_logic
 );
end UCC;

architecture Behavioral of UCC is

type stari is (inceput,incarcare_date,octet1,transmisie1,octet2,transmisie2,stop);
signal stare_cur:stari:=incarcare_date;
signal stare_urm:stari:=incarcare_date;

signal oc1:std_logic_vector(7 downto 0):="00000001";
signal oc2:std_logic_vector(7 downto 0):="00000010";
begin

process(clk,rst)
begin

if rst='1' then
stare_cur<=inceput;
elsif clk'event and clk='1' then 
stare_cur<=stare_urm;
end if;

end process;

process(stare_cur,activ,done,date_intrare,oc1,oc2)
begin

case stare_cur is
when inceput=>  if btn_start='1' then
                    stare_urm<=incarcare_date;
                else
                    stare_urm<=inceput;
                end if;
when incarcare_date=>stare_urm<=octet1;
                     oc1<=date_intrare(15 downto 8);
                     oc2<=date_intrare(7 downto 0);
when octet1=>stare_urm<=transmisie1;
             date_iesire<=oc1;
when transmisie1=>if activ='0' and done='1' then
                        stare_urm<=octet2;
                  else
                        stare_urm<=transmisie1;
                  end if;
when octet2=>stare_urm<=transmisie2;
             date_iesire<=oc2;
when transmisie2=>if activ='0' and done='1' then
                        stare_urm<=stop;
                  else
                        stare_urm<=transmisie2;
                  end if;
when others=>stare_urm<=inceput;
end case;

end process;

process(stare_cur)
begin
case stare_cur is
when inceput=>start<='0';
when incarcare_date=>start<='0';
when octet1=>start<='1';
when transmisie1=>start<='0';
when octet2=>start<='1';
when transmisie2=>start<='0';
when others=>start<='0';
end case;
end process;
end Behavioral;
