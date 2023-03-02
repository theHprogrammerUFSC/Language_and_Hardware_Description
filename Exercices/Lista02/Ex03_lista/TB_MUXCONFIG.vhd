-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_MUXCONFIG IS
END TB_MUXCONFIG;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF TB_MUXCONFIG IS

	COMPONENT MUXCONFIG IS
		GENERIC (
			bits : INTEGER := 16;
			sel : INTEGER := 3
		);
		PORT (
			i_A : IN STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);
			i_B : IN STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);
			i_C : IN STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);
			i_D : IN STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);
			i_E : IN STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);
			i_F : IN STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);
			i_G : IN STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);
			--i_H	: in	STD_LOGIC_VECTOR(bits-1 DOWNTO 0);
			o_C : OUT STD_LOGIC_VECTOR(bits - 1 DOWNTO 0);
			i_SEL : IN STD_LOGIC_VECTOR(sel - 1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL w_A : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL w_B : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL w_C : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL w_D : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL w_E : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL w_F : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL w_G : STD_LOGIC_VECTOR(15 DOWNTO 0);
	--signal w_H	: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL w_S : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL w_SEL : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

	UUT : MUXCONFIG
	GENERIC MAP(
		bits => 16,
		sel => 3
	)
	PORT MAP(
		i_A => w_A,
		i_B => w_B,
		i_C => w_C,
		i_D => w_D,
		i_E => w_E,
		i_F => w_F,
		i_G => w_G,
		--i_H	=> w_H,
		o_C => w_S,
		i_SEL => w_SEL
	);

	PROCESS
	BEGIN

		w_A <= x"AAAA";
		w_B <= x"BBBB";
		w_C <= x"CCCC";
		w_D <= x"DDDD";
		w_E <= x"EEEE";
		w_F <= x"FFFF";
		w_G <= x"ABCD";
		--w_H <= x"ABCF";

		w_SEL <= "000";
		WAIT FOR 20 ns;

		w_SEL <= "001";
		WAIT FOR 20 ns;

		w_SEL <= "010";
		WAIT FOR 20 ns;

		w_SEL <= "011";
		WAIT FOR 20 ns;

		w_SEL <= "100";
		WAIT FOR 20 ns;

		w_SEL <= "101";
		WAIT FOR 20 ns;

		w_SEL <= "110";
		WAIT FOR 20 ns;

		w_SEL <= "111";
		WAIT FOR 20 ns;

		WAIT;

	END PROCESS;

END Behavioral;