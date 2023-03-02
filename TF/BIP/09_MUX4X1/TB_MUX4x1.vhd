-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 30/06/2022
--
-- Testbench para multiplexador genérico
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_MUX4x1 IS
	GENERIC (n : INTEGER := 16);
END TB_MUX4x1;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF TB_MUX4x1 IS

	-- Declaração do componente testado
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT MUX4x1 IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_BUS_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			i_BUS_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			i_BUS_C : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			i_SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

			-- Saídas
			o_BUS : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0)
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de sinais internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_BUS_A : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_BUS_B : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_BUS_C : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_SEL : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL w_BUS : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Instancialização do componente
	-------------------------------------------------------------------------------------------------------------------------

	UN : MUX4x1
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_BUS_A => w_BUS_A,
		i_BUS_B => w_BUS_B,
		i_BUS_C => w_BUS_C,
		i_SEL => w_SEL,

		-- Saídas
		o_BUS => w_BUS
	);

	-------------------------------------------------------------------------------------------------------------------------

	-- Processo para simulação
	-------------------------------------------------------------------------------------------------------------------------
	w_BUS_A <= x"AAAA";

	PROCESS
	BEGIN
		w_BUS_B <= x"BBBB";
		WAIT FOR 10 ns;
		w_BUS_B <= x"CCCC";
		WAIT FOR 10 ns;
		w_BUS_B <= x"DDDD";
		WAIT FOR 10 ns;
		w_BUS_B <= x"EEEE";
		WAIT FOR 10 ns;
	END PROCESS;

	PROCESS
	BEGIN
		w_BUS_C <= x"FFFF";
		WAIT FOR 20 ns;
		w_BUS_C <= x"1111";
		WAIT FOR 20 ns;
		w_BUS_C <= x"2222";
		WAIT FOR 20 ns;
		w_BUS_C <= x"3333";
		WAIT FOR 20 ns;
	END PROCESS;

	PROCESS
	BEGIN
		w_SEL <= "01";
		WAIT FOR 20 ns;
		w_SEL <= "11";
		WAIT FOR 20 ns;
		w_SEL <= "10";
		WAIT FOR 20 ns;
		w_SEL <= "00";
		WAIT;
	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;