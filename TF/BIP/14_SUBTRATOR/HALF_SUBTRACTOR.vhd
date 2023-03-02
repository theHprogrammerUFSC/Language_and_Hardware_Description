-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar um Meio Subtrator de 2 bit
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY HALF_SUBTRACTOR IS
	PORT (
		-- Entradas
		i_INPUT_A : IN STD_LOGIC; -- Entrada do primeiro valor
		i_INPUT_B : IN STD_LOGIC; -- Entrada do segundo valor			

		-- Saídas
		o_OUTPUT : OUT STD_LOGIC; -- Saída do Resultado
		o_BORROW : OUT STD_LOGIC -- Emprestimo
	);
END HALF_SUBTRACTOR;

ARCHITECTURE Behavioral OF HALF_SUBTRACTOR IS
BEGIN
	-- Implementar um Meio Subtrator de 2 bits
	-------------------------------------------------------------------------------------------------------------------------

	o_OUTPUT <= i_INPUT_A XOR i_INPUT_B; -- Saída RESULTADO
	o_BORROW <= (NOT i_INPUT_A) AND i_INPUT_B; -- Borrow "pede um emprestado"

	-------------------------------------------------------------------------------------------------------------------------	
END Behavioral;