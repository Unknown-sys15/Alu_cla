--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:58:03 10/25/2023
-- Design Name:   
-- Module Name:   /home/ise/Xilinx_host/2Dn/ALU_CLA/cla_gp_tb.vhd
-- Project Name:  ALU_CLA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cla_gp
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
 
ENTITY cla_gp_tb IS
END cla_gp_tb;
 
ARCHITECTURE behavior OF cla_gp_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cla_gp
    PORT(
         Cin : IN  std_logic;
         x : IN  std_logic;
         y : IN  std_logic;
         S : OUT  std_logic;
         Cout : OUT  std_logic;
         g : OUT  std_logic;
         p : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Cin : std_logic := '0';
   signal x : std_logic := '0';
   signal y : std_logic := '0';

 	--Outputs
   signal S : std_logic;
   signal Cout : std_logic;
   signal g : std_logic;
   signal p : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
	signal clk : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cla_gp PORT MAP (
          Cin => Cin,
          x => x,
          y => y,
          S => S,
          Cout => Cout,
          g => g,
          p => p
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

      wait for clk_period*10;
		x<='0';
		y<='0';
		Cin<='0';
		
		wait for clk_period*10;
		x<='0';
		y<='1';
		Cin<='0';
		
		wait for clk_period*10;
		x<='1';
		y<='0';
		Cin<='0';
		
		wait for clk_period*10;
		x<='1';
		y<='1';
		Cin<='0';
		
		wait for clk_period*10;
		x<='0';
		y<='0';
		Cin<='1';
		
		wait for clk_period*10;
		x<='0';
		y<='1';
		Cin<='1';
		
		wait for clk_period*10;
		x<='1';
		y<='0';
		Cin<='1';
		
		wait for clk_period*10;
		x<='1';
		y<='1';
		Cin<='1';
       

      wait;
   end process;

END;
