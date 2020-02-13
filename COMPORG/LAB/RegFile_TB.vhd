Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Library work;
use work.DecodeLogic.All;
 
ENTITY TestRegFile IS
END TestRegFile;
 
ARCHITECTURE behavior OF TestRegFile IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
   COMPONENT RegFile IS
	PORT( 	
		Asel : IN 	STD_LOGIC_VECTOR(4  DOWNTO 0);
		Bsel : IN 	STD_LOGIC_VECTOR(4  DOWNTO 0);
		Dsel : IN 	STD_LOGIC_VECTOR(4  DOWNTO 0);
		Din  : IN 	STD_LOGIC_VECTOR(31  DOWNTO 0);
		Strb : IN 	STD_LOGIC;
		Aout : OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Bout : OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
   END COMPONENT;

   --Inputs
   signal Asel : STD_LOGIC_VECTOR(4  DOWNTO 0);
   signal Bsel : STD_LOGIC_VECTOR(4  DOWNTO 0);
   signal Dsel : STD_LOGIC_VECTOR(4  DOWNTO 0);
	signal Din  : STD_LOGIC_VECTOR(31  DOWNTO 0);
	signal Strb : std_logic := '0';

   --Outputs
   signal Aout : STD_LOGIC_VECTOR(31  DOWNTO 0);
   signal Bout : STD_LOGIC_VECTOR(31  DOWNTO 0);

 
BEGIN
   -- Instantiate the Unit Under Test (UUT)
   x: RegFile PORT MAP (
		Asel => Asel,
		Bsel => Bsel,
		Dsel => Dsel,
		Din  => Din,
		Strb => Strb
   );

   stim_proc: process begin
	wait for 5ns;
	--   	 Writting to RegFile
	Strb <= '1';
	wait for 5ns;
	Din <= x"FFFFFFFF";
	Dsel <= "00001";
	wait for 5ns;
	Dsel <= "00010";
	Din <= x"00000000";
	
	wait for 5ns;
--		  testing If Value written for both A and B

	Strb <= '0';
	wait for 5ns;
	Asel <= "00001";
	Bsel <= "00010";

	wait for 4ns;

   end process;
END;
