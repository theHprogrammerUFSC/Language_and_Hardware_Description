-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar um Subtrator Completo de n bits
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY SUBTRATOR IS
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
		o_BORROW : OUT STD_LOGIC -- Emprestimo
	);
END SUBTRATOR;

ARCHITECTURE Behavioral OF SUBTRATOR IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT FULL_SUBTRACTOR IS
		PORT (
			-- Entradas
			i_INPUT_A : IN STD_LOGIC; -- Entrada do primeiro valor
			i_INPUT_B : IN STD_LOGIC; -- Entrada do segundo valor			
			i_BORROW : IN STD_LOGIC; -- Emprestimo anterior

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC; -- Saída do Resultado
			o_BORROW : OUT STD_LOGIC -- Emprestimo
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de Sinais Internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_INTERNAL_BORROW : STD_LOGIC_VECTOR((bits - 1) DOWNTO 1); -- Ligação interna dos empréstimos

	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Implementar um Subtrator Completo de n bits

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------

	UFS_Primeiro : FULL_SUBTRACTOR
	PORT MAP(
		-- Entradas
		i_INPUT_A => i_REG_A(0),
		i_INPUT_B => i_REG_B(0),
		i_BORROW => i_BORROW, -- Primeiro "empresta um" (aterrado)

		-- Saídas
		o_OUTPUT => o_OUTPUT(0),
		o_BORROW => w_INTERNAL_BORROW(1) -- "empresta um" transportado para um carry "empresta um" interno
	);

	SUBTRATORES_DO_MEIO : FOR i IN (bits - 2) DOWNTO 1 GENERATE
		UFS_N : FULL_SUBTRACTOR
		PORT MAP(
			-- Entradas
			i_INPUT_A => i_REG_A(i),
			i_INPUT_B => i_REG_B(i),
			i_BORROW => w_INTERNAL_BORROW(i), -- "empresta um" recebido internamente

			-- Saídas
			o_OUTPUT => o_OUTPUT(i),
			o_BORROW => w_INTERNAL_BORROW(i + 1)
		);
	END GENERATE SUBTRATORES_DO_MEIO;

	UFS_Ultimo : FULL_SUBTRACTOR
	PORT MAP(
		-- Entradas
		i_INPUT_A => i_REG_A(bits - 1),
		i_INPUT_B => i_REG_B(bits - 1),
		i_BORROW => w_INTERNAL_BORROW(bits - 1),

		-- Saídas
		o_OUTPUT => o_OUTPUT(bits - 1),
		o_BORROW => o_BORROW -- Último "empresta um"
	);

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;