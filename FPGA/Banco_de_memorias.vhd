----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:45 01/13/2018 
-- Design Name: 
-- Module Name:    Banco_de_memorias - Behavioral 
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

entity Banco_de_memorias is
    Port ( Particulas : in  STD_LOGIC_VECTOR (11 downto 0);
	        Cont_Particulas : std_logic_vector(38 downto 0);
           Cont_Errores : std_logic_vector(38 downto 0);
           Sel_Funcion : in  STD_LOGIC_VECTOR (1 downto 0);
           Addr_R : in  STD_LOGIC_VECTOR (4 downto 0);
           PPS : in  STD_LOGIC;
           En_cont_RST_RAM : in  STD_LOGIC;
           RST_cont_RST_RAM : in  STD_LOGIC;
			  RST_Addr_W : in STD_LOGIC;
           NULL_Particulas : in  STD_LOGIC;
           RST_PPS : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Data_Out : out  STD_LOGIC_VECTOR (39 downto 0);
			  Evento_Particulas : out STD_LOGIC;
           Max_addr_W_Particulas : out  STD_LOGIC;
			  Max_TIME : out STD_LOGIC;
           Max_addr_RST_RAM : out  STD_LOGIC);
end Banco_de_memorias;

architecture Behavioral of Banco_de_memorias is
	COMPONENT Almacen_datos_RAM
	PORT(
		WE : IN std_logic;
		clk : IN std_logic;
		Address_W : IN std_logic_vector(4 downto 0);
		Address_E : IN std_logic_vector(4 downto 0);
		Data_In : IN std_logic_vector(38 downto 0);          
		Data_Out : OUT std_logic_vector(38 downto 0)
		);
	END COMPONENT;

COMPONENT Contador_senal_PPS
	PORT(
		en : IN std_logic;
		rst : IN std_logic;
		clk : IN std_logic;          
		count : OUT std_logic_vector(26 downto 0)
		);
	END COMPONENT;

	

COMPONENT evento_interrupcion
	PORT(
		clk : IN std_logic;
		senal : IN std_logic_vector(11 downto 0);          
		senal_evento : OUT std_logic
		);
	END COMPONENT;

COMPONENT INTERRUPCION_S
	PORT(
		INPUTT : IN std_logic;
		clk : IN std_logic;          
		OUPUTT : OUT std_logic
		);
	END COMPONENT;

	

	
	COMPONENT contador_binario_5bits
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		en : IN std_logic;          
		cout : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

	
Signal Particulas_2 : STD_LOGIC_VECTOR(11 downto 0); 
Signal Particulas_3 : STD_LOGIC_VECTOR(11 downto 0); 
Signal Signal_Evento_Particulas : STD_LOGIC;
Signal RST_cont_PPS : STD_LOGIC;
Signal Time_Evento : std_logic_vector(26 downto 0);
Signal Null_PPS : STD_LOGIC:='0';
Signal PPS_2 : STD_LOGIC;
Signal PPS_3 : STD_LOGIC;
Signal Interrup_PPS : STD_LOGIC;



Signal Data_Particulas_Time : std_logic_vector(38 downto 0);
Signal Data_NULL : std_logic_vector(38 downto 0):= (others => '0');
Signal Data_IN_RAM : std_logic_vector(38 downto 0);
Signal Data_out_RAM : std_logic_vector(38 downto 0);


Signal addr_W_Eventos : std_logic_vector(4 downto 0);
Signal addr_RST_RAM : std_logic_vector(4 downto 0);
Signal addr_num_Eventos : std_logic_vector(4 downto 0);
Signal addr_num_Errores : std_logic_vector(4 downto 0);
Signal addr_W : std_logic_vector(4 downto 0);




begin

---- Asignaciones -----------------------------
addr_num_Eventos  <= "11110";
addr_num_Errores  <= "11111";
Data_NULL <= (others => '0');
Data_Particulas_Time <= Particulas_3 & Time_Evento;

-----------------------------------------------



---- Multiplexores ----------------------------
with Sel_Funcion select
Data_IN_RAM <= Data_Particulas_Time when "00",
               Data_NULL  when "01",
			      Cont_Particulas when "10",
               Cont_Errores when others;
					
					
with Sel_Funcion select
addr_W <= addr_W_Eventos when "00",
          addr_RST_RAM  when "01",
			 addr_num_Eventos when "10",
          addr_num_Errores when others;
			 
-----------------------------------------------


---- Operaciones Logicas  ---------------------
RST_cont_PPS <= Interrup_PPS or RST_PPS;



-----------------------------------------------
 
---- Registros anti-Metaestabilidad --------------------------

---flip_flops_Particulas------ 
process (clk)
begin
   if clk'event and clk='1' then  
      Particulas_2 <= Particulas;
   end if;
end process;

process (clk)

begin
   if clk'event and clk='1' then  
      if NULL_Particulas = '1' then   
         Particulas_3 <= "000000000000";
      else
         Particulas_3 <= not(Particulas_2);
      end if;
   end if;
end process;
-----------------------------


----flip_flops_PPS

process (clk)
begin
   if clk'event and clk='1' then  
      PPS_2 <= PPS;
   end if;
end process;

process (clk)
begin
   if clk'event and clk='1' then  
      PPS_3 <= PPS_2;
   end if;
end process;
------------------
--------------------------------------------------------------



---- Registro ausencia PPS -----------------------------------
process (clk)
begin
   if clk'event and clk='1' then  
      if PPS_3='1' then   
         Null_PPS <= '0';
      elsif RST_PPS ='1' then
         Null_PPS <= '1';
      end if;
   end if;
end process;

---------------------------------------------------------------


Inst_INTERRUPCION_S_PPS: INTERRUPCION_S PORT MAP(
		INPUTT => PPS_3,
		clk => clk,
		OUPUTT => Interrup_PPS
	);

Inst_evento_interrupcion: evento_interrupcion PORT MAP(
		clk => clk,
		senal => Particulas_3,
		senal_evento => Signal_Evento_Particulas
	);



Inst_Almacen_datos_RAM: Almacen_datos_RAM PORT MAP(
		WE => WE,
		clk => clk,
		Address_W => addr_W,
		Address_E => addr_R,
		Data_In => Data_IN_RAM,
		Data_Out => Data_Out_RAM
	);
	

Inst_Contador_senal_PPS: Contador_senal_PPS PORT MAP(
		en => '1',
		rst => RST_cont_PPS,
		clk => clk,
		count => Time_Evento
	);


Inst_contador_binario_5bits_Evenos: contador_binario_5bits PORT MAP(
		clk => clk,
		rst => RST_Addr_W,
		en => Signal_Evento_Particulas,
		cout => addr_W_Eventos
	);
	
Inst_contador_binario_5bits_RST: contador_binario_5bits PORT MAP(
		clk => clk,
		rst => RST_cont_RST_RAM,
		en => En_cont_RST_RAM,
		cout => addr_RST_RAM
	);

---- Asignacion Salidas -------------------------------------

Evento_Particulas <= Signal_Evento_Particulas;
Data_out <= Data_out_RAM & Null_PPS;
Max_TIME <= '1' when Time_Evento >= "000000000000101111101011110000100000010" else '0';
Max_addr_RST_RAM <= '1' when addr_RST_RAM >= "11100" else '0';
Max_addr_W_Particulas <= '1' when addr_W_Eventos >= "11100" else '0';
-------------------------------------------------------------
end Behavioral;

