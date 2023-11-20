--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:48:54 10/26/2023
-- Design Name:   
-- Module Name:   /home/ise/Xilinx_host/2Dn/ALU_CLA/alu_cla_tb.vhd
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
USE ieee.numeric_std.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alu_cla_tb IS
	generic(n:natural := 8);
END alu_cla_tb;
 
ARCHITECTURE behavior OF alu_cla_tb IS 
 
    --UUT declaration
    COMPONENT alu_cla
	 GENERIC( n: natural := 8 );
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

	signal X_int, Y_int : integer := 0;
	signal S_comp, X_and_Y, X_nand_Y, X_or_Y, X_nor_Y, 
			 X_xor_Y, X_xnor_Y : std_logic_vector(n-1 downto 0) := (others => '0');
	signal Neg_comp, Over_comp, Zero_comp : std_logic := '0';
	constant zeros : std_logic_vector(n-1 downto 0) := (others => '0');
 
 
BEGIN
 
	-- UUT INIT
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
      wait for 100 ns;	
      -- insert stimulus here 

		----------------------------------------------------------
		----------------------------------------------------------
		----------------------------------------------------------
		--loop through all combinations
		for i in -(2**(n-1)) to 2**(n-1) - 1 loop
			X_int <= i;
			X <= std_logic_vector(to_signed(i, n));
			for j in -(2**(n-1)) to 2**(n-1) - 1 loop
				Y_int <= j;
				Y <= std_logic_vector(to_signed(j, n));
				----------------------------------------------------------
				-------------------ARITMETICNI NACIN----------------------
				----------------------------------------------------------
				M <= '0'; 
				F <= "000"; -- X + Y
				wait for 2 ns;
				assert(S_comp = S) report "S = X+Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Neg_comp = Negative) report "S = X+Y Negative failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Over_comp = Overflow) report "S = X+Y Overflow(V) failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Zero_comp = Zero) report "S = X+Y Zero failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "001"; -- X - Y
				wait for 2 ns;
				assert(S_comp = S) report "S = X-Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Neg_comp = Negative) report "S = X-Y Negative failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Over_comp = Overflow) report "S = X-Y Overflow(V) failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Zero_comp = Zero) report "S = X-Y Zero failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "010"; -- X + 1
				wait for 2 ns;
				assert(S_comp = S) report "S = X+1 failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Neg_comp = Negative) report "S = X+1 Negative failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Over_comp = Overflow) report "S = X+1 Overflow(V) failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Zero_comp = Zero) report "S = X+1 Zero failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "011"; -- X - 1
				wait for 2 ns;
				assert(S_comp = S) report "S = X-1 failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Neg_comp = Negative) report "S = X-1 Negative failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Over_comp = Overflow) report "S = X-1 Overflow(V) failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Zero_comp = Zero) report "S = X-1 Zero failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "100"; -- X + X
				wait for 2 ns;
				assert(S_comp = S) report "S = X+X failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Neg_comp = Negative) report "S = X+X Negative failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Over_comp = Overflow) report "S = X+X Overflow(V) failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Zero_comp = Zero) report "S = X+X Zero failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "101"; -- -1
				wait for 2 ns;
				assert(S_comp = S) report "S = -1 failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Neg_comp = Negative) report "S = -1 Negative failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Zero_comp = Zero) report "S = -1 Zero failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
								
				F <= "110"; -- undefined operation
				wait for 2 ns;
				assert(zeros = S) report "0110 failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "111"; -- undefined operation
				wait for 2 ns;
				assert(zeros = S) report "0111 failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				----------------------------------------------------------
				---------------------LOGICNI NACIN------------------------
				----------------------------------------------------------
				
				M <= '1';
 				F <= "000"; -- X and Y
				wait for 2 ns;
				assert(X_and_Y = S) report "S = X and Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "001"; -- X nand Y
				wait for 2 ns;
				assert(X_nand_Y = S) report "S = X nand Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "010"; -- X or Y
				wait for 2 ns;
				assert(X_or_Y = S) report "S = X or Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "011"; -- X nor Y
				wait for 2 ns;
				assert(X_nor_Y = S) report "S = X nor Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "100"; -- X xor Y
				wait for 2 ns;
				assert(X_xor_Y = S) report "S = X xor Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "101"; -- X xnor Y
				wait for 2 ns;
				assert(X_xnor_Y = S) report "S = X xnor Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "110"; -- X
				wait for 2 ns;
				assert(X = S) report "S=X failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Neg_comp = Negative) report "S=X Negative failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Zero_comp = Zero) report "S=X Zero failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				
				F <= "111"; -- Y
				wait for 2 ns;
				assert(Y = S) report "S=Y failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Neg_comp = Negative) report "S=Y Negative failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
				assert(Zero_comp = Zero) report "S=Y Zero failed. X:" & integer'image(i) & " Y:" & integer'image(j) severity error;
			end loop;
		end loop;
 
   end process;
	
	
	-- Calculate all sums
	comp_proc: process (X_int, Y_int, F)
	variable S_temp, X_temp, Y_temp : std_logic_vector(n-1 downto 0);
	variable Res_temp : integer;
	begin
		X_temp := std_logic_vector(to_signed(X_int, n));
		Y_temp := std_logic_vector(to_signed(Y_int, n));
		
		if F = "101" then -- minus 1
			S_temp := not zeros;
			Over_comp <= '0';
		else
			if F = "000" then
				Res_temp := X_int + Y_int;
			elsif F = "001" then
				Res_temp := X_int - Y_int;
			elsif F = "010" then
				Res_temp := X_int + 1;
			elsif F = "011" then
				Res_temp := X_int - 1;
			elsif F = "100" then
				Res_temp := X_int + X_int;
			elsif F = "110" then
				Res_temp := X_int;
			elsif F = "111" then
				Res_temp := Y_int;
			else
				Res_temp := 0;
			end if;
			
			--CHECK OVERFLOW STATUS
			if Res_temp > 2**(n-1) - 1 or Res_temp < -(2**(n-1)) then
				Over_comp <= '1';
			else
				Over_comp <= '0';
			end if;
			S_temp := std_logic_vector(to_unsigned(Res_temp mod 2**n, n));
		end if;

		S_comp <= S_temp;
		Neg_comp <= S_temp(n-1);
		
		if S_temp = zeros then
			Zero_comp <= '1';
		else
			Zero_comp <= '0';
		end if;
		 
		X_and_Y <= X_temp and Y_temp;
		X_nand_Y <= X_temp nand Y_temp;
		X_or_Y <= X_temp or Y_temp;
		X_nor_Y <= X_temp nor Y_temp;
		X_xor_Y <= X_temp xor Y_temp;
		X_xnor_Y <= X_temp xnor Y_temp;
 
   end process;

END;
