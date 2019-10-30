----------------------------------------------------------------------------------
-- Company: Grupo Halley 
-- Engineer: Jose Luis Salamanca Coy, Karen Juliet Forero Gutiérrez
-- 
-- Create Date:    17:05:46 06/12/2017 
-- Design Name:    Maquina de estados protocolo SPI
-- Module Name:    Maquina_arranque - Behavioral 
-- Project Name:   Mini-Mute
-- Target Devices: Spartan 6, Mimas V2
-- Tool versions:  4.2
-- Description:    Este bloque describe una maquina de 4 estados, con los cuales se pretende controlar la 
--                 transmicion y recepcion de bits por medio del protocolo SPI.
--                    
--                 Estado        |                 Funcion
--                -----------------------------------------------------------------------------------------
--                 Espera        | En este estado se reinicia los contadores y se mantiene inactivo el     |
--										   | desplazamiento de bits tanto de transmicion como de recepcion           |
--                ----------------------------------------------------------------------------------------- 
--                 Lectura       | En este estado se activan los contadores tanto de bits como del         |
--										   | Checksum, ademas de habilitar el desplazamiento de bits en la recepcion.|
--                -----------------------------------------------------------------------------------------
--                 ant_Escritura | En este estado se carga la trama de bits para la transmicion, se        |
--											| desactiva el desplazamiento de bits de la lectura y se activa el        |
--                               | contador de bits, este estado solo dura un ciclo de reloj de la FPGA    |   	
--                -----------------------------------------------------------------------------------------
--                 Escritura     | En este estado se activa el desplazamiento de bits en la transmicion,   |
--                               | el contador de bits estara activo y el desplazamiento de bits en la     |
--                               | recepcion permanece inactivo.          											  |
--   					-----------------------------------------------------------------------------------------
--
--
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



entity Maquina_SPI_SLAVE is
    Port ( EN_R : in  STD_LOGIC:='0';
			  EN_W : in  STD_LOGIC:='0';
			  clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  En_Serial_Paralelo : out STD_LOGIC;
			  En_C_W : out STD_LOGIC;
			  En_D_W : out STD_LOGIC;
			  Rst_cont_bits: out  STD_LOGIC);
end Maquina_SPI_SLAVE; 
 
	architecture Behavioral of Maquina_SPI_SLAVE is 


type ESTADOS is (Espera,Lectura,ant_Escritura,Escritura); --estados
signal D_bus, Q_bus: ESTADOS;  --- entrada y salida del registro 
signal salidas : std_logic_vector(3 downto 0);
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

process (Q_bus, EN_R,EN_W)
begin
 case (Q_bus) is 
      when Espera =>		
         if EN_R  = '1' then
				D_bus <= Lectura;
			elsif EN_W = '1' then 
				D_bus <= ant_Escritura;
			else
			   D_bus <= Espera;
			end if;		
			
		when Lectura =>	
		   if EN_R  = '1' then
				D_bus <= Lectura;
			elsif EN_W = '1' then 
				D_bus <= ant_Escritura;
			else
			   D_bus <= Espera;
			end if;	
      
		when ant_Escritura =>	
		   D_bus <= Escritura;
							
	   when others => 
		if EN_W='1' then  
		   D_bus <=Escritura;
		else
			D_bus <=Espera;
		end if;
		
   end case;
end process;
		 
------ Lógica de Salida  -----------------

 with Q_bus select
      salidas <= "1000" when Espera,
					  "0100" when Lectura,
					  "0010" when ant_Escritura,
					  "0001" when others;
				
				
Rst_cont_bits <= salidas(3);
En_Serial_Paralelo <= salidas(2);
En_C_W <= salidas(1);
En_D_W <= salidas(0);


end Behavioral;
