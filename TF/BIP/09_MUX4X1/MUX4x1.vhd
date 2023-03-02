-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 25/06/2022
--
-- Implementar multiplexador 3x1 para seleção do OP1
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MUX4x1 IS
	GENERIC (
		n : INTEGER := 16
	);
	PORT (
		-- Entradas
		i_BUS_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 0
		i_BUS_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 1
		i_BUS_C : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 2
		i_SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Seleção para a entrada

		-- Saídas
		o_BUS : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0) -- Saída do valor que está na entrada
	);
END MUX4x1;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF MUX4x1 IS
BEGIN
	-- Implementação do MUX
	-------------------------------------------------------------------------------------------------------------------------

	WITH (i_SEL) SELECT o_BUS <=
	i_BUS_A WHEN "00",
	i_BUS_B WHEN "01",
	i_BUS_C WHEN "10",
	(OTHERS => 'Z') WHEN OTHERS;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;