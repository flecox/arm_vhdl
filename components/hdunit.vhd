library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hdunit is
port(
	id_to_exe_out_register_rd, exe_to_mem_out_register_rd, if_to_id_out_register_rn, if_to_id_out_register_rm : in std_logic_vector(4 downto 0);
	id_to_exe_out_mem_read, id_to_exe_out_reg_write, exe_to_mem_out_reg_write : in std_logic;
	stall : out std_logic
);
end entity;

architecture hdunit_arq of hdunit is
	signal ex_reg_reg_hazzard, mem_reg_reg_hazard, mem_mem_reg_hazard, is_id_to_exe_register_rd_31, is_exe_to_mem_register_rd_31, is_id_to_exe_register_rd_equal_if_to_id_out_register_rn, is_id_to_exe_register_rd_equal_if_to_id_out_register_rm, is_exe_to_mem_register_rd_equal_if_to_id_out_register_rn, is_exe_to_mem_register_rd_equal_if_to_id_out_register_rm: std_logic;	
begin
-- ex tipo reg reg (para tipo r)
	is_id_to_exe_register_rd_31 <= '1' when id_to_exe_out_register_rd /= "11111" else '0';
	is_id_to_exe_register_rd_equal_if_to_id_out_register_rn <= '1' when id_to_exe_out_register_rd = if_to_id_out_register_rn else '0';
	is_id_to_exe_register_rd_equal_if_to_id_out_register_rm <= '1' when id_to_exe_out_register_rd = if_to_id_out_register_rm else '0';
	ex_reg_reg_hazzard <= id_to_exe_out_reg_write and is_id_to_exe_register_rd_31 and (is_id_to_exe_register_rd_equal_if_to_id_out_register_rn or is_id_to_exe_register_rd_equal_if_to_id_out_register_rm);
-- mem tipo reg reg (para tipo r)
	is_exe_to_mem_register_rd_31 <= '1' when exe_to_mem_out_register_rd /= "11111" else '0';
	is_exe_to_mem_register_rd_equal_if_to_id_out_register_rn <= '1' when exe_to_mem_out_register_rd = if_to_id_out_register_rn else '0';
	is_exe_to_mem_register_rd_equal_if_to_id_out_register_rm <= '1' when exe_to_mem_out_register_rd = if_to_id_out_register_rm else '0';
	mem_reg_reg_hazard <= exe_to_mem_out_reg_write and is_exe_to_mem_register_rd_31 and (is_exe_to_mem_register_rd_equal_if_to_id_out_register_rn or is_exe_to_mem_register_rd_equal_if_to_id_out_register_rm);

-- mem tipo mem reg hazarz (ldur y tipor)

	mem_mem_reg_hazard <= id_to_exe_out_mem_read and (is_id_to_exe_register_rd_equal_if_to_id_out_register_rn or is_id_to_exe_register_rd_equal_if_to_id_out_register_rm);
	
	stall <= '1' when (ex_reg_reg_hazzard or mem_reg_reg_hazard or mem_mem_reg_hazard) ='1' else '0'; -- mem_mem_reg_hazard or mem_reg_reg_hazard or ex_reg_reg_hazzard;


end architecture;
