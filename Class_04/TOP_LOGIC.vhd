-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar Lógica de componentes da Aula 4 
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TOP_LOGIC IS
	PORT (
		-- Entradas
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		i_D : IN STD_LOGIC;
		i_E : IN STD_LOGIC;

		-- Saídas
		o_S1 : OUT STD_LOGIC;
		o_S2 : OUT STD_LOGIC
	);
END TOP_LOGIC;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF TOP_LOGIC IS

	-- Componentes
	COMPONENT LOGIC1 IS
		PORT (
			-- Entradas
			i_A : IN STD_LOGIC;
			i_B : IN STD_LOGIC;
			i_C : IN STD_LOGIC;
			i_D : IN STD_LOGIC;

			-- Saídas
			o_S1 : OUT STD_LOGIC;
			o_D1 : OUT STD_LOGIC;
			o_D2 : OUT STD_LOGIC
		);
	END COMPONENT;
	COMPONENT LOGIC2 IS
		PORT (
			-- Entradas
			i_D1 : IN STD_LOGIC;
			i_D2 : IN STD_LOGIC;
			i_E : IN STD_LOGIC;

			-- Saídas
			o_S2 : OUT STD_LOGIC
		);
	END COMPONENT;

	-- Sinais Internos
	SIGNAL w_D1 : STD_LOGIC;
	SIGNAL w_D2 : STD_LOGIC;

BEGIN

	-- Instancialização do componente 1
	U01 : LOGIC1
	PORT MAP(
		-- Entradas
		i_A => i_A,
		i_B => i_B,
		i_C => i_C,
		i_D => i_D,

		-- Saídas
		o_S1 => o_S1,
		o_D1 => w_D1,
		o_D2 => w_D2
	);

	-- Instancialização do componente 1
	U02 : LOGIC2
	PORT MAP(
		-- Entradas
		i_D1 => w_D1,
		i_D2 => w_D2,
		i_E => i_E,

		-- Saídas
		o_S2 => o_S2
	);
END Behavioral;