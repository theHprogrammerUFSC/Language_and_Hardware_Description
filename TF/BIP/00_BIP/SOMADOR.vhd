-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar um Somador Completo de n bits
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY SOMADOR IS
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
END SOMADOR;

ARCHITECTURE Behavioral OF SOMADOR IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT FULL_ADDER IS
		PORT (
			-- Entradas
			i_INPUT_A : IN STD_LOGIC; -- Entrada do primeiro valor											
			i_INPUT_B : IN STD_LOGIC; -- Entrada do segundo valor
			i_CARRY : IN STD_LOGIC; -- Estouro anterior

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC; -- Saída do Resultado
			o_CARRY : OUT STD_LOGIC -- Estouro
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de Sinais Internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_INTERNAL_CARRY : STD_LOGIC_VECTOR((bits - 1) DOWNTO 1); -- Ligação interna dos estouros

	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Implementar um Somador Completo de n bits

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------

	UFA_Primeiro : FULL_ADDER
	PORT MAP(
		-- Entradas
		i_INPUT_A => i_REG_A(0),
		i_INPUT_B => i_REG_B(0),
		i_CARRY => i_CARRY, -- Primeiro "vem um" (aterrado)

		-- Saídas
		o_OUTPUT => o_OUTPUT(0),
		o_CARRY => w_INTERNAL_CARRY(1) -- "vai um" transportado para um carry "vem um" interno
	);

	SOMADORES_DO_MEIO : FOR i IN (bits - 2) DOWNTO 1 GENERATE
		UFA_N : FULL_ADDER
		PORT MAP(
			-- Entradas
			i_INPUT_A => i_REG_A(i),
			i_INPUT_B => i_REG_B(i),
			i_CARRY => w_INTERNAL_CARRY(i), -- "vem um" recebido internamente

			-- Saídas
			o_OUTPUT => o_OUTPUT(i),
			o_CARRY => w_INTERNAL_CARRY(i + 1)
		);
	END GENERATE SOMADORES_DO_MEIO;

	UFA_Ultimo : FULL_ADDER
	PORT MAP(
		-- Entradas
		i_INPUT_A => i_REG_A(bits - 1),
		i_INPUT_B => i_REG_B(bits - 1),
		i_CARRY => w_INTERNAL_CARRY(bits - 1),

		-- Saídas
		o_OUTPUT => o_OUTPUT(bits - 1),
		o_CARRY => o_CARRY -- Estouro último "vai um"
	);

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;