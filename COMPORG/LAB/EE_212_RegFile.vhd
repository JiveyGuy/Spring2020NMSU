-------------------------------------------------------------------------------------
--    Library:	EE_212_RegFile
--
--       File:	EE212RegFile.vhd
--	
--    Project:	LabCPU
--
--     Author:	A.K. Petersen
--
--    Purpose: define constants and components for the Register File
--
--  Copyright 2019 by A.K. Petersen, New Mexico State University, all rights reserved
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library EE_212_Decoder;
use EE_212_Decoder.DecodeLogic.all;

PACKAGE RegFile IS

	FUNCTION	RF_mask (Reg : std_logic_vector(31 DOWNTO 0); Func : std_logic_vector(1 downto 0); Field : std_logic_vector(2 downto 0)) RETURN std_logic_vector;


	COMPONENT RegFile IS															-- register file
		PORT(	Asel	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
				Bsel	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
				Dsel	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
				 Din	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				func	:	IN		std_logic_vector(1 downto 0);
				field	:	IN		std_logic_vector(2 downto 0);
				Strb	:	IN		STD_LOGIC;
				Aout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT RegFile;
	
END PACKAGE RegFile;	

	
PACKAGE BODY RegFile IS
	
	FUNCTION	RF_mask (Reg : std_logic_vector(31 DOWNTO 0); Func : std_logic_vector(1 downto 0); Field : std_logic_vector(2 downto 0)) RETURN std_logic_vector IS

		VARIABLE	MaskWord	:	std_logic_vector(31 DOWNTO 0);
		VARIABLE	Result	:	std_logic_vector(31 DOWNTO 0);

		BEGIN
			IF (Field = RF_FIELD_WORD) AND (Func = RF_FUNC_AND) THEN					-- do any masking?
				Result := Reg;																		--		No- just return Reg
			ELSE																						--    YES-
				CASE Field IS																		-- 		reset msb then choose the mask to apply
					WHEN RF_FIELD_WORD		=>	MaskWord := RF_FIELD_WORD_MASK;		--				keep all 32 bits
					WHEN RF_FIELD_HALF_MSH	=>	MaskWord := RF_FIELD_HALF_LSH_MASK;	-- 			Keep most significant half word
					WHEN RF_FIELD_HALF_LSH	=>	MaskWord := RF_FIELD_HALF_MSH_MASK;	-- 			Keep least significant half word
					WHEN RF_FIELD_BYTE_MSB	=>	MaskWord := RF_FIELD_BYTE_MSB_MASK;	-- 			keep most significant byte
					WHEN RF_FIELD_BYTE_3		=>	MaskWord := RF_FIELD_BYTE_3_MASK;	-- 			keep next-to-most significant byte
					WHEN RF_FIELD_BYTE_2		=>	MaskWord := RF_FIELD_BYTE_2_MASK;	-- 			keep next-to-least significant byte
					WHEN RF_FIELD_BYTE_LSB	=>	MaskWord := RF_FIELD_BYTE_LSB_MASK;	-- 			keep least significant byte
					WHEN OTHERS					=>	MaskWord := RF_FIELD_NONE_MASK;		-- 			don't keep anything
				END CASE;

				CASE Func IS																		-- 		isolate function bits then calculate the result
					WHEN RF_FUNC_AND			=>	Result := Reg AND MaskWord;			--				turn 1's into 0's
					WHEN RF_FUNC_OR			=>	Result := Reg OR  MaskWord;			-- 			turn 0's into 1's
					WHEN RF_FUNC_NAND			=>	Result := Reg AND NOT MaskWord;		-- 			AND against an inverted mask
					WHEN RF_FUNC_NOR			=>	Result := Reg OR  NOT MaskWord;		-- 			OR against an inverted mask
					WHEN OTHERS					=>	Result := Reg;								-- 			don't change anything
				END CASE;
			END IF;

			RETURN Result;																			-- return result 
			
	END RF_mask;
		
	
END PACKAGE BODY RegFile;