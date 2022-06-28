----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/15 22:23:48
-- Design Name: 
-- Module Name:  RUN_NET- Behavioral
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



ENTITY RUN_NET IS
GENERIC(r:INTEGER:=5;c:INTEGER:=5);
PORT (clk,srstn,ce,load,pre_load:IN STD_LOGIC;
       left_side:IN STD_LOGIC_VECTOR(r-1 DOWNTO 0);
       right_side:OUT STD_LOGIC_VECTOR(r-1 DOWNTO 0);
       read_cell:OUT STD_LOGIC_VECTOR(r*c-1 DOWNTO 0)
         );
END RUN_NET;

ARCHITECTURE Behavioral of RUN_NET IS
COMPONENT SINGLE_CELL
PORT (clk,srstn,ce,load,NW,N,NE,E,SE,S,SW,W:IN STD_LOGIC;
        state:OUT STD_LOGIC );
END COMPONENT;
SIGNAL NW,N,NE,E,SE,S,SW,W,cell:STD_LOGIC_VECTOR(R*C-1 DOWNTO 0);
--signal load:std_logic;
BEGIN
 
 WIN: FOR i IN 0 TO r-1 GENERATE
          WITH pre_load SELECT
          W(i*c)<=  left_side(i)  WHEN '1' ,
                     cell((i+1)*c-1) WHEN '0' ,
                     'X'WHEN OTHERS;
 END GENERATE WIN; 
     -------------------------------

---------internal part-----------
    CONC1:FOR i IN 1 TO r-2 GENERATE
    BEGIN
        CONC2:FOR j IN 1 TO c-2 GENERATE
        BEGIN
            NW(i*c+j)<=cell((i-1)*c+j-1);
            N(i*c+j)<=cell((i-1)*c+j);
            NE(i*c+j)<=cell((i-1)*c+j+1);
            W(i*c+j)<=cell(i*c+j-1);
            E(i*c+j)<=cell(i*c+j+1);
            SW(i*c+j)<=cell((i+1)*c+j-1);
            S(i*c+j)<=cell((i+1)*c+j);
            SE(i*c+j)<=cell((i+1)*c+j+1);
        END GENERATE CONC2;
    END GENERATE CONC1;

-------------left edge-----------------------------
    LEFT:FOR i IN 1 TO r-2 GENERATE
    BEGIN 
            NW(i*c)<=cell(i*c-1);
            N(i*c)<=cell((i-1)*c);
            NE(i*c)<=cell((i-1)*c+1);
      --      W(i*c)<=cell(i*c+c-1);
            E(i*c)<=cell(i*c+1);
            SW(i*c)<=cell((i+2)*c-1);
            S(i*c)<=cell((i+1)*c);
            SE(i*c)<=cell((i+1)*c+1);
    END GENERATE LEFT;


-----------------right edge
    RIGHT:FOR i IN 2 TO r-1 GENERATE 
        NW(i*c-1)<=cell((i-1)*c-2);
        N(i*c-1)<=cell((i-1)*c-1);
        NE(i*c-1)<=cell((i-2)*c);
        W(i*c-1)<=cell(i*c-2);
        E(i*c-1)<=cell((i-1)*c);
        SW(i*c-1)<=cell((i+1)*c-2);
        S(i*c-1)<=cell((i+1)*c-1);
        SE(i*c-1)<=cell(i*c);
    END GENERATE RIGHT;

----------------up edge---------------------
    UP:FOR i IN 1 TO c-2 GENERATE 
        NW(i)<=cell((r-1)*c+i-1);
        N(i)<=cell((r-1)*c+i);
        NE(i)<=cell((r-1)*c+i+1);
        W(i)<=cell(i-1);
        E(i)<=cell(i+1);
        SW(i)<=cell(c+i-1);
        S(i)<=cell(c+i);
        SE(i)<=cell(c+i+1);
    END GENERATE UP;

---------------down edge--------------------
    DOWN:FOR i IN 1 TO c-2 GENERATE 
        NW((r-1)*c+i)<=cell((r-2)*c+i-1);
        N((r-1)*c+i)<=cell((r-2)*c+i);
        NE((r-1)*c+i)<=cell((r-2)*c+i+1);
        W((r-1)*c+i)<=cell((r-1)*c+i-1);
        E((r-1)*c+i)<=cell((r-1)*c+i+1);
        SW((r-1)*c+i)<=cell(i-1);
        S((r-1)*c+i)<=cell(i);
        SE((r-1)*c+i)<=cell(i+1);
    END GENERATE DOWN;

-----------------north west---------------
NWCORNER: BLOCK    
BEGIN
    NW(0)<=cell(c*r-1);
    N(0)<=cell((r-1)*c);
    NE(0)<=cell((r-1)*c+1);
  --  W(0)<=cell(c-1);
    E(0)<=cell(1);
    SW(0)<=cell(c*2-1);
    S(0)<=cell(c);
    SE(0)<=cell(c+1);
END BLOCK NWCORNER;




------------------north east------------------
NECORNER: BLOCK 
BEGIN
    NW(c-1)<=cell(r*c-2);
    N(c-1)<=cell(r*c-1);
    NE(c-1)<=cell((r-1)*c);
    W(c-1)<=cell(c-2);
    E(c-1)<=cell(0);
    SW(c-1)<=cell(2*c-2);
    S(c-1)<=cell(2*c-1);
    SE(c-1)<=cell(c); 
END BLOCK NECORNER;

-------------------------south west---------------------------
SWCORNER: BLOCK 
BEGIN
    NW(c*(r-1))<=cell((c-1)*r-1);
    N(c*(r-1))<=cell((c-2)*r);
    NE(c*(r-1))<=cell((c-2)*r+1);
   --W(c*(r-1))<=cell(c*r-1);
    E(c*(r-1))<=cell((c-1)*r+1);
    SW(c*(r-1))<=cell(c-1);
    S(c*(r-1))<=cell(0);
    SE(c*(r-1))<=cell(1); 
END BLOCK SWCORNER;

---------------------------------south east-------------------------------
SECORNER: BLOCK 
BEGIN
    NW(c*r-1)<=cell((r-1)*c-2);
    N(c*r-1)<=cell((r-1)*c-1);
    NE(c*r-1)<=cell((r-2)*c);
    W(c*r-1)<=cell(r*c-2);
    E(c*r-1)<=cell((r-1)*c);
    SW(c*r-1)<=cell(c-2);
    S(c*r-1)<=cell(c-1);
    SE(c*r-1)<=cell(0); 
END BLOCK SECORNER;
--------------------------------------------
GENERATE_CELL1:FOR i IN 0 TO R-1 GENERATE
BEGIN
    GENERATE_CELL2:FOR j IN 0 TO C-1 GENERATE
        CELL_INTIA:SINGLE_CELL PORT MAP(clk=>clk,srstn=>srstn,ce=>ce,load=>load,NW=>NW(i*C+j),N=>N(i*C+j),
            NE=>NE(i*C+j),W=>W(i*C+j),E=>E(i*C+j),SW=>SW(i*C+j),S=>S(i*C+j),SE=>SE(i*C+j),state=>cell(i*C+j));
    END GENERATE GENERATE_CELL2;
END GENERATE GENERATE_CELL1;

------------------------------------
OUTPUT:FOR i IN 0 TO r-1 generate
    right_side(i)<=cell(i*c+c-1);  
END GENERATE OUTPUT;  
read_cell<=cell;
END Behavioral;
