----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:19:42 04/09/2017 
-- Design Name: 
-- Module Name:    cont_5ms_max4 - Behavioral 
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

entity cont_5ms_max4 is
    Port ( clk : in  STD_LOGIC;
           ENABLE : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           OUT_CONT_MAX4 : out  STD_LOGIC_VECTOR (1 downto 0));
end cont_5ms_max4;

architecture Behavioral of cont_5ms_max4 is

	
	COMPONENT div_de_fre
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;
		max_cnt : IN std_logic_vector(12 downto 0);          
		clk_out : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT contador_binario
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;          
		cout : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;




	
	--SEALES
signal CLOCK_5mS : STD_LOGIC;

begin

	Inst_contador_binario: contador_binario PORT MAP(
		clock => CLK,
		reset => RST,
		enable => CLOCK_5mS,
		cout => OUT_CONT_MAX4
	);
	
Inst_div_de_fre: div_de_fre PORT MAP(
		clock =>CLK ,
		reset =>RST ,
		enable => ENABLE,						
		max_cnt => "1001110001000",		
		clk_out => CLOCK_5mS 
	);
	
	
end Behavioral;

