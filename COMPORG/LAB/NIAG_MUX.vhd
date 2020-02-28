library IEEE;
use 	IEEE.STD_Logic_1164.All;
use 	IEEE.NUMERIC_STD.All;

Library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

Library EE_212_DECODER;
use 	EE_212_DECODER.DecodeLogic.all;

ENTITY NIAG_MUX IS 
	PORT( 	NxtAdrs 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		AbsltAdrs 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RelAdrs 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RegAdrs 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Cond 		: IN STD_LOGIC_VECTOR(2  DOWNTO 0);
		Sel 		: IN STD_LOGIC_VECTOR(1  DOWNTO 0);
		Stat 		: IN STAT_SIGNL_REC;
		InstrAdrs	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF NIAG_MUX IS 
	SIGNAL MUX_Sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	BEGIN PROCESS ( Cond, Sel, Stat, MUX_Sel, AbsltAdrs, RelAdrs, RegAdrs, NxtAdrs) IS BEGIN
		IF Sel /= NIAG_SEL_FLOAT THEN
			IF Sel /= NIAG_SEL_REL THEN
				MUX_Sel <= Sel;
			ELSE
				CASE Cond IS
					WHEN NIAG_COND_EQ => IF Stat.ALU_Zero = ALU_STAT_ZERO THEN
						Mux_Sel <= NIAG_SEL_REL;
					END IF;

					WHEN NIAG_COND_NEQ => IF Stat.ALU_Zero = ALU_STAT_N_ZERO THEN
						Mux_Sel <= NIAG_SEL_REL;
					END IF;

					WHEN NIAG_COND_GTZ => IF (Stat.ALU_Zero = ALU_STAT_N_ZERO) AND (Stat.ALU_Sign = ALU_STAT_POS) THEN
						Mux_Sel <= NIAG_SEL_REL;
					END IF;

					WHEN NIAG_COND_LTZ => IF (Stat.ALU_Zero = ALU_STAT_N_ZERO) AND (Stat.ALU_Sign = ALU_STAT_NEG) THEN
						Mux_Sel <= NIAG_SEL_REL;
					END IF;

					WHEN NIAG_COND_GEZ => IF (Stat.ALU_Zero = ALU_STAT_ZERO) OR (Stat.ALU_Sign = ALU_STAT_POS) THEN
						Mux_Sel <= NIAG_SEL_REL;
					END IF;

					WHEN NIAG_COND_LEZ => IF (Stat.ALU_Zero = ALU_STAT_N_ZERO) AND (Stat.ALU_Sign = ALU_STAT_NEG) THEN
						Mux_Sel <= NIAG_SEL_REL;
					END IF;

					WHEN OTHERS => MUX_Sel <= NIAG_SEL_NSA;
				END CASE;
			END IF;
		END IF;
	END PROCESS;

	WITH MUX_Sel SELECT
		INSTRAdrs <= 	AbsltAdrs WHEN NIAG_SEL_ABS,  
				RelAdrs   WHEN NIAG_SEL_REL,
				RegAdrs   WHEN NIAG_SEL_REG,
				NxtAdrs   WHEN OTHERS;
END ARCHITECTURE;
