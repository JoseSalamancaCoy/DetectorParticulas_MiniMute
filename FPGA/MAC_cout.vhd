----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:35:32 01/03/2018 
-- Design Name: 
-- Module Name:    MAC_cout - Behavioral 
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

entity MAC_cout is
    Port ( en : in  STD_LOGIC;
           Max_U : in  STD_LOGIC;
           Max_D : in  STD_LOGIC;
           Max_C : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  clk : in STD_LOGIC;
           en_U : out  STD_LOGIC;
           rst_U : out  STD_LOGIC;
           en_D : out  STD_LOGIC;
           rst_D : out  STD_LOGIC;
           en_C : out  STD_LOGIC;
           rst_C : out  STD_LOGIC;
           en_M : out  STD_LOGIC;
           rst_M : out  STD_LOGIC);
end MAC_cout;

architecture Behavioral of MAC_cout is

type ESTADOS is (Espera,Cont_U, Cont_D, Cont_C, Cont_M,Reinicio); --estados
signal D_bus, Q_bus: ESTADOS;  --- entrada y salida del registro 
signal salidas : std_logic_vector(7 downto 0);

begin


----- Registro de Estado -------
process (clk)
begin
   if clk'event and clk='1' then  
      if rst='1' then   
         q_bus <= Reinicio;
      else
         q_bus <= D_bus;
      end if;
   end if;
	
end process;
----- Lógica del Estado Siguiente-- ------

process (Q_bus, en, Max_U,Max_D,Max_C)
begin
 case (Q_bus) is 
      when Reinicio =>		
				D_bus <= Espera;
      when Espera =>		
         if( en = '1')then
				D_bus <= Cont_U;
			else
				D_bus <= Espera;
			end if;		
			
		when Cont_U =>		
         if( Max_U = '1')then
				D_bus <= Cont_D;
			else
				D_bus <= Espera;
			end if;		

		when Cont_D =>		
         if( Max_D = '1')then
				D_bus <= Cont_C;
			else
				D_bus <= Espera;
			end if;	
			
		when Cont_C =>		
         if( Max_C = '1')then
				D_bus <= Cont_M;
			else
				D_bus <= Espera;
			end if;	
	   when others => 
		   D_bus <=Espera;
	end case;
end process;
		 
------ Lógica de Salida  -----------------

 with Q_bus select
      salidas <= "01010101" when Reinicio,
					  "00000000" when Espera,
			   	  "10000000" when Cont_U,
					  "01100000" when Cont_D,
					  "00011000" when Cont_C,
					  "00000110" when others;
				
				
en_U <= salidas(7);
rst_U <= salidas(6);
en_D <= salidas(5);
rst_D <= salidas(4);
en_C <= salidas(3);
rst_C <= salidas(2);
en_M <= salidas(1);
rst_M <= salidas(0);
			  
			  
end Behavioral;
