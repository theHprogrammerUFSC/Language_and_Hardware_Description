-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar um Meio Somador de 2 bit
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY HALF_ADDER IS
	PORT (
		-- Entradas
		i_INPUT_A : IN STD_LOGIC; -- Entrada do primeiro valor
		i_INPUT_B : IN STD_LOGIC; -- Entrada do segundo valor

		-- Saídas
		o_OUTPUT : OUT STD_LOGIC; -- Saída do Resultado
		o_CARRY : OUT STD_LOGIC -- Estouro
	);
END HALF_ADDER;

ARCHITECTURE Behavioral OF HALF_ADDER IS
BEGIN
	-- Implementar um Meio Somador de 2 bit
	-------------------------------------------------------------------------------------------------------------------------

	o_OUTPUT <= i_INPUT_A XOR i_INPUT_B; -- Saída RESULTADO
	o_CARRY <= i_INPUT_A AND i_INPUT_B; -- ESTOURO, famoso "vai um"

	-------------------------------------------------------------------------------------------------------------------------	
END Behavioral;