----------------------------------------------------------------------------------
-- Company: Grupo Halley 
-- Engineer: Jose Luis Salamanca Coy , Karen Juliet Forero Gutiérrez
-- 
-- Create Date:    00:35:08 12/31/2017 
-- Design Name:    Interrupcion de flanco de bajada
-- Module Name:    INTERRUPCION_B - Behavioral 
-- Project Name:   Mini-Mute
-- Target Devices: Spartan 6, Mimas V2
-- Tool versions:  2.2 
-- Description:    Este bloque entrega un bit en alto cuando detecta un flanco de bajada en la señal de entrada,
--                 dicha señal dura un ciclo de reloj de la FPGA
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity INTERRUPCION_B is
    Port ( INPUTT : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           OUPUTT : out  STD_LOGIC);
end INTERRUPCION_B;

architecture Behavioral of INTERRUPCION_B is

signal Ant_INPUTT: STD_LOGIC:='0';
signal evento: STD_LOGIC:='0';
signal s1: STD_LOGIC:='0';
begin
evento <= INPUTT xor Ant_INPUTT;  --Genera un 1 cuando hay una diferencia

process (clk)
begin
 
   if clk'event and clk='1' then  
       Ant_INPUTT <=  INPUTT ;  --Guarda la entrada anterior
   end if;
end process;

process (clk)
begin
 
   if clk'event and clk='1' then  
       s1 <=  evento;  --Retiene el evento un ciclo de reloj
   end if;
end process;


OUPUTT <= s1 AND NOT(Ant_INPUTT);  -- Asigna a la salida la interrupcion generada por el flanco de subida
-- Si se quiere detectar el flanco de bajada se debe negar a la variable "Ant_INPUTT"
end Behavioral;

