library ieee;
use ieee.std_logic_1164.all;

entity maindec is
    port(Op: in std_logic_vector(10 downto 0);
         Reg2Loc, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch: out std_logic;
         AluOp: out std_logic_vector(1 downto 0));
end maindec;

architecture behaviour of maindec is
begin
    process(Op)
    begin
		if op(10 downto 1) = "1001000100" then
		          Reg2Loc <= '1';
                ALUsrc <= '1';
                MemtoReg <= '0';
                RegWrite <= '1';
                MemRead <= '0';
                MemWrite <= '0';
                Branch <= '0';
                AluOp <= "10";
		elsif op(10) = '1' and op(7 downto 4) = "0101" and op(2 downto 0) = "000" then
                Reg2Loc <= '0';
                ALUsrc <= '0';
                MemtoReg <= '0';
                RegWrite <= '1';
                MemRead <= '0';
                MemWrite <= '0';
                Branch <= '0';
                AluOp <= "10";
		elsif op = "11111000010" then
                Reg2Loc <= '0';
                ALUsrc <= '1';
                MemtoReg <= '1';
                RegWrite <= '1';
                MemRead <= '1';
                MemWrite <= '0';
                Branch <= '0';
                AluOp <= "00";
		elsif Op = "11111000000" then
                Reg2Loc <= '1';
                ALUsrc <= '1';
                MemtoReg <= '0';
                RegWrite <= '0';
                MemRead <= '0';
                MemWrite <= '1';
                Branch <= '0';
                AluOp <= "00";
	 elsif op(10 downto 3) = "10110100" then
                Reg2Loc <= '1';
                ALUsrc <= '0';
                MemtoReg <= '0';
                RegWrite <= '0';
                MemRead <= '0';
                MemWrite <= '0';
                Branch <= '1';
                AluOp <= "01";
	elsif op(10 downto 3) = "10110101" then
                Reg2Loc <= '1';
                ALUsrc <= '0';
                MemtoReg <= '0';
                RegWrite <= '0';
                MemRead <= '0';
                MemWrite <= '0';
                Branch <= '1';
                AluOp <= "01";
    else
                Reg2Loc <= 'X';
                ALUsrc <= 'X';
                MemtoReg <= 'X';
                RegWrite <= 'X';
                MemRead <= 'X';
                MemWrite <= 'X';
                Branch <= 'X';
                AluOp <= "XX"; 
        end if;
    end process;
end behaviour;
