-------------------------------------------------------------------------------------
--    Library:	EE_212_PC
--
--       File:	EE212PC.vhd
--	
--    Project:	LabCPU
--
--     Author:	A.K. Petersen
--
--    Purpose: define constants and components for the Program counter
--
--  Copyright 2019 by A.K. Petersen, New Mexico State University, all rights reserved
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library EE_212_ALU;
use EE_212_ALU.ALU.all;

PACKAGE NIAG IS

	COMPONENT NIAG IS																-- Program Counter
		PORT(	Target	:	IN		STD_LOGIC_VECTOR(25 DOWNTO 0);
				Immed		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Reg		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Xshft		:	IN		STD_LOGIC;
				PCin		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Cond		:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				Sel		:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				Stat		:	IN		STAT_SIGNL_REC;
				MemAdrs	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				RtnAdrs	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT NIAG;
	
	COMPONENT NIAG_NSA IS														-- Next Sequential instruction Address
		PORT(	PC			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				NSA		:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT NIAG_NSA;
	
	COMPONENT NIAG_Abslt IS
		PORT(	Index 	:	IN		STD_LOGIC_VECTOR(25 DOWNTO 0);
				NSA		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				AbsltAdrs:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT NIAG_Abslt;
	
	COMPONENT NIAG_Rel IS
		PORT(	Immed 	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Xshft		:	IN		STD_LOGIC;
				NSA		:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				RelAdrs	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT NIAG_Rel;
	
	COMPONENT NIAG_ReG IS
		PORT(	Reg	 	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				RegAdrs	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT NIAG_Reg;

	COMPONENT NIAG_MUX IS
		PORT(	NxtAdrs	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				AbsltAdrs:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				RelAdrs	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				RegAdrs	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Cond		:	IN		STD_LOGIC_VECTOR(2  DOWNTO 0);
				Sel		:	IN		STD_LOGIC_VECTOR(1  DOWNTO 0);
				Stat		:	IN		STAT_SIGNL_REC;
				InstrAdrs:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT NIAG_MUX;

	COMPONENT NIAG_Rtn IS
		PORT(	PC			:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				RtnAdrs	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT NIAG_Rtn;

END PACKAGE NIAG;	
