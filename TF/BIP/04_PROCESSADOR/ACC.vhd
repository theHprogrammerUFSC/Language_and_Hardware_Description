-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 27/06/2022
--
-- Implementar um registrador genérico
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ACC IS
	GENERIC (
		n : INTEGER := 16
	);
	PORT (
		-- Entradas
		i_RESET : IN STD_LOGIC; -- Entrada de Reset
		i_CLOCK : IN STD_LOGIC; -- Entrada de Clock
		i_EN : IN STD_LOGIC; -- Enable/Write
		i_DATA : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada de dados no acumulador

		-- Saídas
		o_DATA : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Saída de dados no acumulador
		o_LED : OUT STD_LOGIC_VECTOR((n - 7) DOWNTO 0) -- Saída dos dados do acumulador para o FPGA
	);
END ACC;

ARCHITECTURE Behavioral OF ACC IS
BEGIN
	-- Implementação do ACC
	-------------------------------------------------------------------------------------------------------------------------

	PROCESS (i_CLOCK, i_RESET, i_EN)
		VARIABLE v_DATA : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	BEGIN
		-- Se o nível lógico do reset estiver em 1, zera tudo.
		IF (i_RESET = '1') THEN
			o_DATA <= (OTHERS => '0');
			o_LED <= (OTHERS => '0');
		ELSE
			-- Se a borda de clock estiver em alto e o write ACC estiver em alto, a saída do acumulador recebe o valor da entrada
			IF rising_edge (i_CLOCK) THEN
				IF (i_EN = '1') THEN
					v_DATA := i_DATA;
					o_DATA <= v_DATA;
					o_LED <= v_DATA(9 DOWNTO 0);
				ELSE
					-- Se não a saída fica em alta impedância
					o_DATA <= (OTHERS => 'Z');
				END IF;
			END IF;
		END IF;
	END PROCESS;

	-------------------------------------------------------------------------------------------------------------------------	
END Behavioral;