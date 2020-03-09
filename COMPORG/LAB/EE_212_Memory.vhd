-------------------------------------------------------------------------------------
--    Library:	EE_212_Memory
--
--       File:	EE212Memory.vhd
--	
--    Project:	LabCPU
--
--     Author:	A.K. Petersen
--
--    Purpose: define constants and components for the system memory
--
--  Copyright 2019 by A.K. Petersen, New Mexico State University, all rights reserved
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


PACKAGE Memory IS
	TYPE	RAM_Memory IS ARRAY(0 to 511) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	TYPE	ROM_Memory IS ARRAY(0 to 511) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	COMPONENT RAM IS
		PORT(	Addr	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Strb	:	IN		STD_LOGIC;
				 rw	:	IN		STD_LOGIC;
				 en	:	IN		STD_LOGIC;
			  Data	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
			 );
	END COMPONENT RAM;

	
	COMPONENT ROM IS
		PORT(	Addr	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			  Data	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
			 );
	END COMPONENT ROM;
END PACKAGE Memory;	
