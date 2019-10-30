----------------------------------------------------------------------------------
-- Company: Grupo Halley 
-- Engineer: Jose Luis Salamanca Coy, Karen Juliet Forero Gutiérrez


-- Create Date:    02:44:38 01/05/2018 
-- Design Name:    Registro de desplazamieto, serial a paralelo
-- Module Name:    Serial_Paralelo - Behavioral 
-- Project Name:   Mini-Mute 
-- Target Devices: Spartan 6, Mimas V2
-- Tool versions:  1.2
-- Description:    Este bloque corresponde a un Shift Register, se desplaza la trama de bits una posicion 
-- 					 a la izquierda(eliminando el mas significativo) y se agrega el bit de la entrada en la
--                 posicion menos significativa, la salida corresponde a la trama de bits anterior(antes 
--						 de la habilitacion y flanco de subida del reloj de la FPGA)
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

entity Serial_Paralelo is
    Port ( serial_in : in  STD_LOGIC;
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           paralelo_out : out  STD_LOGIC_VECTOR (8 downto 0));
end Serial_Paralelo;

architecture Behavioral of Serial_Paralelo is
  signal tmp: std_logic_vector(8 downto 0):= (others => '0');
begin

    process (clk)
    begin
        if (clk'event and clk='1') then
				if (rst='1') then
					tmp <=(others => '0');
				elsif (en='1') then
					for i in 0 to 7 loop
						 tmp(i+1) <= tmp(i);
					end loop; 
					tmp(0) <= serial_in;
				end if;
        end if;
    end process;

    paralelo_out <= tmp;


end Behavioral;

