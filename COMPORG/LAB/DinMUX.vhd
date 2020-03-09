library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;

library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

library EE_212_Decoder;
use 	EE_212_Decoder.DecodeLogic.all;

ENTITY DinMUX IS
	PORT(	ALUresult :	IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		MemData	  :	IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		RetAdrs	  :	IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		Sel	  :	IN  STD_LOGIC_VECTOR(1  DOWNTO 0);
		Data	  :	OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF DinMUX IS
	BEGIN 
		WITH Sel SELECT
			Data <= ALUresult 	 when RF_DSEL_ALU,
				MemData   	 when RF_DSEL_MEM,
				RetAdrs   	 when RF_DSEL_RET,
				(others  => 'Z') when others;
END;
