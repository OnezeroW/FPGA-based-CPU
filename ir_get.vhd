----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:54:24 11/18/2013 
-- Design Name: 
-- Module Name:    ir_get - Behavioral 
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

entity ir_get is
    Port ( clk : in  STD_LOGIC;
	        rst : in  STD_LOGIC;
	        t0 : in  STD_LOGIC;
	        t1 : in  STD_LOGIC;
           pcupdate : in  STD_LOGIC;
           pcnew : in  STD_LOGIC_VECTOR (15 downto 0);
           irnew : in  STD_LOGIC_VECTOR (15 downto 0);
           irout : out  STD_LOGIC_VECTOR (15 downto 0);
           pcout : out  STD_LOGIC_VECTOR (15 downto 0);
           irreq : out  STD_LOGIC);
end ir_get;

architecture Behavioral of ir_get is
signal IR,PC : STD_LOGIC_VECTOR (15 downto 0);
begin
   process(clk,rst,t0,t1,pcupdate,pcnew,irnew)
	begin
	   if(rst='1') then irreq<='0';
		   IR<="0000000000000000";PC<="0000000000000000";
	   elsif(t0='1') then irreq<='1';IR<=irnew;
      elsif(t1='1') then irreq<='0';
			if(clk' event and clk='0') then PC<=PC+1;
			end if;
			--PC<=PC+1;
		elsif(pcupdate='1') then
		   --if(clk' event and clk='0') then PC<=pcnew;
			--end if;
			PC<=pcnew;
		end if;
	end process;
	pcout<=PC;
	irout<=IR;
end Behavioral;