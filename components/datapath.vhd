library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;


entity datapath is
	 generic (N: integer := 64);
    port (
         reset, clk :in  std_logic;
         reg2loc, regWrite, AluSrc, Branch,  memtoReg, memRead, memWrite: in std_logic;
         AluControl : in std_logic_vector (3 downto 0);
			IM_readData : in std_logic_vector (31 downto 0);
			DM_readData: in std_logic_vector (N-1 downto 0);
			IM_addr,DM_addr, DM_writeData: out std_logic_vector (N-1 downto 0);
         DM_writeEnable, DM_readEnable: out std_logic;
			instruction_out:out std_logic_vector (31 downto 0)
       );
end entity;


architecture behav of datapath is

--- Signals
signal PCSrc, zero: std_logic;
signal PCBranch, PCBranch_E,writeData_D,PC, DM_readData_s, signImm : std_logic_vector(N-1 downto 0);
signal readData1,readData2, aluResult,writeData_E : std_logic_vector(N-1 downto 0);
-- if -> id signals
signal if_to_id_in, if_to_id_out : std_logic_vector(95 downto 0);
-- id -> exe signals
signal reg2loc_e, regWrite_e, AluSrc_e, Branch_e,  memtoReg_e, memRead_e, memWrite_e, is_not_e: std_logic;
signal AluControl_e : std_logic_vector (3 downto 0);
signal id_to_exe_in, id_to_exe_out : std_logic_vector(271 downto 0);
-- exe -> mem signals
signal regWrite_m, Branch_m,  memtoReg_m, memRead_m, memWrite_m, zero_m, is_not_m: std_logic;
signal exe_to_mem_in, exe_to_mem_out : std_logic_vector(203 downto 0);
-- mem -> wb signals
signal regWrite_w, memtoReg_w: std_logic;
signal mem_to_wb_in, mem_to_wb_out : std_logic_vector(134 downto 0);



begin

-- Fetch inst
	fetch_0: entity work.fetch 
	generic map (
		N => N)
	port map (
		PCSrc_F => PCSrc,
		clk => clk,
		reset => reset,
		PCBranch_F => PCBranch,
		imem_addr_F => PC
	);
	
-- if_id_reg registros if id:
   if_to_id_in(95 downto 32) <= PC;
   if_to_id_in(31 downto 0) <= IM_readData;
   if_id_reg: entity work.flopr generic map(N => 96) port map(d => if_to_id_in, clk => clk, reset => reset, q => if_to_id_out);
	instruction_out <= if_to_id_out(31 downto 0);
-- Decode Inst
	decode_0: entity work.decode 
	generic map (
		N => N)
	port map (
		wa3_D => mem_to_wb_out(4 downto 0),
		regWrite_D => regWrite_w,
		reg2loc_D => reg2loc,
		clk => clk,
		writeData3_D => writeData_D,
		instr_D => if_to_id_out(31 downto 0),
		signImm_D => signImm,
		readData1_D => readData1,
		readData2_D => readData2	
	);
-- id_exe_reg registros if id:
   id_to_exe_in(4 downto 0) <= if_to_id_out(4 downto 0);
   id_to_exe_in(68 downto 5) <= readData2;
   id_to_exe_in(132 downto 69) <= readData1;
   id_to_exe_in(196 downto 133) <= signImm;
   id_to_exe_in(260 downto 197) <= if_to_id_out(95 downto 32);
	id_to_exe_in(261) <= memtoReg;
	id_to_exe_in(262) <= regWrite;
	id_to_exe_in(263) <= memWrite;
	id_to_exe_in(264) <= memRead;
	id_to_exe_in(265) <= Branch;
	id_to_exe_in(269 downto 266) <= AluControl;
	id_to_exe_in(270) <= AluSrc;
	id_to_exe_in(271) <= if_to_id_out(24); -- bit for cbnz
	
   id_exe_reg: entity work.flopr generic map(N => 272) port map(d => id_to_exe_in, clk => clk, reset => reset, q => id_to_exe_out);
	
	memtoReg_e <= id_to_exe_out(261);
	regWrite_e <= id_to_exe_out(262);
	memWrite_e <= id_to_exe_out(263);
	memRead_e <= id_to_exe_out(264);
	Branch_e <= id_to_exe_out(265);
	AluControl_e <= id_to_exe_out(269 downto 266);
	AluSrc_e <= id_to_exe_out(270);
	is_not_e <= id_to_exe_out(271);
	
-- Excecute
  execute_0: entity work.execute
  generic map (
			 N => N)
  port map (
			 aluSrc => AluSrc_e,
			 aluControl => AluControl_e,
			 PC_E => id_to_exe_out(260 downto 197),
			 SignImm_E => id_to_exe_out(196 downto 133),
			 readData1_E => id_to_exe_out(132 downto 69),
			 readData2_E => id_to_exe_out(68 downto 5),
			 PCBranch_E => PCBranch_E,
			 aluResult_E => aluResult,
			 writeData_E => writeData_E,
			 zero_E => zero
  );
exe_to_mem_in(4 downto 0) <= id_to_exe_out(4 downto 0);
exe_to_mem_in(68 downto 5) <= writeData_E;
exe_to_mem_in(132 downto 69) <= aluResult;
exe_to_mem_in(133) <= zero;
exe_to_mem_in(197 downto 134) <= PCBranch_E;
exe_to_mem_in(198) <= memtoReg_e;
exe_to_mem_in(199) <= regWrite_e;
exe_to_mem_in(200) <= memWrite_e;
exe_to_mem_in(201) <= memRead_e;
exe_to_mem_in(202) <= Branch_e;
exe_to_mem_in(203) <= is_not_e;

exe_mem_reg: entity work.flopr generic map(N => 204) port map(d => exe_to_mem_in, clk => clk, reset => reset, q => exe_to_mem_out);


memtoReg_m <= exe_to_mem_out(198);
regWrite_m <= exe_to_mem_out(199);
memWrite_m <= exe_to_mem_out(200);
memRead_m <= exe_to_mem_out(201);
Branch_m <= exe_to_mem_out(202);
is_not_m <= exe_to_mem_out(203);
PCBranch <= exe_to_mem_out(197 downto 134);
zero_m <= exe_to_mem_out(133);


-- Memory
DM_addr <= exe_to_mem_out(132 downto 69);
DM_writeData <= exe_to_mem_out(68 downto 5);
DM_writeEnable <= memWrite_m;
DM_readEnable <= memRead_m;
memory_0: entity work.memory
    port map (
         Branch => Branch_m,
         zero => zero_m,
			isNot => is_not_m,
			PCSrc => PCSrc
         ); 
mem_to_wb_in(4 downto 0) <= exe_to_mem_out(4 downto 0);
mem_to_wb_in(68 downto 5) <= DM_readData;
mem_to_wb_in(132 downto 69) <= exe_to_mem_out(132 downto 69);
mem_to_wb_in(133) <= memtoReg_m;
mem_to_wb_in(134) <= regWrite_m;

mem_wb_reg: entity work.flopr generic map(N => 135) port map(d => mem_to_wb_in, clk => clk, reset => reset, q => mem_to_wb_out);

memtoReg_w <= mem_to_wb_out(133);
regWrite_w <= mem_to_wb_out(134);

-- Writeback

writeback_0: entity work.writeback
    port map (
         aluResult => mem_to_wb_out(132 downto 69),
         DM_readData => mem_to_wb_out(68 downto 5),
         memtoReg => memtoReg_w,
			writeData => writeData_D
         );

-- Other 
IM_addr <= PC;
end architecture;
