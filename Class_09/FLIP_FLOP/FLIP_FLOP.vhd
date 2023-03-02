-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar um Flip-flop tipo D com reset síncrono
-- Implementar um Flip-flop tipo D com reset assíncrono
--
-- Sobre o Flip-flop tipo D:
-- O Flip-flop tipo D é um tipo de flip-flop que armazena um bit de informação. Ele é um tipo de flip-flop de nível de bit.
--
-- Sobre o reset síncrono:
-- O reset síncrono é um tipo de reset que depende do clock para ser ativado.
--
-- Sobre o reset assíncrono:
-- O reset assíncrono é um tipo de reset que não depende do clock para ser ativado.
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY FLIP_FLOP IS
	PORT (
		i_RESET : IN STD_LOGIC;
		i_CLOCK : IN STD_LOGIC;
		i_DATA : IN STD_LOGIC;
		o_DATA : OUT STD_LOGIC
	);
END FLIP_FLOP;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE reset_sincrono OF FLIP_FLOP IS
BEGIN
	-- Implementar um Flip-flop tipo D com reset síncrono
	PROCESS (i_CLOCK)
	BEGIN
		IF rising_edge(i_CLOCK) THEN
			IF (i_RESET = '1') THEN
				o_DATA <= '0';
			ELSE
				o_DATA <= i_DATA;
			END IF;
		END IF;
	END PROCESS;
END reset_sincrono;

ARCHITECTURE reset_assincrono OF FLIP_FLOP IS

BEGIN
	-- Implementar um Flip-flop tipo D com reset assíncrono
	PROCESS (i_CLOCK, i_RESET)
	BEGIN
		IF (i_RESET = '1') THEN
			o_DATA <= '0';
		ELSE
			IF RISING_EDGE (i_CLOCK) THEN
				o_DATA <= i_DATA;
			END IF;
		END IF;
	END PROCESS;
END reset_assincrono;
-------------------------------------------------------------------------------------------------------------------------

CONFIGURATION config OF FLIP_FLOP IS
	FOR reset_sincrono
	END FOR;
END;