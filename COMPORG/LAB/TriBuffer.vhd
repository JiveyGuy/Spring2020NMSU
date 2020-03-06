library IEEE;
use 	IEEE.STD_LOGIC_1164.ALL;

library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

library EE_212_Decoder;
use 	EE_212_Decoder.DecodeLogic.all;

ENTITY 	   TriBuffer IS
	PORT(	Sel	:	IN		STD_LOGIC;
		Bout	:	INOUT		STD_LOGIC_VECTOR(31 DOWNTO 0);
		DataBus	:	INOUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY TriBuffer;

ARCHITECTURE BEHAVIORAL OF TriBuffer IS
	BEGIN PROCESS( Bout, Sel) BEGIN
		IF ( Sel = '0' ) THEN
			DataBus <= (others => 'Z');		
		ELSE IF ( Sel = '1' ) THEN
			DataBus <= Bout;
		END IF;
	END PROCESS;
END;