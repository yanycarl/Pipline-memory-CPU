library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mem is
	port(addr1: in std_logic_vector(4 downto 0);   
	addr2: in std_logic_vector(4 downto 0);
	addr3: in std_logic_vector(4 downto 0);
	input: in std_logic_vector(31 downto 0);
	output1: out std_logic_vector(31 downto 0);
	output2: out std_logic_vector(31 downto 0);
	en:in std_logic; clk:in std_logic);
end entity mem;

architecture sample of mem is
	type rom_array is array (0 to 31) of std_logic_vector(31 downto 0);
	signal rom_data:rom_array:=( X"00000000", X"00000000", X"00000000", X"00018637", X"00006994", X"0000C9C6", X"000067C3", X"0000D642",
	X"0001744E", X"0001817C",X"0000AA49", X"000047A1", X"00007D3F", X"00012561", X"00014436", X"00017897",
	X"00017AE9", X"0000DE31", X"00003585", X"0000E1D1", X"0000957D", X"00000C22", X"0000EE46", X"00001D70",
	X"0000DC27", X"00000B29", X"0000E978", X"0000DB44", X"00007BC9", X"00012208", X"00000343", X"00007926");
begin
	
		
	output1<=rom_data(conv_integer(addr1));
	output2<=rom_data(conv_integer(addr2));
process(clk,en)
begin
	if(en='1')  then
		rom_data(conv_integer(addr3))<=input;
	end if;
end process;
end architecture sample;
