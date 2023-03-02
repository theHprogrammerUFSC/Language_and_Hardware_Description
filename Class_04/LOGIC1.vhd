-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar Lógica de componentes da Aula 4 
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY LOGIC1 IS
	PORT (
		-- Entradas
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		i_D : IN STD_LOGIC;

		-- Saídas
		o_S1 : OUT STD_LOGIC;
		o_D1 : OUT STD_LOGIC;
		o_D2 : OUT STD_LOGIC
	);
END LOGIC1;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF LOGIC1 IS

	-- Sinais Internos
	SIGNAL w_F : STD_LOGIC;
	SIGNAL w_G : STD_LOGIC;

BEGIN
	w_F <= i_A AND i_B AND i_C;
	w_G <= i_C AND i_D;
	o_S1 <= w_F OR W_G;
	o_D1 <= i_D;
	o_D2 <= i_D;

END Behavioral;