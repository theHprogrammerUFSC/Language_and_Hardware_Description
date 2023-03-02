-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 27/06/2022
--
-- Implementar o instruction register
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY IR IS
	GENERIC (
		n : INTEGER := 16
	);
	PORT (
		-- Entradas
		i_RESET : IN STD_LOGIC; -- Entrada do Reset
		i_CLOCK : IN STD_LOGIC; -- Entrada do Clock
		i_EN : IN STD_LOGIC; -- Enable do Instruct Register
		i_DATA : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do endereço que vem da ROM

		-- Saídas
		o_ADD_RAM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Saída para o mux e para a ram
		o_CONTROLE : OUT STD_LOGIC_VECTOR((n - 13) DOWNTO 0) -- Saída para o caminho de controle
	);
END IR;

ARCHITECTURE Behavioral OF IR IS
BEGIN
	-- Implementação do REGISTRADOR IR
	-------------------------------------------------------------------------------------------------------------------------

	PROCESS (i_CLOCK, i_RESET, i_EN)
	BEGIN
		-- Se o nível do reset estiver em alto, zera tudo
		IF (i_RESET = '1') THEN
			o_CONTROLE <= (OTHERS => '0');
			o_ADD_RAM <= (OTHERS => '0');
		ELSE
			IF rising_edge (i_CLOCK) THEN
				IF (i_EN = '1') THEN
					o_CONTROLE <= i_DATA((n - 1) DOWNTO 12); -- Manda os 4 bits mais significativos da instrução para o controle
					o_ADD_RAM <= i_DATA((n - 5) DOWNTO 0); -- Manda os 12 bits menos significativos para a RAM
				END IF;
			END IF;
		END IF;
	END PROCESS;

	-------------------------------------------------------------------------------------------------------------------------	
END Behavioral;