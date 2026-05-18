library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_proyecto is
end tb_top_proyecto;

architecture Behavioral of tb_top_proyecto is

    signal clk        : STD_LOGIC := '0';
    signal reset      : STD_LOGIC := '1';
    signal echo       : STD_LOGIC := '0';
    signal sw_sel     : STD_LOGIC := '0';
    signal trigger    : STD_LOGIC;
    signal pwm_out    : STD_LOGIC;
    signal led_medida : STD_LOGIC;
    signal seg        : std_logic_vector(6 downto 0);
    signal anodo      : std_logic_vector(3 downto 0);
    signal distancia  : unsigned(9 downto 0);
    signal angulo     : unsigned(7 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    UUT: entity work.top_proyecto
    port map(
        clk        => clk,
        reset      => reset,
        echo       => echo,
        sw_sel     => sw_sel,
        trigger    => trigger,
        pwm_out    => pwm_out,
        led_medida => led_medida,
        seg        => seg,
        anodo      => anodo,
        distancia  => distancia,
        angulo     => angulo
    );

    clk <= not clk after CLK_PERIOD / 2;

    process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- --------------------------------------------------
        -- CASO 1: distancia ~17 cm → ángulo 45° → PWM 1.25 ms
        -- echo = 1000 us (1000/58 ≈ 17 cm)
        -- --------------------------------------------------
        wait for 200 us;
        echo <= '1';
        wait for 1000 us;
        echo <= '0';
        wait for 1 ms;

        -- --------------------------------------------------
        -- CASO 2: distancia ~43 cm → ángulo 90° → PWM 1.5 ms
        -- echo = 2500 us (2500/58 ≈ 43 cm)
        -- --------------------------------------------------
        wait for 200 us;
        echo <= '1';
        wait for 2500 us;
        echo <= '0';
        wait for 1 ms;

        -- --------------------------------------------------
        -- CASO 3: distancia ~172 cm → ángulo 180° → PWM 2.0 ms
        -- echo = 10000 us (10000/58 ≈ 172 cm)
        -- --------------------------------------------------
        wait for 200 us;
        echo <= '1';
        wait for 10000 us;
        echo <= '0';
        wait for 1 ms;
        wait;
    end process;

end Behavioral;