----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:56:41 11/18/2013 
-- Design Name: 
-- Module Name:    clock - Behavioral 
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

entity clock is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           t : out  STD_LOGIC_VECTOR (4 downto 0));
end clock;

architecture Behavioral of clock is
signal tmp : std_logic_vector(4 downto 0);
begin
   process(rst,clk)
	begin
	   if rst='1' then t<="00000";tmp<="00001";
		elsif clk' event and clk='1' then
		   case tmp is
				when "00001" => tmp<="00010";
				when "00010" => tmp<="00100";
				when "00100" => tmp<="01000";
				when "01000" => tmp<="10000";
				when "10000" => tmp<="00001";
				when others => null;
			end case;
			t<=tmp;
		end if;
	end process;
end Behavioral;