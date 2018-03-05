library ieee;
use 	ieee.std_logic_1164.all;				  -- import library
use 	ieee.std_logic_unsigned.all;
use 	ieee.numeric_std.all;

entity top is
end entity top;

architecture sample of top is 
	signal clk:            std_logic; 
	-- clock excitation
	signal rom_addr:       std_logic_vector(4 downto 0)        :="00000";
	-- the address register of ROM (Program counter)
	signal addr1:          std_logic_vector(4 downto 0)        :="00000";
	-- input address 1 of RAM
	signal addr2:          std_logic_vector(4 downto 0)        :="00000";
	-- input address 2 of RAM
	signal addr3:          std_logic_vector(4 downto 0)        :="00000";
	-- output address of RAM
	signal opcode:         std_logic_vector(5 downto 0)        :="000000"; 
	-- store the opcode
	signal alu_a:          std_logic_vector(31 downto 0)       :=X"00000000"; 
	-- input opreate number 1 for alu
	signal alu_b:          std_logic_vector(31 downto 0)       :=X"00000000"; 
	-- input opreate number 2 for alu
	signal alu_c:          std_logic_vector(31 downto 0)       :=X"00000000"; 		
	-- output number of alu
	signal instruction1:   std_logic_vector(31 downto 0)       :=X"00000000"; 
	-- store the first level instruction  
	-- (For fetch instruction and opreate numbers)
	signal instruction2 :  std_logic_vector(31 downto 0)       :=X"00000000"; 
	-- store the second level instruction	 
	-- (For excecution)
	signal instruction3:   std_logic_vector(31 downto 0)       :=X"00000000"; 
	-- store the third level instruction  
	-- (For result write back RAM)
	type word is array(3 downto 0) of std_logic_vector(31 downto 0); 
	type rom_array is array (0 to 31) of std_logic_vector(31 downto 0);
	signal rom_data:rom_array:=( 
		X"00000000", X"00000000", X"00000000", X"00018637", 
		X"00006994", X"0000C9C6", X"000067C3", X"0000D642",
		X"0001744E", X"0001817C", X"0000AA49", X"000047A1", 
		X"00007D3F", X"00012561", X"00014436", X"00017897",
		X"00017AE9", X"0000DE31", X"00003585", X"0000E1D1", 
		X"0000957D", X"00000C22", X"0000EE46", X"00001D70",
		X"0000DC27", X"00000B29", X"0000E978", X"0000DB44", 
		X"00007BC9", X"00012208", X"00000343", X"00007926"
	);
	-- create and initialize a RAM that can store opreate numbers
		
	begin  
	
	
	process(clk)
	begin 
		rom_data(0)<=X"00000000";  
		-- keep the NO.0 of ROM	is zero	
		
		if((instruction2(15 downto 11)=addr2)and conv_integer(rom_addr)>1)then 
			alu_b<=alu_c;
		else
			alu_b<=rom_data(conv_integer(addr2));
		end if;
		-- For data harzard
	    -- if the opreate number 2 of alu is currently in the alu
		-- directly fetch number from result register(alu_c)
			
		if(falling_edge(clk)) then 
			if(addr1=addr3)then
				alu_a<=alu_c;
			else
				alu_a<=rom_data(conv_integer(addr1));
			end if;
			
			if(addr3="00000")then
			else
				rom_data(conv_integer(addr3))<=alu_c;
			end if;
		end if; 
	    -- For data harzard
	    -- if the opreate number 1 of alu is currently writing back
		-- directly fetch number from result register(alu_c)
		
	end process;

		g1:entity work.alu(sample) port map (alu_a,alu_b,opcode,alu_c,clk);
		-- connect alu unit
		g2:entity work.ir(sample) port map (clk,instruction1,rom_addr,addr1,addr2,instruction2);
		-- connect FI & OF instruction register and control unit
		g3:entity work.rom(sample) port map(rom_addr,instruction1);
		-- connect ROM (instruction memory)
		g4:entity work.irex(sample) port map (clk,instruction2,opcode,instruction3,rom_addr);	 
		-- connect EX instruction register and control unit
		g5:entity work.irwb(sample) port map (clk,instruction3,addr3);
		-- connect WB instruction register and control unit
end architecture sample;