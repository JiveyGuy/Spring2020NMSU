library ieee;
use ieee.std_logic_1164.all;

entity tb_DselMUX is
end tb_DselMUX;

architecture tb of tb_DselMUX is

    component DselMUX
        port (RD   : in std_logic_vector (4 downto 0);
              RT   : in std_logic_vector (4 downto 0);
              RET  : in std_logic_vector (4 downto 0);
              Sel  : in std_logic_vector (1 downto 0);
              Data : out std_logic_vector (4 downto 0));
    end component;

    signal RD   : std_logic_vector (4 downto 0);
    signal RT   : std_logic_vector (4 downto 0);
    signal RET  : std_logic_vector (4 downto 0);
    signal Sel  : std_logic_vector (1 downto 0);
    signal Data : std_logic_vector (4 downto 0);

begin

    dut : DselMUX
    port map (RD   => RD,
              RT   => RT,
              RET  => RET,
              Sel  => Sel,
              Data => Data);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        RD  	<= "00010";
        RT   	<= "00001";
        RET   	<= "00000";
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

configuration cfg_tb_DselMUX of tb_DselMUX is
    for tb
    end for;
end cfg_tb_DselMUX;
