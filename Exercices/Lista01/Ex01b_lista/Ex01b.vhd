-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar ~((A∧B∧~C∨~(CD))⊕D)
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ex01b IS
	PORT (
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		i_D : IN STD_LOGIC;
		o_S : OUT STD_LOGIC
	);
END ex01b;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF ex01b IS

	SIGNAL w_E : STD_LOGIC;
	SIGNAL w_F : STD_LOGIC;
	SIGNAL W_G : STD_LOGIC;

BEGIN

	PROCESS (i_A, i_B, i_C, i_D, w_E, w_F, w_G)
	BEGIN

		w_E <= i_A AND i_B AND (NOT i_C);
		w_F <= i_C NAND i_D;
		w_G <= w_E OR w_F;
		o_S <= w_G XNOR i_D;

	END PROCESS;
END Behavioral;