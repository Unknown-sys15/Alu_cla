LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_MISC.ALL; -- reduction operators ( AND_REDUCE, OR_REDUCE )

ENTITY cla_add_n_bit IS
    generic( n: natural := 8 );
	 
    PORT (Cin : in std_logic ;
    X, Y : in std_logic_vector( n-1 downto 0 );
    S : out std_logic_vector( n-1 downto 0 );
    Gout, Pout, Cout : out std_logic );
END cla_add_n_bit;

ARCHITECTURE NDV OF cla_add_n_bit IS
    COMPONENT cla_gp IS
    PORT ( Cin, x, y : IN STD_LOGIC;
    s, Cout, g, p : OUT STD_LOGIC );
    END COMPONENT;
    
    -- vektorji vmesnih signalov
    SIGNAL G, P : STD_LOGIC_VECTOR( n-1 DOWNTO 0 );
    SIGNAL S_sig : STD_LOGIC_VECTOR( n-1 DOWNTO 0 );
    SIGNAL Gint : STD_LOGIC_VECTOR( n-1 DOWNTO 1 );
    SIGNAL C : STD_LOGIC_VECTOR( n DOWNTO 0 );

BEGIN 

    C( 0 ) <= Cin;
    
    stages: FOR i IN 0 TO ( n-1 ) GENERATE 
		--izvedes brez port mapa v izogib izlocitvi vmesnih sign
		--cla_stage: cla_gp PORT MAP ( C(i), X(i), Y(i), S_sig(i), C(i+1), G(i),P(i) );
		G(i) <= X(i) and Y(i); -- Generate 
		P(i) <= X(i) xor Y(i); -- Propagate  
		S_sig(i) <= X(i) xor Y(i) xor C(i); -- Sum 
		C(i+1) <= G(i) or ( P(i) and C(i) ); -- Cout
	 END GENERATE;
    
	 --Calc Gint
    g_stages: FOR i IN 1 TO ( n-1 ) GENERATE
        g_stage: Gint( i ) <= AND_REDUCE( P( n-1 downto i ) ) and G ( i-1 );
    END GENERATE;
    
    Pout <= AND_REDUCE ( P );
    Gout <= G( n-1 ) or OR_REDUCE( Gint );
    S <= S_sig;
    Cout <= C( n ); -- Carry-out
    
END NDV;