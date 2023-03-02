-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar um Subtrator Completo de 2 bit
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY FULL_SUBTRACTOR IS
	PORT (
		-- Entradas
		i_INPUT_A : IN STD_LOGIC; -- Entrada do primeiro valor
		i_INPUT_B : IN STD_LOGIC; -- Entrada do segundo valor			
		i_BORROW : IN STD_LOGIC; -- Emprestimo anterior

		-- Saídas
		o_OUTPUT : OUT STD_LOGIC; -- Saída do Resultado
		o_BORROW : OUT STD_LOGIC -- Emprestimo
	);
END FULL_SUBTRACTOR;

ARCHITECTURE Behavioral OF FULL_SUBTRACTOR IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT HALF_SUBTRACTOR IS
		PORT (
			-- Entradas
			i_INPUT_A : IN STD_LOGIC; -- Entrada do primeiro valor
			i_INPUT_B : IN STD_LOGIC; -- Entrada do segundo valor			

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC; -- Saída do Resultado
			o_BORROW : OUT STD_LOGIC -- Emprestimo
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de Sinais Internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_OFI_A : STD_LOGIC; -- Valor do primeiro meio subtrator para o segundo
	SIGNAL w_B1F_oB : STD_LOGIC; -- Primeiro emprestimo ligado ao emprestimo final
	SIGNAL w_B2F_oB : STD_LOGIC; -- Segundo emprestimo ligado ao emprestimo final
	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Implementar um Subtrator Completo de 2 bit

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------

	UHS_01 : HALF_SUBTRACTOR
	PORT MAP(
		-- Entradas
		i_INPUT_A => i_INPUT_A, -- Recebe a entrada A
		i_INPUT_B => i_INPUT_B, -- Recebe a entrada B

		-- Saídas
		o_OUTPUT => w_OFI_A, -- Saída vai para a entrada A do segundo meio subtrator
		o_BORROW => w_B1F_oB -- Saída do primeiro borrow vai para a entrada borrow final
	);

	UHS_02 : HALF_SUBTRACTOR
	PORT MAP(
		-- Entradas
		i_INPUT_A => w_OFI_A, -- Valor que veio do primeiro meio subtrator
		i_INPUT_B => i_BORROW, -- "empresta um" na entrada do segundo meio somador

		-- Saídas
		o_OUTPUT => o_OUTPUT, -- Resultado
		o_BORROW => w_B2F_oB -- Saída do segundo borrow vai para a entrada borrow final
	);

	-------------------------------------------------------------------------------------------------------------------------
	-- Comportamento do borrow final "empresta um"

	o_BORROW <= w_B1F_oB OR w_B2F_oB;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;