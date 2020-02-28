-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 28.2.2020 01:23:09 GMT

library IEEE;
use 	IEEE.STD_Logic_1164.All;
use 	IEEE.NUMERIC_STD.All;

Library EE_212_ALU;
use 	EE_212_ALU.ALU.all;

Library EE_212_DECODER;
use 	EE_212_DECODER.DecodeLogic.all;

Library EE_212_NIAG;
use 	EE_212_NIAG.NIAG.all;

entity tb_NIAG is
end tb_NIAG;

architecture tb of tb_NIAG is

    component NIAG
        port (Target  : in std_logic_vector (25 downto 0);
              Immed   : in std_logic_vector (31 downto 0);
              Reg     : in std_logic_vector (31 downto 0);
              Xshft   : in std_logic;
              PCin    : in std_logic_vector (31 downto 0);
              Cond    : in std_logic_vector (2 downto 0);
              Sel     : in std_logic_vector (1 downto 0);
              Stat    : in stat_signl_rec;
              MemAdrs : out std_logic_vector (31 downto 0);
              RtnAdrs : out std_logic_vector (31 downto 0));
    end component;

    signal Target  : std_logic_vector (25 downto 0);
    signal Immed   : std_logic_vector (31 downto 0);
    signal Reg     : std_logic_vector (31 downto 0);
    signal Xshft   : std_logic;
    signal PCin    : std_logic_vector (31 downto 0);
    signal Cond    : std_logic_vector (2 downto 0);
    signal Sel     : std_logic_vector (1 downto 0);
    signal Stat    : stat_signl_rec;
    signal MemAdrs : std_logic_vector (31 downto 0);
    signal RtnAdrs : std_logic_vector (31 downto 0);

begin

    dut : NIAG
    port map (Target  => Target,
              Immed   => Immed,
              Reg     => Reg,
              Xshft   => Xshft,
              PCin    => PCin,
              Cond    => Cond,
              Sel     => Sel,
              Stat    => Stat,
              MemAdrs => MemAdrs,
              RtnAdrs => RtnAdrs);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Target 		<= 	x"000001" & "00";
        Immed 		<= 	x"00000004";
        Reg 		<= 	x"00000010";
        Xshft 		<= 	'1';
        PCin 		<= 	x"00000000";
        Cond 		<= 	NIAG_COND_NONE; --Mem addr should be 04, 08 for rt adress
        Sel 		<= 	NIAG_SEL_NSA;
        Stat.ALU_ZERO <= '0';
	Stat.ALU_SIGN <= '0';
        -- EDIT Add stimuli here
	wait for 5ns;
        Target 		<= 	x"000001" & "00";
        Immed 		<= 	x"00000004";
        Reg 		<= 	x"00000010";
        Xshft 		<= 	'1';
        PCin 		<= 	x"00000000"; --Mem addr should be 14, 08 for rt adress
        Cond 		<= 	NIAG_COND_EQ; 
        Sel 		<= 	NIAG_SEL_REL;
        Stat.ALU_ZERO 	<= 	'1';
	Stat.ALU_SIGN 	<= 	'0';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_NIAG of tb_NIAG is
    for tb
    end for;
end cfg_tb_NIAG;
