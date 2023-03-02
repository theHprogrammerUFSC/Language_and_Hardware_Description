-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Implementar um MULTIPLEXADOR 2x1 utilizando os comandos WHEN ELSE
-- Implementar um MULTIPLEXADOR 4x1 de 8 bits utilizando os comandos WHEN ELSE
-- Implementar um MULTIPLEXADOR 4x1 de 8 bits utilizando os comandos WITH SELECT
-- Implementar o mesmo MULTIPEXADOR utilizando um PROCESS
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

-- ARCHITECTURE mux_2x1 OF MUX IS
-- BEGIN
-- IMPLEMENTAR UM MULTIPLEXADOR 2x1 UTILIZANDO OS COMANDOS WHEN ELSE
-- o_C <= i_A WHEN i_SEL = "0" ELSE
--	i_B WHEN i_SEL = "1";
-- END mux_2x1;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE mux_when OF MUX IS
BEGIN
	-- IMPLEMENTAR UM MULTIPLEXADOR 4x1 DE 8 BITS UTILIZANDO OS COMANDOS WHEN ELSE
	o_C <= i_A WHEN i_SEL = "00" ELSE
		i_B WHEN i_SEL = "01" ELSE
		i_C WHEN i_SEL = "10" ELSE
		i_D WHEN i_SEL = "11";
END mux_when;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE mux_with_select OF mux IS
BEGIN
	-- IMPLEMENTAR UM MULTIPLEXADOR 4x1 DE 8 BITS UTILIZANDO OS COMANDOS WITH SELECT
	WITH i_SEL SELECT
		o_C <= i_A WHEN "00",
		i_B WHEN "01",
		i_C WHEN "10",
		i_D WHEN "11";
END mux_with_select;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE mux_process OF MUX IS
BEGIN
	-- IMPLEMENTAR O MESMO MULTIPEXADOR UTILIZANDO UM PROCESS
	PROCESS (i_SEL)
	BEGIN
		CASE i_SEL IS
			WHEN "00" => o_C <= i_A;
			WHEN "01" => o_C <= i_B;
			WHEN "10" => o_C <= i_C;
			WHEN "11" => o_C <= i_D;
		END CASE;
	END PROCESS;
END mux_process;

-------------------------------------------------------------------------------------------------------------------------

CONFIGURATION config OF MUX IS
	FOR mux_process
	END FOR;
END;