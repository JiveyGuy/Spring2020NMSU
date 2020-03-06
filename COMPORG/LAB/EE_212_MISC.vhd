-------------------------------------------------------------------------------------
--    Library:	EE_212_MISC
--
--       File:	EE212MISC.vhd
--	
--    Project:	LabCPU
--
--     Author:	A.K. Petersen
--
--    Purpose: define constants and components for the Miscellaneous components
--
--  Copyright 2019 by A.K. Petersen, New Mexico State University, all rights reserved
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


PACKAGE MISC IS

	COMPONENT DinMUX IS
		PORT(	ALUresult	:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				MemData		:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				RetAdrs		:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				Sel			:	IN			STD_LOGIC_VECTOR(1  DOWNTO 0);
				Data			:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT DinMUX;

	COMPONENT DselMUX IS
		PORT(	RD				:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
				RT				:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
				RET			:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
				Sel			:	IN			STD_LOGIC_VECTOR(1 DOWNTO 0);
				Data			:	OUT		STD_LOGIC_VECTOR(4 DOWNTO 0));
	END COMPONENT DselMUX;

	COMPONENT ALUinMUX IS
		PORT(	Aout			:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				Immed			:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				Sel			:	IN			STD_LOGIC;
				Data			:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT ALUinMUX;

	COMPONENT ALUsftMUX IS
		PORT(	RS				:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
				Bout			:	IN			STD_LOGIC_VECTOR(4 DOWNTO 0);
				Sel			:	IN			STD_LOGIC;
				Data			:	OUT		STD_LOGIC_VECTOR(4 DOWNTO 0));
	END COMPONENT ALUsftMUX;
	
	COMPONENT PCMUX IS
		PORT(	NxtAdrs		:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				RelAdrs		:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				RegAdrs		:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				AbsltAdrs	:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				Sel			:	IN			STD_LOGIC_VECTOR(1  DOWNTO 0);
				Data			:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT PCMUX;
	
	COMPONENT ImmedXtnd IS
		PORT(	Immed16		:	IN			STD_LOGIC_VECTOR(15 DOWNTO 0);
				Sel			:	IN			STD_LOGIC;
				Immed32		:	INOUT		STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT ImmedXtnd;

	COMPONENT TriBuffer IS
		PORT(	Sel		:	IN			STD_LOGIC;
				Bout		:	INOUT		STD_LOGIC_VECTOR(31 DOWNTO 0);
				DataBus	:	INOUT		STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT TriBuffer;

END PACKAGE MISC;	