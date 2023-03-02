-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 28/06/2022
--
-- Implementar o Caminho de Dados
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_CAMINHO_DADOS IS
	GENERIC (n : INTEGER := 16);
END TB_CAMINHO_DADOS;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF TB_CAMINHO_DADOS IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT CAMINHO_DADOS IS
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

			i_WR_ACC : IN STD_LOGIC;
			i_SEL_ULA : IN STD_LOGIC;
			i_SEL_OP2 : IN STD_LOGIC;
			i_SEL_OP1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			i_EN_IN : IN STD_LOGIC;

			-- Saídas
			o_CONTROLE : OUT STD_LOGIC_VECTOR((n - 13) DOWNTO 0);
			o_ADD_RAM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0);
			o_DATA_RAM : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
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
	SIGNAL w_WR_ACC : STD_LOGIC;
	SIGNAL w_SEL_ULA : STD_LOGIC;
	SIGNAL w_SEL_OP2 : STD_LOGIC;
	SIGNAL w_SEL_OP1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL w_EN_IN : STD_LOGIC;
	SIGNAL w_CONTROLE : STD_LOGIC_VECTOR((n - 13) DOWNTO 0);
	SIGNAL w_ADD_RAM : STD_LOGIC_VECTOR((n - 5) DOWNTO 0);
	SIGNAL w_oDATA_RAM : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_LED : STD_LOGIC_VECTOR((n - 7) DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do Caminho de Dados

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	UN : CAMINHO_DADOS
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
		i_WR_ACC => w_WR_ACC,
		i_SEL_ULA => w_SEL_ULA,
		i_SEL_OP2 => w_SEL_OP2,
		i_SEL_OP1 => w_SEL_OP1,
		i_EN_IN => w_EN_IN,

		-- Saídas
		o_CONTROLE => w_CONTROLE,
		o_ADD_RAM => w_ADD_RAM,

		-- Bidirecional
		o_DATA_RAM => w_oDATA_RAM,
		o_LED => w_LED
	);

	-------------------------------------------------------------------------------------------------------------------------
	w_OUTSIDE <= "0000000111";

	-- TESTE DE RESET
	PROCESS
	BEGIN
		w_RST <= '1';
		WAIT FOR 60 ns;
		w_RST <= '0';
		WAIT;
	END PROCESS;

	-- TESTE DE CLOCK
	PROCESS
	BEGIN
		w_CLOCK <= '0';
		WAIT FOR 20 ns;
		w_CLOCK <= '1';
		WAIT FOR 20 ns;
	END PROCESS;

	-- TESTE DE SORTE
	PROCESS
	BEGIN
		w_DATA_ROM <= (OTHERS => '0');
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 120 ns;

		w_DATA_ROM <= x"3000";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '1';
		w_SEL_OP1 <= "01";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1000";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"3014";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '1';
		w_SEL_OP1 <= "01";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1001";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"3019";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '1';
		w_SEL_OP1 <= "01";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1002";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"3003";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '1';
		w_SEL_OP1 <= "01";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1003";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"301A";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '1';
		w_SEL_OP1 <= "01";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1004";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2001";
		w_iDATA_RAM <= x"0014";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"4001";
		w_iDATA_RAM <= x"0014";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "10";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1005";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2003";
		w_iDATA_RAM <= x"0003";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"4003";
		w_iDATA_RAM <= x"0003";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "10";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1006";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2005";
		w_iDATA_RAM <= x"0028";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"6002";
		w_iDATA_RAM <= x"0019";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '1';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "10";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1007";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2007";
		w_iDATA_RAM <= x"000F";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"4006";
		w_iDATA_RAM <= x"0006";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "10";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1008";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2008";
		w_iDATA_RAM <= x"0015";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"4004";
		w_iDATA_RAM <= x"001A";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "10";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"1009";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"9000";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "01";
		w_EN_IN <= '1';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"100A";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"2009";
		w_iDATA_RAM <= x"002F";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"600A";
		w_iDATA_RAM <= x"0007";
		w_WR_ACC <= '1';
		W_SEL_ULA <= '1';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "10";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"100B";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT FOR 40 ns;

		w_DATA_ROM <= x"0000";
		w_iDATA_RAM <= (OTHERS => '0');
		w_WR_ACC <= '0';
		W_SEL_ULA <= '0';
		w_SEL_OP2 <= '0';
		w_SEL_OP1 <= "00";
		w_EN_IN <= '0';
		WAIT;

	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;