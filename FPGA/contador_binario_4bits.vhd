library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity contador_binario_4bits is
	generic (n : positive := 4);
    Port ( clock : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
			  max_count : out STD_LOGIC;
           cout : out  STD_LOGIC_VECTOR (n-1 downto 0));
end contador_binario_4bits;

architecture n_bits of contador_binario_4bits is
	signal q : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');
	signal d : STD_LOGIC_VECTOR (n-1 downto 0);

begin

sumador : d <= q+1;

comparacion : max_count <=  '0' when q < "1001" else '1';

registro: process(clock)
	begin 
		if rising_edge(clock) then 
			if rst = '1' then
				q <= (others => '0');
			elsif en = '1' then
				q <= d;
			else 
				q <= q;
			end if;
		end if;
	end process;
	
salidas : cout <= q;

end n_bits;

