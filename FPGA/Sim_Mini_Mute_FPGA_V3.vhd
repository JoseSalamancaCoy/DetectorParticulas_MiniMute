--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:10:02 01/18/2018
-- Design Name:   
-- Module Name:   C:/Jose Luis/Jose UIS/Proyecto de grado/Interfaz_digita/FPGA_V2/Mini_Mute_FPGA_V3/Sim_Mini_Mute_FPGA_V3.vhd
-- Project Name:  Mini_Mute_FPGA_V3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mini_Mute_FPGA
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Sim_Mini_Mute_FPGA_V3 IS
END Sim_Mini_Mute_FPGA_V3;
 
ARCHITECTURE behavior OF Sim_Mini_Mute_FPGA_V3 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mini_Mute_FPGA
    PORT(
         Particulas : IN  std_logic_vector(11 downto 0);
         PPS : IN  std_logic;
         MOSI : IN  std_logic;
         CS_SPI : IN  std_logic;
         CLK_SPI : IN  std_logic;
         clk : IN  std_logic;
         Evento_Particula : OUT  std_logic;
         MISO : OUT  std_logic;
         numero : OUT  std_logic_vector(7 downto 0);
         digito : OUT  std_logic_vector(2 downto 0);
         leds : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Particulas : std_logic_vector(11 downto 0) := (others => '0');
   signal PPS : std_logic := '0';
   signal MOSI : std_logic := '0';
   signal CS_SPI : std_logic := '0';
   signal CLK_SPI : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Evento_Particula : std_logic;
   signal MISO : std_logic;
   signal numero : std_logic_vector(7 downto 0);
   signal digito : std_logic_vector(2 downto 0);
   signal leds : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_SPI_period : time := 10 ns;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mini_Mute_FPGA PORT MAP (
          Particulas => Particulas,
          PPS => PPS,
          MOSI => MOSI,
          CS_SPI => CS_SPI,
          CLK_SPI => CLK_SPI,
          clk => clk,
          Evento_Particula => Evento_Particula,
          MISO => MISO,
          numero => numero,
          digito => digito,
          leds => leds
        );

   -- Clock process definitions

   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      Particulas <= "000000000000";
      PPS <= '0';
      MOSI <= '0';
      CS_SPI <= '1';
      CLK_SPI <= '0';
      wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		wait for clk_period*10;
		Particulas <= "000000001100";
		wait for clk_period*3;
		Particulas <= "000000001111";
		wait for clk_period;
		Particulas <= "000100001011";
		
		wait for clk_period*100;
		--
      CS_SPI <= '0';
      CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '1';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '1';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '1'; 
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '1';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '1';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0'; 
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		CLK_SPI <= '0';
		CS_SPI <= '1';

		--
		
		
		
		
		
		
		wait for clk_period*100;
		--
		MOSI <= '0';
      CS_SPI <= '0';
      CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0';
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		--
		--
		CLK_SPI <= '0'; 
		wait for clk_period*10;
		MOSI <= '0';
		CLK_SPI <= '1';
		wait for clk_period*10;
		CLK_SPI <= '0';
		--
		
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		--.........
		wait for clk_period*10;
		CLK_SPI <= '1';
		 wait for clk_period*10;
		CLK_SPI <= '0';
		--.........
		

      -- insert stimulus here 

      wait;
   end process;

END;
