-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Implementar Meio Somador

ENTITY SomadorCompleto IS
	PORT (
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		o_S : OUT STD_LOGIC;
		o_C : OUT STD_LOGIC
	);
END SomadorCompleto;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF SomadorCompleto IS

	--
	-- Declarando componente externo.
	--
	COMPONENT MeioSomador IS
		PORT (
			i_A : IN STD_LOGIC;
			i_B : IN STD_LOGIC;
			o_S : OUT STD_LOGIC;
			o_C : OUT STD_LOGIC
		);
	END COMPONENT;

	--
	-- Declarando sinais internos
	--
	SIGNAL w_S1 : STD_LOGIC;
	SIGNAL w_C1 : STD_LOGIC;
	SIGNAL w_C2 : STD_LOGIC;

BEGIN

	--
	-- Instancialização de um componente lógico
	--
	U01 : MeioSomador
	PORT MAP(
		i_A => i_A,
		i_B => i_B,
		o_S => w_S1,
		o_C => w_C1
	);

	U02 : MeioSomador
	PORT MAP(
		i_A => w_S1,
		i_B => i_C,
		o_S => o_S,
		o_C => w_C2
	);

	o_C <= w_C2 OR w_C1;

END Behavioral;