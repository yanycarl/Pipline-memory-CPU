library ieee;
use 	ieee.std_logic_1164.all;	 -- import library
use 	ieee.std_logic_unsigned.all;
use 	ieee.numeric_std.all;

entity ir is
	port(
		clk:		   in std_logic;
		-- clock excitation
		instruction:   in std_logic_vector(31 downto 0);
		-- IF & OF instruction
		rom_addr:	   out std_logic_vector(4 downto 0); 
		-- Program counter	(address of instruction ROM)
		addr1:		   out std_logic_vector(4 downto 0);
		-- RAM Address of Opreate number 1
		addr2:		   out std_logic_vector(4 downto 0);
		-- RAM Address of Opreate number 2
		instructionOut:out std_logic_vector(31 downto 0):=X"00000000"
		-- Give to EX instruction register and control unit
	);
end entity ir;

architecture sample of ir is
	signal pc:std_logic_vector(4 downto 0):="00000";
	-- save the program counter value
	begin 
		addr1<=instruction(25 downto 21);	
		addr2<=instruction(20 downto 16);
		-- Get address from instruction
		process(clk) 
		begin
			if(rising_edge(clk)) then  
				pc<=std_logic_vector(to_unsigned(conv_integer(pc)+1, 5)); 
				-- program counter value plues 1
					if pc = "00000" then
						instructionOut <= X"00000000";	
					-- if this is the first instruction, give later level zero
					else
						instructionOut<= instruction;  
						-- give later level control unit the instruction
					end if;
				rom_addr<=pc;
				-- set ROM address the program counter value
			end if;
		end process;
end architecture sample;