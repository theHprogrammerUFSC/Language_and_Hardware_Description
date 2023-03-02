-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Utilizando o comando GENERATE implemente um componente que faça as seguintes operações bit-a-bit:
-- Lógica AND entre os bits de 0 até 5
-- Lógica OR entre os bits de 6 até 10
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY FOR_GENERATE IS

	GENERIC (
		n : INTEGER := 12;
	);

	PORT (
		i_A : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		i_B : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		o_C : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);

END FOR_GENERATE;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF FOR_GENERATE IS

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

BEGIN

	-- Lógica AND entre os bits de 0 até 5
	PORTA_AND_1 : PORTA_AND
	GENERIC MAP(
		n => 6
	)
	PORT MAP(
		i_A => i_A(5 DOWNTO 0),
		i_B => i_B(5 DOWNTO 0),
		o_C => o_C(5 DOWNTO 0)
	);

	-- Lógica OR entre os bits de 6 até 10
	PORTA_OR_1 : PORTA_OR
	GENERIC MAP(
		n => 6
	)
	PORT MAP(
		i_A => i_A(10 DOWNTO 6),
		i_B => i_B(10 DOWNTO 6),
		o_C => o_C(10 DOWNTO 6)
	);

END Behavioral;