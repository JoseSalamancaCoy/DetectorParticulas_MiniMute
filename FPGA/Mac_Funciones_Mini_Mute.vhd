----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:50:50 01/17/2018 
-- Design Name: 
-- Module Name:    Mac_Funciones_Mini_Mute - Behavioral 
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

entity Mac_Funciones_Mini_Mute_FPGA is
	PORT(		Interrup_B_CS_SPI : IN std_logic;
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
		rst_interrup_S_CS_SPI : OUT std_logic);
	
end Mac_Funciones_Mini_Mute_FPGA;

architecture Behavioral of Mac_Funciones_Mini_Mute_FPGA is

type ESTADOS is (Espera, Init_Comunicacion, Fin_Comunicacion, Rst_TimePPS_Saturacion, Rst_RAM, Rst_Pos_RAM, Cont_Error, 
					  Rst_contadores, Carga_bits, Save_Eventos, Save_Errores, Despliegue_Errores, Despliegue_Eventos); --estados
signal D_bus, Q_bus: ESTADOS;  --- entrada y salida del registro 
signal salidas : std_logic_vector(15 downto 0);
begin


----- Registro de Estado -------
process (clk) 
begin
   if clk'event and clk='1' then  
      if rst='1' then   
         q_bus <= Espera;
      else
         q_bus <= D_bus;
      end if;
   end if;
	
end process;


----- Lógica del Estado Siguiente-- ------ 
process (Q_bus, Interrup_B_CS_SPI, Interrup_S_CS_SPI, EN_W_SPI, EN_R_SPI, RTA_SPI, Max_addr_W_Pos, Max_addr_RST_RAM,
			Evento_Particula, Saturacion_Time, bits_RST_Contadores, bits_RST_RAM, bits_Despliegue_Errores, bits_despliegue_Conteo, PosRam_ON)
begin
 case (Q_bus) is 
      when Espera =>		
         if Evento_Particula = '1' then
				if  Max_addr_W_Pos = '1' then 
					D_bus <= Rst_Pos_RAM;
				else
					D_bus <= Save_Eventos;		
				end if;
			elsif Interrup_B_CS_SPI = '1' then 
				D_bus <= Init_Comunicacion;
			elsif Interrup_S_CS_SPI = '1' then
			   D_bus <= Fin_Comunicacion;
			elsif Saturacion_Time = '1' then 
			   D_bus <= Rst_TimePPS_Saturacion;			
			elsif (EN_R_SPI = '0')	and (EN_W_SPI = '1') then  
			   if RTA_SPI = '0' then
					D_bus <= Cont_Error;
				elsif PosRam_ON = '0' then 
					D_bus <= Carga_bits;
				elsif bits_RST_Contadores = '1' then 
					D_bus <= Rst_contadores;
				elsif bits_RST_RAM = '1' then 
					D_bus <= Rst_RAM;
				elsif bits_Despliegue_Errores = '1' then 
					D_bus <= Despliegue_Errores;
				elsif bits_despliegue_Conteo = '1' then 
					D_bus <= Despliegue_Eventos;
				else 
  					D_bus <= Espera;
				end if;
			else 
				D_bus <= Espera;
			end if;		
			
		when RST_RAM =>	
			if Max_addr_RST_RAM = '1' then  
				D_bus <=Espera;
			else
				D_bus <=RST_RAM;
			end if;
      
		when Cont_Error =>	
		   D_bus <= Save_Errores;
			
		when RST_Pos_RAM =>	
		   D_bus <= Save_Eventos;
							
	   when others => 
			D_bus <= Espera;
		
		
   end case;
end process;
		 
------ Lógica de Salida  -----------------

 with Q_bus select
      salidas <= "0001000110000010" when Init_Comunicacion,
					  "0001000101000001" when Fin_Comunicacion,
					  "0001001100000000" when Rst_TimePPS_Saturacion,
					  "0110010101000000" when Rst_RAM,
					  "0001100100000000" when Rst_Pos_RAM,
					  "0001000101100000" when Cont_Error,
					  "0001010101010000" when Rst_contadores,
					  "0001000000000000" when Carga_bits,
					  "1001000100000000" when Save_Eventos,
					  "1101000100000000" when Save_Errores,
					  "0001000101000100" when Despliegue_Errores,
					  "0001000101001000" when Despliegue_Eventos,
					  "0001000100000000" when others;
				
				
Sel_Funcion <= salidas(15) & salidas(14);  
En_Cont_RST_RAM <= salidas(13);
RST_cont_RST_RAM <= salidas(12);
RST_addr_W_RAM <= salidas(11);
Null_Particulas <= salidas(10);
RST_TIME <= salidas(9);
WE_RAM <= salidas(8);
EN_SPI <= salidas(7);
RST_SPI <= salidas(6);
EN_Error <= salidas(5);
RST_CONT_PARTICULAS_ERRORES <= salidas(4);
Despliegue_numEventos <= salidas(3);
Despliegue_numErrores <= salidas(2);
rst_interrup_B_CS_SPI <= salidas(1);
rst_interrup_S_CS_SPI <= salidas(0);

end Behavioral;

