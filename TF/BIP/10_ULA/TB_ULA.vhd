-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar o Testbench de uma Unidade Lógico Aritmética (ULA) que realize soma e subtração entre dois sinais de entrada, com n bits cada
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_ULA IS
	GENERIC (n : INTEGER := 16);
END TB_ULA;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF TB_ULA IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT ULA IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_INPUT_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			i_INPUT_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			i_SEL : IN STD_LOGIC;

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0)
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos
	SIGNAL w_INPUT_A : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_INPUT_B : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_SEL : STD_LOGIC;
	SIGNAL w_OUTPUT : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do testbench da ULA

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	UN : ULA
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_INPUT_A => w_INPUT_A,
		i_INPUT_B => w_INPUT_B,
		i_SEL => w_SEL,

		-- Saídas
		o_OUTPUT => w_OUTPUT
	);
	-------------------------------------------------------------------------------------------------------------------------

	-- Teste
	-------------------------------------------------------------------------------------------------------------------------	

	PROCESS
	BEGIN
		w_INPUT_A <= x"05DC";
		w_INPUT_B <= x"029A";
		WAIT FOR 40 ns;
		w_INPUT_A <= x"0000";
		w_INPUT_B <= x"1000";
		WAIT FOR 40 ns;
		w_INPUT_A <= x"000A";
		w_INPUT_B <= x"0A00";
		WAIT FOR 40 ns;
		w_INPUT_A <= x"029A";
		w_INPUT_B <= x"029A";
		WAIT FOR 40 ns;
		w_INPUT_A <= x"000A";
		w_INPUT_B <= x"A000";
		WAIT FOR 40 ns;
		w_INPUT_A <= x"FFFF";
		w_INPUT_B <= x"0000";
		WAIT FOR 40 ns;
		WAIT;
	END PROCESS;

	PROCESS
	BEGIN
		w_SEL <= '0';
		WAIT FOR 20 ns;
		w_SEL <= '1';
		WAIT FOR 20 ns;
	END PROCESS;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;