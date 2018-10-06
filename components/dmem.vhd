-------------------------------------------------------------------------------
--
-- Title       : dmem
-- Design      : Mips
-- Author      : Eduardo Sanchez
-- Company     : Famaf
--
-------------------------------------------------------------------------------
--
-- File        : dmem.vhd
--
-------------------------------------------------------------------------------
--
-- Description : Archivo con el dise�o de la memoria RAM del procesador MIPS.
-- Para mantener un dise�o corto, la memoria solo contiene 64 palabras de 
-- 32 bits c/u (aunque podria direccionar mas memoria)
-- dump: si esta se�al esta activa (1), se copia le contenido de la memoria
-- en el archivo de salida DUMP (para su posterior revision).
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_SIGNED.all;
use ieee.numeric_std.all;

entity dmem is -- data memory
	generic (width: integer := 64);
   port(clk, memWrite, memRead:  in STD_LOGIC;
       address :    in STD_LOGIC_VECTOR(5 downto 0);
		 writeData :    in STD_LOGIC_VECTOR(width-1 downto 0);
       readData:       out STD_LOGIC_VECTOR(width-1 downto 0);
       dump: in STD_LOGIC
		 );
end;

architecture behave of dmem is
 constant MAX_BOUND: Integer := width;
 constant MEMORY_DUMP_FILE: string := "mem.dump";
 
 type ramtype is array (MAX_BOUND-1 downto 0) of STD_LOGIC_VECTOR(width-1 downto 0);
 signal mem: ramtype;

 procedure memDump is
--   file dumpfile : text open write_mode is MEMORY_DUMP_FILE;
   FILE dumpfile: TEXT IS OUT MEMORY_DUMP_FILE;
   variable dumpline : line;
   variable i: natural := 0;
   begin
		write(dumpline, string'("Memoria RAM de Arm:"));
		writeline(dumpfile,dumpline);
		write(dumpline, string'("Address Data"));
		writeline(dumpfile,dumpline);
      while i <= MAX_BOUND-1 loop        
		  write(dumpline, i);
		  write(dumpline, string'(" "));
		  hwrite(dumpline, to_bitvector(mem(i)));
		  writeline(dumpfile,dumpline);
        i:=i+1;
      end loop;
		assert false report "fin del testdump" severity note;
   end procedure memDump;

begin
   process(clk, address, mem, memWrite, memRead)
	begin 
	  if clk'event and clk = '1' and memWrite = '1' then
				mem(conv_integer("0" & address(5 downto 0))) <= writeData;
	  end if;
	  if memRead = '1' then
			readData <= mem(conv_integer("0" & address(5 downto 0))); -- word aligned
	  else
			readData <= (others => '0');
	  end if;
	end process;
	
	process(dump)
	begin
	 if dump = '1' then
	   memDump;
	 end if;
	end process;
end;