----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:26:59 01/17/2018 
-- Design Name: 
-- Module Name:    Contadores_Y_Despliegue - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;

entity Contadores_Y_Despliegue is
Port ( en_Eventos : in  STD_LOGIC;
		 en_Errores : in  STD_LOGIC;
		 Selector : in  STD_LOGIC;
       rst : in  STD_LOGIC;
       clk : in  STD_LOGIC;
		 num_Eventos : out  STD_LOGIC_VECTOR (38 downto 0);
		 num_Errores : out  STD_LOGIC_VECTOR (38 downto 0);
       numero : out  STD_LOGIC_VECTOR (7 downto 0);
       digito : out  STD_LOGIC_VECTOR (2 downto 0);
       leds : out  STD_LOGIC_VECTOR (7 downto 0));

end Contadores_Y_Despliegue;

architecture Behavioral of Contadores_Y_Despliegue is

COMPONENT Contador_Display_Leds
	PORT(
		en : IN std_logic;
		rst : IN std_logic;
		clk : IN std_logic;          
		numero : OUT std_logic_vector(7 downto 0);
		digito : OUT std_logic_vector(2 downto 0);
		leds : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

signal numero_Eventos : std_logic_vector(7 downto 0);
signal digito_Eventos : std_logic_vector(2 downto 0);
signal leds_Eventos : std_logic_vector(7 downto 0);

signal numero_Errores : std_logic_vector(7 downto 0);
signal digito_Errores : std_logic_vector(2 downto 0);
signal leds_Errores : std_logic_vector(7 downto 0);


begin
---- Multiplexores -------------------------------------------
numero <= numero_Eventos when Selector = '0' else numero_Errores;
digito <= digito_Eventos when Selector = '0' else digito_Errores;
leds <= leds_Eventos when Selector = '0' else leds_Errores;

--------------------------------------------------------------

Inst_Contador_Display_Leds_Eventos: Contador_Display_Leds PORT MAP(
		en => en_Eventos,
		rst => rst,
		clk => clk,
		numero => numero_Eventos,
		digito => digito_Eventos,
		leds => leds_Eventos
	);
	

Inst_Contador_Display_Leds_Errores: Contador_Display_Leds PORT MAP(
		en => en_Errores,
		rst => rst,
		clk => clk,
		numero => numero_Errores,
		digito => digito_Errores,
		leds => leds_Errores
	);
	
	
num_Eventos(15 downto 0) <= numero_Eventos & leds_Eventos;
num_Eventos(38 downto 16) <= "00000000000000000000000";


num_Errores(15 downto 0) <= numero_Errores & leds_Errores;
num_Errores(38 downto 16) <= "00000000000000000000000";


end Behavioral;

