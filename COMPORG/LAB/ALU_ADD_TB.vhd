
-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 13.2.2020 23:47:30 GMT

library ieee;
use ieee.std_logic_1164.all;

Library EE_212_ALU;
use EE_212_ALU.ALU.All;

entity tb_ALU_ADD is
end tb_ALU_ADD;

architecture tb of tb_ALU_ADD is

    component ALU_ADD
        port (Ain  : in std_logic_vector (31 downto 0);
              Bin  : in std_logic_vector (31 downto 0);
              Func : in std_logic_vector (4  downto 0);
              Rout : out std_logic_vector (31 downto 0);
              Stat : out stat_signl_rec);
    end component;

    signal Ain  : std_logic_vector (31 downto 0);
    signal Bin  : std_logic_vector (31 downto 0);
    signal Func : std_logic_vector (4  downto 0);
    signal Rout : std_logic_vector (31 downto 0);
    signal Stat : stat_signl_rec;

begin

    dut : ALU_ADD
    port map (Ain  => Ain,
              Bin  => Bin,
              Func => Func,
              Rout => Rout,
              Stat => Stat);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Ain <= (others => '0');
        Bin <= (others => '0');
        Func <= (others => '0');

        -- EDIT Add stimuli here
	wait for 5ns;
	Ain  <= x"00000001";
	Bin  <= x"00000001";
	Func <= ALU_FUNC_ADD;
	wait for 5ns;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ALU_ADD of tb_ALU_ADD is
    for tb
    end for;
end cfg_tb_ALU_ADD;
