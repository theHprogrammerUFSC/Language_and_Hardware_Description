-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Signals
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Ex_03 IS

	PORT (
		i_A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		i_B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		o_S : OUT STD_LOGIC
	);

END Ex_03;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF Ex_03 IS

	SIGNAL w_D : STD_LOGIC;
	SIGNAL w_C : STD_LOGIC;

BEGIN

	o_S <= w_C AND w_D;

	w_D <= i_B(0) OR i_B(1) OR i_B(2) OR i_B(3);

	w_C <= i_A(0) AND i_A(1) AND i_A(2) AND i_A(3);

END Behavioral;