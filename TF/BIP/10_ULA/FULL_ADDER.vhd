-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar um Somador Completo de 2 bit
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY FULL_ADDER IS
	PORT (
		-- Entradas
		i_INPUT_A : IN STD_LOGIC; -- Entrada do primeiro valor											
		i_INPUT_B : IN STD_LOGIC; -- Entrada do segundo valor
		i_CARRY : IN STD_LOGIC; -- Estouro anterior

		-- Saídas
		o_OUTPUT : OUT STD_LOGIC; -- Saída do Resultado
		o_CARRY : OUT STD_LOGIC -- Estouro
	);
END FULL_ADDER;

ARCHITECTURE Behavioral OF FULL_ADDER IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT HALF_ADDER IS
		PORT (
			-- Entradas
			i_INPUT_A : IN STD_LOGIC; -- Entrada do primeiro valor
			i_INPUT_B : IN STD_LOGIC; -- Entrada do segundo valor

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC; -- Saída do Resultado
			o_CARRY : OUT STD_LOGIC -- Estouro
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de Sinais Internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_OUTPUT_FOR_INPUT_A : STD_LOGIC; -- Resultado anterior entrando na entrada A
	SIGNAL w_CARRY1_FOR_o_CARRY : STD_LOGIC; -- Estouro 1 ligado ao estouro final
	SIGNAL w_CARRY2_FOR_o_CARRY : STD_LOGIC; -- Estouro 2 ligado ao estouro final
	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Implementar um Somador Completo de 2 bit

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------

	UHA_01 : HALF_ADDER
	PORT MAP(
		-- Entradas
		i_INPUT_A => i_INPUT_A, -- Recebe a entrada A
		i_INPUT_B => i_INPUT_B, -- Recebe a entrada B

		-- Saídas
		o_OUTPUT => w_OUTPUT_FOR_INPUT_A, -- Saída vai para a entrada A do segundo meio somador
		o_CARRY => w_CARRY1_FOR_o_CARRY -- Saída do primeiro carry vai para a entrada carry final
	);

	UHA_02 : HALF_ADDER
	PORT MAP(
		-- Entradas
		i_INPUT_A => w_OUTPUT_FOR_INPUT_A, -- Valor que veio do primeiro meio somador
		i_INPUT_B => i_CARRY, -- "Vem um (primeiro valor aterrado)" na entrada do segundo meio somador

		-- Saídas
		o_OUTPUT => o_OUTPUT, -- Resultado
		o_CARRY => w_CARRY2_FOR_o_CARRY -- Saída do segundo carry vai para a entrada carry final
	);

	-------------------------------------------------------------------------------------------------------------------------
	-- Comportamento do carry final "vai um"

	o_CARRY <= w_CARRY1_FOR_o_CARRY OR w_CARRY2_FOR_o_CARRY;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;