----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:16:44 01/13/2018 
-- Design Name: 
-- Module Name:    Interrupcion_Particulas - Behavioral 
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

entity Interrupcion_Particulas is
    Port ( INPUTT : in  STD_LOGIC_VECTOR (11 downto 0);
           clk : in  STD_LOGIC;
           OUPUTT : out  STD_LOGIC_VECTOR (11 downto 0));
end Interrupcion_Particulas;

architecture Behavioral of Interrupcion_Particulas is

begin


end Behavioral;

