LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestTransLatch IS
END TestTransLatch;
 
ARCHITECTURE behavior OF TestTransLatch IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT TransLatch
    	PORT(
         	Data : IN  std_logic;
         	Gate : IN  std_logic;
         	Reset : IN  std_logic;
         	Q_HIGH : OUT  std_logic;
		Q_LOW :  OUT std_logic
        );
    END COMPONENT;

   --Inputs
   signal Data : std_logic := '0';
   signal Gate : std_logic := '0';
   signal Reset : std_logic := '0';

   --Outputs
   signal Q_HIGH : std_logic;
   signal Q_LOW : std_logic;

 
BEGIN
   -- Instantiate the Unit Under Test (UUT)
   uut: TransLatch PORT MAP (
          Data => Data,
          Gate => Gate,
          Reset => Reset,
          Q_HIGH => Q_HIGH,
	  Q_LOW => Q_LOW
        );

   stim_proc: process begin
   	   wait for 10ns;
	   Reset<='0';
	   wait for 5ns;
		
	   Reset<='1';
	   Data<='1';
	   Gate<='0';
           wait for 5ns;
		
	   Gate<='1';
	   wait for 5ns;
		
	   Data<='0';
	   Gate<='1';
	   wait for 5ns;
	
	   Gate<='0';
   end process;
END;
