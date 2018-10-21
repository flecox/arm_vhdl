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
-- ejercicio 2
--	x"91003c0a",
--	x"aa14018b",
--	x"8a14018c",
--	x"8b0a0000",
--	x"cb01014a",
--	x"f80003eb",
--	x"f80083ec",
--	x"b5ffff8a",
--	x"f80103e0",

-- ejercicio 3 sin cambios
--	x"91000be0",
--	x"91000801",
--	x"91000822",
--	x"91000843",
--	x"f80003e0",
--	x"f80083e1",
--	x"f80103e2",
--	x"f80183e3",

-- ejercicio 3 con nopa cambios
--	x"91000be0",
--	x"00000000",
--	x"00000000",
--	x"91000801",
--	x"00000000",
--	x"00000000",
--	x"91000822",
--	x"00000000",
--	x"00000000",
--	x"91000843",
--	x"00000000",
--	x"00000000",
--	x"f80003e0",
--	x"f80083e1",
--	x"00000000",
--	x"00000000",
--	x"f80103e2",
--	x"00000000",
--	x"00000000",
--	x"f80183e3",

-- practico 2 test:
--	x"f8000000", 
--	x"f8008001",
--	x"f8010002", 
--	x"f8018003", 
--	x"f8020004", 
--	x"f8028005",
--	x"f8030006", 
--	x"f8400007", 
--	x"f8408008", 
--	x"f8410009",
--	x"f841800a", 
--	x"f842000b", 
--	x"f842800c", 
--	x"f843000d",
--	x"cb0e01ce",  
--	x"b400004e", 
--	x"cb01000f", 
--	x"8b01000f",
--	x"f803800f",

-- ejemplo prueba HDU
--	x"9100014b",
--	x"9100040c",
--	x"91002809",
--	x"cb09014a",
--	x"b400004a",
--	x"f800002a",
--	x"9100c96a",
--	x"f8000001",
--	x"8b010002",
--	x"f8408001",
--	x"8b010042",
--	x"91004000",
--	x"cb0c014a",
--	x"b5ffff4a",
--	x"00000000",
--	x"00000000",
--	x"cb0d01ad",
--	x"b4ffffed",

-- led basico
	x"91002001",
	x"f8000001",
	x"91007001",
	x"f8000001",
	x"9100f801",
	x"f8000001",
	x"f8400002",
	x"8b020021",
	x"91000c21",
	x"f8000001",
	x"9100f801",
	x"f8000001",
	x"91007001",
	x"f8000001",
	x"91002001",
	x"f8000001",
	x"cb020042",
	x"b4fffde2",
	x"00000000",
	x"00000000",
	x"00000000",

	others => x"00000000"
	);

begin
	q <= rom(to_integer(unsigned(addr)));

end rtl;
