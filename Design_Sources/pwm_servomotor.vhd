library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_servomotor is
    Port (
        clk     : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        angulo   : in  unsigned(7 downto 0);
        pwm_out : out STD_LOGIC
    );
end pwm_servomotor;

architecture Behavioral of pwm_servomotor is

    signal contador : integer range 0 to 199999 := 0;
signal pw       : integer range 0 to 199999  := 0;
begin
    pw <= 10000 when angulo = 0   else
          12500 when angulo = 45  else
          15000 when angulo = 90  else
          17500 when angulo = 135 else
          20000;
    process(clk, reset)
    begin
        if reset = '1' then
            contador <= 0;

        elsif rising_edge(clk) then

            if contador = 199999 then
                contador <= 0;
            else
                contador <= contador + 1;
            end if;

        end if;
    end process;

    pwm_out <= '1' when contador < pw else '0';

end Behavioral;