-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implemente uma memória RAM com 1K células de memória, de 16 bits cada:
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY RAM IS
	GENERIC (
		p_DATA_WIDTH : INTEGER := 16;
		p_ADD_WIDTH : INTEGER := 12
	);
	PORT (
		-- Entradas
		i_ADD : IN STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0); -- Entrada do endereço a ser acessado
		i_EN : IN STD_LOGIC; -- Enable da RAM
		i_WR : IN STD_LOGIC; -- Write da RAM
		i_RESET : IN STD_LOGIC; -- Entrada de Reset
		i_CLOCK : IN STD_LOGIC; -- Entrada de Clock

		-- Saídas
		io_DATA : INOUT STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0) -- Entrada e saída de valores
	);
END RAM;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF RAM IS

	-- Declaração de Sinais Internos
	-------------------------------------------------------------------------------------------------------------------------
	TYPE MEM_TYPE IS ARRAY (0 TO 4095) OF STD_LOGIC_VECTOR(io_DATA'RANGE);
	SIGNAL w_MEMORIA : MEM_TYPE := (OTHERS => (OTHERS => '0'));

	ATTRIBUTE ramstyle : STRING;
	ATTRIBUTE ramstyle OF w_MEMORIA : SIGNAL IS "M9K";
	-------------------------------------------------------------------------------------------------------------------------

	SIGNAL w_oDATA : STD_LOGIC_VECTOR(io_DATA'RANGE);
	-------------------------------------------------------------------------------------------------------------------------
BEGIN

	-- RAM por código
	-------------------------------------------------------------------------------------------------------------------------
	PROCESS (i_CLOCK, i_WR, i_EN, i_RESET)
	BEGIN
		-- Se o nível do reset está em alto ele zera tudo
		IF (i_RESET = '1') THEN
			w_oDATA <= (OTHERS => '0');
			-- Se a borda de clock está na subida, o enable e o write está ativo. A RAM registra o valor no endereço solicitado
		ELSIF rising_edge(i_CLOCK) THEN
			IF (i_EN = '1') THEN
				IF (i_WR = '1') THEN
					w_MEMORIA(conv_integer(i_ADD)) <= io_DATA;
					-- Se não, trata-se de leitura do dado no endereço solicitado
				ELSE
					w_oDATA <= w_MEMORIA(conv_integer(i_ADD));
				END IF;
			END IF;
		END IF;
	END PROCESS;

	-------------------------------------------------------------------------------------------------------------------------

	-- Comportamento do io_DATA. Write = 0 = Leitura. Write = 1 = Escrita
	io_DATA <= w_oDATA WHEN (i_WR = '0') ELSE
		(OTHERS => 'Z');

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;