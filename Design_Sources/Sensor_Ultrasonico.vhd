library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Sensor_Ultrasonico is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        echo       : in  std_logic;
        trigger    : out std_logic;
        distancia  : out unsigned(9 downto 0);
        led_medida : out std_logic
    );
end Sensor_Ultrasonico;

architecture Behavioral of Sensor_Ultrasonico is

    type estado_type is (IDLE, TRIG, WAIT_ECHO, MEASURE, DONE);
    signal estado : estado_type := IDLE;

    signal contador      : unsigned(31 downto 0) := (others => '0');
    signal echo_counter  : unsigned(31 downto 0) := (others => '0');
    signal dist_reg      : unsigned(9 downto 0)  := (others => '0');

    constant TRIG_TIME : integer := 1000;       -- 10 us con clk de 100 MHz
    constant WAIT_TIME : integer := 1000000;    -- 10 ms para simulación rápida
    constant DIV_CM    : integer := 5800;       -- aprox. 58 us * 100 ciclos/us

begin

    distancia <= dist_reg;

    process(clk, reset)
    begin
        if reset = '1' then
            estado       <= IDLE;
            contador     <= (others => '0');
            echo_counter <= (others => '0');
            dist_reg     <= (others => '0');
            trigger      <= '0';
            led_medida   <= '0';

        elsif rising_edge(clk) then

            case estado is

                when IDLE =>
                    trigger    <= '0';
                    led_medida <= '0';
                    contador   <= (others => '0');
                    estado     <= TRIG;

                when TRIG =>
                    trigger    <= '1';
                    led_medida <= '1';

                    if contador < TRIG_TIME then
                        contador <= contador + 1;
                    else
                        contador <= (others => '0');
                        trigger  <= '0';
                        estado   <= WAIT_ECHO;
                    end if;

                when WAIT_ECHO =>
                    led_medida <= '1';

                    if echo = '1' then
                        echo_counter <= (others => '0');
                        estado <= MEASURE;

                    elsif contador < WAIT_TIME then
                        contador <= contador + 1;

                    else
                        contador <= (others => '0');
                        estado <= DONE;
                    end if;

                when MEASURE =>
                    led_medida <= '1';

                    if echo = '1' then
                        echo_counter <= echo_counter + 1;
                    else
                        dist_reg <= resize(echo_counter / DIV_CM, 10);
                        estado <= DONE;
                    end if;

                when DONE =>
                    led_medida <= '0';

                    if contador < WAIT_TIME then
                        contador <= contador + 1;
                    else
                        contador <= (others => '0');
                        estado <= TRIG;
                    end if;

            end case;

        end if;
    end process;

end Behavioral;