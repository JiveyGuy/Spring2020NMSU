
--------------------------------------------------------------------------------------
--    Library:	EE_212_Decoder
--
--       File:	EE_212_Decoder.vhd
--	
--    Project:	LabCPU
--
--     Author:	A.K. Petersen
--
--    Purpose: define constants and components for the Instruction Decode Logic
--
--  Copyright 2019 by A.K. Petersen, New Mexico State University, all rights reserved
--
-------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.ALU.all;

PACKAGE DecodeLogic IS																							-- CPU instruction opcodes
																									
	CONSTANT	CPU_OPCODE_SPECIAL	:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";					--    R-type instruction opcode
	CONSTANT	CPU_OPCODE_SPECIAL2	:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "011100";					--    Multiply & accumulate opcode
	CONSTANT	CPU_OPCODE_REGIMM		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000001";					--    Branch instruction opcode
																									
																									
																														--		add signed word
	CONSTANT	CPU_ADD_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--       IR opcode field value
	CONSTANT	CPU_ADD_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100000";					--			IR func field value

	CONSTANT	CPU_ADDI_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";					--		add immediate signed word

	CONSTANT	CPU_ADDIU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001001";					--		add immediate unsigned word

	CONSTANT	CPU_ADDU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		add unsigned word
	CONSTANT	CPU_ADDU_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100001";
	
	CONSTANT	CPU_AND_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		and word
	CONSTANT	CPU_AND_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100100";

	CONSTANT	CPU_ANDI_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001100";					--		and immediate word

	CONSTANT	CPU_BEQ_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";					--		branch on =

	CONSTANT	CPU_BGEZ_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_REGIMM;		--		branch on >=0
	CONSTANT	CPU_BGEZ_RT				:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";

	CONSTANT	CPU_BGEZAL_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_REGIMM;		--		branch & link on >=0
	CONSTANT	CPU_BGEZAL_RT			:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10001";

	CONSTANT	CPU_BGTZ_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000111";					--		branch on >0

	CONSTANT	CPU_BLEZ_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000110";					--		branch on <=0

	CONSTANT	CPU_BLTZ_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_REGIMM;		--		branch on <0
	CONSTANT	CPU_BLTZ_RT				:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";

	CONSTANT	CPU_BLTZAL_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_REGIMM;		--		branch & link on <0
	CONSTANT	CPU_BLTZAL_RT			:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000";

	CONSTANT	CPU_BNE_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";					--		branch on !=
	CONSTANT	CPU_BNE_RT				:	STD_LOGIC_VECTOR(4 DOWNTO 0) := "-----";

	CONSTANT	CPU_DIV_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		divide signed word
	CONSTANT	CPU_DIV_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "011010";

	CONSTANT	CPU_DIVU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		divide unsigned word
	CONSTANT	CPU_DIVU_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "011011";

	CONSTANT	CPU_J_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";					--		jump

	CONSTANT	CPU_JAL_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000011";					--		jump and link

	CONSTANT	CPU_JALR_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		jump & link register
	CONSTANT	CPU_JALR_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001001";

	CONSTANT	CPU_JR_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		jump register
	CONSTANT	CPU_JR_FUNC				:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";

	CONSTANT	CPU_LB_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100000";					--		load signed byte

	CONSTANT	CPU_LBU_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100100";					--		load unsigned byte

	CONSTANT	CPU_LH_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100001";					--		load signed half word

	CONSTANT	CPU_LHU_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100101";					--		load unsigned half word

	CONSTANT	CPU_LUI_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001111";					--		load upper immediate

	CONSTANT	CPU_LW_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100011";					--		load word

	CONSTANT	CPU_LWL_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100010";					--		load word left

	CONSTANT	CPU_LWR_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100110";					--		load word right

	CONSTANT	CPU_MADD_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL2;	--		multiply & add signed word
	CONSTANT	CPU_MADD_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";

	CONSTANT	CPU_MADDU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL2;	--		multiply & add unsigned word
	CONSTANT	CPU_MADDU_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000001";

	CONSTANT	CPU_MFHI_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		move from HI
	CONSTANT	CPU_MFHI_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "010000";

	CONSTANT	CPU_MFLO_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		move from LO
	CONSTANT	CPU_MFLO_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "010010";

	CONSTANT	CPU_MSUB_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL2;	--		multiply & subtract signed word
	CONSTANT	CPU_MSUB_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";

	CONSTANT	CPU_MSUBU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL2;	--		multiply & subtract unsigned word
	CONSTANT	CPU_MSUBU_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";

	CONSTANT	CPU_MTHI_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		move to HI
	CONSTANT	CPU_MTHI_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "010001";

	CONSTANT	CPU_MTLO_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		move to LO
	CONSTANT	CPU_MTLO_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "010011";

	CONSTANT	CPU_MUL_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL2;	--		multiply half word
	CONSTANT	CPU_MUL_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";

	CONSTANT	CPU_MULT_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		multiply signed word
	CONSTANT	CPU_MULT_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "011000";

	CONSTANT	CPU_MULTU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		multipy unsigned word
	CONSTANT	CPU_MULTU_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "011001";
	
	CONSTANT	CPU_NOR_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		nor word
	CONSTANT	CPU_NOR_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100111";

	CONSTANT	CPU_OR_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		or word
	CONSTANT	CPU_OR_FUNC				:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100101";

	CONSTANT	CPU_ORI_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001101";					--		or immediate word

	CONSTANT	CPU_SB_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "101000";					--		store byte

	CONSTANT	CPU_SH_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "101001";					--		store half word

	CONSTANT	CPU_SLA_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		shift left arithmetic
	CONSTANT	CPU_SLA_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000001";

	CONSTANT	CPU_SLAV_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		shift left arithmetic variable
	CONSTANT	CPU_SLAV_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";

	CONSTANT	CPU_SLL_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		shift left logical
	CONSTANT	CPU_SLL_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";

	CONSTANT	CPU_SLLV_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		shift left logical variable
	CONSTANT	CPU_SLLV_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";

	CONSTANT	CPU_SLT_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		set on < (signed)
	CONSTANT	CPU_SLT_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "101010";

	CONSTANT	CPU_SLTI_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001010";					--		set on < immediate (signed)

	CONSTANT	CPU_SLTIU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001011";					--		set on < immediate (unsigned)

	CONSTANT	CPU_SLTU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		set on < (unsigned)
	CONSTANT	CPU_SLTU_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "101011";

	CONSTANT	CPU_SRA_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		shift right arithmetic
	CONSTANT	CPU_SRA_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000011";

	CONSTANT	CPU_SRAV_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		shift right arithmetic variable
	CONSTANT	CPU_SRAV_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000111";

	CONSTANT	CPU_SRL_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		shift right logical
	CONSTANT	CPU_SRL_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";

	CONSTANT	CPU_SRLV_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		shift right logical variable
	CONSTANT	CPU_SRLV_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000110";

	CONSTANT	CPU_SUB_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		subtract signed word
	CONSTANT	CPU_SUB_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100010";

	CONSTANT	CPU_SUBU_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		subtract unsigned word
	CONSTANT	CPU_SUBU_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100011";

	CONSTANT	CPU_SW_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "101011";					--		store word

	CONSTANT	CPU_SWL_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "101010";					--		store word left

	CONSTANT	CPU_SWR_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "101110";					--		store word right

	CONSTANT	CPU_XOR_OPCODE			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := CPU_OPCODE_SPECIAL;	--		xor word
	CONSTANT	CPU_XOR_FUNC			:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "100110";

	CONSTANT	CPU_XORI_OPCODE		:	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001110";					--		XOR immediate word
	

	CONSTANT	ALU_ASEL_FLOAT			:	STD_LOGIC							:= 'Z';						--		ALU_ASEL float (not used)
	CONSTANT	ALU_ASEL_AOUT			:	STD_LOGIC							:= '0';						--		ALU_ASEL RF A output
	CONSTANT	ALU_ASEL_IMMED			:	STD_LOGIC							:= '1';						--		ALU_ASEL IR immediate field
	
	CONSTANT	ALU_SSEL_FLOAT			:	STD_LOGIC							:= 'Z';						--		ALU_SSEL float (not used)
	CONSTANT	ALU_SSEL_RS				:	STD_LOGIC							:= '0';						--		ALU_SSEL IR shift field
	CONSTANT	ALU_SSEL_BOUT			:	STD_LOGIC							:= '1';						--		ALU_SSEL RF B output
	
	CONSTANT	DM_STRB_FLOAT			:	STD_LOGIC							:= 'Z';						--		DN_STRB float (not used)
	CONSTANT	DM_STRB_HOLD			:	STD_LOGIC							:= '0';						--		DN_STRB hold data
	CONSTANT	DM_STRB_STORE			:	STD_LOGIC							:= '1';						--		DM_STRB store data
	
	CONSTANT	DM_RW_FLOAT				:	STD_LOGIC							:= 'Z';						--		DM_rw float (not used)
	CONSTANT	DM_RW_WR					:	STD_LOGIC							:= '0';						--		DM_rw write
	CONSTANT	DM_RW_RD					:	STD_LOGIC							:= '1';						--		DM_rw read
	
	CONSTANT	DM_EN_FLOAT				:	STD_LOGIC							:= 'Z';						--		DM_EN float (not used)
	CONSTANT	DM_EN_DISABLE			:	STD_LOGIC							:= '0';						--		DM_EN	disable
	CONSTANT	DM_EN_ENABLE			:	STD_LOGIC							:= '1';						--		DM_EN enable

	CONSTANT	RN_SIZE_FLOAT			:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "ZZZZ";					--		RN_size float (not used)
	CONSTANT	RN_SIZE_NONE			:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0000";					--		RN_size no masking
	CONSTANT	RN_SIZE_UWORD			:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0001";					--		RN_size signed 32 bits
	CONSTANT	RN_SIZE_UHALF_LSH		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0010";					--		RN_size signed LS 16 bits
	CONSTANT	RN_SIZE_UHALF_MSH		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0011";					--		RN_size signed MS 16 bits
	CONSTANT	RN_SIZE_UBYTE_MSB		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0100";					--		RN_size signed LS 8 bits
	CONSTANT	RN_SIZE_UBYTE_3		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0101";					--		RN_size signed next-to LS 8 bits
	CONSTANT	RN_SIZE_UBYTE_2		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0110";					--		RN_size signed next-to MS 8 bits
	CONSTANT	RN_SIZE_UBYTE_LSB		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0111";					--		RN_size signed MS 8 bits

	CONSTANT	RN_SIZE_SIGN_BIT_MAsk:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "0111";					--		RN_size signed MS 8 bits

	CONSTANT	RN_SIZE_UNSIGNED		:	STD_LOGIC							:= '0';						--		RN_size unsigned
	CONSTANT	RN_SIZE_SIGNED			:	STD_LOGIC							:= '1';						--		RN_size signed

	CONSTANT	RN_SIZE_SWORD			:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "1001";					--		RN_size unsigned 32 bits
	CONSTANT	RN_SIZE_SHALF_LSH		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "1010";					--		RN_size unsigned LS 16 bits
	CONSTANT	RN_SIZE_SHALF_MSH		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "1011";					--		RN_size unsigned MS 16 bits
	CONSTANT	RN_SIZE_SBYTE_MSB		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "1100";					--		RN_size unsigned LS 8 bits
	CONSTANT	RN_SIZE_SBYTE_3		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "1101";					--		RN_size unsigned next-to LS 8 bits
	CONSTANT	RN_SIZE_SBYTE_2		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "1110";					--		RN_size unsigned next-to MS 8 bits
	CONSTANT	RN_SIZE_SBYTE_LSB		:	STD_LOGIC_VECTOR(3 DOWNTO 0)	:= "1111";					--		RN_size unsigned MS 8 bits
	
	CONSTANT	NIAG_SEL_FLOAT			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "ZZ";						--		NIAG_sel float (not used)
	CONSTANT	NIAG_SEL_NSA			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "00";						--		NIAG_sel Next Sequential Address
	CONSTANT	NIAG_SEL_REL			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "01";						--		NIAG_sel Relative
	CONSTANT	NIAG_SEL_REG			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "10";						--		NIAG_sel Register
	CONSTANT	NIAG_SEL_ABS			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "11";						--		NIAG_sel Absolute

	CONSTANT	NIAG_STRB_FLOAT		:	STD_LOGIC							:= 'Z';						--		NIAG_STRB don't load
	CONSTANT	NIAG_STRB_HOLD			:	STD_LOGIC							:= '0';						--		NIAG_STRB don't load
	CONSTANT	NIAG_STRB_STROBE		:	STD_LOGIC							:= '1';						--		NIAG_STRB load
	
	CONSTANT	NIAG_COND_FLOAT		:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "ZZZ";					--		NIAG_COND float (not used)
	CONSTANT	NIAG_COND_NONE			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "000";					--		NIAG_COND Unconditional
	CONSTANT	NIAG_COND_EQ			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "001";					--		NIAG_COND rs  = rt
	CONSTANT	NIAG_COND_NEQ			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "010";					--		NIAG_COND rs != rt
	CONSTANT	NIAG_COND_GTZ			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "011";					--		NIAG_COND rs >  0	
	CONSTANT	NIAG_COND_GEZ			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "100";					--		NIAG_COND rs >= 0
	CONSTANT	NIAG_COND_LTZ			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "101";					--		NIAG_COND rs <  0
	CONSTANT	NIAG_COND_LEZ			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "110";					--		NIAG_COND rs <= 0

	CONSTANT	IR_STRB_FLOAT			:	STD_LOGIC							:= 'Z';						--		IR_STRB float (not used)
	CONSTANT	IR_STRB_HOLD			:	STD_LOGIC							:= '0';						--		IR_STRB don't load
	CONSTANT	IR_STRB_STROBE			:	STD_LOGIC							:= '1';						--		IR_STRB load

	CONSTANT	IR_XSEL_FLOAT			:	STD_LOGIC							:= 'Z';						--		IR_XSEL float (not used)
	CONSTANT	IR_XSEL_ZERO			:	STD_LOGIC							:= '0';						--		IR_XSEL zero pad
	CONSTANT	IR_XSEL_SIGN			:	STD_LOGIC							:= '1';						--		IR_XSEL sign extend
	
	CONSTANT	IR_XLSFT_FLOAT			:	STD_LOGIC							:= 'Z';						--		IR_XLSFT float (not used)
	CONSTANT	IR_XLSFT_NONE			:	STD_LOGIC							:= '0';						--		IR_XLSFT don't shift
	CONSTANT	IR_XLSFT_TWO			:	STD_LOGIC							:= '1';						--		IR_XLSFT shift left 2
	
	CONSTANT	RF_DSEL_FLOAT			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "ZZ";						--		RF_Dsel float (not used)
	CONSTANT	RF_DSEL_ALU				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "00";						--		RF_Dsel ALU result bus
	CONSTANT	RF_DSEL_MEM				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "01";						--		RF_Dsel memory data bus
	CONSTANT	RF_DSEL_RET				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "10";						--		RF_Dsel return address
	
	CONSTANT	RF_STRB_FLOAT			:	STD_LOGIC							:= 'Z';						--		RF_STRB float (not used)
	CONSTANT	RF_STRB_HOLD			:	STD_LOGIC							:= '0';						--		RF_STRB don't strobe
	CONSTANT	RF_STRB_STROBE			:	STD_LOGIC							:= '1';						--		RF_STRB strobe

	CONSTANT	RF_WSEL_FLOAT			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "ZZ";						--		RF_Wsel float (not used)
	CONSTANT	RF_WSEL_RD				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "00";						--		RF_Wsel IR reg RD field
	CONSTANT	RF_WSEL_RT				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "01";						--		RF_Wsel IR reg RT field
	CONSTANT	RF_WSEL_RET				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "10";						--		RF_Wsel return address
																								 
	CONSTANT	RF_FIELD_FLOAT			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "ZZZ";					--		RF_field float (not used)
	CONSTANT	RF_FIELD_WORD			:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "000";					--		RF_field full word
	CONSTANT	RF_FIELD_HALF_MSH		:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "001";					--		RF_field most significant half-word
	CONSTANT	RF_FIELD_HALF_LSH		:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "010";					--		RF_field least significant half-word
	CONSTANT	RF_FIELD_BYTE_MSB		:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "011";					--		RF_field most significant byte
	CONSTANT	RF_FIELD_BYTE_3		:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "100";					--		RF_field next-to-most significant byte
	CONSTANT	RF_FIELD_BYTE_2		:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "101";					--		RF_field next-to-least significant byte
	CONSTANT	RF_FIELD_BYTE_LSB		:	STD_LOGIC_VECTOR(2 DOWNTO 0)	:= "110";					--		RF_field least significant byte

	CONSTANT	RF_FIELD_WORD_MASK		:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= X"FFFFFFFF";		--		RF_field full word mask
	CONSTANT	RF_FIELD_HALF_LSH_MASK	:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= X"FFFF0000";		--		RF_field most significant half-word mask
	CONSTANT	RF_FIELD_HALF_MSH_MASK	:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= X"0000FFFF";		--		RF_field least significant half-word mask
	CONSTANT	RF_FIELD_BYTE_MSB_MASK	:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= X"FF000000";		--		RF_field most significant byte mask
	CONSTANT	RF_FIELD_BYTE_3_MASK		:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= X"00FF0000";		--		RF_field next-to-most significant byte mask
	CONSTANT	RF_FIELD_BYTE_2_MASK		:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= X"0000FF00";		--		RF_field next-to-least significant byte mask
	CONSTANT	RF_FIELD_BYTE_LSB_MASK	:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= X"000000FF";		--		RF_field least significant byte mask
	CONSTANT	RF_FIELD_NONE_MASK		:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= X"00000000";		--		RF_field least significant byte mask

	CONSTANT	RF_FUNC_FLOAT			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "ZZ";						--		RF_func float (not used)
	CONSTANT	RF_FUNC_AND				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "00";						--		RF_func AND
	CONSTANT	RF_FUNC_OR				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "01";						--		RF_func OR
	CONSTANT	RF_FUNC_NAND			:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "10";						--		RF_func NAND
	CONSTANT	RF_FUNC_NOR				:	STD_LOGIC_VECTOR(1 DOWNTO 0)	:= "11";						--		RF_func NOR
	
	CONSTANT	RF_OE_FLOAT				:	STD_LOGIC							:= 'Z';						--		RF_OE float (not used)
	CONSTANT	RF_OE_HiZ				:	STD_LOGIC							:= '0';						--		RF_OE disable output
	CONSTANT	RF_OE_DRIVE				:	STD_LOGIC							:= '1';						--		RF_OE disable output
																									
	CONSTANT	RF_REG_00				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "00000";					--		Register 00
	CONSTANT	RF_REG_01				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "00001";					--		Register 01
	CONSTANT	RF_REG_02				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "00010";					--		Register 02
	CONSTANT	RF_REG_03				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "00011";					--		Register 03
	CONSTANT	RF_REG_04				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "00100";					--		Register 04
	CONSTANT	RF_REG_05				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "00101";					--		Register 05
	CONSTANT	RF_REG_06				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "00110";					--		Register 06
	CONSTANT	RF_REG_07				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "00111";					--		Register 07
	CONSTANT	RF_REG_08				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "01000";					--		Register 08
	CONSTANT	RF_REG_09				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "01001";					--		Register 09
	CONSTANT	RF_REG_0A				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "01010";					--		Register 0A
	CONSTANT	RF_REG_0B				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "01011";					--		Register 0B
	CONSTANT	RF_REG_0C				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "01100";					--		Register 0C
	CONSTANT	RF_REG_0D				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "01101";					--		Register 0D
	CONSTANT	RF_REG_0E				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "01110";					--		Register 0E
	CONSTANT	RF_REG_0F				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "01111";					--		Register 0F
	CONSTANT	RF_REG_10				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "10000";					--		Register 10
	CONSTANT	RF_REG_11				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "10001";					--		Register 11
	CONSTANT	RF_REG_12				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "10010";					--		Register 12
	CONSTANT	RF_REG_13				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "10011";					--		Register 13
	CONSTANT	RF_REG_14				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "10100";					--		Register 14
	CONSTANT	RF_REG_15				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "10101";					--		Register 15
	CONSTANT	RF_REG_16				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "10110";					--		Register 16
	CONSTANT	RF_REG_17				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "10111";					--		Register 17
	CONSTANT	RF_REG_18				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "11000";					--		Register 18
	CONSTANT	RF_REG_19				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "11001";					--		Register 19
	CONSTANT	RF_REG_1A				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "11010";					--		Register 1A
	CONSTANT	RF_REG_1B				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "11011";					--		Register 1B
	CONSTANT	RF_REG_1C				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "11100";					--		Register 1C
	CONSTANT	RF_REG_1D				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "11101";					--		Register 1D
	CONSTANT	RF_REG_1E				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "11110";					--		Register 1E
	CONSTANT	RF_REG_1F				:	STD_LOGIC_VECTOR(4 DOWNTO 0)	:= "11111";					--		Register 1F

	CONSTANT	VAL_32_ZERO				:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= (Others => '0');		--		32-bit zero
	CONSTANT	VAL_32_FLOAT			:	STD_LOGIC_VECTOR(31 DOWNTO 0)	:= (Others => 'Z');		--		32-bit float
	CONSTANT	VAL_5_FLOAT				:	STD_LOGIC_VECTOR(4  DOWNTO 0)	:= (Others => 'Z');		--		5-bit float

	
	TYPE CTRL_SIGNL_REC is record															--    control signal fields										
		ALU_func		:	std_logic_vector(4 downto 0);					    			-- 			ALU function code
		ALU_Asel		:	std_logic;															--				ALU A input source select                
		ALU_Ssel		:	std_logic;															--				ALU shift amount source select                
		DM_strb		:	std_logic;															--				Data memory data strobe
		DM_rw			:	std_logic;															--				Data memory read/write                
		DM_en			:	std_logic;															--				Data memory enable
		IR_Xsel		:	std_logic;											    			-- 			IR immediate field extend method select
		IR_Xlsft		:	std_logic;											    			-- 			IR immediate field left shift method
		IR_strb		:	std_logic;															--				Instruction Register strobe
		NIAG_sel		:	std_logic_vector(1 downto 0);					    			-- 			Program counter select
		NIAG_strb		:	std_logic;															--				Program counter strobe
		NIAG_cond		:	std_logic_vector(2 downto 0);									--				Program counter conditional relationship
		RF_Dsel		:	std_logic_vector(1 downto 0);									--				Register file data input select
		RF_strb		:	std_logic;															--				Register file strobe
		RF_Wsel		:	STD_LOGIC_VECTOR(1 DOWNTO 0);									--				Register file write destination select
		RF_func		:	std_logic_vector(1 downto 0);					    			-- 			Register file mask function to apply
		RF_field		:	std_logic_vector(2 downto 0);					    			-- 			Register file mask field to target
		RF_oe			:	std_logic;															--				Register file output enable
		RN_size		:	std_logic_vector(3 downto 0);					    			-- 			Rat's nest transfer size
	END RECORD;  
 
																									
	TYPE R_INSTRUCTION is record															--    R-type instruction format										
		R_OPCODE		:	std_logic_vector(5 downto 0);					    			-- 			opcode
		R_RS			:	std_logic_vector(4 downto 0);									--				rs field (source 0)                
		R_RT			:	std_logic_vector(4 downto 0);									--				rt field (source 1)
		R_RD			:	std_logic_vector(4 downto 0);									--				rd field (destination)
		R_SA			:	std_logic_vector(4 downto 0);									--				sa field (shift)                
		R_FUNC		:	std_logic_vector(5 downto 0);									--				func field (aux opcode)
	END RECORD;  
																									
	TYPE I_INSTRUCTION is record															--    I-type instruction format										
		I_OPCODE		:	std_logic_vector(5 downto 0);					    			-- 			opcode
		I_RS			:	std_logic_vector(4 downto 0);									--				rs field (source 0)                
		I_RT			:	std_logic_vector(4 downto 0);									--				rt field (source 1)
		I_IMMED		:	std_logic_vector(15 downto 0);								--				IMMED field (immediate)
	END RECORD;  
																									
	TYPE J_INSTRUCTION is record															--    J-type instruction format										
		J_OPCODE		:	std_logic_vector(5 downto 0);					    			-- 			opcode
		J_INDEX		:	std_logic_vector(25 downto 0);								--				index field (addrress)                
	END RECORD;  
	
																									--    decoder body (calls the instructions)
	COMPONENT Decoder IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;																				--    operation components
																									--    		ADD instruction
	COMPONENT Decode_ADD IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		ADDI instruction
	COMPONENT Decode_ADDI IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		ADDIU instruction
	COMPONENT Decode_ADDIU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		ADDU instruction
	COMPONENT Decode_ADDU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		AND instruction
	COMPONENT Decode_AND IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		ANDI instruction
	COMPONENT Decode_ANDI IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		BEQ instruction
	COMPONENT Decode_BEQ IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		BGEZ instruction
	COMPONENT Decode_BGEZ IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		BGEZAL instruction
	COMPONENT Decode_BGEZAL IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		BGTZ instruction
	COMPONENT Decode_BGTZ IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		BLEZ instruction
	COMPONENT Decode_BLEZ IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		BLTZ instruction
	COMPONENT Decode_BLTZ IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		BLTZAL instruction
	COMPONENT Decode_BLTZAL IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		BNE instruction
	COMPONENT Decode_BNE IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		DIV instruction
	COMPONENT Decode_DIV IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		DIVU instruction
	COMPONENT Decode_DIVU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		J instruction
	COMPONENT Decode_J IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		JAL instruction
	COMPONENT Decode_JAL IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		JALR instruction
	COMPONENT Decode_JALR IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		JR instruction
	COMPONENT Decode_JR IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		LB instruction
	COMPONENT Decode_LB IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		LBU instruction
	COMPONENT Decode_LBU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		LH instruction
	COMPONENT Decode_LH IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		LHU instruction
	COMPONENT Decode_LHU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		LUI instruction
	COMPONENT Decode_LUI IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		LW instruction
	COMPONENT Decode_LW IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		LWL instruction
	COMPONENT Decode_LWL IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		LWR instruction
	COMPONENT Decode_LWR IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MADD instruction
	COMPONENT Decode_MADD IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MADDU instruction
	COMPONENT Decode_MADDU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MFHI instruction
	COMPONENT Decode_MFHI IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MFLO instruction
	COMPONENT Decode_MFLO IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MOVN instruction
	COMPONENT Decode_MOVN IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MOVZ instruction
	COMPONENT Decode_MOVZ IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MSUB instruction
	COMPONENT Decode_MSUB IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MSUBU instruction
	COMPONENT Decode_MSUBU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MTHI instruction
	COMPONENT Decode_MTHI IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MTLO instruction
	COMPONENT Decode_MTLO IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MUL instruction
	COMPONENT Decode_MUL IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MULT instruction
	COMPONENT Decode_MULT IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		MULTU instruction
	COMPONENT Decode_MULTU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		NOT instruction
	COMPONENT Decode_NOT IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		OR instruction
	COMPONENT Decode_OR IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		ORI instruction
	COMPONENT Decode_ORI IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SB instruction
	COMPONENT Decode_SB IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SC instruction
	COMPONENT Decode_SC IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SH instruction
	COMPONENT Decode_SH IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SLL instruction
	COMPONENT Decode_SLL IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SLLV instruction
	COMPONENT Decode_SLLV IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SLTI instruction
	COMPONENT Decode_SLT IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SLTIU instruction
	COMPONENT Decode_SLTIU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SLTU instruction
	COMPONENT Decode_SLTU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SRA instruction
	COMPONENT Decode_SRA IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SRAV instruction
	COMPONENT Decode_SRAV IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SRL instruction
	COMPONENT Decode_SRL IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SRLV instruction
	COMPONENT Decode_SRLV IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SUB instruction
	COMPONENT Decode_SUB IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SUBU instruction
	COMPONENT Decode_SUBU IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SW instruction
	COMPONENT Decode_SW IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SWL instruction
	COMPONENT Decode_SWL IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		SWR instruction
	COMPONENT Decode_SWR IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		XOR instruction
	COMPONENT Decode_XOR IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;
																									--    		XORI instruction
	COMPONENT Decode_XORI IS
	PORT(	Instruction	:	IN		STD_LOGIC_VECTOR(31 DOWNTO 0);
			CtrlSgnls	:	OUT	CTRL_SIGNL_REC);
	END COMPONENT;

	FUNCTION	CtrlSgnls_Float RETURN CTRL_SIGNL_REC;
	FUNCTION	IR_to_Rtype(Instruction : std_logic_vector(31 DOWNTO 0)) RETURN R_INSTRUCTION;
	FUNCTION	IR_to_Itype(Instruction : std_logic_vector(31 DOWNTO 0)) RETURN I_INSTRUCTION;
	FUNCTION	IR_to_Jtype(Instruction : std_logic_vector(31 DOWNTO 0)) RETURN J_INSTRUCTION;
	
