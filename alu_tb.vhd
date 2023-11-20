--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:12:41 10/26/2023
-- Design Name:   
-- Module Name:   /home/ise/Xilinx_host/2Dn/ALU_CLA/alu_tb.vhd
-- Project Name:  ALU_CLA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu_cla
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
USE ieee.numeric_std.ALL;
 
ENTITY alu_tb IS
END alu_tb;
 
ARCHITECTURE behavior OF alu_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu_cla
    PORT(
         M : IN  std_logic;
         F : IN  std_logic_vector(2 downto 0);
         X : IN  std_logic_vector(7 downto 0);
         Y : IN  std_logic_vector(7 downto 0);
         S : OUT  std_logic_vector(7 downto 0);
         Negative : OUT  std_logic;
         Cout : OUT  std_logic;
         Overflow : OUT  std_logic;
         Zero : OUT  std_logic;
         Gout : OUT  std_logic;
         Pout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal M : std_logic := '0';
   signal F : std_logic_vector(2 downto 0) := (others => '0');
   signal X : std_logic_vector(7 downto 0) := (others => '0');
   signal Y : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(7 downto 0);
   signal Negative : std_logic;
   signal Cout : std_logic;
   signal Overflow : std_logic;
   signal Zero : std_logic;
   signal Gout : std_logic;
   signal Pout : std_logic;

	signal x_int,y_int : integer := 0;
	signal S_calc : std_logic_vector(7 downto 0); 
	
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu_cla PORT MAP (
          M => M,
          F => F,
          X => X,
          Y => Y,
          S => S,
          Negative => Negative,
          Cout => Cout,
          Overflow => Overflow,
          Zero => Zero,
          Gout => Gout,
          Pout => Pout
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 10 ns;	

      -- insert stimulus here
		for i in 0 to 2**8 -1 loop
			x_int <= i;
			x <= std_logic_vector(to_unsigned(i,8));
			for j in 0 to 2**8 -1 loop
				y_int <= j;
				y <= std_logic_vector(to_unsigned(j,8));
				--preveri ce se rezulatati skladajo
				F <= "000";
				wait for 1 ns;
				assert(S_calc=S) report "Napaka sestevanje. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
					
				F<="001";
				wait for 1 ns;
				assert(S_calc=S) report "Napaka odstevanje. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
					
			end loop;
		end loop;
		wait;
	end process ;
				 
		--calculate output 
	calc_proc: process(X_int, Y_int, F)
	begin
		if F = "000" then
			S_calc <= std_logic_vector(to_unsigned((x_int + y_int) mod 2**8,8));
		else
			S_calc <= std_logic_vector(to_unsigned((x_int - y_int) mod 2**8,8));
		end if;
		--wait;
   end process;

END;
