library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Sensor_Ultrasonico is
end tb_Sensor_Ultrasonico;

architecture Behavioral of tb_Sensor_Ultrasonico is

    component Sensor_Ultrasonico
        Port (
            clk        : in  STD_LOGIC;
            reset      : in  STD_LOGIC;
            echo       : in  STD_LOGIC;
            trigger    : out STD_LOGIC;
            distancia  : out unsigned(9 downto 0);
            led_medida : out STD_LOGIC
        );
    end component;

    signal clk        : STD_LOGIC := '0';
    signal reset      : STD_LOGIC := '1';
    signal echo       : STD_LOGIC := '0';
    signal trigger    : STD_LOGIC;
    signal distancia  : unsigned(9 downto 0);
    signal led_medida : STD_LOGIC;

begin

    ----------------------------------------------------------------
    -- INSTANCIA DEL MODULO
    ----------------------------------------------------------------
    UUT: Sensor_Ultrasonico
        port map(
            clk        => clk,
            reset      => reset,
            echo       => echo,
            trigger    => trigger,
            distancia  => distancia,
            led_medida => led_medida
        );

    ----------------------------------------------------------------
    -- CLOCK 100 MHz (10 ns)
    ----------------------------------------------------------------
    clk <= not clk after 5 ns;

    ----------------------------------------------------------------
    -- ESTIMULOS
    ----------------------------------------------------------------
    process
    begin

        ------------------------------------------------------------
        -- RESET INICIAL
        ------------------------------------------------------------
        reset <= '1';
        echo  <= '0';

        wait for 200 ns;

        reset <= '0';

        ------------------------------------------------------------
        -- CASO 1 : ~10 cm
        -- echo ≈ 580 us
        ------------------------------------------------------------
        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 580 us;
        echo <= '0';

        wait for 10 ms;

        ------------------------------------------------------------
        -- CASO 2 : ~30 cm
        -- echo ≈ 1740 us
        ------------------------------------------------------------
        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 1740 us;
        echo <= '0';

        wait for 10 ms;

        ------------------------------------------------------------
        -- CASO 3 : ~60 cm
        -- echo ≈ 3480 us
        ------------------------------------------------------------
        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 3480 us;
        echo <= '0';

        wait for 10 ms;

        ------------------------------------------------------------
        -- CASO 4 : ~100 cm
        -- echo ≈ 5800 us
        ------------------------------------------------------------
        wait until trigger = '1';
        wait until trigger = '0';

        wait for 200 us;

        echo <= '1';
        wait for 5800 us;
        echo <= '0';

        wait for 10 ms;

        ------------------------------------------------------------
        -- FIN
        ------------------------------------------------------------
        wait;

    end process;

end Behavioral;