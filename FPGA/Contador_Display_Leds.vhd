----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:13:58 01/03/2018 
-- Design Name: 
-- Module Name:    Contador_Display_Leds - Behavioral 
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

entity Contador_Display_Leds is
    Port ( en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           numero : out  STD_LOGIC_VECTOR (7 downto 0);
           digito : out  STD_LOGIC_VECTOR (2 downto 0);
           leds : out  STD_LOGIC_VECTOR (7 downto 0));
end Contador_Display_Leds;

architecture Behavioral of Contador_Display_Leds is
	COMPONENT MAC_cout
	PORT(
		en : IN std_logic;
		Max_U : IN std_logic;
		Max_D : IN std_logic;
		Max_C : IN std_logic;
		rst : IN std_logic;
		clk : IN std_logic;          
		en_U : OUT std_logic;
		rst_U : OUT std_logic; 
		en_D : OUT std_logic;
		rst_D : OUT std_logic;
		en_C : OUT std_logic;
		rst_C : OUT std_logic;
		en_M : OUT std_logic;
		rst_M : OUT std_logic
		);
	END COMPONENT;

	
		COMPONENT cont_5ms_max4
	PORT(
		clk : IN std_logic;
		ENABLE : IN std_logic;
		RST : IN std_logic;          
		OUT_CONT_MAX4 : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
COMPONENT contador_binario_4bits
	PORT(
		clock : IN std_logic;
		rst : IN std_logic;
		en : IN std_logic;          
		max_count : OUT std_logic;
		cout : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	


	
	COMPONENT contador_binario_8bits
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;          
		cout : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;




signal Max_U : std_logic;
signal Max_D : std_logic;
signal Max_C : std_logic;
signal en_U : std_logic;
signal rst_U : std_logic;
signal en_D : std_logic;
signal rst_D : std_logic;
signal en_C : std_logic;
signal rst_C : std_logic;
signal en_M : std_logic;
signal rst_M : std_logic;
signal ant_numero: std_logic_vector(3 downto 0);
signal CONT_MAX4 : std_logic_vector(1 downto 0);
signal UNIDADES : std_logic_vector(3 downto 0); 
signal DECENAS : std_logic_vector(3 downto 0);
signal CENTENAS : std_logic_vector(3 downto 0);

begin


Inst_MAC_cout: MAC_cout PORT MAP(
		en => en,
		Max_U => Max_U,
		Max_D => Max_D,
		Max_C => Max_C,
		rst => rst,
		clk => clk,
		en_U => en_U,
		rst_U => rst_U,
		en_D => en_D,
		rst_D => rst_D,
		en_C => en_C,
		rst_C => rst_C,
		en_M => en_M,
		rst_M => rst_M
	);

	Inst_cont_5ms_max4: cont_5ms_max4 PORT MAP(
		clk => clk,
		ENABLE => '1',
		RST => rst,
		OUT_CONT_MAX4 => CONT_MAX4 
	);
	
	
   Inst_contador_binario_4bits_UNIDADES: contador_binario_4bits PORT MAP(
		clock => clk,
		rst => rst_U,
		en => en_U,
		max_count => Max_U,
		cout => UNIDADES
	);
   
	
	  Inst_contador_binario_4bits_DECENAS: contador_binario_4bits PORT MAP(
		clock => clk,
		rst => rst_D,
		en => en_D,
		max_count => Max_D,
		cout => DECENAS
	);
	
	  Inst_contador_binario_4bits_CENTENAS: contador_binario_4bits PORT MAP(
		clock => clk,
		rst => rst_C,
		en => en_C,
		max_count => Max_C,
		cout => CENTENAS
	);

	Inst_contador_binario_8bits: contador_binario_8bits PORT MAP(
		clock => clk,
		reset => rst_M,
		enable => en_M,
		cout => leds
	);

with ant_numero  select
      numero<= "00000011" when "0000",
					"10011111" when "0001",
					"00100101" when "0010",
					"00001101" when "0011",
					"10011001" when "0100",
					"01001001" when "0101",
					"01000001" when "0110",
					"00011111" when "0111",
					"00000001" when "1000",
					"00011001" when "1001",
               "11111111" when others;

with CONT_MAX4  select
      ant_numero <= CENTENAS when "00",
                    DECENAS when "01",
					     UNIDADES when "10",
                    "0000" when others;

with CONT_MAX4  select
      digito <= "011" when "00",
                "101" when "01",
					 "110" when "10",
                "111" when others;
					 
					 
end Behavioral;

