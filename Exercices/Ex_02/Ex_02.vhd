-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Ex_02 IS

	PORT (
		i_A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		--		i_B		: in	STD_LOGIC_VECTOR(7 DOWNTO 0);
		--		o_C		: out	STD_LOGIC_VECTOR(7 DOWNTO 0)
		o_C : OUT STD_LOGIC
	);

END Ex_02;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF Ex_02 IS

BEGIN

	--		o_C <= i_A and i_B;
	o_C <= i_A(0) AND i_A(1) AND i_A(2) AND i_A(3) AND i_A(4) AND i_A(5) AND i_A(6) AND i_A(7);

END Behavioral;