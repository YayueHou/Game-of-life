----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/06/15 13:55:23
-- Design Name: 
-- Module Name: Cell_Module - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;


ENTITY SINGLE_CELL IS
PORT (clk,srstn,ce,load,NW,N,NE,W,E,SW,S,SE:IN STD_LOGIC;
        state:OUT STD_LOGIC );
END SINGLE_CELL;

ARCHITECTURE Behavioral OF SINGLE_CELL IS

SIGNAL current_state:STD_LOGIC;
SIGNAL next_state:STD_LOGIC;
SIGNAL live_num:INTEGER;


FUNCTION convert_logic(a:STD_LOGIC)RETURN INTEGER IS
    BEGIN
        IF a='1' THEN 
            RETURN 1;
        ELSE 
            RETURN 0;
        END IF;
    END FUNCTION convert_logic;

    
BEGIN 

REG:PROCESS(clk,srstn)
BEGIN
    IF clk'EVENT AND clk='1' THEN
        IF srstn='0' THEN
            current_state<='0';
        ELSE
            IF ce='1' THEN
                current_state<=next_state;       
            END IF;
        END IF;
    END IF;
END PROCESS REG;

STATE_OUT:PROCESS(current_state)
BEGIN 
    state<=current_state;
END PROCESS STATE_OUT;

--state<=current_state;

live_num<=((convert_logic(NW)+convert_logic(N))+(convert_logic(NE)+convert_logic(E)))
         +((convert_logic(SE)+convert_logic(S))+(convert_logic(SW)+convert_logic(W)));
NEXT_GET:PROCESS(load,live_num)
BEGIN
    IF load='1'THEN
        next_state<=W;
    ELSE
        IF current_state='1' THEN
            IF live_num=2 THEN
                next_state<='1';
            ELSIF live_num=3 THEN
                next_state<='1';
            ELSE
                next_state<='0';
            END IF;
        ELSIF current_state='0' THEN
            IF live_num=3 THEN
                next_state<='1';
            ELSE
                next_state<='0';
            END IF;
        ELSE 
               next_state<=current_state;
        END IF;     
    END IF;
END PROCESS NEXT_GET;

END Behavioral;
