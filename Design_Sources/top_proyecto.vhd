library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_proyecto is
    Port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        echo       : in  STD_LOGIC;
        sw_sel     : in  STD_LOGIC;
        trigger    : out STD_LOGIC;
        pwm_out    : out STD_LOGIC;
        led_medida : out STD_LOGIC;
        seg        : out std_logic_vector(6 downto 0);
        anodo      : out std_logic_vector(3 downto 0);
        -- Salidas extra para verificación en simulación
        distancia  : out unsigned(9 downto 0);
        angulo     : out unsigned(7 downto 0)
    );
end top_proyecto;

architecture Behavioral of top_proyecto is
    signal distancia_signal : unsigned(9 downto 0);
    signal angulo_signal    : unsigned(7 downto 0);
begin

    -- Conectar señales internas a puertos de salida
    distancia <= distancia_signal;
    angulo    <= angulo_signal;

    U1: entity work.Sensor_Ultrasonico
        port map(clk=>clk, reset=>reset, echo=>echo,
                 trigger=>trigger, distancia=>distancia_signal,
                 led_medida=>led_medida);

    U2: entity work.Distancia_angulo
        port map(distancia=>distancia_signal,
                 angulo=>angulo_signal);

    U3: entity work.pwm_servomotor
        port map(clk=>clk, reset=>reset, angulo=>angulo_signal,
                 pwm_out=>pwm_out);

    U4: entity work.display_7seg
        port map(clk=>clk, reset=>reset, sw_sel=>sw_sel,
                 distancia=>distancia_signal, angulo=>angulo_signal,
                 seg=>seg, anodo=>anodo);

end Behavioral;