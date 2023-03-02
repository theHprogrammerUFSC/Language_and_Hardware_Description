-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Lógica Pin-Out
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Ex_04 IS
	GENERIC (
		N : INTEGER := 4
	);

	PORT (
		i_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
		i_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
		o_C : OUT STD_LOGIC;
		o_D : OUT STD_LOGIC
	);
END Ex_04;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF Ex_04 IS
BEGIN

	o_C <= i_A(0) AND i_A(1) AND i_A(2) AND i_A(3) AND i_B(0) AND i_B(1) AND i_B(2) AND i_B(3);
	o_D <= i_A(0) OR i_A(1) OR i_A(2) OR i_A(3) OR i_B(0) OR i_B(1) OR i_B(2) OR i_B(3);

END Behavioral;