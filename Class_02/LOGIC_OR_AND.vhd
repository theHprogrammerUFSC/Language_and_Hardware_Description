-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar uma porta lógica OR 2x1
-- Implementar uma porta lógica AND 4x1
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY LOGIC_OR_AND IS
	PORT (
		-- Entradas
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		i_D : IN STD_LOGIC;

		-- Saídas
		o_S : OUT STD_LOGIC
	);
END LOGIC_OR_AND;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE teste_or OF LOGIC_OR_AND IS
BEGIN
	-- Implementação da Lógica or 2x1
	o_S <= i_A OR i_B;
END teste_or;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE teste_and OF LOGIC_OR_AND IS
BEGIN
	-- Implementação da Lógica and 4x1
	o_S <= i_A AND i_B AND i_C AND i_D;
END teste_and;

-------------------------------------------------------------------------------------------------------------------------

CONFIGURATION config OF LOGIC_OR_AND IS
	FOR teste_or
	END FOR;
END;