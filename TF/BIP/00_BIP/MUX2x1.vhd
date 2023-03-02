-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 28/06/2022
--
-- Implementar multiplexador de até 2 entradas de n bits
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MUX2x1 IS
	GENERIC (
		n : INTEGER := 16
	);
	PORT (
		-- Entradas
		i_BUS_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 0
		i_BUS_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 1
		i_SEL : IN STD_LOGIC; -- Seletor de entrada

		-- Saídas
		o_BUS : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0) -- Saída do Resultado
	);
END MUX2x1;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF MUX2x1 IS
BEGIN
	-- Implementação do MUX
	-------------------------------------------------------------------------------------------------------------------------

	-- Comportamento do multiplexador
	WITH (i_SEL) SELECT o_BUS <=
	i_BUS_A WHEN '0',
	i_BUS_B WHEN '1',
	(OTHERS => 'Z') WHEN OTHERS;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;