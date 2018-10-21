library ieee;
use ieee.std_logic_1164.all;

entity processor_arm_tb is
end processor_arm_tb;

architecture Behavior of processor_arm_tb is

constant CLK_PERIOD : time := 20 ns;

-- Input Signals
signal clk,finish, dump : std_logic:= '0';
signal reset		: std_logic:= '1';
signal DM_addr, DM_writeData: std_logic_vector (63 downto 0);
signal DM_writeEnable, stall_out, reg_write_etapa: std_logic;
signal instruction_out_p: std_logic_vector(31 downto 0);
signal id_to_exe_out_register_rd, if_to_id_out_register_rn, if_to_id_out_register_rm: std_logic_vector(4 downto 0);
-- Output Signals
signal led : std_logic_vector (7 downto 0);
begin
	dut: entity work.processor_arm
	generic map (
		N => 64)
	port map (
		clk => clk,
		reset => reset,
		dump => dump,
		DM_addr => DM_addr,
		DM_writeData => DM_writeData,
		DM_writeEnable => DM_writeEnable
		);
		
	clk <= not clk after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal
	test_proc: process
	begin
		reset <= '1'; 
		wait for CLK_PERIOD;
		reset <= '0'; 
		wait for CLK_PERIOD*64;
		finish <= '1';
		dump <= '1';
		wait;
	end process;
end;