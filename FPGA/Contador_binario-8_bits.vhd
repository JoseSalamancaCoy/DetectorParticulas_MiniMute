----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:44 01/03/2018 
-- Design Name: 
-- Module Name:    Contador_binario-8_bits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity contador_binario_8bits is
	generic (n : positive := 8);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           cout : out  STD_LOGIC_VECTOR (n-1 downto 0));
end contador_binario_8bits;

architecture n_bits of contador_binario_8bits is
	signal q : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');
	signal d : STD_LOGIC_VECTOR (n-1 downto 0);

begin

sumador : d <= q+1;
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


