library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;

library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

library EE_212_Decoder;
use 	EE_212_Decoder.DecodeLogic.all;

ENTITY ALUinMUX IS
	PORT(	Aout	: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Immed	: IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Sel	: IN	STD_LOGIC;
		Data	: OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF ALUinMUX IS
	BEGIN 
		WITH Sel SELECT
			Data <= Aout 	 	 when ALU_ASEL_AOUT,
				Immed  	 	 when ALU_ASEL_IMMED,
				(others  => 'Z') when others;
END;
