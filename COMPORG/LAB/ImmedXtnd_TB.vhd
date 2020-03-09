
-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 6.3.2020 00:14:44 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_ImmedXtnd is
end tb_ImmedXtnd;

architecture tb of tb_ImmedXtnd is

    component ImmedXtnd
        port (Immed16 : in std_logic_vector (15 downto 0);
              Sel     : in std_logic;
              Immed32 : inout std_logic_vector (31 downto 0));
    end component;

    signal Immed16 : std_logic_vector (15 downto 0);
    signal Sel     : std_logic;
    signal Immed32 : std_logic_vector (31 downto 0);

begin

    dut : ImmedXtnd
    port map (Immed16 => Immed16,
              Sel     => Sel,
              Immed32 => Immed32);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Immed16 <= x"FFFF";
        Sel     <= '0';
	wait for 5ns;
	Sel     <= '1';
	wait for 5ns;
	Immed16 <= x"FFF"&"1101";
        -- EDIT Add stimuli here
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ImmedXtnd of tb_ImmedXtnd is
    for tb
    end for;
end cfg_tb_ImmedXtnd;
