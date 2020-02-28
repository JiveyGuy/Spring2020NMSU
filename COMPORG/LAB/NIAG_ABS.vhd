library IEEE;
use 	IEEE.STD_Logic_1164.All;
use 	IEEE.NUMERIC_STD.All;

Library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

Library EE_212_DECODER;
use 	EE_212_DECODER.DecodeLogic.all;


ENTITY  NIAG_Abslt IS
	PORT(	Index 		:	IN		STD_LOGIC_VECTOR(25 DOWNTO 0);
		NSA		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		AbsltAdrs	:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF NIAG_Abslt IS BEGIN
		AbsltAdrs <= NSA(31 DOWNTO 28) & Index & "00";
END ARCHITECTURE;