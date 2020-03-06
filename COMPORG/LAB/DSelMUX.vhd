library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;

library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

library EE_212_Decoder;
use 	EE_212_Decoder.DecodeLogic.all;

ENTITY DselMUX IS
	PORT(	RD   :	IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		RT   :	IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		RET  :	IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		Sel  :	IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		Data :	OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF DselMUX IS
	BEGIN 
		WITH Sel SELECT
			Data <= RD 	 	 when RF_WSEL_RD,
				RT   	 	 when RF_WSEL_RT,
				RET   	 	 when RF_WSEL_RET,
				(others  => 'Z') when others;
END;
