-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementar uma memória ROM
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ROM IS
	GENERIC (
		p_DATA_WIDTH : INTEGER := 16;
		p_ADD_WIDTH : INTEGER := 12
	);
	PORT (
		-- Entradas
		i_ADD : IN STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0); -- Entrada do endereço de acesso da ROM
		i_EN : IN STD_LOGIC; -- Enable da ROM
		i_RESET : IN STD_LOGIC; -- Entrada de Reset
		i_CLOCK : IN STD_LOGIC; -- Entrada de Clock

		-- Saídas
		o_DATA : OUT STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0) -- Saída do valaor salvo no endereço acessado
	);
END ROM;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF ROM IS

	-- Declaração da arquitetura
	-------------------------------------------------------------------------------------------------------------------------
	TYPE MEM_TYPE IS ARRAY (0 TO 30) OF STD_LOGIC_VECTOR(o_DATA'RANGE);
	CONSTANT rom : MEM_TYPE := (
		x"3000",
		x"1000",
		x"3014",
		x"1001",
		x"3019",
		x"1002",
		x"3003",
		x"1003",
		x"301A",
		x"1004",
		x"2001",
		x"4001",
		x"1005",
		x"2003",
		x"4003",
		x"1006",
		x"2005",
		x"6002",
		x"1007",
		x"2007",
		x"4006",
		x"1008",
		x"2008",
		x"4004",
		x"1009",
		x"9000",
		x"100A",
		x"2009",
		x"600A",
		x"100B",
		x"0000");

	-------------------------------------------------------------------------------------------------------------------------

BEGIN

	--Comportamento
	-------------------------------------------------------------------------------------------------------------------------
	PROCESS (i_CLOCK, i_ADD, i_EN, i_RESET)
		VARIABLE v_oDATA : STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0);
	BEGIN
		IF (i_RESET = '1') THEN
			v_oDATA := (OTHERS => '0');
			o_DATA <= v_oDATA;
		ELSIF rising_edge(i_CLOCK) THEN
			IF (i_EN = '1') THEN
				o_DATA <= rom(conv_integer(i_ADD));
			END IF;
		END IF;
	END PROCESS;

END Behavioral;