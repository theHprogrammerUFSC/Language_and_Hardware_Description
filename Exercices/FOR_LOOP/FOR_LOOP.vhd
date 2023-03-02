-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY FOR_LOOP IS

	GENERIC (
		n : INTEGER := 16
	);

	PORT (
		i_A : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		i_B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		i_C : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		i_D : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		i_E : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);

		o_F : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);

END FOR_LOOP;

ARCHITECTURE Behavioral OF FOR_LOOP IS

	SIGNAL w_G : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
	SIGNAL w_H : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);

BEGIN
	PROCESS (i_A, i_B, i_C, i_D, i_E)
	BEGIN
		U01 : FOR i IN (n - 1) DOWNTO 0 LOOP
			w_G(i) <= i_A(i) AND i_B(i) AND i_C(i);
			w_H(i) <= i_C(i) AND i_D(i) AND i_E(i);
			o_F(i) <= w_G(i) OR w_H(i);
		END LOOP U01;
	END PROCESS;

END Behavioral;