-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar o Testbech do Meio Subtrator de 2 bit
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_HALF_SUBTRACTOR IS
END TB_HALF_SUBTRACTOR;

ARCHITECTURE Behavioral OF TB_HALF_SUBTRACTOR IS

	-- Declaração do componente
	-------------------------------------------------------------------------------------------------------------------------

	COMPONENT HALF_SUBTRACTOR
		PORT (
			-- Entradas
			i_INPUT_A : IN STD_LOGIC;
			i_INPUT_B : IN STD_LOGIC;

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC;
			o_BORROW : OUT STD_LOGIC
		);
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de sinais internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_INPUT_A : STD_LOGIC;
	SIGNAL w_INPUT_B : STD_LOGIC;
	SIGNAL w_OUTPUT : STD_LOGIC;
	SIGNAL w_BORROW : STD_LOGIC;
	-------------------------------------------------------------------------------------------------------------------------	

BEGIN
	-- Instancialização do componente
	-------------------------------------------------------------------------------------------------------------------------

	UN : HALF_SUBTRACTOR
	PORT MAP(
		-- Entradas
		i_INPUT_A => w_INPUT_A,
		i_INPUT_B => w_INPUT_B,

		-- Saídas
		o_OUTPUT => w_OUTPUT,
		o_BORROW => w_BORROW
	);

	-------------------------------------------------------------------------------------------------------------------------	

	-- Teste
	-------------------------------------------------------------------------------------------------------------------------
	PROCESS
	BEGIN
		w_INPUT_A <= '0';
		w_INPUT_B <= '0';
		WAIT FOR 20 ns;

		w_INPUT_A <= '0';
		w_INPUT_B <= '1';
		WAIT FOR 20 ns;

		w_INPUT_A <= '1';
		w_INPUT_B <= '0';
		WAIT FOR 20 ns;

		w_INPUT_A <= '1';
		w_INPUT_B <= '1';
		WAIT;
	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;