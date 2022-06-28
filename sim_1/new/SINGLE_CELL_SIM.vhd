----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/22 23:07:27
-- Design Name: 
-- Module Name: SINGLE_CELL_SIM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SINGLE_CELL_SIM is
--  Port ( );
end SINGLE_CELL_SIM;


architecture Behavioral of SINGLE_CELL_SIM is
component SINGLE_CELL
Port (clk,srstn,ce,load,NW,N,NE,E,SE,S,SW,W:in std_logic;
        state:out std_logic);--live:out integer);
end component;

signal clk:std_logic:='0';
signal srstn:std_logic:='1';
signal ce:std_logic:='1';
signal load:std_logic:='0';
signal NW,N,NE,E,SE,S,SW,W:std_logic:='1';
--signal live:integer;
--signal load_initial:std_logic:='0';
--signal initial:std_logic:='1';
signal state:std_logic;
--signal live: INTEGER;
constant CLK_period:TIME:=10ns;
begin
tb_process:process
begin
    --同步复位
    ce<='1';
    srstn<='1';
    wait for 20*CLK_period;
    srstn<='0';
    wait for 20*CLK_period;
    srstn<='1';
    
    --加载W状态进入Cell
    wait for 20*CLK_period;
    load<='1';
    wait for 10*CLK_period;
    load<='0';
    
    --周围有4个活细胞
    --wait for 20ns;
    NW<='1';
    N<='1';
    NE<='1';
    E<='1';
    SE<='0';
    S<='0';
    SW<='0';
    W<='0';
     wait for 6*CLK_period;
     
    --周围有3个活细胞
     
      NW<='1';
      N<='1';
      NE<='1';
      E<='0';
      SE<='0';
      S<='0';
      SW<='0';
      W<='0';
       wait for 6*CLK_period;
        --周围有2个活细胞
      NW<='1';
      N<='1';
      NE<='0';
      E<='0';
      SE<='0';
      S<='0';
      SW<='0';
      W<='0';
       wait for 6*CLK_period;
        --周围有1个活细胞
     NW<='1';
     N<='0';
     NE<='0';
     E<='0';
     SE<='0';
     S<='0';
     SW<='0';
     W<='0';
   wait for 6*CLK_period;
      NW<='0';
      N<='0';
      NE<='0';
      E<='0';
      SE<='0';
      S<='0';
      SW<='0';
      W<='0';
       wait for 6*CLK_period;
        --周围有1个活细胞
    
   --周围有3个活细胞
    
    NW<='0';
    N<='0';
    NE<='1';
    E<='1';
    SE<='0';
    S<='1';
    SW<='1';
    W<='0';
    wait for 6*CLK_period;
    
       --周围有3个活细胞
    
    NW<='1';
    N<='1';
    NE<='1';
    E<='1';
    SE<='1';
    S<='1';
    SW<='1';
    W<='1';
    wait for 6*CLK_period;
    
    
       --周围有3个活细胞
    
    NW<='0';
    N<='0';
    NE<='0';
    E<='0';
    SE<='0';
    S<='1';
    SW<='1';
    W<='1';
    wait for 6*CLK_period;
    
    
       --周围有3个活细胞
    
    NW<='0';
    N<='0';
    NE<='0';
    E<='1';
    SE<='0';
    S<='0';
    SW<='1';
    W<='0';
    wait for 6*CLK_period;
    
    
       --周围有3个活细胞
    
    NW<='0';
    N<='0';
    NE<='0';
    E<='0';
    SE<='0';
    S<='0';
    SW<='0';
    W<='1';
    wait for 6*CLK_period;
    
    
       --周围有3个活细胞
    
    NW<='0';
    N<='1';
    NE<='0';
    E<='0';
    SE<='1';
    S<='1';
    SW<='0';
    W<='0';
    wait for 6*CLK_period;
    
    ce<='0';
       --周围有3个活细胞
    
    NW<='0';
    N<='0';
    NE<='0';
    E<='0';
    SE<='1';
    S<='1';
    SW<='1';
    W<='1';
    wait for 6*CLK_period;
    
    NW<='0';
    N<='1';
    NE<='0';
    E<='0';
    SE<='1';
    S<='1';
    SW<='0';
    W<='0';
    wait for 6*CLK_period;
    
    NW<='0';
    N<='1';
    NE<='0';
    E<='0';
    SE<='0';
    S<='0';
    SW<='0';
    W<='0';
    wait for 10*CLK_period;
    ce<='1';
      
    NW<='0';
    N<='1';
    NE<='1';
    E<='0';
    SE<='1';
    S<='0';
    SW<='0';
    W<='0';
    wait for 10*CLK_period;
    --周围有1个活细胞
  --  wait for 20ns;
 --   NW<='1';
  --  N<='0';
 --   NE<='0';
 --   E<='0';
 --   SE<='0';
 --  S<='0';
 --   SW<='0';
 --   W<='0';
      
      --周围有3个活细胞
  --   wait for 20ns;
  --    NW<='1';
  --    N<='1';
  --    NE<='1';
  --    E<='0';
  --    SE<='0';
 --     S<='0';
 --     SW<='0';
  --    W<='0';
   
end process;



clk_process:process
begin
    clk<='0';
    wait for CLK_period/2;
    clk<='1';
    wait for CLK_period/2;
end process;

DUT:SINGLE_CELL port map(clk=>clk,srstn=>srstn,ce=>ce,load=>load,NW=>NW,N=>N,NE=>NE,E=>E,SE=>SE,S=>S,SW=>SW,W=>W,state=>state);--live=>live);


end Behavioral;
