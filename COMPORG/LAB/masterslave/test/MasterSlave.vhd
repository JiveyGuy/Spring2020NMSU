library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MasterSlave is
	port(
		Data_M: 	in std_logic;
		Reset_M: in std_logic;
		Clock: 	in std_logic;
		
		Q_H_M : out std_logic;
		Q_L_M : out std_logic
	);
end entity;

architecture Behavioral of MasterSlave is

	component TransLatch
		PORT(
  
			Reset: in STD_Logic;
			Gate:	 in STD_LOGIC;
			Data:	 in STD_LOGIC;
			
			Q_HIGH:	 out STD_LOGIC; 
			Q_LOw:	 out STD_Logic

		);
		
	end component;
	
	signal Q_1D: 		std_logic;
	signal not_clock: std_logic;
	
	begin
		not_clock <= not Clock;
		
		
		u1: TransLatch port map ( Reset_m, not_clock, Data_M, Q_1D, open );
		u2: TransLatch port map ( Reset_M, Clock, Q_1D, Q_H_M, Q_L_M);
end Behavioral;

