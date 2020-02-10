Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Library work;
use work.DecodeLogic.All;

ENTITY RegFile IS
	PORT( 	
		Asel : IN 	STD_LOGIC_VECTOR(4  DOWNTO 0);
		Bsel : IN 	STD_LOGIC_VECTOR(4  DOWNTO 0);
		Dsel : IN 	STD_LOGIC_VECTOR(4  DOWNTO 0);
		Din  : IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Strb : IN 	STD_LOGIC;
		Aout : OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Bout : OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE Behavoiral of RegFile is
	signal Reg00 : STD_LOGIC_VECTOR(31 downto 0):= ( others=> '0');
	signal Reg01 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg02 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg03 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg04 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg05 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg06 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg07 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg08 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg09 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg0A : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg0B : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg0C : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg0D : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg0E : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg0F : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg10 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg11 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg12 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg13 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg14 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg15 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg16 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg17 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg18 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg19 : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg1A : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg1B : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg1C : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg1D : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg1E : STD_LOGIC_VECTOR(31 downto 0);
	signal Reg1F : STD_LOGIC_VECTOR(31 downto 0);
	
	begin
	
	Aout <= 	Reg01 when Asel= RF_REG_01 else
				Reg02 when Asel= RF_REG_02 else
				Reg03 when Asel= RF_REG_03 else
				Reg04 when Asel= RF_REG_04 else
				Reg05 when Asel= RF_REG_05 else
				Reg06 when Asel= RF_REG_06 else
				Reg07 when Asel= RF_REG_07 else
				Reg08 when Asel= RF_REG_08 else
				Reg09 when Asel= RF_REG_09 else
				Reg0A when Asel= RF_REG_0A else
				Reg0B when Asel= RF_REG_0B else
				Reg0C when Asel= RF_REG_0C else
				Reg0D when Asel= RF_REG_0D else
				Reg0E when Asel= RF_REG_0E else
				Reg0F when Asel= RF_REG_0F else
				Reg10 when Asel= RF_REG_10 else
				Reg11 when Asel= RF_REG_11 else
				Reg12 when Asel= RF_REG_12 else
				Reg13 when Asel= RF_REG_13 else
				Reg14 when Asel= RF_REG_14 else
				Reg15 when Asel= RF_REG_15 else
				Reg16 when Asel= RF_REG_16 else
				Reg17 when Asel= RF_REG_17 else
				Reg18 when Asel= RF_REG_18 else
				Reg19 when Asel= RF_REG_19 else
				Reg1A when Asel= RF_REG_1A else
				Reg1B when Asel= RF_REG_1B else
				Reg1C when Asel= RF_REG_1C else
				Reg1D when Asel= RF_REG_1D else
				Reg1E when Asel= RF_REG_1E else
				Reg1F when Asel= RF_REG_1F;

	Bout <= 	Reg01 when Bsel= RF_REG_01 else
				Reg02 when Bsel= RF_REG_02 else
				Reg03 when Bsel= RF_REG_03 else
				Reg04 when Bsel= RF_REG_04 else
				Reg05 when Bsel= RF_REG_05 else
				Reg06 when Bsel= RF_REG_06 else
				Reg07 when Bsel= RF_REG_07 else
				Reg08 when Bsel= RF_REG_08 else
				Reg09 when Bsel= RF_REG_09 else
				Reg0A when Bsel= RF_REG_0A else
				Reg0B when Bsel= RF_REG_0B else
				Reg0C when Bsel= RF_REG_0C else
				Reg0D when Bsel= RF_REG_0D else
				Reg0E when Bsel= RF_REG_0E else
				Reg0F when Bsel= RF_REG_0F else
				Reg10 when Bsel= RF_REG_10 else
				Reg11 when Bsel= RF_REG_11 else
				Reg12 when Bsel= RF_REG_12 else
				Reg13 when Bsel= RF_REG_13 else
				Reg14 when Bsel= RF_REG_14 else
				Reg15 when Bsel= RF_REG_15 else
				Reg16 when Bsel= RF_REG_16 else
				Reg17 when Bsel= RF_REG_17 else
				Reg18 when Bsel= RF_REG_18 else
				Reg19 when Bsel= RF_REG_19 else
				Reg1A when Bsel= RF_REG_1A else
				Reg1B when Bsel= RF_REG_1B else
				Reg1C when Bsel= RF_REG_1C else
				Reg1D when Bsel= RF_REG_1D else
				Reg1E when Bsel= RF_REG_1E else
				Reg1F when Bsel= RF_REG_1F;

	Process(Asel, Bsel, Dsel, Din, Strb) begin
		if( Strb = '1' ) then 
			case Dsel is
				when RF_REG_01 => Reg01 <= Din;
				when RF_REG_02 => Reg02 <= Din;
				when RF_REG_03 => Reg03 <= Din;
				when RF_REG_04 => Reg04 <= Din;
				when RF_REG_05 => Reg05 <= Din;
				when RF_REG_06 => Reg06 <= Din;
				when RF_REG_07 => Reg07 <= Din;
				when RF_REG_08 => Reg08 <= Din;
				when RF_REG_09 => Reg09 <= Din;
				when RF_REG_0A => Reg0A <= Din;
				when RF_REG_0B => Reg0B <= Din;
				when RF_REG_0C => Reg0C <= Din;
				when RF_REG_0D => Reg0D <= Din;
				when RF_REG_0E => Reg0E <= Din;
				when RF_REG_0F => Reg0F <= Din;
				when RF_REG_10 => Reg10 <= Din;
				when RF_REG_11 => Reg11 <= Din;
				when RF_REG_12 => Reg12 <= Din;
				when RF_REG_13 => Reg13 <= Din;
				when RF_REG_14 => Reg14 <= Din;
				when RF_REG_15 => Reg15 <= Din;
				when RF_REG_16 => Reg16 <= Din;
				when RF_REG_17 => Reg17 <= Din;
				when RF_REG_18 => Reg18 <= Din;
				when RF_REG_19 => Reg19 <= Din;
				when RF_REG_1A => Reg1A <= Din;
				when RF_REG_1B => Reg1B <= Din;
				when RF_REG_1C => Reg1C <= Din;
				when RF_REG_1D => Reg1D <= Din;
				when RF_REG_1E => Reg1E <= Din;
				when RF_REG_1F => Reg1F <= Din;
				when others => Reg00 <= VAL_32_ZERO;
			end case;
		end if;
	end Process;
end Behavoiral;
