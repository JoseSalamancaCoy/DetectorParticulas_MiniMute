----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:27:56 10/02/2017 
-- Design Name: 
-- Module Name:    evento_interrupcion - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity evento_interrupcion is
    Port ( clk : in  STD_LOGIC;
           senal : in  STD_LOGIC_VECTOR (11 downto 0);
           senal_evento : out  STD_LOGIC);
end evento_interrupcion;

architecture Behavioral of evento_interrupcion is

COMPONENT INTERRUPCION_S
	PORT(
		INPUTT : IN std_logic;
		clk : IN std_logic;          
		OUPUTT : OUT std_logic
		);
	END COMPONENT;


signal ant_interrupcion: std_logic_vector(11 downto 0);
signal salida: std_logic;


begin

	Inst_INTERRUPCION_S_0: INTERRUPCION_S PORT MAP(
		INPUTT => senal(0),
		clk => clk,
		OUPUTT => ant_interrupcion(0)
	);
	
	Inst_INTERRUPCION_S_1: INTERRUPCION_S PORT MAP(
		INPUTT => senal(1),
		clk => clk,
		OUPUTT => ant_interrupcion(1)
	);
	
	Inst_INTERRUPCION_S_2: INTERRUPCION_S PORT MAP(
		INPUTT => senal(2),
		clk => clk,
		OUPUTT => ant_interrupcion(2)
	);
	
	Inst_INTERRUPCION_S_3: INTERRUPCION_S PORT MAP(
		INPUTT => senal(3),
		clk => clk,
		OUPUTT => ant_interrupcion(3)
	);
	
	Inst_INTERRUPCION_S_4: INTERRUPCION_S PORT MAP(
		INPUTT => senal(4),
		clk => clk,
		OUPUTT => ant_interrupcion(4)
	);
	
	Inst_INTERRUPCION_S_5: INTERRUPCION_S PORT MAP(
		INPUTT => senal(5),
		clk => clk,
		OUPUTT => ant_interrupcion(5)
	);
	
	Inst_INTERRUPCION_S_6: INTERRUPCION_S PORT MAP(
		INPUTT => senal(6),
		clk => clk,
		OUPUTT => ant_interrupcion(6)
	);
	
	Inst_INTERRUPCION_S_7: INTERRUPCION_S PORT MAP(
		INPUTT => senal(7),
		clk => clk,
		OUPUTT => ant_interrupcion(7)
	);
	
	Inst_INTERRUPCION_S_8: INTERRUPCION_S PORT MAP(
		INPUTT => senal(8),
		clk => clk,
		OUPUTT => ant_interrupcion(8)
	);
	
	Inst_INTERRUPCION_S_9: INTERRUPCION_S PORT MAP(
		INPUTT => senal(9),
		clk => clk,
		OUPUTT => ant_interrupcion(9)
	);
	
	Inst_INTERRUPCION_S_10: INTERRUPCION_S PORT MAP(
		INPUTT => senal(10),
		clk => clk,
		OUPUTT => ant_interrupcion(10)
	);
	
	Inst_INTERRUPCION_S_11: INTERRUPCION_S PORT MAP(
		INPUTT => senal(11),
		clk => clk,
		OUPUTT => ant_interrupcion(11)
	);
	
	salida<= ant_interrupcion(0) or ant_interrupcion(1) or ant_interrupcion(2) or ant_interrupcion(3) or ant_interrupcion(4) or ant_interrupcion(5) or ant_interrupcion(6) or ant_interrupcion(7) or ant_interrupcion(8) or ant_interrupcion(9) or ant_interrupcion(10) or ant_interrupcion(11);
   senal_evento<= salida;
end Behavioral;

