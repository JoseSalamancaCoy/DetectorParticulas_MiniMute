----------------------------------------------------------------------------------
-- Company: Grupo Halley 
-- Engineer: Jose Luis Salamanca Coy, Karen Juliet Forero Gutiérrez
-- 
-- Create Date:    18:40:20 01/05/2018 
-- Design Name:    Checksum
-- Module Name:    Checksum - Behavioral 
-- Project Name:   Mini-Mute
-- Target Devices: Spartan 6,Mimas V2
-- Tool versions:  1.3
-- Description:    Si este bloque es habilitado: cada flanco de reloj suma en 1 su salida si la entrada es un '1', 
--						 si es un '0' la salida se mantiene constante. De esta manera despues de n ciclos de reloj la 
--                 salida de este bloque correspondra a la sumatoria de cada uno de los bits de la trama de n numeros
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

entity Checksum is
	 generic (n : positive := 6);
    Port ( sum_in : in  STD_LOGIC;
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           sum_out : out  STD_LOGIC_VECTOR (n-1 downto 0));
end Checksum;

architecture Behavioral of Checksum is
	signal q : STD_LOGIC_VECTOR (n-1 downto 0) := (others => '0');
	signal d : STD_LOGIC_VECTOR (n-1 downto 0);
begin

sumador : d <= q + 1 when sum_in='1' else q;

 
registro: process(clk)
	begin 
		if rising_edge(clk) then 
			if rst = '1' then
				q <= (others => '0');
			elsif en = '1' then
				q <= d;
			else 
				q <= q;
			end if;
		end if;
	end process;
	
salidas : sum_out <= q;



end Behavioral;

