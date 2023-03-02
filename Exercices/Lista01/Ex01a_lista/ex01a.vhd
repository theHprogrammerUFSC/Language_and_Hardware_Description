-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar ~((A∧~B)∨~(C∧D)) = (~A∨B)∧C∧D
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ex01a IS
	PORT (
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		i_D : IN STD_LOGIC;
		o_S : OUT STD_LOGIC
	);
END ex01a;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF ex01a IS

	SIGNAL w_E : STD_LOGIC;
	SIGNAL w_F : STD_LOGIC;

BEGIN

	--w_E <= not i_A or i_B;
	--o_S <= w_E and i_C and i_D;
	w_E <= i_A AND NOT i_B;
	w_F <= i_C NAND i_D;
	o_S <= w_E NOR w_F;

END Behavioral;