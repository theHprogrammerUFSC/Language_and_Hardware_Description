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

ENTITY LOGIC2 IS
	PORT (
		-- Entradas
		i_D1 : IN STD_LOGIC;
		i_D2 : IN STD_LOGIC;
		i_E : IN STD_LOGIC;

		-- Saídas
		o_S2 : OUT STD_LOGIC
	);
END LOGIC2;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF LOGIC2 IS

	-- Sinais Internos
	SIGNAL w_F : STD_LOGIC;
	SIGNAL w_G : STD_LOGIC;

BEGIN
	w_F <= i_D1 AND i_E;
	w_G <= i_D2 AND '1';
	o_S2 <= w_F OR w_G;

END Behavioral;