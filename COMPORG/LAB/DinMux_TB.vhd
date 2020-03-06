-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 5.3.2020 23:03:14 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_DinMUX is
end tb_DinMUX;

architecture tb of tb_DinMUX is

    component DinMUX
        port (ALUresult : in std_logic_vector (31 downto 0);
              MemData   : in std_logic_vector (31 downto 0);
              RetAdrs   : in std_logic_vector (31 downto 0);
              Sel       : in std_logic_vector (1  downto 0);
              Data      : out std_logic_vector (31 downto 0));
    end component;

    signal ALUresult : std_logic_vector (31 downto 0);
    signal MemData   : std_logic_vector (31 downto 0);
    signal RetAdrs   : std_logic_vector (31 downto 0);
    signal Sel       : std_logic_vector (1  downto 0);
    signal Data      : std_logic_vector (31 downto 0);

begin

    dut : DinMUX
    port map (ALUresult => ALUresult,
              MemData   => MemData,
              RetAdrs   => RetAdrs,
              Sel       => Sel,
              Data      => Data);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ALUresult <= x"00000002";
        MemData   <= x"00000001";
        RetAdrs   <= x"00000000";
        Sel 	  <= "ZZ";
	wait for 5ns;
	Sel 	  <= "00";
	wait for 5ns;
	Sel 	  <= "01";
	wait for 5ns;
	Sel 	  <= "10";
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_DinMUX of tb_DinMUX is
    for tb
    end for;
end cfg_tb_DinMUX;