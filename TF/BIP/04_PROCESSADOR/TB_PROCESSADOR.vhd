-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 28/06/2022
--
-- Implementar Processador
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_PROCESSADOR IS
	GENERIC (n : INTEGER := 16);
END TB_PROCESSADOR;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF TB_PROCESSADOR IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT PROCESSADOR IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_DATA_ROM : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			i_DATA_RAM : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			i_OUTSIDE : IN STD_LOGIC_VECTOR((n - 7) DOWNTO 0);
			i_CLOCK : IN STD_LOGIC;
			i_RESET : IN STD_LOGIC;

			-- Saídas
			o_ADD_RAM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0);
			o_ADD_ROM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0);
			o_DATA_RAM : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			o_EN_ROM : OUT STD_LOGIC;
			o_EN_RAM : OUT STD_LOGIC;
			o_WR_RAM : OUT STD_LOGIC;

			o_LED : OUT STD_LOGIC_VECTOR((n - 7) DOWNTO 0)
		);
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos
	SIGNAL w_DATA_ROM : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_iDATA_RAM : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_OUTSIDE : STD_LOGIC_VECTOR((n - 7) DOWNTO 0);
	SIGNAL w_CLOCK : STD_LOGIC;
	SIGNAL w_RST : STD_LOGIC;

	SIGNAL w_ADD_RAM : STD_LOGIC_VECTOR((n - 5) DOWNTO 0);
	SIGNAL w_ADD_ROM : STD_LOGIC_VECTOR((n - 5) DOWNTO 0);
	SIGNAL w_oDATA_RAM : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_EN_ROM : STD_LOGIC;
	SIGNAL w_EN_RAM : STD_LOGIC;
	SIGNAL w_WR_RAM : STD_LOGIC;
	SIGNAL w_LED : STD_LOGIC_VECTOR((n - 7) DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do Processador

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	U00 : PROCESSADOR
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_DATA_ROM => w_DATA_ROM,
		i_DATA_RAM => w_iDATA_RAM,
		i_OUTSIDE => w_OUTSIDE,
		i_CLOCK => w_CLOCK,
		i_RESET => w_RST,

		-- Saídas
		o_ADD_RAM => w_ADD_RAM,
		o_ADD_ROM => w_ADD_ROM,
		o_DATA_RAM => w_oDATA_RAM,
		o_EN_ROM => w_EN_ROM,
		o_EN_RAM => w_EN_RAM,
		o_WR_RAM => w_WR_RAM,
		o_LED => w_LED
	);

	-------------------------------------------------------------------------------------------------------------------------

	w_OUTSIDE <= "0000000111";

	-- TESTE DE RESET
	PROCESS
	BEGIN
		w_RST <= '1';
		WAIT FOR 40 ns;
		w_RST <= '0';
		WAIT;
	END PROCESS;

	-- TESTE DE CLOCK
	PROCESS
	BEGIN
		w_CLOCK <= '1';
		WAIT FOR 20 ns;
		w_CLOCK <= '0';
		WAIT FOR 20 ns;
	END PROCESS;

	-- TESTE DE SORTE
	PROCESS
	BEGIN
		w_DATA_ROM <= (OTHERS => '0');
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 80 ns;

		w_DATA_ROM <= x"3000";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1000";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"3014";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1001";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"3019";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1002";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"3003";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1003";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"301A";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1004";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2001";
		w_iDATA_RAM <= x"0014";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"4001";
		w_iDATA_RAM <= x"0014";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1005";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2003";
		w_iDATA_RAM <= x"0003";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"4003";
		w_iDATA_RAM <= x"0003";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1006";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2005";
		w_iDATA_RAM <= x"0028";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"6002";
		w_iDATA_RAM <= x"0019";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1007";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2007";
		w_iDATA_RAM <= x"000F";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"4006";
		w_iDATA_RAM <= x"0006";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1008";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2008";
		w_iDATA_RAM <= x"0015";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"4004";
		w_iDATA_RAM <= x"001A";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1009";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"9000";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"100A";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2009";
		w_iDATA_RAM <= x"002F";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"600A";
		w_iDATA_RAM <= x"0007";
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"100B";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"0000";
		w_iDATA_RAM <= (OTHERS => '0');
		WAIT;

	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;