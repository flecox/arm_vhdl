library ieee;
use ieee.std_logic_1164.all;

entity fetch is
	generic (N: integer := 64);
    port(PCSrc_F,clk, reset:in std_logic;
			PCBranch_F: in std_logic_vector(N-1 downto 0);
         imem_addr_F: out std_logic_vector(N-1 downto 0));
end fetch;

architecture behaviour of fetch is
signal PCnext: std_logic_vector(N-1 downto 0);
signal PCplus4: std_logic_vector(N-1 downto 0);
signal PC, PCTemp: std_logic_vector(N-1 downto 0);
begin
  	 dut_ADDER: entity work.adder port map (a => PC, b => x"0000000000000004", y => PCPlus4);
	 dut_MUX2: entity work.MUX2 port map(d0 => PCPlus4, d1 => PCbranch_F, s => PCSrc_F, y => PCNext);
	 dut_FLOPR: entity work.flopr port map(d => PCNext, clk => clk, reset => reset, q => PCTemp);
	 PC <= PCTemp;
	 imem_addr_F <= PCTemp;
  
end behaviour;
