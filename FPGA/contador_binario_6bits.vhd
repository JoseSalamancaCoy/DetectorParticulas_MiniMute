library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity contador_binario_6bits is
	generic (n : positive := 6);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
           cout : out  STD_LOGIC_VECTOR(n-1 downto 0));
end contador_binario_6bits;

architecture n_bits of contador_binario_6bits is
	signal q : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');
	signal d : STD_LOGIC_VECTOR(n-1 downto 0);
	
begin

sumador : d <= q+1;

registro: process(clk)
	begin 
		if rising_edge(clk) then  
			if rst = '1' then
				q <= (others => '0');
			elsif en = '1' then
				q <= d;
			end if;
		end if;
	end process;

cout <= q;



end n_bits;

