-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Ex_01 IS

	PORT (
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		i_D : IN STD_LOGIC;
		i_E : IN STD_LOGIC;
		i_F : IN STD_LOGIC;
		o_G : OUT STD_LOGIC;
		o_H : OUT STD_LOGIC
	);

END Ex_01;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF Ex_01 IS
BEGIN
	o_G <= i_A OR i_B;
	o_H <= i_C AND i_D AND i_E AND i_F;
END Behavioral;