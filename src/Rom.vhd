library ieee;
use 	ieee.std_logic_1164.all;
use 	ieee.std_logic_unsigned.all;
use		ieee.numeric_std.all;		  -- import library

entity rom is
	port(addr:   in std_logic_vector(4 downto 0);
	 	 -- input the address of instruction
		 output: out std_logic_vector(31 downto 0)); 
		 -- output 32 bits instruction
end entity rom;

architecture sample of rom is
	type rom_array is array (0 to 31) of std_logic_vector(31 downto 0);
	signal rom_data:rom_array:=( 	
	
	X"10640800", X"10A61000", X"34220800",	
	X"10E81000", X"10220800",	 
	X"112A1000", X"34220800", 	  
	X"116C1000", X"10220800", 	 
	X"11AE1000", X"34220800",	   
	X"11F01000", X"10220800", 	  
	X"12321000", X"34220800", 	 
	X"12741000", X"10220800",	  
	X"12B61000", X"34220800", 	  
	X"12F81000", X"10220800",	   
	X"133A1000", X"34220800",	  
	X"137C1000", X"10220800", 	 
	X"13BE1000", X"34220800", 	
	X"13E11000", X"13E11000",
	X"00000000", X"00000000",
	X"00000000"); 
	-- create ROM to store instructions
	
	begin
		output<=rom_data(conv_integer(addr)); 
	-- output instruction at the position
end architecture sample;