----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:40:49 01/17/2018 
-- Design Name: 
-- Module Name:    Gestion_Funciones_Mini_Mute_FPGA - Behavioral 
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

entity Gestion_Funciones_Mini_Mute_FPGA is
	PORT(		CS_SPI : IN std_logic;
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
				Despliegue_numEventos_numErrores  : OUT std_logic := '0');
		
		
	end Gestion_Funciones_Mini_Mute_FPGA;

architecture Behavioral of Gestion_Funciones_Mini_Mute_FPGA is
COMPONENT Mac_Funciones_Mini_Mute_FPGA
	PORT(
		Interrup_B_CS_SPI : IN std_logic;
		Interrup_S_CS_SPI : IN std_logic;
		EN_W_SPI : IN std_logic;
		EN_R_SPI : IN std_logic;
		RTA_SPI : IN std_logic;
		Max_addr_W_Pos : IN std_logic;
		Max_addr_RST_RAM : IN std_logic;
		Evento_Particula : IN std_logic;
		Saturacion_Time : IN std_logic;
		bits_RST_Contadores : IN std_logic;
		bits_RST_RAM : IN std_logic;
		bits_Despliegue_Errores : IN std_logic;
		bits_despliegue_Conteo : IN std_logic;
		PosRam_ON : IN std_logic;
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
		Despliegue_numEventos : OUT std_logic;
		Despliegue_numErrores : OUT std_logic;
		rst_interrup_B_CS_SPI : OUT std_logic;
		rst_interrup_S_CS_SPI : OUT std_logic
		);
	END COMPONENT;






   COMPONENT INTERRUPCION_S
	PORT(
		INPUTT : IN std_logic;
		clk : IN std_logic;          
		OUPUTT : OUT std_logic
		);
	END COMPONENT;

	COMPONENT INTERRUPCION_B
	PORT(
		INPUTT : IN std_logic;
		clk : IN std_logic;          
		OUPUTT : OUT std_logic
		);
	END COMPONENT;




Signal CS_SPI_1 : std_logic;
Signal CS_SPI_2 : std_logic;
Signal Interrup_B_CS_SPI : std_logic;
Signal Interrup_S_CS_SPI : std_logic;
Signal Interrup_B_CS_SPI_S : std_logic;
Signal Interrup_S_CS_SPI_S : std_logic;
Signal rst_interrup_B_CS_SPI : std_logic;
Signal rst_interrup_S_CS_SPI : std_logic;
Signal bits_RST_Contadores : std_logic;
Signal bits_RST_RAM : std_logic;
Signal bits_Despliegue_Errores : std_logic;
Signal bits_despliegue_Conteo : std_logic;
Signal PosRam_ON : std_logic;
Signal control_EN_SPI : std_logic;
Signal control_RST_SPI : std_logic;
Signal CS_SPI_OUT : std_logic;
Signal despliegue_numEventos : std_logic;
Signal despliegue_numErrores : std_logic;

begin

PosRam_ON <= bits_Funcion(5);
bits_RST_Contadores <= '1' when bits_Funcion = "111000" else '0';
bits_RST_RAM <= '1' when bits_Funcion = "110000" else '0';
bits_Despliegue_Errores <= '1' when bits_Funcion = "111100" else '0';
bits_despliegue_Conteo <= '1' when bits_Funcion = "111110" else '0';


---- Conexiones bloques --------------
process (clk)
begin
   if clk'event and clk='1' then  
      CS_SPI_1 <= CS_SPI;
   end if;
end process;

process (clk)
begin
   if clk'event and clk='1' then  
      CS_SPI_2 <= CS_SPI_1;
   end if;
end process;

Inst_INTERRUPCION_S: INTERRUPCION_S PORT MAP(
		INPUTT => CS_SPI_2,
		clk => clk,
		OUPUTT => Interrup_S_CS_SPI
	);

	Inst_INTERRUPCION_B: INTERRUPCION_B PORT MAP(
		INPUTT => CS_SPI_2,
		clk => clk,
		OUPUTT => Interrup_B_CS_SPI
	);

process (clk)
begin
   if clk'event and clk='1' then  
      if rst_interrup_S_CS_SPI='1' then   
         Interrup_S_CS_SPI_S <= '0';
      else
         Interrup_S_CS_SPI_S <= Interrup_S_CS_SPI;
      end if;
   end if;
end process;

process (clk)
begin
   if clk'event and clk='1' then  
      if rst_interrup_B_CS_SPI='1' then   
         Interrup_B_CS_SPI_S <= '0';
      else
         Interrup_B_CS_SPI_S <= Interrup_B_CS_SPI;
      end if;
   end if;
end process;
 
Inst_Mac_Funciones_Mini_Mute_FPGA: Mac_Funciones_Mini_Mute_FPGA PORT MAP(
		Interrup_B_CS_SPI => Interrup_B_CS_SPI_S,
		Interrup_S_CS_SPI => Interrup_S_CS_SPI_S,
		EN_W_SPI => bussy_SPI(0),
		EN_R_SPI => bussy_SPI(1),
		RTA_SPI => RTA_SPI,
		Max_addr_W_Pos => Max_addr_W_Pos,
		Max_addr_RST_RAM => Max_addr_RST_RAM,
		Evento_Particula => Evento_Particula,
		Saturacion_Time => Saturacion_Time,
		bits_RST_Contadores => bits_RST_Contadores,
		bits_RST_RAM => bits_RST_RAM,
		bits_Despliegue_Errores => bits_Despliegue_Errores,
		bits_despliegue_Conteo => bits_despliegue_Conteo,
		PosRam_ON => PosRam_ON,
		rst => rst,
		clk => clk ,
		Sel_Funcion => Sel_Funcion,
		En_Cont_RST_RAM => En_Cont_RST_RAM,
		RST_cont_RST_RAM => RST_cont_RST_RAM,
		RST_addr_W_RAM => RST_addr_W_RAM,
		Null_Particulas => Null_Particulas,
		RST_TIME => RST_TIME,
		WE_RAM => WE_RAM,
		EN_SPI => control_EN_SPI,
		RST_SPI => control_RST_SPI,
		EN_Error => EN_Error,
		RST_CONT_PARTICULAS_ERRORES => RST_CONT_PARTICULAS_ERRORES,
		Despliegue_numEventos => Despliegue_numEventos,
		Despliegue_numErrores => Despliegue_numErrores,
		rst_interrup_B_CS_SPI => rst_interrup_B_CS_SPI,
		rst_interrup_S_CS_SPI => rst_interrup_S_CS_SPI
	);



process (clk)
begin
   if clk'event and clk='1' then  
      if control_RST_SPI='1' then   
         CS_SPI_OUT <= '1';
      elsif control_EN_SPI = '1' then
         CS_SPI_OUT <= '0';
		else
		   CS_SPI_OUT <= CS_SPI_OUT;
      end if;
   end if;
end process;


process (clk) 
begin
   if clk'event and clk='1' then  
      if Despliegue_numErrores='1' then   
         Despliegue_numEventos_numErrores <= '1';
      elsif Despliegue_numEventos = '1' then
         Despliegue_numEventos_numErrores <= '0';
      end if;
   end if;
end process;

EN_SPI <= CS_SPI_OUT;
RST_SPI <= CS_SPI_OUT;
end Behavioral;

