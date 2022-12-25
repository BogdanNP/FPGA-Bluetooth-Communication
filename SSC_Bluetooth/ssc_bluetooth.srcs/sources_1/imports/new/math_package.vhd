-- package for math functions

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package math_package is
  function log2( i : natural) return integer;
  function ceil(num : real) return integer;
end package math_package;

package body math_package is
  function log2( i : natural) return integer is
    variable temp    : integer := i;
    variable ret_val : integer := 0; 
  begin					
    while temp > 1 loop
      ret_val := ret_val + 1;
      temp    := temp / 2;     
    end loop;
    return ret_val;
  end function;
  
  function ceil(num : real) return integer is
    variable inum : integer := integer(num);
  begin
    if (num = real(inum)) then
        return inum;
    end if;
    return inum + 1;
  end function;
  

end package body math_package;