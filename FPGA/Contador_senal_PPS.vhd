----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:52:47 10/02/2017 
-- Design Name: 
-- Module Name:    Contador_senal_PPS - Behavioral 
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

entity Contador_senal_PPS is
    Port ( en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (26 downto 0));
end Contador_senal_PPS;

architecture Behavioral of Contador_senal_PPS is
	COMPONENT interrupcio
	PORT(
		clk : IN std_logic;
		Senal : IN std_logic;          
		interrupcion : OUT std_logic
		);
	END COMPONENT;
	
	signal q : STD_LOGIC_VECTOR (26 downto 0) := (others => '0');
	signal d : STD_LOGIC_VECTOR (26 downto 0);
	signal interrupcion_rst: STD_LOGIC;
   signal bug_clock: std_logic:='1';
   signal salida :std_logic:='0';
	signal Comparador : STD_LOGIC;
begin

Sumador : d <= q+1 when Comparador='0' else "000000000000000000000000000" ;
Comparacion : Comparador <= '1' when q>="101111101011110000100000000" else '0';
   process (clk)
    begin
       if clk'event and clk='1' then 
			 if ((rst xor salida)and rst and bug_clock) = '1' then 
					salida <= '1';
					bug_clock<='0';
			  else 
					salida <= '0';
			  end if;
			  if (not(rst) and not(salida))= '1' then 
					bug_clock<='1';
			  end if; 
		 end if;
    end process;	

	
	
registro: process(clk)
	begin 
		if rising_edge(clk) then 
			if salida = '1' then
				q <= (others => '0');
			elsif en = '1' then
				q <= d;
			else 
				q <= q;
			end if;
		end if;
	end process;
	
count<= q;
end Behavioral;

