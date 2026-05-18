library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Distancia_angulo is
end tb_Distancia_angulo;

architecture Behavioral of tb_Distancia_angulo is

    component Distancia_angulo
        Port (
            distancia : in  unsigned(9 downto 0);
            angulo    : out unsigned(7 downto 0)
        );
    end component;

    signal distancia : unsigned(9 downto 0) := (others => '0');
    signal angulo    : unsigned(7 downto 0);

begin

    UUT: Distancia_angulo
        port map(
            distancia => distancia,
            angulo    => angulo
        );

    process
    begin
        -- Caso 1: distancia < 10 cm → 0°
        distancia <= to_unsigned(5, 10);
        wait for 10 ns;

        -- Caso 2: 10 cm <= distancia < 30 cm → 45°
        distancia <= to_unsigned(20, 10);
        wait for 10 ns;

        -- Caso 3: 30 cm <= distancia < 60 cm → 90°
        distancia <= to_unsigned(50, 10);
        wait for 10 ns;

        -- Caso 4: 60 cm <= distancia < 100 cm → 135°
        distancia <= to_unsigned(80, 10);
        wait for 10 ns;

        -- Caso 5: distancia >= 100 cm → 180°
        distancia <= to_unsigned(120, 10);
        wait for 10 ns;

        wait;
    end process;

end Behavioral;