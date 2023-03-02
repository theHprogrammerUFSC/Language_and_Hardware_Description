-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Implementar Somador Completo de 8 bits

ENTITY TB_Somador_8bits IS
END TB_Somador_8bits;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF TB_Somador_8bits IS

	COMPONENT Somador_8bits IS
		PORT (
			i_A : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada A do somador
			i_B : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada B do somador
			i_C : IN STD_LOGIC; -- "vem um"
			o_S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Soma
			o_C : OUT STD_LOGIC -- "vai um"
		);
	END COMPONENT;

	SIGNAL w_A : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_B : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_vemUm : STD_LOGIC;
	SIGNAL w_S : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_vaiUm : STD_LOGIC;

BEGIN

	U01 : Somador_8bits
	PORT MAP(
		i_A => w_A,
		i_B => w_B,
		i_C => w_vemUm,
		o_S => w_S,
		o_C => w_vaiUm
	);

	PROCESS
	BEGIN

		w_A <= x"3C";
		w_B <= x"3C";
		w_vemUm <= '0';
		WAIT FOR 20 NS;

		w_A <= x"34";
		w_B <= x"64";
		w_vemUm <= '0';
		WAIT FOR 20 NS;

		w_A <= x"3C";
		w_B <= x"41";
		w_vemUm <= '0';
		WAIT FOR 20 NS;

		w_A <= x"7A";
		w_B <= x"9A";
		w_vemUm <= '0';
		WAIT FOR 20 NS;

		w_A <= x"35";
		w_B <= x"3C";
		w_vemUm <= '0';
		WAIT FOR 20 NS;

		WAIT;
	END PROCESS;

END Behavioral;