END Package;


PACKAGE BODY DecodeLogic IS
	
	FUNCTION	CtrlSgnls_Float RETURN CTRL_SIGNL_REC IS
		BEGIN
			RETURN(ALU_func 		=> ALU_FUNC_FLOAT,			-- ALU function code
					 ALU_Asel 		=> ALU_ASEL_FLOAT,			--	ALU A input source select 
  				    ALU_Ssel 		=> ALU_SSEL_FLOAT,			--	ALU shift amount source select
					 DM_strb 		=> DM_STRB_FLOAT,				--	Data memory data strobe
					 DM_rw    		=> DM_RW_FLOAT,				--	Data memory read/write                
					 DM_en    		=> DM_EN_FLOAT,				--	Data memory enable
					 RN_size  		=> RN_SIZE_FLOAT,				--	Rat's nest transfer size
					 NIAG_sel   	=> NIAG_SEL_FLOAT,			-- Program counter select
					 NIAG_strb  	=> NIAG_STRB_FLOAT,			--	Program counter condition code
					 NIAG_cond  	=> NIAG_COND_FLOAT,			-- Program counter use carry flag
					 IR_Xsel  		=> IR_XSEL_FLOAT,				-- IR immediate field extend method select
					 IR_Xlsft 		=> IR_XLSFT_FLOAT,			-- IR immediate field left shift method
					 IR_strb  		=> IR_STRB_FLOAT,				--	Instruction Register strobe
					 RF_Dsel  		=> RF_DSEL_FLOAT,				--	Register file data input select
					 RF_strb  		=> RF_STRB_FLOAT,				--	Register file strobe
					 RF_Wsel  		=> RF_WSEL_FLOAT,				--	Register file write destination select
					 RF_func 		=> RF_FUNC_FLOAT,				-- Register File function to apply
					 RF_field		=> RF_FIELD_FLOAT,			-- Register File field to target
					 RF_oe    		=> RF_OE_FLOAT					--	Register file output enable
					);
	END CtrlSgnls_Float;
	
	FUNCTION	IR_to_Rtype(Instruction : std_logic_vector(31 DOWNTO 0)) RETURN R_INSTRUCTION IS
		BEGIN
			RETURN (Instruction(31 downto 26),		-- opcode
					  Instruction(25 downto 21),		--	rs field (source 0)
					  Instruction(20 downto 16),		--	rt field (source 1)
					  Instruction(15 downto 11),		--	rd field (destination)
					  Instruction(10 downto  6),		--	sa field (shift)
					  Instruction( 5 downto  0) 		--	func field (aux opcode)
					 );
	END IR_to_Rtype;
	
	FUNCTION	IR_to_Itype(Instruction : std_logic_vector(31 DOWNTO 0)) RETURN I_INSTRUCTION IS
		BEGIN
			RETURN (Instruction(31 downto 26),		-- opcode
					  Instruction(25 downto 21),		--	rs field (source 0)
					  Instruction(20 downto 16),		--	rt field (source 1)
					  Instruction(15 downto  0)		--	immediate field
					 );
	END IR_to_Itype;
	
	FUNCTION	IR_to_Jtype(Instruction : std_logic_vector(31 DOWNTO 0)) RETURN J_INSTRUCTION IS
		BEGIN
			RETURN (Instruction(31 downto 26),		-- opcode
					  Instruction(25 downto 0)			--	target field
					 );
	END IR_to_Jtype;

END DecodeLogic;