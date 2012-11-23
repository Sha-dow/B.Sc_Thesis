-------------------------------------------------------------------------------
-- Title      : Counter Testbench
-- Project    : Kandidaatintyö
-------------------------------------------------------------------------------
-- File       : counter_tb.vhd
-- Author     :   <Hannu_2@BLACKPEARL>
-- Company    : 
-- Created    : 2012-03-12
-- Last update: 2012-03-14
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Simple testbench for counters
-------------------------------------------------------------------------------
-- Copyright (c) 2012 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2012-03-12  1.0      Hannu_2 Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------

entity counter_tb is
  
  port (
    clk    : out std_logic;             -- kello
    reset  : out std_logic;             -- reset
    enable : out std_logic);            -- enable

end counter_tb;

-------------------------------------------------------------------------------
-- ARCHITECHTURE
-------------------------------------------------------------------------------
architecture tb_counter of counter_tb is

  -- vakiot
  constant clk_period_c     : time := 100 ns;  -- kellon viive
  constant execution_cycle_c : integer := 1000000;    -- simulaation suoritusaika

  -- Signaalit
  signal clk_int    : std_logic := '0';            -- kello
  signal reset_int  : std_logic := '0';            -- reset
  signal enable_int : std_logic := '0';            -- enable
  
  signal clk_count_r : integer := 0;

  signal simulation_ready_r : std_logic := '0';  -- simulaatio valmis

begin  -- tb_counter

  reset_int  <= '1' after clk_period_c*2;
  enable_int <= '1' after clk_period_c*4;

  -- purpose: Generoi kello
  -- type   : combinational
  -- inputs : clk
  -- outputs: clk
  clk_gen : process (clk_int)
  begin  -- process clk_gen
    clk_int <= not clk_int after clk_period_c/2;
  end process clk_gen;
  
  -- purpose: Aja simulaatiota ja keskeyta oikeassa kohdassa
  -- type   : sequential
  -- inputs : clk, reset
  -- outputs: simulation_ready_r  
  calculate : process (clk_int, reset_int)
  begin  -- process input_gen_output_check
    if reset_int = '0' then                 -- asynchronous reset (active low)
      
    elsif clk_int'event and clk_int = '1' then  -- rising clock edge

      if clk_count_r = execution_cycle_c then
        clk_count_r <= 0;
		simulation_ready_r <= '1';
        
      else
        clk_count_r <= clk_count_r + 1;
      end if;
    
    end if;
  end process calculate;


  clk <= clk_int;
  reset <= reset_int;
  enable <= enable_int;
  
  assert simulation_ready_r = '0'
    report "Simulation finished!" severity failure;

  

end tb_counter;
