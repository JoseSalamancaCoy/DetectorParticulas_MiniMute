----------------------------------------------------------------------------------
-- Company: Grupo Halley 
-- Engineer: Jose Luis Salamanca Coy ,  Karen Juliet Forero Gutiérrez
-- 
-- Create Date:    17:32:35 01/05/2018 
-- Design Name:    SPI Slave
-- Module Name:    SPI_SLAVE_R_W_ - Behavioral 
-- Project Name:   Mini-Mute
-- Target Devices: Spartan 6, Mimas V2
-- Tool versions:  3.2
-- Description:  Este bloque corresponde a la transmicion y recepcion del protocolo SPI y tiene la capacidad de:
--               1) Transformar una estrada paralelo en una salida serial, eliminando el bit mas significativo. 
--               2) Calcular el numero correspondiente al Checksum y añadirlo al final de la trama de transmision Serial 
--					  3) Entregar un vector(bits en paralelo) apartir de una entrada Serial, donde el primer bit serial sera el mas significativo de la salida
--               4) Verificar el Checksum del mensaje para definir si los bits llegaron correctamente.
--					  5) Entrega el numero de bits recibidos y transmitidos. 
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
    
entity SPI_SLAVE_R_W is
    Port ( EN : in  STD_LOGIC;
			  Paralelo_MISO : in  STD_LOGIC_VECTOR (39 downto 0);
           MOSI : in  STD_LOGIC;
           clk_SPI : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           MISO : out  STD_LOGIC;
			  bussy : out STD_LOGIC_VECTOR(1 downto 0);
			  RTA_Checksum_R : out std_logic;
           Paralelo_MOSI : out  STD_LOGIC_VECTOR (8 downto 0));
end SPI_SLAVE_R_W;

architecture Behavioral of SPI_SLAVE_R_W is

COMPONENT INTERRUPCION_S
	PORT(
		INPUTT : IN std_logic;
		clk : IN std_logic;          
		OUPUTT : OUT std_logic
		);
	END COMPONENT;

COMPONENT Maquina_SPI_SLAVE
	PORT(
		EN_R : IN std_logic;
		EN_W : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;          
		En_Serial_Paralelo : OUT std_logic;
		En_C_W : OUT std_logic;
		En_D_W : OUT std_logic;
		Rst_cont_bits : OUT std_logic
		);
	END COMPONENT; 

COMPONENT Paralelo_Serial
	PORT(
		Paralelo_in : IN std_logic_vector(39 downto 0);
		en_C : IN std_logic;
		en_D : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;          
		serial_out : OUT std_logic
		);
	END COMPONENT;

COMPONENT Serial_Paralelo
	PORT(
		serial_in : IN std_logic;
		en : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;          
		paralelo_out : OUT std_logic_vector(8 downto 0)
		);
	END COMPONENT;

