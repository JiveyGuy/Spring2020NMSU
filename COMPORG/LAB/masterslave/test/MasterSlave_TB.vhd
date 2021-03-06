LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TestMasterSlave IS
END TestMasterSlave;
 
ARCHITECTURE behavior OF TestMasterSlave IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
   COMPONENT MasterSlave
    	PORT(
		Data_M:  in std_logic;
		Reset_M: in std_logic;
		Clock: 	 in std_logic;
		
		Q_H_M : out std_logic;
		Q_L_M : out std_logic
	);
   END COMPONENT;

   --Inputs
   signal Data_M : std_logic := '0';
   signal Reset_M : std_logic := '0';
   signal Clock : std_logic := '0';

   --Outputs
   signal Q_H_M : std_logic;
   signal Q_L_M : std_logic;

 
BEGIN
   -- Instantiate the Unit Under Test (UUT)
   uut: MasterSlave PORT MAP (
          Data_M => Data_M,
          Reset_M => Reset_M,
          Clock => Clock,
          Q_H_M => Q_H_M,
	  Q_L_M => Q_L_M
        );

   stim_proc: process begin

   	   wait for 10ns;
	   Reset_M<='0';
	   wait for 5ns;
		
	   Reset_M<='1';
	   Data_M<='1';
	   Clock<='0';
           wait for 5ns;
		
	   Clock<='1';
	   wait for 5ns;
		
	   Data_M<='0';
	   Clock<='1';
	   wait for 5ns;
	
	   Clock<='0';
   end process;
END;
