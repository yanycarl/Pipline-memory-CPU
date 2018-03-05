library ieee;
use 	ieee.std_logic_1164.all;
use 	ieee.std_logic_unsigned.all;   -- import library
use 	ieee.numeric_std.all;

entity irwb is
	port( 
		clk:in std_logic;
		instruction:in std_logic_vector(31 downto 0):= ( others => '0'); 
		-- save level 3 (WB) instruction
		addr3:out std_logic_vector(4 downto 0):="00000"
		-- write back address
	);
end entity irwb; 

architecture sample of irwb is

begin 	
	addr3<=instruction(15 downto 11); -- get write back address
end architecture sample;