library IEEE;
use 	IEEE.STD_Logic_1164.All;
use 	IEEE.NUMERIC_STD.All;

Library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

Library EE_212_DECODER;
use 	EE_212_DECODER.DecodeLogic.all;


ENTITY NIAG_NSA IS -- Next Sequential instruction Address
	PORT(	PC	:	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		NSA	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0) 
	);
End Entity;

ARCHITECTURE BEHAVIORAL OF NIAG_NSA IS 
	Signal ShiftInned : STD_LOGIC_VECTOR(31 downto 0);
	Begin Process( PC ) IS BEGIN
		NSA <= STD_LOGIC_VECTOR(unsigned(pc) + 4);
	end process;
END ARCHITECTURE;