Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

Library EE_212_ALU;
use EE_212_ALU.ALU.All;

ENTITY ALU_ADD IS
	PORT(
		Ain	: 	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		Bin	: 	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
		Func	: 	IN		STD_LOGIC_VECTOR(4  DOWNTO 0);
		Rout	: 	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Stat	: 	OUT	STAT_SIGNL_REC
		);
END ENTITY;

ARCHITECTURE Behavioral OF ALU_ADD IS 
	SIGNAL Result	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	BEGIN PROCESS(Ain, Bin, Func, Result) IS BEGIN
		IF( Func = ALU_FUNC_ADD )THEN
			Result 			<= STD_LOGIC_VECTOR(unsigned(Bin) + unsigned(Ain));
			Rout 				<= Result;
			Stat.ALU_zero 	<= NOT(OR_REDUCE(STD_LOGIC_VECTOR(Result)));
			Stat.ALU_sign 	<= Result(31);
		ELSE
			Rout 				<= (others => 'Z');
			Stat				<= (others => 'Z');
		END IF;
	END PROCESS;
END ARCHITECTURE;

