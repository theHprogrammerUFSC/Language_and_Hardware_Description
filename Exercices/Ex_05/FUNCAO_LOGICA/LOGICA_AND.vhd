-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Lógica para Componetização
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY LOGICA_AND IS
	PORT (
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		i_D : IN STD_LOGIC;
		i_E : IN STD_LOGIC;
		o_C : OUT STD_LOGIC
	);
END LOGICA_AND;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF LOGICA_AND IS

	SIGNAL w_F : STD_LOGIC;
	SIGNAL w_G : STD_LOGIC;

BEGIN

	w_F <= i_A AND i_B AND i_C;
	w_G <= i_C AND i_D AND i_E;
	o_C <= w_F OR w_G;

END Behavioral;