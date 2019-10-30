library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity contador_binario is
	generic (n : positive := 2);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           cout : out  STD_LOGIC_VECTOR (n-1 downto 0));
end contador_binario;

architecture n_bits of contador_binario is
	
	signal q : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');
	signal mas1,d : STD_LOGIC_VECTOR (n-1 downto 0);
   signal compara : STD_LOGIC;
begin

comparador : compara <= '1' when q = "10" else '0';
sumador : mas1 <= q +1;
mux_d : d <= mas1 when compara = '0' else (others => '0');


registro: process(clock)
	begin 
		if rising_edge(clock) then 
			if reset = '1' then
				q <= (others => '0');
			elsif enable = '1' then
				q <= d;
			else 
				q <= q;
			end if;
		end if;
	end process;
	
salidas : cout <= q;

end n_bits;

