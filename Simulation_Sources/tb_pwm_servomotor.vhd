library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_pwm_servomotor is
end tb_pwm_servomotor;

architecture Behavioral of tb_pwm_servomotor is

    component pwm_servomotor
        Port (
            clk     : in  STD_LOGIC;
            reset   : in  STD_LOGIC;
            angulo  : in  unsigned(7 downto 0);
            pwm_out : out STD_LOGIC
        );
    end component;

    signal clk     : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '1';
    signal angulo  : unsigned(7 downto 0) := (others => '0');
    signal pwm_out : STD_LOGIC;

begin

    UUT: pwm_servomotor
        port map(
            clk     => clk,
            reset   => reset,
            angulo  => angulo,
            pwm_out => pwm_out
        );

    clk <= not clk after 5 ns;

    process
    begin
        -- Reset activo al inicio
        reset  <= '1';
        angulo <= to_unsigned(0, 8);
        wait for 200 ns;

        -- Soltar reset
        reset <= '0';

        -- Angulo 0° → pw=100000 → pulso 1 ms
        angulo <= to_unsigned(0, 8);
        wait for 2 ms;

        -- Angulo 90° → pw=150000 → pulso 1.5 ms
        angulo <= to_unsigned(90, 8);
        wait for 2 ms;

        -- Angulo 180° → pw=200000 → pulso 2 ms
        angulo <= to_unsigned(180, 8);
        wait for 2 ms;

        wait;
    end process;

end Behavioral;