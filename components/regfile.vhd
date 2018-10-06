-- Quartus II VHDL Template
-- Single-Port ROM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity regfile is
	port(
        	clk, we3 : in std_logic;
       		ra1, ra2, wa3 : in std_logic_vector(4 downto 0);
        	wd3 : in std_logic_vector(63 downto 0);
        	rd1, rd2 : out std_logic_vector(63 downto 0)
	);

end entity;

architecture rtl of regfile is

	-- Build a 2-D array type for the ROM
	type mem_reg is array(0 to 31) of std_logic_vector(63 downto 0);
	 

	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	
	signal rom : mem_reg := (
	x"0000000000000000",
	x"0000000000000001",	
	x"0000000000000002",
	x"0000000000000003",
	x"0000000000000004",
	x"0000000000000005",
	x"0000000000000006",
	x"0000000000000007",
	x"0000000000000008",
	x"0000000000000009",
	x"000000000000000a",
	x"000000000000000b",
	x"000000000000000c",
	x"000000000000000d",
	x"000000000000000e",
	x"000000000000000f",
	x"0000000000000010",
	x"0000000000000020",
   x"0000000000000030",
   x"0000000000000040",
   x"0000000000000050",
   x"0000000000000060",
   x"0000000000000070",
   x"0000000000000080",
   x"0000000000000090",
   x"00000000000000a0",
   x"00000000000000b0",
   x"00000000000000c0",
   x"00000000000000d0",
   x"00000000000000e0",
   x"00000000000000f0",
	x"0000000000000000"
	);

begin
	process(clk)
	begin
      	if(clk'event and clk = '1') then
                -- escribimos los datos wd3 en el registro wa3
                	if(we3='1' and wa3 /= "11111") then
                        	rom(to_integer(unsigned(wa3))) <= wd3;
						end if;
			end if;
   end process;
	rd1 <= rom(to_integer(unsigned(ra1)));
	rd2 <= rom(to_integer(unsigned(ra2)));

end rtl;