library ieee;
use ieee.std_logic_1164.all;

entity execute is
	generic (N: integer := 64);
    port(signal aluSrc: in std_logic;
	signal aluControl: in std_logic_vector(3 downto 0);
	signal PC_E, SignImm_E: in std_logic_vector(N-1 downto 0);
	signal readData1_E, readData2_E: in std_logic_vector(N-1 downto 0);
	signal PCBranch_E, aluResult_E: out std_logic_vector(N-1 downto 0);
	signal writeData_E : out std_logic_vector(N-1 downto 0);
	signal zero_E : out std_logic);
end execute;

architecture behaviour of execute is
signal SrcB_add: std_logic_vector(N-1 downto 0);
signal SrcB_alu: std_logic_vector(N-1 downto 0);
begin
	 dut_SL2: entity work.sl2 port map (a => SignImm_E, y => SrcB_add);
  	 dut_ADDER: entity work.adder port map (a => PC_E, b => SrcB_add, y => PCBranch_E);
	 dut_MUX2: entity work.MUX2 port map(d0 => ReadData2_E, d1 => SignImm_E, s => AluSrc, y => SrcB_alu);
	 dut_ALU: entity work.alu port map(a => ReadData1_E, b => SrcB_alu, alucontrol => AluControl, zero => Zero_E, result => AluResult_E);
	 
	 writeData_E <= readData2_E;
  
end behaviour;
