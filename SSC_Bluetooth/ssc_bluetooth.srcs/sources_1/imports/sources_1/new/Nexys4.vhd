----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2022 08:46:09 PM
-- Design Name: 
-- Module Name: Nexys4 - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Nexys4 is
Port 
(
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
end Nexys4;

architecture Behavioral of Nexys4 is


-- Senzor Temperatura
component TempSensorCtl is
Generic (CLOCKFREQ : natural := 100); -- input CLK frequency in MHz
Port (
  TMP_SCL : inout STD_LOGIC;
  TMP_SDA : inout STD_LOGIC;
  TEMP_O : out STD_LOGIC_VECTOR(12 downto 0); --12-bit two's complement temperature with sign bit
  RDY_O : out STD_LOGIC;	--'1' when there is a valid temperature reading on TEMP_O
  ERR_O : out STD_LOGIC; --'1' if communication error
  CLK_I : in STD_LOGIC;
  SRST_I : in STD_LOGIC);
end component;

signal tempValue : std_logic_vector(12 downto 0);
signal tempRdy, tempErr : std_logic;
signal realValue: std_logic_vector(15 downto 0);
constant ONE_BIT_DEG: integer := 625;

-- END Senzor Temperatura


signal date:std_logic_vector(31 downto 0);
signal rx_8:std_logic_vector(7 downto 0);

signal btn_rst:std_logic;
signal btn_start:std_logic;

signal trimitere_mesaje:std_logic_vector(7 downto 0);

signal start:std_logic;
signal activ:std_logic;
signal done:std_logic;
begin

realValue <= STD_LOGIC_VECTOR(to_unsigned(integer((conv_integer(tempValue)) * ONE_BIT_DEG / 10000), 16));
--date<=x"000000" & rx_8;
date <= (X"0000" & realValue);

Inst_TempSensorCtl: TempSensorCtl
generic map (CLOCKFREQ => 100)
port  map(
  TMP_SCL => TMP_SCL,
  TMP_SDA => TMP_SDA,
  TEMP_O => tempValue,
  RDY_O => tempRdy,
  ERR_O => tempErr,		
  CLK_I => clk,
  SRST_I => btn_rst);


afisor:entity WORK.displ7seg port map
(
Clk=>clk,
Rst=>btn_rst,
Data=> date,
An=>an,
Seg=>cat
);

btn_c:entity WORK.mpg port map
(
btn=>btn(0),
clk=>clk,
en=>btn_rst
);

btn_u:entity WORK.mpg port map
(
    btn=>btn(1),
    clk=>clk,
    en=>btn_start
);

b1_rx:entity WORK.UART_rx
generic map
(
g_CLKS_PER_BIT => 10416
)
port map
(
    i_Clk=>clk,
    i_RX_Serial=>RX,
    o_RX_DV=>led(0),
    o_RX_Byte=>rx_8
);

--baud rate: 96000
--nexys 4 frequency 100MHz -> 100 * 10^6
--g_CLKS_PER_BIT = 100 * 10 ^ 6 / 9600 = 10416

b1_tx:entity WORK.UART_tx
generic map
(
    g_CLKS_PER_BIT=> 10416
)
port map
(
    i_Clk=>clk,
    i_TX_DV=>start,
    i_TX_Byte=>trimitere_mesaje,
    o_TX_Active=>activ,
    o_TX_Serial=>TX,
    o_TX_Done=>done
);

unitate_cc:entity WORK.UCC
port map
(
    clk=>clk,
    rst=>btn_rst,
    btn_start=>btn_start,
    date_intrare=> realValue, --sw(15 downto 0),
    activ=>activ,
    done=>done,
    date_iesire=>trimitere_mesaje,
    start=>start
);    
end Behavioral;
