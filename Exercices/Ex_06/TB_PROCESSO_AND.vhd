-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Testbench do Processo AND
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_PROCESSO_AND IS
END TB_PROCESSO_AND;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF TB_PROCESSO_AND IS

	COMPONENT PROCESSO_AND IS
		PORT (
			i_A : IN STD_LOGIC;
			i_B : IN STD_LOGIC;
			o_C : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL w_A : STD_LOGIC;
	SIGNAL w_B : STD_LOGIC;
	SIGNAL w_C : STD_LOGIC;

BEGIN

	UUT : PROCESSO_AND
	PORT MAP(
		i_A => w_A,
		i_B => w_B,
		o_C => w_C
	);

	PROCESS
	BEGIN
		w_A <= '0';
		w_B <= '0';
		WAIT FOR 20 ns;
		w_A <= '0';
		w_B <= '1';
		WAIT FOR 20 ns;

		w_A <= '1';
		w_B <= '0';
		WAIT FOR 20 ns;

		w_A <= '1';
		w_B <= '1';
		WAIT FOR 20 ns;

	END PROCESS;

END Behavioral;