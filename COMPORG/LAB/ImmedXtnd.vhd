library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;

library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

library EE_212_Decoder;
use 	EE_212_Decoder.DecodeLogic.all;

ENTITY 	   ImmedXtnd IS
	PORT(	Immed16	: IN	STD_LOGIC_VECTOR(15 DOWNTO 0);
		Sel	: IN	STD_LOGIC;
		Immed32	: INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY ImmedXtnd;

ARCHITECTURE BEHAVIORAL OF ImmedXtnd IS
	BEGIN PROCESS( Immed16, Sel) BEGIN
		IF( Sel = '0' ) THEN
				Immed32 <= x"0000" & Immed16;
		END IF;
		IF( Sel = '1' ) THEN
			IF( Immed16(15) = '1' ) THEN
				Immed32 <= x"FFFF" & Immed16;
			ELSE
				Immed32 <= x"0000" & Immed16;
			END IF;
		END IF;
	END PROCESS;
END;
