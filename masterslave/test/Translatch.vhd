
--Libraries
library ieee;
use ieee.std_logic_1164.all;

--Entity
ENTITY TransLatch IS
	GENERIC (n: integer := 16);
	
	PORT(
		--Here you have to declare your inputs and outputs and their sizes(bits)  
	
		Reset: in STD_Logic;
		Gate: in STD_LOGIC;
		Data: in STD_LOGIC;
		
		Q_HIGH: out STD_LOGIC; 
		Q_LOW: out STD_Logic
		);
END ENTITY;

--Defines Arch behavior of Translatch
ARCHITECTURE Behavioralr of Translatch IS BEGIN
	
	process(Reset, Gate, Data) begin
		if ( Reset = '0') then --If Reset out(H) = 0, Out(L) = 1
			Q_HIGH <= '0';
			Q_LOW  <= '1';
		else 
			if (Gate = '1') then
				Q_HIGH <= Data;
				Q_LOW  <= not Data;
			end if;
		end if;	
	end process;
END;