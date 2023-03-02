-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Utilizando o comando IF implemente um componente que possa ser implementado de duas formas:
-- Lógica AND entre os dados de entrada
-- Lógica OR entre os dados de entrada
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY IF_GENERATE IS

	GENERIC (
		n : INTEGER := 8;
		TIPO : STRING := "AND"
	);

	PORT (
		i_A : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		i_B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		o_C : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);

END IF_GENERATE;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF IF_GENERATE IS

	COMPONENT PORTA_AND IS
		GENERIC (
			n : INTEGER := 32
		);
		PORT (
			i_A : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			i_B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			o_C : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT PORTA_OR IS
		GENERIC (
			n : INTEGER := 64
		);
		PORT (
			i_A : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			i_B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			o_C : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
		);
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------

BEGIN

	U_AND : IF (TIPO = "AND") GENERATE
		U01 : PORTA_AND
		GENERIC MAP(
			n => n
		)
		PORT MAP(
			i_A => i_A,
			i_B => i_B,
			o_C => o_C
		);
	END GENERATE;

	U_OR : IF (TIPO = "OR") GENERATE
		U02 : PORTA_OR
		GENERIC MAP(
			n => n
		)
		PORT MAP(
			i_A => i_A,
			i_B => i_B,
			o_C => o_C
		);
	END GENERATE;

END Behavioral;