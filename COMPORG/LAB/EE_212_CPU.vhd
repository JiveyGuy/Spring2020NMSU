-------------------------------------------------------------------------------------
--    Library:	EE_212_CPU
--
--       File:	EE212CPU.vhd
--	
--    Project:	LabCPU
--
--     Author:	A.K. Petersen
--
--    Purpose: define constants and components for the Central Proccessing Unit
--
--  Copyright 2019 by A.K. Petersen, New Mexico State University, all rights reserved
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library EE_212_Decoder;
use EE_212_Decoder.DecodeLogic.all;

PACKAGE LabCPU IS

	CONSTANT	CPU_BYTE_SIZE	:	INTEGER	:= 4;
	CONSTANT	CPU_BIT_SIZE	:	INTEGER	:= 32;
	
	
	COMPONENT CPU IS
		PORT(	Clk	:	IN		STD_LOGIC);
	END COMPONENT CPU;

END PACKAGE LabCPU;	
