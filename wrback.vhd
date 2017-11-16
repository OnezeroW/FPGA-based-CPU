----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:12:49 11/19/2013 
-- Design Name: 
-- Module Name:    wrback - Behavioral 
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

entity wrback is
    Port ( rst : in  STD_LOGIC;
	        clk : in  STD_LOGIC;
           t4 : in  STD_LOGIC;
           irin : in  STD_LOGIC_VECTOR (15 downto 0);
           --pcin : in  STD_LOGIC_VECTOR (15 downto 0);
           pcnewin : in  STD_LOGIC_VECTOR (15 downto 0);
           cyin : in  STD_LOGIC;
           zin : in  STD_LOGIC;
           Rtempin : in  STD_LOGIC_VECTOR (7 downto 0);
           Rupdate : out  STD_LOGIC;
           Raddrout : out  STD_LOGIC_VECTOR (2 downto 0);
           Rdataout : out  STD_LOGIC_VECTOR (7 downto 0);
           pcupdate : out  STD_LOGIC;
           pcnewout : out  STD_LOGIC_VECTOR (15 downto 0));
end wrback;

architecture Behavioral of wrback is
signal pcnewtmp : std_logic_vector(15 downto 0);
begin
   process(rst,clk,t4,irin,pcnewin,cyin,zin,Rtempin)
	begin
	   if(rst='1') then Rupdate<='0';pcupdate<='0';
		   Raddrout<="000";Rdataout<="00000000";
			pcnewtmp<="0000000000000000";
		elsif(t4='1') then
		   case irin(15 downto 11) is
			   when "00000" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "00001" => Rupdate<='0';pcupdate<='0';
            when "00010" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "00011" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "00100" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "00101" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "00110" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "00111" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "01000" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "01001" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "01010" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "01011" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "01100" => Rupdate<='0';pcupdate<='0';
				when "01101" => Rupdate<='0';pcupdate<='0';
				when "01110" => pcnewtmp<=pcnewin;pcupdate<='1';Rupdate<='0';
				when "01111" => if(zin='1') then pcnewtmp<=pcnewin;pcupdate<='1';
				                else pcupdate<='0';
				                end if;
									 Rupdate<='0';
				when "10000" => if(cyin='1') then pcnewtmp<=pcnewin;pcupdate<='1';
				                else pcupdate<='0';
				                end if;
									 Rupdate<='0';
				when "10001" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when "10010" => Raddrout<=irin(10 downto 8);Rdataout<=Rtempin;Rupdate<='1';pcupdate<='0';
				when others => null;
			end case;
		else Rupdate<='0';pcupdate<='0';
		--else pcupdate<='0';
		end if;
	end process;
	pcnewout<=pcnewtmp;
end Behavioral;