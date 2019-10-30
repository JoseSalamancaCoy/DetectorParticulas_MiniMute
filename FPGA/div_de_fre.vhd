library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity div_de_fre is
	generic (n : positive := 13);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           max_cnt : in  STD_LOGIC_VECTOR (n-1 downto 0);
           clk_out : out  STD_LOGIC
			  );
end div_de_fre;

architecture modulo_variable of div_de_fre is
 signal q : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');
 signal compara : STD_LOGIC;
 signal mas1, d : STD_LOGIC_VECTOR (n-1 downto 0);
 
begin
comparador : compara <= '1' when q >= max_cnt else '0';
sumador : mas1 <= q +1;
mux_d : d <= mas1 when compara = '0' else (others => '0');

registro: process (clock)
			 begin 
				if rising_edge(clock) then 
					if reset = '1' then
						q <= (others => '0');
					elsif enable = '1' then
						q <= d;
					end if;
				end if;
			end process;

salidas : clk_out <= compara;

end modulo_variable;
