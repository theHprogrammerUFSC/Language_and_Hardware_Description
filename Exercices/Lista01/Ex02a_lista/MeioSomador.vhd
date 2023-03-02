-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar Meio Somador
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MeioSomador IS
	PORT (
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		o_S : OUT STD_LOGIC;
		o_C : OUT STD_LOGIC
	);
END MeioSomador;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF MeioSomador IS

BEGIN

	o_S <= i_A XOR i_B;
	o_C <= i_B AND i_A;

END Behavioral;