-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MUXCONFIG IS
	--	Generic (
	--		bits	 	: integer 	:= 16;
	--		sel 		: integer 	:= 3
	--	);
	PORT (
		i_A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		i_B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		i_C : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		i_D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		i_E : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		i_F : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		i_G : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		--i_H	: in	STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
		o_C : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		i_SEL : IN STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END MUXCONFIG;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF MUXCONFIG IS
BEGIN

	--	o_C <= i_A WHEN i_SEL = "000" ELSE
	--			 i_B WHEN i_SEL = "001" ELSE
	--			 i_C WHEN i_SEL = "010" ELSE
	--			 i_D WHEN i_SEL = "011" ELSE
	--			 i_E WHEN i_SEL = "100" ELSE
	--			 i_F WHEN i_SEL = "101" ELSE
	--			 i_G WHEN i_SEL = "110";

	-- Utilizando o comando concorrente WITH SELECT.

	WITH (i_SEL) SELECT
	o_C <= i_A WHEN "000",
		i_B WHEN "001",
		i_C WHEN "010",
		i_D WHEN "011",
		i_E WHEN "100",
		i_F WHEN "101",
		i_G WHEN "110",
		x"0000" WHEN OTHERS;
	--i_H WHEN "111";

	-- Utilizando um PROCESS.

	--	PROCESS (i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_SEL)
	--	BEGIN
	--		IF (i_SEL = "000") THEN
	--			o_C <= i_A;
	--		ELSIF (i_SEL = "001") THEN
	--			o_C <= i_B;
	--		ELSIF (i_SEL = "010") THEN
	--			o_C <= i_C;
	--		ELSIF (i_SEL = "011") THEN
	--			o_C <= i_D;
	--		ELSIF (i_SEL = "100") THEN
	--			o_C <= i_E;
	--		ELSIF (i_SEL = "101") THEN
	--			o_C <= i_F;
	--		ELSIF (i_SEL = "110") THEN
	--			o_C <= i_G;
	--		ELSE
	--			NULL;
	--		END IF;
	--	END PROCESS;

	--	process (i_SEL, i_A, i_B, i_C, i_D, i_E, i_F, i_G)
	--	begin
	--		case (i_SEL) is
	--			when "000" =>
	--				o_C <= i_A;
	--			when "001" =>
	--				o_C <= i_B;
	--			when "010" =>
	--				o_C <= i_C;
	--			when "011" =>
	--				o_C <= i_D;
	--			when "100" =>
	--				o_C <= i_E;
	--			when "101" =>
	--				o_C <= i_F;
	--			when "110" =>
	--				o_C <= i_G;
	--			when others =>
	--				NULL;
	--		end case;
	--	end process;

END Behavioral;