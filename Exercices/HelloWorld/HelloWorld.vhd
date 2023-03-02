-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY HelloWorld IS

	PORT (
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		o_C : OUT STD_LOGIC
	);

END HelloWorld;

ARCHITECTURE Behavioral OF HelloWorld IS

BEGIN

	o_C <= i_A AND i_B;

END Behavioral;