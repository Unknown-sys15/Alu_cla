library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_cla is
	generic( n: natural := 8 );
	port(	M		:	in 	std_logic;	--nacin delovanja //0 => aritmetcini, 1 => logicni)			
			F		: 	in 	std_logic_vector(2 downto 0);	-- izbira operacije
			X, Y	:	in 	std_logic_vector(n-1 downto 0); --vhod
			S		:	out std_logic_vector(n-1 downto 0); --izhod
			Negative, Cout, Overflow, Zero,	Gout, Pout :	out	std_logic );
end alu_cla;

architecture NDV of alu_cla is
	COMPONENT cla_add_n_bit IS
		generic(n: natural := 8);
		PORT (	Cin	:	in 	std_logic ;
				X, Y	:	in 	std_logic_vector(n-1 downto 0);
				S		:	out	std_logic_vector(n-1 downto 0);
				Gout,	Pout, Cout	:	out	std_logic);
	END COMPONENT;
	
	signal Y_sig,S_sig : std_logic_vector(n-1 downto 0);
	constant one   : std_logic_vector(n-1 downto 0) := (0 => '1', others => '0');
	signal nAddSub : std_logic;
	constant zeros : std_logic_vector(n-1 downto 0) := (others => '0');
	signal alu_operation: std_logic_vector(3 downto 0);
	
begin
	--component
	U1: cla_add_n_bit 
	generic map (n => n) 
	port map (X => X, Y=>Y_sig, S=>S_sig, Cin=>nAddSub ,Gout=>Gout, Pout=>Pout, Cout=>Cout
	);
	alu_operation <= M & F;
	nAddSub <= alu_operation(0);
	
	--Dolocanje izhoda
	with alu_operation select S <=
			S_sig when "0000",--x+y
			S_sig when "0001",--x-y
			S_sig when "0010",--x+1
			S_sig when "0011",--x-1
			S_sig when "0100",--x+x
			not zeros when "0101",
			X and Y  when "1000",
			X nand Y when "1001",
			X or Y  when "1010",
			X nor Y  when "1011",
			X xor Y  when "1100",
			X xnor Y when "1101",
			X 	when "1110",
			Y 	when "1111",
			zeros when others;
	
	--Zero-> ko je izhod enak 0 postavi ta bit
	Zero <= '0' when alu_operation = "0101" else
				  '1' when alu_operation = "1110" and X = zeros else
				  '0' when alu_operation = "1110" and X /= zeros else
				  '1' when alu_operation = "1111" and Y = zeros else
				  '0' when alu_operation = "1111" and Y /= zeros else
				  '1' when S_sig = zeros else '0';
				  
	--Dolocanje y_sig
	with alu_operation select Y_sig <=
					 Y when "0000",
				not Y when "0001",
				  one when "0010",
			 not one when "0011",
			       X when "0100",
					 Y when others;
					 
	--Overflow
	Overflow <= (not X(n-1) and not Y_sig(n-1) and S_sig(n-1)) or (X(n-1) and Y_sig(n-1) and not S_sig(n-1)); 
	
	--NEGATIVE
	with alu_operation select Negative <=
			'1' when "0101",
			X(n-1) when "1110",
			Y(n-1) when "1111",
			S_sig(n-1) when others;
			
end NDV;
