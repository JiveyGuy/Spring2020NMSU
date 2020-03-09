-------------------------------------------------------------------------------------
--    Library:	EE_212_RatsNest
--
--       File:	EE212RatsNest.vhd
--	
--    Project:	LabCPU
--
--     Author:	A.K. Petersen
--
--    Purpose: define constants and components for the Rats Nest
--
--  Copyright 2019 by A.K. Petersen, New Mexico State University, all rights reserved
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


PACKAGE RatsNest IS
	COMPONENT RatsNest IS
		PORT(	AluRslt	:	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
				RW			:	IN			STD_LOGIC;
				EN			:	IN			STD_LOGIC;
				Size		:	IN			STD_LOGIC_VECTOR(3  DOWNTO 0);
				RFin		:	INOUT		STD_LOGIC_VECTOR(31 DOWNTO 0);
				DataBus	:	INOUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END COMPONENT RatsNest;
END PACKAGE RatsNest;	
