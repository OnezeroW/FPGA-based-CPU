----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:10:28 11/19/2013 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( Rseven : out  STD_LOGIC_VECTOR (7 downto 0);
	        rst : in  STD_LOGIC;
	        t2 : in  STD_LOGIC;
           t3 : in  STD_LOGIC;
           pcin : in  STD_LOGIC_VECTOR (15 downto 0);
           irin : in  STD_LOGIC_VECTOR (15 downto 0);
           Rupdate : in  STD_LOGIC;
           Rdata : in  STD_LOGIC_VECTOR (7 downto 0);
           Raddr : in  STD_LOGIC_VECTOR (2 downto 0);
           aluout : out  STD_LOGIC_VECTOR (7 downto 0);
           pnewout : out  STD_LOGIC_VECTOR (15 downto 0);
           addr : out  STD_LOGIC_VECTOR (15 downto 0);
           Rout : out  STD_LOGIC_VECTOR (7 downto 0);
           rdreq : out  STD_LOGIC;
           wrreq : out  STD_LOGIC;
           cyout : out  STD_LOGIC;
           zout : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
type regtype IS array(0 to 7) of std_logic_vector(7 downto 0);
signal R:regtype;
signal A,B:std_logic_vector(7 downto 0);
signal alutmp:std_logic_vector(8 downto 0);
signal cy:std_logic;
signal z:std_logic;
begin
   --process(rst,t2,t3,irin,Rupdate,Rdata,Raddr)
	process(rst,t2,t3,irin,Rupdate,Rdata)
	begin
	   A<=R(conv_integer(irin(10 downto 8)));
		B<=R(conv_integer(irin(2 downto 0)));
		--case irin(15 downto 11) is
		   --when "00001" => addr<=R(7)&irin(10 downto 3);
			--when "00010" => addr<=R(7)&irin(7 downto 0);
			--when "10001" => addr<=R(7)&(R(6)+irin(7 downto 0));
			--when "10010" => addr<=R(7)&R(conv_integer(irin(2 downto 0)));
			--when others => null;
		--end case;
		rdreq<='0';
		wrreq<='0';
		if(rst='1') then
		   for i in 0 to 7 loop
			   R(i)<="00000000";
			end loop;
		   pnewout<="0000000000000000";
			addr<="0000000000000000";
			Rout<="00000000";
		   alutmp<="000000000";
			cy<='0';
			z<='0';
		--end if;
		elsif(t2='1') then
		   case irin(15 downto 11) is
			   when "00000" => alutmp(7 downto 0)<=irin(7 downto 0);
				when "00001" => addr<=R(7)&irin(10 downto 3);rdreq<='0';wrreq<='1';Rout<=R(conv_integer(irin(2 downto 0)));
				when "00010" => addr<=R(7)&irin(7 downto 0);rdreq<='1';wrreq<='0';
				when "00011" => alutmp(7 downto 0)<=R(conv_integer(irin(2 downto 0)));
				when "00100" => alutmp<='0'&A+irin(7 downto 0)+cy;
			                   if(alutmp="000000000") then z<='1';
			                   else z<='0';
			                   end if;
									 --cy<=alutmp(8);
				when "00101" => alutmp<='0'&A+B+cy;
				                if(alutmp="000000000") then z<='1';
			                   else z<='0';
			                   end if;
									 --cy<=alutmp(8);
				when "00110" => alutmp<='0'&A-irin(7 downto 0)-cy;
				                if(alutmp="000000000") then z<='1';
			                   else z<='0';
			                   end if;
									 --cy<=alutmp(8);
				when "00111" => alutmp<='0'&A-B-cy;
				                if(alutmp="000000000") then z<='1';
			                   else z<='0';
			                   end if;
									 --cy<=alutmp(8);
				when "01000" => alutmp(7 downto 0)<=A and irin(7 downto 0);
				when "01001" => alutmp(7 downto 0)<=A and B;
				when "01010" => alutmp(7 downto 0)<=A or irin(7 downto 0);
				when "01011" => alutmp(7 downto 0)<=A or B;
				when "01100" => --cy<='0';
				                alutmp(8)<='0';
				when "01101" => --cy<='1';
				                alutmp(8)<='1';
				when "01110" => pnewout<=R(7)&irin(7 downto 0);
				when "01111" => if(irin(7)='1') then pnewout<=pcin+irin(6 downto 0)-"10000000";
									 else pnewout<=pcin+irin(6 downto 0);
									 end if;
				when "10000" => if(irin(7)='1') then pnewout<=pcin+irin(6 downto 0)-"10000000";
									 else pnewout<=pcin+irin(6 downto 0);
									 end if;
				when "10001" => addr<=R(7)&(R(6)+irin(7 downto 0));rdreq<='1';wrreq<='0';
				when "10010" => addr<=R(7)&R(conv_integer(irin(2 downto 0)));rdreq<='1';wrreq<='0';
				when others => null;
			end case;
			--aluout<=alutmp(7 downto 0);
		--end if;
		elsif(t3='1') then
		   cy<=alutmp(8);
		   aluout<=alutmp(7 downto 0);
			cyout<=cy;
	      zout<=z;
		   --cy<=alutmp(8);----------------------------------------
			--if(alutmp="000000000") then z<='1';
			--else z<='0';
			--end if;-----------------------------------------------
		--end if;
		elsif(Rupdate='1') then
		   --R(conv_integer(irin(10 downto 8)))<=Rdata;
			R(conv_integer(Raddr))<=Rdata;
		end if;
		--aluout<=alutmp(7 downto 0);
	   --cyout<=cy;
	   --zout<=z;
	end process;
	Rseven<=R(7);
end Behavioral;