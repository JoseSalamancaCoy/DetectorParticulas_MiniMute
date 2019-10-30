----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:32 01/17/2018 
-- Design Name: 
-- Module Name:    Mini_Mute_FPGA - Behavioral 
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

entity Mini_Mute_FPGA is
    Port ( Particulas : in  STD_LOGIC_VECTOR (11 downto 0);
           PPS : in  STD_LOGIC;
           MOSI : in  STD_LOGIC;
           CS_SPI : in  STD_LOGIC;
           CLK_SPI : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Evento_Particula : out  STD_LOGIC ;
           MISO : out  STD_LOGIC;
           numero : out  STD_LOGIC_VECTOR (7 downto 0);
           digito : out  STD_LOGIC_VECTOR (2 downto 0);
           leds : out  STD_LOGIC_VECTOR (7 downto 0));
end Mini_Mute_FPGA;

architecture Behavioral of Mini_Mute_FPGA is


COMPONENT SPI_SLAVE_R_W
	PORT(
		EN : IN std_logic;
		Paralelo_MISO : IN std_logic_vector(39 downto 0);
		MOSI : IN std_logic;
		clk_SPI : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;          
		MISO : OUT std_logic;
		bussy : OUT std_logic_vector(1 downto 0);
		RTA_Checksum_R : OUT std_logic;
		Paralelo_MOSI : OUT std_logic_vector(8 downto 0)
		);
	END COMPONENT;
 
	
	COMPONENT Contadores_Y_Despliegue
	PORT(
		en_Eventos : IN std_logic;
		en_Errores : IN std_logic;
		Selector : IN std_logic;
		rst : IN std_logic;
		clk : IN std_logic;          
		num_Eventos : OUT std_logic_vector(38 downto 0);
		num_Errores : OUT std_logic_vector(38 downto 0);
		numero : OUT std_logic_vector(7 downto 0);
		digito : OUT std_logic_vector(2 downto 0);
		leds : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	

	
	COMPONENT Banco_de_memorias
	PORT(
		Particulas : IN std_logic_vector(11 downto 0);
		Cont_Particulas : IN std_logic_vector(38 downto 0);
		Cont_Errores : IN std_logic_vector(38 downto 0);
		Sel_Funcion : IN std_logic_vector(1 downto 0);
		Addr_R : IN std_logic_vector(4 downto 0);
		PPS : IN std_logic;
		En_cont_RST_RAM : IN std_logic;
		RST_cont_RST_RAM : IN std_logic;
		RST_Addr_W : IN std_logic;
		NULL_Particulas : IN std_logic;
		RST_PPS : IN std_logic;
		WE : IN std_logic;
		clk : IN std_logic;          
		Data_Out : OUT std_logic_vector(39 downto 0);
		Evento_Particulas : OUT std_logic;
		Max_addr_W_Particulas : OUT std_logic;
	   Max_TIME : out STD_LOGIC;
		Max_addr_RST_RAM : OUT std_logic
		);
	END COMPONENT;

	
	
	COMPONENT Gestion_Funciones_Mini_Mute_FPGA
	PORT(
		CS_SPI : IN std_logic;
		bussy_SPI : IN std_logic_vector(1 downto 0);
		RTA_SPI : IN std_logic;
		Max_addr_W_Pos : IN std_logic;
		Max_addr_RST_RAM : IN std_logic;
		Evento_Particula : IN std_logic;
		Saturacion_Time : IN std_logic;
		bits_Funcion : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;          
		Sel_Funcion : OUT std_logic_vector(1 downto 0);
		En_Cont_RST_RAM : OUT std_logic;
		RST_cont_RST_RAM : OUT std_logic;
		RST_addr_W_RAM : OUT std_logic;
		Null_Particulas : OUT std_logic;
		RST_TIME : OUT std_logic;
		WE_RAM : OUT std_logic;
		EN_SPI : OUT std_logic;
		RST_SPI : OUT std_logic;
		EN_Error : OUT std_logic;
		RST_CONT_PARTICULAS_ERRORES : OUT std_logic;
		Despliegue_numEventos_numErrores : OUT std_logic
		);
	END COMPONENT;

	
	
	
	
	

Signal bussy_SPI : std_logic_vector(1 downto 0):= (others => '0');
Signal RTA_SPI : std_logic;
Signal Max_addr_W_Pos : std_logic;
Signal Max_addr_RST_RAM : std_logic;
Signal signal_Evento_Particula : std_logic := '0';
Signal Saturacion_Time : std_logic;
Signal Sel_Funcion : std_logic_vector(1 downto 0):= (others => '0');
Signal En_Cont_RST_RAM : std_logic;
Signal RST_cont_RST_RAM : std_logic;
Signal RST_addr_W_RAM : std_logic;
Signal Null_Particulas : std_logic;
Signal RST_TIME : std_logic;
Signal WE_RAM : std_logic;
Signal EN_SPI : std_logic;
Signal RST_SPI : std_logic;
Signal EN_Error : std_logic;
Signal RST_CONT_PARTICULAS_ERRORES : std_logic;
Signal Despliegue_numEventos_numErrores : std_logic;


Signal num_Errores: std_logic_vector(38 downto 0):= (others => '0');
Signal num_Eventos: std_logic_vector(38 downto 0):= (others => '0');

Signal out_RAM_in_SPI : std_logic_vector(39 downto 0):= (others => '0');

Signal Paralelo_MOSI : std_logic_vector(8 downto 0):= (others => '0');

begin



Inst_Gestion_Funciones_Mini_Mute_FPGA: Gestion_Funciones_Mini_Mute_FPGA PORT MAP(
		CS_SPI => CS_SPI,
		bussy_SPI => bussy_SPI,
		RTA_SPI => RTA_SPI,
		Max_addr_W_Pos => Max_addr_W_Pos,
		Max_addr_RST_RAM => Max_addr_RST_RAM,
		Evento_Particula => signal_Evento_Particula,
		Saturacion_Time => Saturacion_Time,
		bits_Funcion => Paralelo_MOSI(8 downto 3),
		rst => '0',
		clk => clk,
		Sel_Funcion => Sel_Funcion,
		En_Cont_RST_RAM => En_Cont_RST_RAM,
		RST_cont_RST_RAM => RST_cont_RST_RAM,
		RST_addr_W_RAM => RST_addr_W_RAM,
		Null_Particulas => Null_Particulas,
		RST_TIME => RST_TIME,
		WE_RAM => WE_RAM,
		EN_SPI => EN_SPI,
		RST_SPI => RST_SPI,
		EN_Error => EN_Error,
		RST_CONT_PARTICULAS_ERRORES => RST_CONT_PARTICULAS_ERRORES,
		Despliegue_numEventos_numErrores => Despliegue_numEventos_numErrores
	);



Inst_Banco_de_memorias: Banco_de_memorias PORT MAP(
		Particulas => Particulas,
		Cont_Particulas => num_Eventos,
		Cont_Errores => num_Errores,
		Sel_Funcion => Sel_Funcion,
		Addr_R => Paralelo_MOSI(7 downto 3),
		PPS => PPS,
		En_cont_RST_RAM => En_Cont_RST_RAM,
		RST_cont_RST_RAM => RST_cont_RST_RAM,
		RST_Addr_W => RST_addr_W_RAM,
		NULL_Particulas => Null_Particulas,
		RST_PPS => RST_TIME,
		WE => WE_RAM,
		clk => clk,
		Data_Out => out_RAM_in_SPI,
		Evento_Particulas => signal_Evento_Particula,
		Max_addr_W_Particulas => Max_addr_W_Pos,
 	   Max_TIME => Saturacion_Time,
		Max_addr_RST_RAM => Max_addr_RST_RAM
	);


Inst_Contadores_Y_Despliegue: Contadores_Y_Despliegue PORT MAP(
		en_Eventos => signal_Evento_Particula,
		en_Errores => EN_Error,
		Selector => Despliegue_numEventos_numErrores,
		rst => RST_CONT_PARTICULAS_ERRORES,
		clk => clk,
		num_Eventos => num_Eventos,
		num_Errores => num_Errores,
		numero => numero,
		digito => digito,
		leds => leds
	);
	
Inst_SPI_SLAVE_R_W: SPI_SLAVE_R_W PORT MAP(
		EN => EN_SPI,
		Paralelo_MISO => out_RAM_in_SPI,
		MOSI => MOSI,
		clk_SPI => CLK_SPI,
		clk => clk,
		rst => RST_SPI,
		MISO => MISO,
		bussy => bussy_SPI,
		RTA_Checksum_R => RTA_SPI,
		Paralelo_MOSI => Paralelo_MOSI
	);

Evento_Particula <=  signal_Evento_Particula;
end Behavioral;

