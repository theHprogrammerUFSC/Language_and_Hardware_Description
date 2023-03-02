-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar Somador Completo de 8 bits
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Somador_8bits IS
	PORT (
		i_A : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada A do somador
		i_B : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada B do somador
		i_C : IN STD_LOGIC; -- "vem um"
		o_S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Soma
		o_C : OUT STD_LOGIC -- "vai um"
	);
END Somador_8bits;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF Somador_8bits IS

	--
	-- Declarando componente externo.
	--
	COMPONENT SomadorCompleto IS
		PORT (
			i_A : IN STD_LOGIC; -- Entrada A
			i_B : IN STD_LOGIC; -- Entrada B
			i_C : IN STD_LOGIC; -- Entrada do "vem um"
			o_S : OUT STD_LOGIC; -- Saída - Soma
			o_C : OUT STD_LOGIC -- Entrada do "vai um"
		);
	END COMPONENT;

	--
	-- Declarando sinais internos
	--
	SIGNAL w_C : STD_LOGIC_VECTOR(7 DOWNTO 1);

BEGIN

	--
	-- Instancialização de um componente lógico
	--
	U00 : SomadorCompleto
	PORT MAP(
		i_A => i_A(0),
		i_B => i_B(0),
		i_C => i_C,
		o_S => o_S(0),
		o_C => w_C(1)
	);

	U01 : SomadorCompleto
	PORT MAP(
		i_A => i_A(1),
		i_B => i_B(1),
		i_C => w_C(1),
		o_S => o_S(1),
		o_C => w_C(2)
	);

	U02 : SomadorCompleto
	PORT MAP(
		i_A => i_A(2),
		i_B => i_B(2),
		i_C => w_C(2),
		o_S => o_S(2),
		o_C => w_C(3)
	);

	U03 : SomadorCompleto
	PORT MAP(
		i_A => i_A(3),
		i_B => i_B(3),
		i_C => w_C(3),
		o_S => o_S(3),
		o_C => w_C(4)
	);

	U04 : SomadorCompleto
	PORT MAP(
		i_A => i_A(4),
		i_B => i_B(4),
		i_C => w_C(4),
		o_S => o_S(4),
		o_C => w_C(5)
	);

	U05 : SomadorCompleto
	PORT MAP(
		i_A => i_A(5),
		i_B => i_B(5),
		i_C => w_C(5),
		o_S => o_S(5),
		o_C => w_C(6)
	);

	U06 : SomadorCompleto
	PORT MAP(
		i_A => i_A(6),
		i_B => i_B(6),
		i_C => w_C(6),
		o_S => o_S(6),
		o_C => w_C(7)
	);

	U07 : SomadorCompleto
	PORT MAP(
		i_A => i_A(7),
		i_B => i_B(7),
		i_C => w_C(7),
		o_S => o_S(7),
		o_C => o_C
	);
END Behavioral;