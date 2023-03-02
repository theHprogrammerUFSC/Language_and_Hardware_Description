LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY TB_VARIAVEL IS
END TB_VARIAVEL;

ARCHITECTURE Behavioral OF TB_VARIAVEL IS
	----------------------------------------------------------------------------------
	-- Internal signals.
	----------------------------------------------------------------------------------
	SIGNAL w_CLK : STD_LOGIC;
	SIGNAL w_RST : STD_LOGIC;
	SIGNAL w_SINAL_1 : STD_LOGIC;
	SIGNAL w_SINAL_2 : STD_LOGIC;
	COMPONENT VARIAVEL IS
		PORT (
			i_CLK : IN STD_LOGIC;
			i_RST : IN STD_LOGIC;
			o_SINAL_1 : OUT STD_LOGIC;
			o_SINAL_2 : OUT STD_LOGIC
		);
	END COMPONENT;
BEGIN

	UUT : VARIAVEL
	PORT MAP(
		i_CLK => w_CLK,
		i_RST => w_RST,
		o_SINAL_1 => w_SINAL_1,
		o_SINAL_2 => w_SINAL_2
	);

	PROCESS
	BEGIN
		w_CLK <= '0';
		WAIT FOR 10 NS;
		w_CLK <= '1';
		WAIT FOR 10 NS;
	END PROCESS;
	PROCESS
	BEGIN
		w_RST <= '1';
		WAIT FOR 40 NS;
		w_RST <= '0';
		WAIT;
	END PROCESS;

END Behavioral;