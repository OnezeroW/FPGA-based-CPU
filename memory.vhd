----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:27:34 11/19/2013 
-- Design Name: 
-- Module Name:    memory - Behavioral 
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

entity memory is
    Port ( rst : in  STD_LOGIC;
	        t3 : in  STD_LOGIC;
           irin : in  STD_LOGIC_VECTOR (15 downto 0);
           aluin : in  STD_LOGIC_VECTOR (7 downto 0);
           mrin : in  STD_LOGIC_VECTOR (7 downto 0);
           Rtempout : out  STD_LOGIC_VECTOR (7 downto 0));
end memory;

architecture Behavioral of memory is
signal Rtemp : std_logic_vector(7 downto 0);
begin
   process(rst,t3,irin,aluin,mrin)
	begin
	   if(rst='1') then Rtemp<="00000000";
		elsif(t3='1') then
		   case irin(15 downto 11) is
			   when "00010" => Rtemp<=mrin;
				when "10001" => Rtemp<=mrin;
				when "10010" => Rtemp<=mrin;
				when others => Rtemp<=aluin;
			end case;
		end if;
	end process;
   Rtempout<=Rtemp;
end Behavioral;

