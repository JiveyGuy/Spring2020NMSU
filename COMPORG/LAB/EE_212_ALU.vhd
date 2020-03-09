
--------------------------------------------------------------------------------------
--    Library:	EE_212_ALU
--
--       File:	EE212ALU.vhd
--	
--    Project:	LabCPU
--
--     Author:	A.K. Petersen
--
--    Purpose: define constants and components for the CPU's ALU
--
--  Copyright 2019 by A.K. Petersen, New Mexico State University, all rights reserved
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

PACKAGE ALU IS
																									-- ALU function codes
	CONSTANT		ALU_FUNC_FLOAT	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "ZZZZZ";	--		float (not used)
	CONSTANT		ALU_FUNC_ADD	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";	--		addition
	CONSTANT		ALU_FUNC_SUB	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";	--		subtration
	CONSTANT		ALU_FUNC_MULS	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00010";	--		signed multiplication
	CONSTANT		ALU_FUNC_MULU	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00011";	--		unsigned multiplication
	CONSTANT		ALU_FUNC_MADS	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00100";	--		signed multiplication & add
	CONSTANT		ALU_FUNC_MADU	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00101";	--		unsigned multiplication & add
	CONSTANT		ALU_FUNC_MSBS	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00110";	--		signed multiplication & subtract
	CONSTANT		ALU_FUNC_MSBU	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00111";	--		unsigned multiplication & subtract
	CONSTANT		ALU_FUNC_DIVS	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "01000";	--		signed division
	CONSTANT		ALU_FUNC_DIVU	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "01001";	--		unsigned division
	CONSTANT		ALU_FUNC_NEG	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "01010";	--		negation
	CONSTANT		ALU_FUNC_SLA	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "01011";	--		shift left arithmetic
	CONSTANT		ALU_FUNC_SRA	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "01100";	--		shift right arithmetic
	CONSTANT		ALU_FUNC_SOLS	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "01101";	--		signed set on less
	CONSTANT		ALU_FUNC_SOLU	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "01110";	--		unsigned set on less
	CONSTANT		ALU_FUNC_AND	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "01111";	--		bitwise AND
	CONSTANT		ALU_FUNC_NAND	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000";	--		bitwise NAND
	CONSTANT		ALU_FUNC_OR		:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10001";	--		bitwise OR
	CONSTANT		ALU_FUNC_NOR	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10010";	--		bitwise NOR
	CONSTANT		ALU_FUNC_XOR	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10011";	--		bitwise XOR
	CONSTANT		ALU_FUNC_XNOR	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10100";	--		bitwise XNOR
	CONSTANT		ALU_FUNC_NOT	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10101";	--		bitwise inversion
	CONSTANT		ALU_FUNC_SLL	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10110";	--		shift left logical
	CONSTANT		ALU_FUNC_SRL	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10111";	--		shift right logical

	CONSTANT		ALU_FUNC_RDLO	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "11100";	--		read LO register
	CONSTANT		ALU_FUNC_RDHI	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "11101";	--		read HI register
	CONSTANT		ALU_FUNC_WRLO	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "11110";	--		write LO register
	CONSTANT		ALU_FUNC_WRHI	:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "11111";	--		write HI register

	CONSTANT		ALU_STAT_FLOAT	:	STD_LOGIC						  := 'Z';		--		status code float (don't use)
	CONSTANT		ALU_STAT_N_ZERO:	STD_LOGIC						  := '0';		--		status code reset
	CONSTANT		ALU_STAT_ZERO	:	STD_LOGIC						  := '1';		--		status code set
	CONSTANT		ALU_STAT_POS	:	STD_LOGIC						  := '0';		--		status code reset
	CONSTANT		ALU_STAT_NEG	:	STD_LOGIC						  := '1';		--		status code set
	
																									-- ALU A input MUX select
																									-- Status code vector bit assignments
	TYPE STAT_SIGNL_REC is record															--  status signal record										
		ALU_zero			:	std_logic;														--		zero status                
		ALU_sign			:	std_logic;														--		sign ststus                
	END RECORD;  
 

																									--    alu body (calls the operations)
	COMPONENT ALU IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);							--			A input value
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);							--			B input value
			Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);								--			Function code input
			Shft	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);								--			Shift input value
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);							--			Result output value
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--	operation components
																									--    addition operation
	COMPONENT ALU_ADD IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    subtract operation
	COMPONENT ALU_SUB IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    signed multiply operation
	COMPONENT ALU_MULS IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			HiReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			LoReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    unsigned multiply operation
	COMPONENT ALU_MULU IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			HiReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			LoReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    signed multiply & add operation
	COMPONENT ALU_MADS IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			HiReg	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			LoReg	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    unsigned multiply & add operation
	COMPONENT ALU_MADU IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			HiReg	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			LoReg	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    signed multiply & subtract operation
	COMPONENT ALU_MSBS IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			HiReg	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			LoReg	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    unsigned multiply & subtract operation
	COMPONENT ALU_MSBU IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			HiReg	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			LoReg	:	INOUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    signed divide operation
	COMPONENT ALU_DIVS IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			HiReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			LoReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    unsigned divide operation
	COMPONENT ALU_DIVU IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			HiReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			LoReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    negate operation
	COMPONENT ALU_NEG IS
		PORT(	Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    shift left arithmetic operation
	COMPONENT ALU_SLA IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Shft	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    shift right arithmetic operation
	COMPONENT ALU_SRA IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Shft	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    signed set on less operation
	COMPONENT ALU_SOLS IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    unsigned set on less operation
	COMPONENT ALU_SOLU IS
	PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
			Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
			Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    read LO operation
	COMPONENT ALU_RDLO IS
		PORT(	LoReg	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    read HI operation
	COMPONENT ALU_RDHI IS
		PORT(	HiReg	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    write HI operation
	COMPONENT ALU_WRHI IS
		PORT(	Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				HiReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;

																									--    write LO operation
	COMPONENT ALU_WRLO IS
		PORT(	Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				LoReg	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0));
	END COMPONENT;

																									--    AND operation
	COMPONENT ALU_AND IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    NAND operation
	COMPONENT ALU_NAND IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    OR operation
	COMPONENT ALU_OR IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    NOR operation
	COMPONENT ALU_NOR IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    XOR operation
	COMPONENT ALU_XOR IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    XNOR operation
	COMPONENT ALU_XNOR IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    negate operation
	COMPONENT ALU_NOT IS
		PORT(	Bin	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    shift left logical operation
	COMPONENT ALU_SLL IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Shft	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;

																									--    shift right logical operation
	COMPONENT ALU_SRL IS
		PORT(	Ain	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
				Func	:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
				Shft	:	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
				Rout	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
				Stat	:	OUT	STAT_SIGNL_REC);
	END COMPONENT;
END PACKAGE;

