library IEEE;
use 	IEEE.STD_Logic_1164.All;
use 	IEEE.NUMERIC_STD.All;

Library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

Library EE_212_DECODER;
use 	EE_212_DECODER.DecodeLogic.all;


ENTITY  NIAG_Rel IS
	PORT(	Immed 	:	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Xshft	:	IN	STD_LOGIC;
		NSA	:	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		RelAdrs	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF NIAG_Rel IS 
	Signal ShiftInned : STD_LOGIC_VECTOR(31 downto 0);
 
	BEGIN Process( Immed, Xshft, NSA) IS BEGIN
		IF ( Xshft = IR_XLSFT_TWO ) then
	 		ShiftInned <= Immed(29 downto 0) & "00";
		else
	 		ShiftInned <= Immed;
		end if;
			RelAdrs <= STD_LOGIC_VECTOR(Unsigned(NSA)+unsigned(ShiftInned));
	end process;
END ARCHITECTURE;