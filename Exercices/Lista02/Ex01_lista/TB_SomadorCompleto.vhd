-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Implementar Meio Somador

ENTITY TB_SomadorCompleto IS
END TB_SomadorCompleto;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF TB_SomadorCompleto IS

	COMPONENT SomadorCompleto IS
		PORT (
			i_A : IN STD_LOGIC;
			i_B : IN STD_LOGIC;
			i_C : IN STD_LOGIC;
			o_S : OUT STD_LOGIC;
			o_C : OUT STD_LOGIC
		);
	END COMPONENT;

	--
	-- Declarando sinais internos
	--
	SIGNAL w_A : STD_LOGIC;
	SIGNAL w_B : STD_LOGIC;
	SIGNAL w_C : STD_LOGIC;
	SIGNAL w_S : STD_LOGIC;
	SIGNAL w_oC : STD_LOGIC;

BEGIN

	--
	-- Instancialização de um componente lógico
	--
	U01 : SomadorCompleto
	PORT MAP(
		i_A => w_A,
		i_B => w_B,
		i_C => w_C,
		o_S => w_S,
		o_C => w_oC
	);

	PROCESS
	BEGIN
		w_A <= '0';
		w_B <= '0';
		w_C <= '0';
		WAIT FOR 20 NS;

		w_A <= '1';
		w_B <= '0';
		w_C <= '0';
		WAIT FOR 20 NS;

		w_A <= '0';
		w_B <= '1';
		w_C <= '0';
		WAIT FOR 20 NS;

		w_A <= '1';
		w_B <= '1';
		w_C <= '0';
		WAIT FOR 20 NS;

		w_A <= '0';
		w_B <= '0';
		w_C <= '1';
		WAIT FOR 20 NS;

		w_A <= '1';
		w_B <= '0';
		w_C <= '1';
		WAIT FOR 20 NS;

		w_A <= '0';
		w_B <= '1';
		w_C <= '1';
		WAIT FOR 20 NS;

		w_A <= '1';
		w_B <= '1';
		w_C <= '1';
		WAIT FOR 20 NS;
	END PROCESS;

END Behavioral;