library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;


entity signext is
	generic (N: integer := 64);
	port(	a: 	in STD_LOGIC_VECTOR(31 downto 0);
			y : 		out STD_LOGIC_VECTOR(N-1 downto 0));
end;

architecture synth of signext is
begin
	process(a)
	variable output: std_logic_vector(N-1 downto 0);
	begin
	if (a(31 downto 21) = "11111000010" or a(31 downto 21) = "11111000000") then
		output(8 downto 0) := a(20 downto 12);
		output(N-1 downto 9) := (others => a(20));
	elsif (a(31 downto 21) = "10001011000" or a(31 downto 21) = "11001011000" or a(31 downto 21) = "10001010000" or a(31 downto 21) = "10101010000") then
		output(4 downto 0) := a(20 downto 16);
		output(N-1 downto 4) := (others => a(20));
	elsif (a(31 downto 24) = "10110100") then
		output(18 downto 0) := a(23 downto 5);
		output(N-1 downto 19) := (others => a(23));
	else
		output := (others => '0');
	end if;
	y <= output;
	end process;
end;
