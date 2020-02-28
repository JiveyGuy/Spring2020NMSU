library IEEE;
use 	IEEE.STD_Logic_1164.All;
use 	IEEE.NUMERIC_STD.All;

Library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

Library EE_212_DECODER;
use 	EE_212_DECODER.DecodeLogic.all;


ENTITY NIAG_REG IS 
	PORT( 	Reg 		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RegAdrs 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF NIAG_REG IS 
	BEGIN PROCESS (Reg)BEGIN
		RegAdrs <= Reg;
	END PROCESS;
END ARCHITECTURE;

-- This just gives Reg to RegAdrs