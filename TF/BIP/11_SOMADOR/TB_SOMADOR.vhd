-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar o Testbench de um Somador Completo de n bits
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_SOMADOR IS
	GENERIC (bits : INTEGER := 16);
END TB_SOMADOR;

ARCHITECTURE Behavioral OF TB_SOMADOR IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT SOMADOR IS
		GENERIC (
			bits : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_REG_A : IN STD_LOGIC_VECTOR((bits - 1) DOWNTO 0);
			i_REG_B : IN STD_LOGIC_VECTOR((bits - 1) DOWNTO 0);
			i_CARRY : IN STD_LOGIC;

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC_VECTOR((bits - 1) DOWNTO 0);
			o_CARRY : OUT STD_LOGIC
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de Sinais Internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_REG_A : STD_LOGIC_VECTOR((bits - 1) DOWNTO 0);
	SIGNAL w_REG_B : STD_LOGIC_VECTOR((bits - 1) DOWNTO 0);
	SIGNAL w_OUTPUT : STD_LOGIC_VECTOR((bits - 1) DOWNTO 0);
	SIGNAL w_oCARRY : STD_LOGIC;

	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Implementar o Testbench de um Somador Completo de n bits

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------

	UN : SOMADOR
	GENERIC MAP(
		bits => 16
	)
	PORT MAP(
		-- Entradas
		i_REG_A => w_REG_A,
		i_REG_B => w_REG_B,
		i_CARRY => '0',

		-- Saídas
		o_OUTPUT => w_OUTPUT,
		o_CARRY => w_oCARRY
	);

	-------------------------------------------------------------------------------------------------------------------------

	-- Teste
	PROCESS
	BEGIN
		w_REG_A <= x"0001";
		w_REG_B <= x"000A";
		WAIT FOR 20 ns;

		w_REG_A <= x"FFFF";
		w_REG_B <= x"AAAA";
		WAIT FOR 20 ns;

		w_REG_A <= x"ABCD";
		w_REG_B <= x"1234";
		WAIT FOR 20 ns;

		w_REG_A <= x"0002";
		w_REG_B <= x"FFFF";
		WAIT;
	END PROCESS;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;