COMPONENT INTERRUPCION_B
	PORT(
		INPUTT : IN std_logic;
		clk : IN std_logic;          
		OUPUTT : OUT std_logic
		);
	END COMPONENT;


	COMPONENT contador_binario_6bits
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		en : IN std_logic;          
		cout : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;





	COMPONENT Checksum_sistem
	PORT(
		cont_bits : IN std_logic_vector(5 downto 0);
		Interrup_clk_SPI_S : IN std_logic;
		Interrup_clk_SPI_B : IN std_logic;
		In_R : IN std_logic;
		In_W : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;          
		C_Cks_W : OUT std_logic;
		Checksum_W : OUT std_logic_vector(5 downto 0);
		Checksum_R : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	


	


signal EN_R : std_logic;
signal EN_W : std_logic;
signal EN_W_1 : std_logic;
signal En_Serial_Paralelo : std_logic; 	 	--Señal para habilita el bloque serial a paralelo, desde la maquina de estados.
signal En_C_W : std_logic;              	 	--Carga bits al registro de desplazamiento
signal En_C_Cks_W : std_logic; 					--Carga bits al registro de dezplazamiento, tanto los del mensaje como los del cks
signal C_Cks_W : std_logic;                  --Señal para cargar el Checksum
signal En_D_W : std_logic;              	 	--Señal para desplazar bits en paralelo.
signal Rst_cont_bits : std_logic;       	 	--Reinicia el contador de bits SPI
signal EN_R_or_W : std_logic;           	 	--Esta señal se utiliza para el Enable del contador de bits SPI en los flancos de bajada del reloj
signal CLK_SPI_2:std_logic;             	 	--Señal de reloj SPI despues del primer flip flop tipo D
signal CLK_SPI_3:std_logic;             	 	--Señal de reloj SPI despues del segundo flip flop tipo D
signal Interrup_Reloj_SPI_S :std_logic; 	 	--Señal correspondiente al flanco de subida del Reloj SPI
signal Interrup_Reloj_SPI_B :std_logic; 	 	--Señal correspondiente al flanco de bajada del Reloj SPI
signal En_Serial_Paralelo_Interrup : std_logic;		--Habilita el bloque serial a paralelo, cuando hay un flanco de subida del reloj SPI
signal En_D_W_Interrup : std_logic;          --Desplaza bits en paralelo cada Flanco de subida del reloj SPI, eliminando el mas significativo.
signal signal_MISO : std_logic;         		--Salida MISO del protocolo SPI
signal cont_bits : std_logic_vector(5 downto 0);	--Señal correspondiente al conteo de bits
signal signal_Checksum_W : std_logic_vector(5 downto 0); --Señal correspondiente al Checksum de la transmicion
signal signal_Checksum_R : std_logic_vector(2 downto 0); --Señal correspondiente al Checksum de la recepcion
signal Paralelo_MISO_CHECKSUM : STD_LOGIC_VECTOR (39 downto 0);
signal signal_Checksum_total : STD_LOGIC_VECTOR (39 downto 0):= (others => '0');
signal signal_Paralelo_MOSI : STD_LOGIC_VECTOR(8 DOWNTO 0);




--signal Paralelo_MISO : STD_LOGIC_VECTOR (38 downto 0);
begin

signal_Checksum_total(39 downto 34)<= signal_Checksum_W;
signal_Checksum_total(33 downto 0) <= "0000000000000000000000000000000000";

---- operaciones logicas -------------
EN_R <= '1' when (EN='0' and (cont_bits < "001001")) else '0';

EN_W <= '1' when (EN='0' and (cont_bits >="001001" and cont_bits <="110101")) else '0'; 

EN_R_or_W <= (En_D_W or En_Serial_Paralelo) and Interrup_Reloj_SPI_B; 

En_Serial_Paralelo_Interrup <= En_Serial_Paralelo and Interrup_Reloj_SPI_S;

En_D_W_Interrup <= En_D_W and Interrup_Reloj_SPI_S;

En_C_Cks_W <= C_Cks_W or En_C_W;
--------------------------------------

---- selector_Paralelo_Serial --------
Paralelo_MISO_CHECKSUM <= Paralelo_MISO when C_Cks_W='0' else signal_Checksum_total;

--------------------------------------


--Paralelo_MISO <= "111111111111110001111111011111111011001";
---- Conexiones bloques --------------
process (clk)
begin
   if clk'event and clk='1' then  
      CLK_SPI_2 <= CLK_SPI;
   end if;
end process;

process (clk)
begin
   if clk'event and clk='1' then  
      CLK_SPI_3 <= CLK_SPI_2;
   end if;
end process;

process (clk)
begin
   if clk'event and clk='1' then  
      EN_W_1 <= EN_W;
   end if;
end process;
	Inst_INTERRUPCION_S: INTERRUPCION_S PORT MAP(
		INPUTT => CLK_SPI_3,
		clk => clk,
		OUPUTT => Interrup_Reloj_SPI_S
	);
	
	
	Inst_INTERRUPCION_B: INTERRUPCION_B PORT MAP(
		INPUTT => CLK_SPI_3,
		clk =>  clk,
		OUPUTT => Interrup_Reloj_SPI_B
	);
Inst_Maquina_SPI_SLAVE: Maquina_SPI_SLAVE PORT MAP(
		EN_R => EN_R,
		EN_W => EN_W_1,
		clk => clk,
		rst => rst ,
		En_Serial_Paralelo => En_Serial_Paralelo,
		En_C_W => En_C_W,
		En_D_W => En_D_W,
		Rst_cont_bits => Rst_cont_bits
	);

Inst_Paralelo_Serial: Paralelo_Serial PORT MAP(
		Paralelo_in => Paralelo_MISO_CHECKSUM,
		en_C => En_C_Cks_W,
		en_D => En_D_W_Interrup,
		clk => clk,
		rst => rst,
		serial_out => signal_MISO 
	);

Inst_Serial_Paralelo: Serial_Paralelo PORT MAP(
		serial_in => MOSI,
		en => En_Serial_Paralelo_Interrup,
		clk => clk,
		rst => rst,
		paralelo_out => signal_Paralelo_MOSI
	);	
	 
	
	Inst_contador_binario_6bits: contador_binario_6bits PORT MAP(
		clk => clk,
		rst => rst,
		en => EN_R_or_W,
		cout => cont_bits
	);
	
Inst_Checksum_sistem: Checksum_sistem PORT MAP(
		cont_bits => cont_bits,
	   Interrup_clk_SPI_S => Interrup_Reloj_SPI_S,
		Interrup_clk_SPI_B => Interrup_Reloj_SPI_B,
		In_R => MOSI,
		In_W => signal_MISO,
		clk => clk,
		rst => rst,
		C_Cks_W => C_Cks_W,
		Checksum_W => signal_Checksum_W,
		Checksum_R => signal_Checksum_R
	);
	
------------------------------------------


---- Asignacion Salidas ------------------
MISO <= signal_MISO;
bussy(1) <= EN_R;
bussy(0) <= EN_W;
RTA_Checksum_R <= '1' when signal_Checksum_R = signal_Paralelo_MOSI(2 downto 0) else '0';
Paralelo_MOSI <= signal_Paralelo_MOSI;
------------------------------------------
end Behavioral;

