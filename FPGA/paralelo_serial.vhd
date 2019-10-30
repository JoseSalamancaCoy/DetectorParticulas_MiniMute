----------------------------------------------------------------------------------
-- Company: Grupo Halley 
-- Engineer: Jose Luis Salamanca Coy, Karen Juliet Forero Gutiérrez
-- 
-- Create Date:    03:17:06 01/05/2018 
-- Design Name:    Registro de desplazamieto, paralelo a serial
-- Module Name:    Paralelo_Serial - Behavioral 
-- Project Name:   Mini-Mute
-- Target Devices: Spartan 6, Mimas V2
-- Tool versions:  2.1
-- Description:    Este bloque corresponde a un Shift Register, se desplaza la trama de bits una posicion 
-- 					 a la izquierda(eliminando el mas significativo) y se agrega un 0 en el bit menos significativo,
--                 la salida corresponde al bit mas significativo de la trama de bits anterior(antes de la 
--                 habilitacion y flanco de subida del reloj de la FPGA) 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Paralelo_Serial is
generic (n : positive := 40);
 Port ( Paralelo_in : in  STD_LOGIC_VECTOR (n-1 downto 0);
        en_C : in  STD_LOGIC;
		  en_D : in  STD_LOGIC;
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        serial_out : out  STD_LOGIC);
end Paralelo_Serial;

architecture n_bits of Paralelo_Serial is

signal tmp: std_logic_vector(n-1 downto 0):= (others => '0');

begin

process (clk)
begin
   if clk'event and clk='1' then 
		if rst='1' then
			tmp <= (others => '0');
		elsif en_C = '1' then
			tmp <=Paralelo_in ;
		elsif en_D = '1' then 
			for i in 0 to n-2 loop
				tmp(i+1) <= tmp(i);
			end loop;
			tmp(0) <= '0';
		end if;
   end if; 
end process;
serial_out <= tmp(n-1);

end n_bits;

