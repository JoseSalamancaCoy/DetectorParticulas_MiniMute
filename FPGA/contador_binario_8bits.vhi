
-- VHDL Instantiation Created from source file contador_binario_8bits.vhd -- 01:04:19 01/18/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT contador_binario_8bits
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;          
		cout : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_contador_binario_8bits: contador_binario_8bits PORT MAP(
		clock => ,
		reset => ,
		enable => ,
		cout => 
	);


