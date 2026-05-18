library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Distancia_angulo is
  Port (
        distancia : in  unsigned(9 downto 0);
        angulo       : out unsigned(7 downto 0)
    );
end Distancia_angulo;

architecture Behavioral of Distancia_angulo is

begin
             angulo <= to_unsigned(0,8) when distancia < 10  else 
             to_unsigned(45,8) when distancia < 30  else
             to_unsigned(90,8) when distancia < 60  else
             to_unsigned(135,8) when distancia < 100 else
             to_unsigned(180,8);

end Behavioral;