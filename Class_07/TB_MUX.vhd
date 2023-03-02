-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Testbench for MUX
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_MUX IS
END TB_MUX;
ARCHITECTURE Behavioral OF TB_MUX IS

	COMPONENT MUX IS
		PORT (
			i_A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			i_B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			i_C : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			i_D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			o_C : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			i_SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------	

	SIGNAL w_A : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_B : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_C : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_D : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_SEL : STD_LOGIC_VECTOR(1 DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	UUT : MUX
	PORT MAP(
		i_A => w_A,
		i_B => w_B,
		i_C => w_C,
		i_D => w_D,
		o_C => w_OUT,
		i_SEL => w_SEL
	);
	PROCESS
	BEGIN
		w_A <= x"AA";
		w_B <= x"BB";
		w_C <= x"CC";
		w_D <= x"DD";

		w_SEL <= "00";
		WAIT FOR 20 NS;

		w_SEL <= "01";
		WAIT FOR 20 NS;

		w_SEL <= "10";
		WAIT FOR 20 NS;

		w_SEL <= "11";
		WAIT FOR 20 NS;

		--			WAIT;
	END PROCESS;
END Behavioral;