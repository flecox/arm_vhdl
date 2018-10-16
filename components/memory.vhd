library ieee;
use ieee.std_logic_1164.all;

entity memory is
    port(
	 Branch, zero, isNot: in std_logic;
    PCSrc: out std_logic
	 );
end entity;

architecture behav of memory is

begin

PCSrc <= Branch and ((zero and not isNot) or (isNot and not zero)) ;

end architecture;