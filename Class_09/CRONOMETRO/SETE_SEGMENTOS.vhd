-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY SETE_SEGMENTOS IS
	GENERIC (
		p_WNUMERO : INTEGER := 4
	);
	PORT (
		i_numero : IN STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
		i_RST : IN STD_LOGIC;
		o_DISPLAY : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
	);
END SETE_SEGMENTOS;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF SETE_SEGMENTOS IS

	SIGNAL w_ON : STD_LOGIC := '0';
	--constant w_ON 	: STD_LOGIC := '0';
	SIGNAL w_OFF : STD_LOGIC := '1';

BEGIN
	PROCESS (i_RST, w_ON, w_OFF)
	BEGIN
		IF (i_RST = '1') THEN
			o_DISPLAY <= (OTHERS => w_OFF);
		ELSE
			CASE i_numero IS
				WHEN x"0" =>
					o_DISPLAY(0) <= w_ON;
					o_DISPLAY(1) <= w_ON;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_ON;
					o_DISPLAY(4) <= w_ON;
					o_DISPLAY(5) <= w_ON;
					o_DISPLAY(6) <= w_OFF;

				WHEN x"1" =>
					o_DISPLAY(0) <= w_OFF;
					o_DISPLAY(1) <= w_ON;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_OFF;
					o_DISPLAY(4) <= w_OFF;
					o_DISPLAY(5) <= w_OFF;
					o_DISPLAY(6) <= w_OFF;

				WHEN x"2" =>
					o_DISPLAY(0) <= w_ON;
					o_DISPLAY(1) <= w_ON;
					o_DISPLAY(2) <= w_OFF;
					o_DISPLAY(3) <= w_ON;
					o_DISPLAY(4) <= w_ON;
					o_DISPLAY(5) <= w_OFF;
					o_DISPLAY(6) <= w_ON;

				WHEN x"3" =>
					o_DISPLAY(0) <= w_ON;
					o_DISPLAY(1) <= w_ON;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_ON;
					o_DISPLAY(4) <= w_OFF;
					o_DISPLAY(5) <= w_OFF;
					o_DISPLAY(6) <= w_ON;

				WHEN x"4" =>
					o_DISPLAY(0) <= w_OFF;
					o_DISPLAY(1) <= w_ON;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_OFF;
					o_DISPLAY(4) <= w_OFF;
					o_DISPLAY(5) <= w_ON;
					o_DISPLAY(6) <= w_ON;

				WHEN x"5" =>
					o_DISPLAY(0) <= w_ON;
					o_DISPLAY(1) <= w_OFF;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_ON;
					o_DISPLAY(4) <= w_OFF;
					o_DISPLAY(5) <= w_ON;
					o_DISPLAY(6) <= w_ON;

				WHEN x"6" =>
					o_DISPLAY(0) <= w_ON;
					o_DISPLAY(1) <= w_OFF;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_ON;
					o_DISPLAY(4) <= w_ON;
					o_DISPLAY(5) <= w_ON;
					o_DISPLAY(6) <= w_ON;

				WHEN x"7" =>
					o_DISPLAY(0) <= w_ON;
					o_DISPLAY(1) <= w_ON;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_OFF;
					o_DISPLAY(4) <= w_OFF;
					o_DISPLAY(5) <= w_OFF;
					o_DISPLAY(6) <= w_OFF;

				WHEN x"8" =>
					o_DISPLAY(0) <= w_ON;
					o_DISPLAY(1) <= w_ON;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_ON;
					o_DISPLAY(4) <= w_ON;
					o_DISPLAY(5) <= w_ON;
					o_DISPLAY(6) <= w_ON;

				WHEN x"9" =>
					o_DISPLAY(0) <= w_ON;
					o_DISPLAY(1) <= w_ON;
					o_DISPLAY(2) <= w_ON;
					o_DISPLAY(3) <= w_OFF;
					o_DISPLAY(4) <= w_OFF;
					o_DISPLAY(5) <= w_ON;
					o_DISPLAY(6) <= w_ON;

				WHEN OTHERS => NULL;
			END CASE;
		END IF;
	END PROCESS;
END Behavioral;