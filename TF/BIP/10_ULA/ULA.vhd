-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar uma Unidade Lógico Aritmética (ULA) que realize soma e subtração entre dois sinais de entrada, com n bits cada
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ULA IS
	GENERIC (
		n : INTEGER := 16
	);
	PORT (
		-- Entradas
		i_INPUT_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do primeiro valor	
		i_INPUT_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do segundo valor
		i_SEL : IN STD_LOGIC; -- Seletor de operação

		-- Saídas
		o_OUTPUT : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0) -- Saída do Resultado
	);
END ULA;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF ULA IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT SOMADOR IS
		GENERIC (
			bits : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_REG_A : IN STD_LOGIC_VECTOR((bits - 1) DOWNTO 0); -- Entrada do primeiro valor	
			i_REG_B : IN STD_LOGIC_VECTOR((bits - 1) DOWNTO 0); -- Entrada do segundo valor
			i_CARRY : IN STD_LOGIC; -- Estouro anterior

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC_VECTOR((bits - 1) DOWNTO 0); -- Saída do Resultado
			o_CARRY : OUT STD_LOGIC -- Estouro
		);
	END COMPONENT;

	COMPONENT SUBTRATOR IS
		GENERIC (
			bits : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_REG_A : IN STD_LOGIC_VECTOR((bits - 1) DOWNTO 0); -- Entrada do primeiro valor
			i_REG_B : IN STD_LOGIC_VECTOR((bits - 1) DOWNTO 0); -- Entrada do segundo valor
			i_BORROW : IN STD_LOGIC; -- Emprestimo anterior

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC_VECTOR((bits - 1) DOWNTO 0); -- Saída do Resultado
			o_BORROW : OUT STD_LOGIC
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos
	SIGNAL w_OUTPUT_SOMADOR : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal para receber a soma
	SIGNAL w_OUTPUT_SUBTRATOR : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal para receber a subtração

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação da ULA

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	UADDER : SOMADOR
	GENERIC MAP(
		bits => 16
	)
	PORT MAP(
		-- Entradas
		i_REG_A => i_INPUT_A,
		i_REG_B => i_INPUT_B,
		i_CARRY => '0',

		-- Saídas
		o_OUTPUT => w_OUTPUT_SOMADOR -- Recebe o resultado do somador
	);
	USUBTRATOR : SUBTRATOR
	GENERIC MAP(
		bits => 16
	)
	PORT MAP(
		-- Entradas
		i_REG_A => i_INPUT_A,
		i_REG_B => i_INPUT_B,
		i_BORROW => '0',

		-- Saídas
		o_OUTPUT => w_OUTPUT_SUBTRATOR -- Recebe o resultado do subtrador
	);
	-------------------------------------------------------------------------------------------------------------------------

	-- Seleção de operação - 0 para soma - 1 para subtração
	WITH (i_SEL) SELECT o_OUTPUT <=
	w_OUTPUT_SOMADOR WHEN '0',
	w_OUTPUT_SUBTRATOR WHEN '1',
	(OTHERS => 'Z') WHEN OTHERS;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;