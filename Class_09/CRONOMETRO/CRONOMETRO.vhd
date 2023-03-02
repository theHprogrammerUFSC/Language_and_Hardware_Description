-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CRONOMETRO IS
	PORT (
		i_CLK : IN STD_LOGIC;
		i_RST : IN STD_LOGIC;
		i_START : IN STD_LOGIC;
		i_STOP : IN STD_LOGIC;
		i_CLEAR : IN STD_LOGIC;
		o_CONTADOR : OUT STD_LOGIC_VECTOR (27 DOWNTO 0);
		o_LED : OUT STD_LOGIC
	);
END CRONOMETRO;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF CRONOMETRO IS
	-----------------------------------------------------------------------------
	-- Internal Signals
	-----------------------------------------------------------------------------
	TYPE Estado IS (st_IDLE, st_CONTAR, st_PARAR);

	ATTRIBUTE syn_encoding : STRING;
	ATTRIBUTE syn_encoding OF Estado : TYPE IS "safe";

	SIGNAL w_STATE : Estado;
	SIGNAL w_CONTADOR : STD_LOGIC_VECTOR (27 DOWNTO 0);
	SIGNAL w_LED : STD_LOGIC;

	-- 0010 1111 1010 1111 0000 1000 0000 "50 milhões" - 50 Mhz (50 milhões de contagem por segundo) para ter 1 segundo no contador 

BEGIN
	-----------------------------------------------------------------------------
	-- State Machine
	-----------------------------------------------------------------------------
	PROCESS (i_RST, i_CLK)
	BEGIN
		-- RESET para que o circuito fique estável
		IF (i_RST = '1') THEN
			w_CONTADOR <= (OTHERS => '0');
			w_LED <= '0';
			w_STATE <= st_IDLE;
		ELSIF rising_edge (i_CLK) THEN
			CASE w_STATE IS
					-- Caso estiver na posição inicial IDLE
				WHEN st_IDLE =>
					IF (i_START = '1') THEN
						w_CONTADOR <= w_CONTADOR + 1;
						w_STATE <= st_CONTAR;
					ELSE
						w_STATE <= st_IDLE;
					END IF;
					-- Caso estiver no estado de CONTAR
				WHEN st_CONTAR =>
					IF (i_STOP = '1') THEN
						w_STATE <= st_PARAR;
					ELSIF (i_CLEAR = '1') THEN
						w_CONTADOR <= (OTHERS => '0');
						w_STATE <= st_idle;
					ELSE
						w_CONTADOR <= w_CONTADOR + 1;
						IF (w_CONTADOR = "0010111110101111000010000000") THEN
							w_CONTADOR <= (OTHERS => '0');
							w_LED <= NOT w_LED;
							w_STATE <= st_CONTAR;
						END IF;
					END IF;
					-- Caso estiver no caso PARAR
				WHEN st_PARAR =>
					IF (i_START = '1') THEN
						w_CONTADOR <= w_CONTADOR + 1;
						w_STATE <= st_CONTAR;
					ELSIF (i_CLEAR = '1') THEN
						w_CONTADOR <= (OTHERS => '0');
						w_STATE <= st_idle;
					ELSE
						w_STATE <= st_PARAR;
					END IF;
					-- Para qualquer outro caso
				WHEN OTHERS =>
					w_STATE <= st_IDLE;
			END CASE;
		END IF;
	END PROCESS;

	-- Coloca o sinal na saída
	o_CONTADOR <= w_CONTADOR;
	o_LED <= w_LED;
END Behavioral;