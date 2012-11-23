-------------------------------------------------------------------------------
-- Title      : Counter
-- Project    : Kandidaatintyö
-------------------------------------------------------------------------------
-- File       : counter.vhd
-- Author     : Hannu Ranta
-- Company    : 
-- Created    : 2011-11-19
-- Last update: 2011-11-24
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Simple counter 
-------------------------------------------------------------------------------
-- Copyright (c) 2011 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2011-11-19  1.0      Hannu   Created
-------------------------------------------------------------------------------

-- Kirjastot
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity counter is
  
  generic (
    width : integer := 20);             -- laskurin leveys

  port (
    clk       : in  std_logic;          -- kello sisaan
    rst_n     : in  std_logic;          -- alhaalla aktiivinen reset
    enable    : in  std_logic;          -- enable-signaali
    value_out : out std_logic_vector(width - 1 downto 0));  -- luku ulos

end counter;

-------------------------------------------------------------------------------
-- ARCHITECHTURE
-------------------------------------------------------------------------------
architecture rtl of counter is
  
  signal internal_count_r : signed(width - 1 downto 0);
  -- sisainen signaali tulokselle

  signal clk_count : integer;
  -- sisainen laskuri kellolle

  constant clk_cycle_c : integer := 50000;
  -- muuttuja clk:n jaksolle jolla laskurin arvoa paivitetaan

begin  -- rtl 



  -- purpose: laskuria kasvatetaan synkronisen prosessin sisalla
  -- type   : sequential
  -- inputs : clk, rst_n
  -- outputs: internal_count
  counter_pros : process (clk, rst_n)
  begin  -- process counter_pros
    if rst_n = '0' then                 -- asynchronous reset (active low)

      internal_count_r <= (others => '0');
      clk_count <= 0;
      
    elsif clk'event and clk = '1' then  -- rising clock edge

      if clk_count = clk_cycle_c then
        clk_count <= 0;

        if enable = '1' then
          internal_count_r <= internal_count_r + 1;
        else
          internal_count_r <= internal_count_r;
        end if;
        
      else
        clk_count <= clk_count + 1;
      end if;
    
    end if;
  end process counter_pros;

  value_out <= std_logic_vector(internal_count_r);

end rtl;
