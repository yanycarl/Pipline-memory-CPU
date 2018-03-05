library ieee;
use 	ieee.std_logic_1164.all;
use 	ieee.std_logic_unsigned.all;   -- import library
use 	ieee.numeric_std.all;

entity irex is
	port( 
	clk:in std_logic;
	instruction:   in std_logic_vector(31 downto 0):= ( others => '0'); 
	-- level2 (EX) instruction
	opcode:		   out std_logic_vector(5 downto 0);
	-- output the opcode
	instructionOut:out std_logic_vector(31 downto 0):=X"00000000";
	-- give the instruction to WB level
	pc:			   in std_logic_vector(4 downto 0)
	-- get current program counter value for using
	);
end entity irex; 

architecture sample of irex is

	begin 
	opcode<= instruction(31 downto 26);
	-- get opcode from the EX instruction
	process(clk) 
	begin 	 
		if(rising_edge(clk)) then 
			if pc = "00000" then
				instructionOut <= X"00000000";
			else
				instructionOut<= instruction;
			end if;
			-- if program counter value is zaro, send zero to later level
		end if;
	end process;
end architecture sample;