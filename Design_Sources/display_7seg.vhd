library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display_7seg is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        sw_sel    : in  STD_LOGIC;
        distancia : in  unsigned(9 downto 0);
        angulo    : in  unsigned(7 downto 0);
        seg       : out std_logic_vector(6 downto 0);
        anodo     : out std_logic_vector(3 downto 0)
    );
end display_7seg;

architecture Behavioral of display_7seg is

    signal cnt_ref : integer range 0 to 99999     := 0;
    signal cnt_alt : integer range 0 to 200000000 := 0;
    signal digito  : integer range 0 to 3         := 0;

    signal mostrar_angulo : std_logic := '0';
    signal valor   : integer range 0 to 1023 := 0;
    signal bcd_act : integer range 0 to 9    := 0;

begin

    valor <= to_integer(angulo)    when (sw_sel='1' or mostrar_angulo='1')
        else to_integer(distancia);

    bcd_act <= (valor / 1000)            when digito = 3 else
               (valor mod 1000) / 100    when digito = 2 else
               (valor mod 100)  / 10     when digito = 1 else
               (valor mod 10);

    with bcd_act select
        seg <= "0000001" when 0,
               "1001111" when 1,
               "0010010" when 2,
               "0000110" when 3,
               "1001100" when 4,
               "0100100" when 5,
               "0100000" when 6,
               "0001111" when 7,
               "0000000" when 8,
               "0000100" when 9,
               "1111111" when others;

    process(clk, reset)
    begin
        if reset = '1' then
            cnt_ref        <= 0;
            cnt_alt        <= 0;
            digito         <= 0;
            mostrar_angulo <= '0';
            anodo          <= "1110";

        elsif rising_edge(clk) then

            if sw_sel = '1' then
                mostrar_angulo <= '1';
                cnt_alt        <= 0;
            else
                if cnt_alt = 200000000 then
                    cnt_alt        <= 0;
                    mostrar_angulo <= not mostrar_angulo;
                else
                    cnt_alt <= cnt_alt + 1;
                end if;
            end if;

            if cnt_ref = 99999 then
                cnt_ref <= 0;
                if digito = 3 then digito <= 0;
                else digito <= digito + 1;
                end if;
            else
                cnt_ref <= cnt_ref + 1;
            end if;

            -- 4 ánodos activos
            case digito is
                when 0 => anodo <= "1110"; -- unidades
                when 1 => anodo <= "1101"; -- decenas
                when 2 => anodo <= "1011"; -- centenas
                when 3 => anodo <= "0111"; -- miles
                when others => anodo <= "1111";
            end case;

        end if;
    end process;

end Behavioral;