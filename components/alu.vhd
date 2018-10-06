library IEEE;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
	generic (N: integer := 64);
	port(	a, b: in STD_LOGIC_VECTOR(N-1 downto 0);
			alucontrol: in STD_LOGIC_VECTOR(3 downto 0);
			result : 	out STD_LOGIC_VECTOR(N-1 downto 0);
			zero: out STD_LOGIC);
end;

architecture synth of alu is
begin
	process(a, b, alucontrol)
		variable res: std_logic_vector(N-1 downto 0);
		variable z: std_logic_vector(N-1 downto 0);
	begin
	case alucontrol is
		WHEN "0000" => res := a and b;
		WHEN "0001" => res := a or b;
		WHEN "0010" => res := std_logic_vector(unsigned(a) + unsigned(b));
		WHEN "0110" => res := std_logic_vector(unsigned(a) - unsigned(b));
		WHEN "0111" => res := b;
		WHEN "1100" => res := a nor b;
		WHEN others => res := a;
	end case;
	z := (others => '0');
	if (res = z) then 
		zero <= '1';
	else
		zero <= '0';
	end if;
	result <= res;
	end process;
end;