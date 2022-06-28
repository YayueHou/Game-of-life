----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/19 19:35:33
-- Design Name: 
-- Module Name: Map_Module_tb - Behavioral
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

ENTITY RUN_SIM IS
GENERIC(r:integer:=8;c:integer:=8);
END RUN_SIM;

ARCHITECTURE Behavioral OF RUN_SIM IS
COMPONENT RUN_NET
GENERIC(r:INTEGER:=8;c:INTEGER:=8);
Port (clk,srstn,ce,load,pre_load:IN STD_LOGIC;
       right_side:OUT STD_LOGIC_VECTOR(r-1 downto 0);
       left_side:IN STD_LOGIC_VECTOR(r-1 downto 0);
       read_cell :OUT  STD_LOGIC_VECTOR(r*c-1 downto 0)
         );
END COMPONENT;

CONSTANT HPCLK:TIME:=10ns;
SIGNAL clk:STD_LOGIC:='0';
SIGNAL srstn:STD_LOGIC:='1';
SIGNAL ce:STD_LOGIC:='1';
SIGNAL load:STD_LOGIC:='0';
SIGNAL pre_load:STD_LOGIC:='0';

SIGNAL left_side:STD_LOGIC_VECTOR(r-1 DOWNTO 0):="00000000";
SIGNAL right_side:STD_LOGIC_VECTOR(r-1 DOWNTO 0):="00000000";
SIGNAL read_cell :STD_LOGIC_VECTOR(c*r-1 DOWNTO 0);

BEGIN

GENERATE_CLK:process
begin
    clk<='0';
    wait for HPCLK;
    clk<='1';
    wait for HPCLK;
END PROCESS GENERATE_CLK;

SIM:PROCESS
BEGIN
    WAIT FOR 2*HPCLK;
    srstn<='1';
    WAIT FOR 2*HPCLK;
    srstn<='0'; 
    WAIT FOR 2*HPCLK;
    srstn<='1';
   
 
    
    left_side<="11011111";
    pre_load<='1';
    load<='1';
    WAIT FOR 2*HPCLK;
    load<='0';
    pre_load<='0';
    WAIT FOR 60*HPCLK;
    
    left_side<="11111111";
    pre_load<='1';
    load<='1';
    WAIT FOR 2*HPCLK;
    load<='0';
    pre_load<='0';
    WAIT FOR 60*HPCLK;
    
    left_side<="11100111";
    pre_load<='1';
    load<='1';
    WAIT FOR 2*HPCLK;
    load<='0';
    pre_load<='0';
    WAIT FOR 60*HPCLK;
    
    
END PROCESS SIM;

DUT:RUN_NET PORT MAP(clk=>clk,srstn=>srstn,ce=>ce,load=>load,pre_load=>pre_load,
       right_side=>right_side,left_side=>left_side,read_cell=>read_cell);

end Behavioral;











