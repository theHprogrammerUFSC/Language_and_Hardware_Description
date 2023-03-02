-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 28/06/2022
--
-- Implementar um componente contador de programa
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY PC IS
	GENERIC (
		p_ADD_WIDTH : INTEGER := 12
	);
	PORT (
		-- Entradas
		i_RESET : IN STD_LOGIC; -- Entrada para o reset	
		i_CLOCK : IN STD_LOGIC; -- Entrada para o clock
		i_EN : IN STD_LOGIC; -- Enable do contador de programa

		-- Saídas
		o_ADD_ROM : OUT STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0) -- Saída para a ROM
	);
END PC;

ARCHITECTURE Behavioral OF PC IS
BEGIN
	-- Implementação do contador
	-------------------------------------------------------------------------------------------------------------------------

	PROCESS (i_CLOCK, i_RESET, i_EN)
		VARIABLE v_ADD : STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0) := (OTHERS => '0');
	BEGIN
		-- Reset Assíncrono - Se o reset estiver em nível alto a saída para a rom é zerada.
		IF (i_RESET = '1') THEN
			v_ADD := (OTHERS => '0');
			o_ADD_ROM <= v_ADD;
		ELSE
			-- Se não, é verificado a borda de subida.
			IF rising_edge (i_CLOCK) THEN
				-- Se o enable do PC estiver em nível alto incrementa o valor de saída para a rom em 1.
				IF (i_EN = '1') THEN
					v_ADD := v_ADD + 1;
				END IF;
			END IF;
			o_ADD_ROM <= v_ADD;
		END IF;
	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------	
END Behavioral;