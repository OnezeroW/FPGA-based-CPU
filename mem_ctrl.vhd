----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:55:40 11/19/2013 
-- Design Name: 
-- Module Name:    mem_ctrl - Behavioral 
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

entity mem_ctrl is
    Port ( irreq : in  STD_LOGIC;
           pcaddr : in  STD_LOGIC_VECTOR (15 downto 0);
           rd : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (15 downto 0);
           regdata : in  STD_LOGIC_VECTOR (7 downto 0);
			  ir : out  STD_LOGIC_VECTOR (15 downto 0);
           mrout : out  STD_LOGIC_VECTOR (7 downto 0);
           DBUS : inout  STD_LOGIC_VECTOR (15 downto 0);
           ABUS : out  STD_LOGIC_VECTOR (15 downto 0);
           nmreq : out  STD_LOGIC;
           nrd : out  STD_LOGIC;
           nwr : out  STD_LOGIC;
           nbhe : out  STD_LOGIC;
           nble : out  STD_LOGIC);
end mem_ctrl;

architecture Behavioral of mem_ctrl is
begin
   process(irreq,pcaddr,rd,wr,addr,regdata)
	begin
	   if(irreq='1') then
		   nmreq<='0';nrd<='0';nwr<='1';nbhe<='0';nble<='0';
			ABUS<=pcaddr;ir<=DBUS;DBUS<="ZZZZZZZZZZZZZZZZ";
		elsif(rd='1') then
		   nmreq<='0';nrd<='0';nwr<='1';nbhe<='1';nble<='0';
			ABUS<=addr;mrout<=DBUS(7 downto 0);DBUS<="ZZZZZZZZZZZZZZZZ";
		elsif(wr='1') then
		   nmreq<='0';nrd<='1';nwr<='0';nbhe<='1';nble<='0';
			ABUS<=addr;--DBUS<="ZZZZZZZZ"&regdata;
			--DBUS(15 downto 8)<="ZZZZZZZZ";DBUS(7 downto 0)<=regdata;
			DBUS<="00000000"&regdata;
		else
		   nmreq<='1';nrd<='1';nwr<='1';nbhe<='1';nble<='1';
			DBUS<="ZZZZZZZZZZZZZZZZ";
		end if;
	end process;
end Behavioral;