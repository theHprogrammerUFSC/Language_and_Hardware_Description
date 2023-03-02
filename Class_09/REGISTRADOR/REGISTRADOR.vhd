-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar um registrador com carregamento (LOAD) assíncrono
-- Implementar um registrador com carregamento (LOAD) síncrono 
--
-- Sobre o registrador com carregamento assíncrono:
-- O carregamento (LOAD) do registrador deve ser assíncrono, ou seja, o carregamento deve ocorrer independentemente do clock.
--
-- Sobre o registrador com carregamento síncrono:
-- O carregamento (LOAD) do registrador deve ser síncrono, ou seja, o carregamento deve ocorrer somente quando o clock estiver em nível alto.
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY REGISTRADOR IS
	GENERIC (
		n : INTEGER := 8
	);

	PORT (
		i_RESET : IN STD_LOGIC;
		i_CLOCK : IN STD_LOGIC;
		i_LOAD : IN STD_LOGIC;
		i_DATA : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
		o_DATA : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0)
	);
END REGISTRADOR;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE registrador_sincrono OF REGISTRADOR IS
BEGIN
	-- REGISTRADOR COM LOAD SINCRONO
	PROCESS (i_CLOCK)
	BEGIN
		IF rising_edge (i_CLOCK) THEN
			IF (i_RESET = '1') THEN
				o_DATA <= x"0000"; -- (OTHERS => '0');
			ELSIF (i_LOAD = '1') THEN
				o_DATA <= x"AA55";
			ELSE
				o_DATA <= i_DATA;
			END IF;
		END IF;
	END PROCESS;
END registrador_sincrono;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE registrador_assincrono OF REGISTRADOR IS
BEGIN
	-- REGISTRADOR COM LOAD ASSINCRONO
	PROCESS (i_CLOCK, i_RESET, i_LOAD)
	BEGIN
		IF (i_RESET = '1') THEN
			o_DATA <= (OTHERS => '0');
		ELSIF (i_LOAD = '1') THEN
			o_DATA <= x"AA55";
		ELSE
			IF rising_edge (i_CLOCK) THEN
				o_DATA <= i_DATA;
			END IF;
		END IF;
	END PROCESS;
END registrador_assincrono;

-------------------------------------------------------------------------------------------------------------------------

CONFIGURATION config OF REGISTRADOR IS
	FOR registrador_assincrono
	END FOR;
END;