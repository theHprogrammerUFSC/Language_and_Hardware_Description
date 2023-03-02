-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TOP_CRONOMETRO IS
	GENERIC (
		p_WNUMERO : INTEGER := 4
	);
	PORT (
		i_CLK : IN STD_LOGIC;
		i_RST : IN STD_LOGIC;
		i_START : IN STD_LOGIC;
		i_STOP : IN STD_LOGIC;
		i_CLEAR : IN STD_LOGIC;
		--o_CONTADOR	: out STD_LOGIC_VECTOR (27 DOWNTO 0);
		o_SEG_0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		o_SEG_1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		o_SEG_2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		o_SEG_3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		o_SEG_4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		o_SEG_5 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
		o_LED : OUT STD_LOGIC
	);
END TOP_CRONOMETRO;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF TOP_CRONOMETRO IS

	-- Internal Signals
	COMPONENT CRONOMETRO IS
		PORT (
			i_CLK : IN STD_LOGIC;
			i_RST : IN STD_LOGIC;
			i_START : IN STD_LOGIC;
			i_STOP : IN STD_LOGIC;
			i_CLEAR : IN STD_LOGIC;
			o_CONTADOR : OUT STD_LOGIC_VECTOR (27 DOWNTO 0);
			o_LED : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT PLL_INTEL
		PORT (
			areset : IN STD_LOGIC := '0';
			inclk0 : IN STD_LOGIC := '0';
			c0 : OUT STD_LOGIC;
			locked : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT CONTADOR IS
		GENERIC (
			p_DATA : INTEGER := 28;
			p_CONTAGEM : INTEGER := 50000000;
			p_DIGITOS : INTEGER := 9;
			p_WNUMERO : INTEGER := 4
		);
		PORT (

			i_RST : IN STD_LOGIC;
			i_CLK : IN STD_LOGIC;
			i_contagem : IN STD_LOGIC_VECTOR (p_DATA - 1 DOWNTO 0);
			o_segundo : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
			o_dsegundo : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
			o_minuto : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
			o_dminuto : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
			o_hora : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
			o_dhora : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT SETE_SEGMENTOS IS
		GENERIC (
			p_WNUMERO : INTEGER := 4
		);
		PORT (
			i_numero : IN STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
			i_RST : IN STD_LOGIC;
			o_DISPLAY : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL w_CLK : STD_LOGIC;
	SIGNAL w_RST : STD_LOGIC;
	SIGNAL w_LOCKED : STD_LOGIC;
	SIGNAL w_CONTADOR : STD_LOGIC_VECTOR (27 DOWNTO 0);
	SIGNAL w_segundo : STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
	SIGNAL w_dsegundo : STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
	SIGNAL w_minuto : STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
	SIGNAL w_dminuto : STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
	SIGNAL w_hora : STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);
	SIGNAL w_dhora : STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------

BEGIN

	-- Instancialização do Cronômetro
	U01 : CRONOMETRO
	PORT MAP(
		i_CLK => w_CLK,
		i_RST => w_RST,
		i_START => NOT i_START,
		i_STOP => i_STOP,
		i_CLEAR => i_CLEAR,
		o_CONTADOR => w_CONTADOR,
		o_LED => o_LED
	);

	-- Instancialização do PLL
	U02 : PLL_INTEL
	PORT MAP(
		areset => NOT i_RST,
		inclk0 => i_CLK,
		c0 => w_CLK,
		locked => w_LOCKED
	);

	w_RST <= NOT w_LOCKED;

	-- Instacialização de um contador
	U03 : CONTADOR
	GENERIC MAP(
		p_DATA => 28,
		p_CONTAGEM => 50000000,
		p_DIGITOS => 9,
		p_WNUMERO => 4
	)
	PORT MAP(

		i_RST => w_RST,
		i_CLK => w_CLK,
		i_contagem => w_CONTADOR,
		o_segundo => w_segundo,
		o_dsegundo => w_dsegundo,
		o_minuto => w_minuto,
		o_dminuto => w_dminuto,
		o_hora => w_hora,
		o_dhora => w_dhora
	);

	-- Instancialização de display - unidade de segundos.
	U04 : SETE_SEGMENTOS
	GENERIC MAP(
		p_WNUMERO => 4
	)
	PORT MAP(
		i_numero => w_segundo,
		i_RST => w_RST,
		o_DISPLAY => o_SEG_0
	);

	-- Instancialização de display - dezena de segundos.
	U05 : SETE_SEGMENTOS
	GENERIC MAP(
		p_WNUMERO => 4
	)
	PORT MAP(
		i_numero => w_dsegundo,
		i_RST => w_RST,
		o_DISPLAY => o_SEG_1
	);

	-- Instancialização de display - unidade de minuto.
	U06 : SETE_SEGMENTOS
	GENERIC MAP(
		p_WNUMERO => 4
	)
	PORT MAP(
		i_numero => w_minuto,
		i_RST => w_RST,
		o_DISPLAY => o_SEG_2
	);

	-- Instancialização de display - dezena de minuto.
	U07 : SETE_SEGMENTOS
	GENERIC MAP(
		p_WNUMERO => 4
	)
	PORT MAP(
		i_numero => w_dminuto,
		i_RST => w_RST,
		o_DISPLAY => o_SEG_3
	);

	-- Instancialização de display - unidade de hora.
	U08 : SETE_SEGMENTOS
	GENERIC MAP(
		p_WNUMERO => 4
	)
	PORT MAP(
		i_numero => w_hora,
		i_RST => w_RST,
		o_DISPLAY => o_SEG_4
	);

	-- Instancialização de display - dezena de hora.
	U09 : SETE_SEGMENTOS
	GENERIC MAP(
		p_WNUMERO => 4
	)
	PORT MAP(
		i_numero => w_dhora,
		i_RST => w_RST,
		o_DISPLAY => o_SEG_5
	);
END Behavioral;