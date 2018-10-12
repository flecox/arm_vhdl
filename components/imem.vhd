-- Quartus II VHDL Template
-- Single-Port ROM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imem is

	generic (N : natural := 32);

	port 
	(
		addr	: in std_logic_vector(5 downto 0);
		q		: out std_logic_vector((N -1) downto 0)
	);

end entity;

architecture rtl of imem is

	-- Build a 2-D array type for the ROM
	type mem_t is array(0 to 63) of std_logic_vector(N-1 downto 0);
	 

	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	
	signal rom : mem_t := (
	x"cb0300c2",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"f8008002",
	x"cb040082",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"b40000c2",
	x"00000000",
	x"00000000",
	x"00000000",
	x"f8030005",
	x"00000000",
	x"f8010009",
	x"f8018002",
	x"f8020008",
--	x"00000000",
--	x"f8010009",
--	x"f8020008",
--	x"f8028007",
--	x"f8030005",
--	x"00000000",
	others => x"00000000"
	);

begin
	q <= rom(to_integer(unsigned(addr)));

end rtl;
