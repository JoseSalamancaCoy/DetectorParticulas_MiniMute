----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:54:12 10/03/2017 
-- Design Name: 
-- Module Name:    Almacen_datos_RAM - Behavioral 
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Almacen_datos_RAM is
    Port ( WE: in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Address_W : in  STD_LOGIC_VECTOR (4 downto 0);
			  Address_E : in  STD_LOGIC_VECTOR (4 downto 0);
           Data_In : in  STD_LOGIC_VECTOR (38 downto 0);
           Data_Out : out  STD_LOGIC_VECTOR (38 downto 0));
end Almacen_datos_RAM;

architecture Behavioral of Almacen_datos_RAM is

type ram_type is array (31 downto 0) of std_logic_vector (38 downto 0);
signal RAM_eventos: ram_type;
begin

process (clk)
begin
   if (clk'event and clk = '1') then
		if (WE = '1') then
			RAM_eventos(conv_integer(Address_W)) <= Data_In;
		else
			Data_Out <= RAM_eventos(conv_integer(Address_E)); 
      end if;
   end if;
end process;


end Behavioral;

