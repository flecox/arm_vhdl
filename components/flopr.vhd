library ieee;
use ieee.std_logic_1164.all;

entity flopr is
generic (N : natural := 64);
port(
	d : in std_logic_vector(N-1 downto 0);
	clk, reset : in std_logic;
	q : out std_logic_vector(N-1 downto 0)
);
end entity;
architecture flipflop_n of flopr is
begin
process(reset, clk)
begin
	if(reset='1') then
		q <= (others=>'0');
	elsif(clk'event and clk='1') then
		q <= d;
	end if;
end process;
end architecture;
