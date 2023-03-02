-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY PORTA_OR IS

	GENERIC (
		n : INTEGER := 64
	);

	PORT (
		i_A : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		i_B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		o_C : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);

END PORTA_OR;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF PORTA_OR IS
BEGIN

	o_C <= i_A OR i_B;

END Behavioral;