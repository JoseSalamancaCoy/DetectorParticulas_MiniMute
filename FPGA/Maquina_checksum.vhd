----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:21:14 01/05/2018 
-- Design Name: 
-- Module Name:    Maquina_checksum - Behavioral 
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

entity Maquina_checksum is 
 Port (    I_Cks_R : in  STD_LOGIC;
			  I_Cks_W : in  STD_LOGIC;
			  Interrup_clk_SPI_S : in  STD_LOGIC;
			  clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  C_Cks_W : out STD_LOGIC;
			  En_Cks_W : out STD_LOGIC;
			  En_Cks_R: out STD_LOGIC);
end Maquina_checksum;

architecture Behavioral of Maquina_checksum is


type ESTADOS is (Espera,Init_Cks_R,Init_Cks_W,ant_Carga_Cks_W,Carga_Cks_W); --estados
signal D_bus, Q_bus: ESTADOS;  --- entrada y salida del registro 
signal salidas : std_logic_vector(2 downto 0);
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

process (Q_bus, I_Cks_R,I_Cks_W,Interrup_clk_SPI_S)
begin
 case (Q_bus) is 
      when Espera =>		
         if I_Cks_R  = '1' then
				D_bus <= Init_Cks_R;
			elsif I_Cks_W = '1' then 
				D_bus <= Init_Cks_W;
			else
			   D_bus <= Espera;
			end if;		
			
		when Init_Cks_R =>	
		   if I_Cks_R  = '1' then
				D_bus <= Init_Cks_R;
			else
			   D_bus <= Espera;
			end if;	
      
		when Init_Cks_W => 
		if I_Cks_W='1' then  
		   D_bus <=Init_Cks_W;
		else
			D_bus <=ant_Carga_Cks_W;
		end if;
		
		when ant_Carga_Cks_W => 
		if Interrup_clk_SPI_S='0' then  
		   D_bus <=ant_Carga_Cks_W;
		else
			D_bus <=Carga_Cks_W;
		end if;
		
		when others =>	
		   D_bus <= Espera;
							
	   
		
   end case;
end process;
		 
------ Lógica de Salida  -----------------

 with Q_bus select
      salidas <= "000" when Espera,
					  "001" when Init_Cks_R,
					  "010" when Init_Cks_W,
					  "000" when ant_Carga_Cks_W,
					  "100" when others;
				


				


C_Cks_W <= salidas(2);
En_Cks_W <= salidas(1);
En_Cks_R <= salidas(0);

end Behavioral;

