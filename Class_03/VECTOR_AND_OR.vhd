-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar uma porta lógica OR 4x1 usando STD_LOGIC_VECTOR
-- Implementar uma porta lógica AND 8x1 usando STD_LOGIC_VECTOR
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY VECTOR_AND_OR IS
	GENERIC (
		bits : INTEGER := 8
	);
	PORT (
		-- Entradas
		i_IN : IN STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);

		-- Saídas
		o_S : OUT STD_LOGIC
	);
END VECTOR_AND_OR;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE teste_or OF VECTOR_AND_OR IS
BEGIN
	-- Implementação da Lógica or 2x1
	o_S <= i_IN(0) OR i_IN(1) OR i_IN(2) OR i_IN(3);
END teste_or;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE teste_and OF VECTOR_AND_OR IS
BEGIN
	-- Implementação da Lógica and 4x1
	o_S <= i_IN(0) AND i_IN(1) AND i_IN(2) AND i_IN(3) AND i_IN(4) AND i_IN(5) AND i_IN(6) AND i_IN(7);
END teste_and;

-------------------------------------------------------------------------------------------------------------------------

CONFIGURATION config OF VECTOR_AND_OR IS
	FOR teste_and
	END FOR;
END;