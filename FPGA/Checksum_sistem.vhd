----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:05:19 01/06/2018 
-- Design Name: 
-- Module Name:    Checksum_sistem - Behavioral 
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

entity Checksum_sistem is
    Port ( cont_bits : in  STD_LOGIC_VECTOR (5 downto 0);
			  Interrup_clk_SPI_S : in  STD_LOGIC;
           Interrup_clk_SPI_B : in  STD_LOGIC;
           In_R : in  STD_LOGIC;
           In_W : in  STD_LOGIC;
           clk : in  STD_LOGIC; 
           rst : in  STD_LOGIC;
           C_Cks_W : out  STD_LOGIC;
           Checksum_W : out  STD_LOGIC_VECTOR (5 downto 0);
           Checksum_R : out  STD_LOGIC_VECTOR (2 downto 0));
end Checksum_sistem;

architecture Behavioral of Checksum_sistem is
	
COMPONENT Checksum
	PORT(
		sum_in : IN std_logic;
		en : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;          
		sum_out : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
COMPONENT Checksum_RR
	PORT(
		sum_in : IN std_logic;
		en : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;          
		sum_out : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Maquina_checksum
	PORT(
		I_Cks_R : IN std_logic;
		I_Cks_W : IN std_logic;
		Interrup_clk_SPI_S : IN std_logic;
		clk : IN std_logic;
		rst : IN std_logic;          
		C_Cks_W : OUT std_logic;
		En_Cks_W : OUT std_logic;
		En_Cks_R : OUT std_logic
		);
	END COMPONENT;

	




signal I_Cks_R : STD_LOGIC;
signal I_Cks_W : STD_LOGIC;
signal En_Cks_W : STD_LOGIC;
signal En_Cks_R : STD_LOGIC;
signal Rst_Cks_W : STD_LOGIC;
signal Rst_Cks_R : STD_LOGIC;
signal Interrrp_CLK_SPI_EN_CKS_W : std_logic;
signal Interrrp_CLK_SPI_EN_CKS_R : std_logic;



begin

Interrrp_CLK_SPI_EN_CKS_W <= Interrup_clk_SPI_B and En_Cks_W and I_Cks_W;
Interrrp_CLK_SPI_EN_CKS_R <= Interrup_clk_SPI_B and En_Cks_R and I_Cks_R;
I_Cks_R <= '1' when cont_bits < "000101" else '0';
I_Cks_W <= '1' when ((cont_bits >= "001001") and (cont_bits < "101111" )) else '0';


Inst_Checksum_W: Checksum PORT MAP(
		sum_in => In_W,
		en => Interrrp_CLK_SPI_EN_CKS_W,
		clk => clk,
		rst => rst,
		sum_out => Checksum_W
	);
	
Inst_Checksum_R: Checksum_RR PORT MAP(
		sum_in => In_R,
		en => Interrrp_CLK_SPI_EN_CKS_R,
		clk => clk,
		rst => rst,
		sum_out => Checksum_R
	);


Inst_Maquina_checksum: Maquina_checksum PORT MAP(
		I_Cks_R => I_Cks_R,
		I_Cks_W => I_Cks_W ,
		Interrup_clk_SPI_S => Interrup_clk_SPI_S,
		clk => clk,
		rst => rst,
		C_Cks_W => C_Cks_W,
		En_Cks_W => En_Cks_W,
		En_Cks_R => En_Cks_R
	);

end Behavioral;

