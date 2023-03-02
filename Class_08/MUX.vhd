-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar um MULTIPLEXADOR 4x1 de 8 bits utilizando o comando sequencial IF ELSE
-- Implementar um MULTIPLEXADOR 4x1 de 8 bits utilizando o comando sequencial CASE WHEN
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MUX IS
	PORT (
		i_A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_C : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_C : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		i_SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END MUX;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE mux_ifelse OF MUX IS
BEGIN
	PROCESS (i_A, i_B, i_C, i_D, i_SEL)
	BEGIN
		IF (i_SEL = "00") THEN
			o_C <= i_A;
		ELSIF (i_SEL = "01") THEN
			o_C <= i_B;
		ELSIF (i_SEL = "10") THEN
			o_C <= i_C;
		ELSE
			o_C <= i_D;
		END IF;
	END PROCESS;
END mux_ifelse;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE mux_case OF MUX IS
BEGIN
	PROCESS (i_A, i_B, i_C, i_D, i_SEL)
	BEGIN
		CASE (i_SEL) IS
			WHEN "00" =>
				o_C <= i_A;
			WHEN "01" =>
				o_C <= i_B;
			WHEN "10" =>
				o_C <= i_C;
			WHEN OTHERS =>
				o_C <= i_D;
		END CASE;
	END PROCESS;
END mux_case;

-------------------------------------------------------------------------------------------------------------------------

CONFIGURATION config OF MUX IS
	FOR mux_ifelse
	END FOR;
END;