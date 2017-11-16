----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:22 11/20/2013 
-- Design Name: 
-- Module Name:    cpu - Behavioral 
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

entity cpu is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           DBUS : inout  STD_LOGIC_VECTOR (15 downto 0);
           ABUS : out  STD_LOGIC_VECTOR (15 downto 0);
           nmreq : out  STD_LOGIC;
           nrd : out  STD_LOGIC;
           nwr : out  STD_LOGIC;
           nbhe : out  STD_LOGIC;
           nble : out  STD_LOGIC;
			  
			  DRupdate : out  STD_LOGIC;
			  Rseven : out  STD_LOGIC_VECTOR (7 downto 0);
			  
			  --Drst : out  STD_LOGIC;
			  DIR : out  STD_LOGIC_VECTOR (15 downto 0);
			  DT : out  STD_LOGIC_VECTOR (4 downto 0);
           DDBUS : out  STD_LOGIC_VECTOR (15 downto 0);
           DABUS : out  STD_LOGIC_VECTOR (15 downto 0);
           Dnmreq : out  STD_LOGIC;
           Dnrd : out  STD_LOGIC;
           Dnwr : out  STD_LOGIC;
           Dnbhe : out  STD_LOGIC;
           Dnble : out  STD_LOGIC;
			  Dcy : out  STD_LOGIC;
			  Dz : out  STD_LOGIC);
			  
end cpu;

architecture Behavioral of cpu is
component clock is
port( clk: in std_logic;
	   rst:in std_logic;
 	   t: out std_logic_vector(4 downto 0));
end component;
component ir_get is
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
end component;
component alu is
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
end component;
component memory is
    Port ( rst : in  STD_LOGIC;
	        t3 : in  STD_LOGIC;
           irin : in  STD_LOGIC_VECTOR (15 downto 0);
           aluin : in  STD_LOGIC_VECTOR (7 downto 0);
           mrin : in  STD_LOGIC_VECTOR (7 downto 0);
           Rtempout : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
component wrback is
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
end component;
component mem_ctrl is
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
end component;

signal PCNEW,PCOUT,IROUT,IRNEW,PNEWOUT,ADDR : std_logic_vector(15 downto 0);
signal ALUOUT,REGDATA,RDATA,MRIN,RTEMPOUT : std_logic_vector(7 downto 0);
signal T : std_logic_vector(4 downto 0);
signal RADDR : std_logic_vector(2 downto 0);
signal PCUPDATE,IRREQ,CYOUT,ZOUT,RD,WR,RUPDATE : std_logic;
signal tmpABUS : std_logic_vector(15 downto 0);
signal tmpnmreq,tmpnrd,tmpnwr,tmpnbhe,tmpnble : std_logic;
signal R7 : std_logic_vector(7 downto 0);
begin
	U1: clock  port map(clk,rst,T);
	U2: ir_get port map(clk,rst,T(0),T(1),PCUPDATE,PCNEW,IRNEW,IROUT,PCOUT,IRREQ);
	U3: alu port map(R7,rst,T(2),T(3),PCOUT,IROUT,RUPDATE,RDATA,RADDR,ALUOUT,PNEWOUT,ADDR,REGDATA,RD,WR,CYOUT,ZOUT);
	U4: memory port map(rst,T(3),IROUT,ALUOUT,MRIN,RTEMPOUT);
	U5: wrback port map(rst,clk,T(4),IROUT,PNEWOUT,CYOUT,ZOUT,RTEMPOUT,RUPDATE,RADDR,RDATA,PCUPDATE,PCNEW);
	U6: mem_ctrl port map(IRREQ,PCOUT,RD,WR,ADDR,REGDATA,IRNEW,MRIN,DBUS,tmpABUS,tmpnmreq,tmpnrd,tmpnwr,tmpnbhe,tmpnble);
	
	--Drst<=rst;
	DIR<=IRNEW;
	DT<=T;
	DDBUS<=DBUS;
	DABUS<=tmpABUS;
	Dnmreq<=tmpnmreq;
	Dnrd<=tmpnrd;
	Dnwr<=tmpnwr;
	Dnbhe<=tmpnbhe;
	Dnble<=tmpnble;
	Dcy<=CYOUT;
	Dz<=ZOUT;
	DRupdate<=RUPDATE;
	Rseven<=R7;

	ABUS<=tmpABUS;
	nmreq<=tmpnmreq;
	nrd<=tmpnrd;
	nwr<=tmpnwr;
	nbhe<=tmpnbhe;
	nble<=tmpnble;
	
end Behavioral;