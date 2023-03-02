-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 28/06/2022
--
-- Implementar o Testbench do Caminho de Controle
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_CAMINHO_CONTROLE IS
	GENERIC (
		add : INTEGER := 12;
		control : INTEGER := 4);
END TB_CAMINHO_CONTROLE;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF TB_CAMINHO_CONTROLE IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT CAMINHO_CONTROLE IS
		GENERIC (
			add : INTEGER := 12;
			control : INTEGER := 4
		);
		PORT (
			-- Entradas
			i_CONTROLE : IN STD_LOGIC_VECTOR((control - 1) DOWNTO 0);
			i_RESET : IN STD_LOGIC;
			i_CLOCK : IN STD_LOGIC;

			-- Saídas
			o_SEL_OP1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			o_SEL_OP2 : OUT STD_LOGIC;
			o_EN_ROM : OUT STD_LOGIC;
			o_EN_RAM : OUT STD_LOGIC;
			o_WR_ACC : OUT STD_LOGIC;
			o_WR_RAM : OUT STD_LOGIC;
			o_SEL_ULA : OUT STD_LOGIC;
			o_EN_IN : OUT STD_LOGIC;
			o_ADD_ROM : OUT STD_LOGIC_VECTOR((add - 1) DOWNTO 0)
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos
	SIGNAL w_CONTROLE : STD_LOGIC_VECTOR((control - 1) DOWNTO 0);
	SIGNAL w_CLOCK : STD_LOGIC;
	SIGNAL w_RST : STD_LOGIC;
	SIGNAL w_SEL_OP1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL w_SEL_OP2 : STD_LOGIC;
	SIGNAL w_EN_ROM : STD_LOGIC;
	SIGNAL w_EN_RAM : STD_LOGIC;
	SIGNAL w_WR_ACC : STD_LOGIC;
	SIGNAL w_WR_RAM : STD_LOGIC;
	SIGNAL w_SEL_ULA : STD_LOGIC;
	SIGNAL w_EN_IN : STD_LOGIC;
	SIGNAL w_ADD_ROM : STD_LOGIC_VECTOR((add - 1) DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do Testbench do Caminho de Controle

	-- Instancialização dos Componentes	
	-------------------------------------------------------------------------------------------------------------------------
	UN : CAMINHO_CONTROLE
	GENERIC MAP(
		add => 12,
		control => 4
	)
	PORT MAP(
		-- Entradas
		i_CONTROLE => w_CONTROLE,
		i_CLOCK => w_CLOCK,
		i_RESET => w_RST,

		-- Saídas
		o_SEL_OP1 => w_SEL_OP1,
		o_SEL_OP2 => w_SEL_OP2,
		o_EN_ROM => w_EN_ROM,
		o_EN_RAM => w_EN_RAM,
		o_WR_ACC => w_WR_ACC,
		o_WR_RAM => w_WR_RAM,
		o_SEL_ULA => w_SEL_ULA,
		o_EN_IN => w_EN_IN,
		o_ADD_ROM => w_ADD_ROM
	);
	-------------------------------------------------------------------------------------------------------------------------

	-- Teste
	-------------------------------------------------------------------------------------------------------------------------

	-- Teste de Reset
	PROCESS
	BEGIN
		w_RST <= '1';
		WAIT FOR 30 ns;
		w_RST <= '0';
		WAIT;
	END PROCESS;

	-- Teste de clock
	PROCESS
	BEGIN
		w_CLOCK <= '0';
		WAIT FOR 20 ns;
		w_CLOCK <= '1';
		WAIT FOR 20 ns;
	END PROCESS;

	-- Teste de controle
	PROCESS
	BEGIN
		w_CONTROLE <= "0011";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0001";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0011";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0001";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0011";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0001";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0011";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0001";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0010";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0100";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0110";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0100";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0100";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0100";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0001";
		WAIT FOR 40 ns;
		w_CONTROLE <= "1000";
		WAIT FOR 80 ns;
		w_CONTROLE <= "1001";
		WAIT FOR 40 ns;
		w_CONTROLE <= "0000";
		WAIT;
	END PROCESS;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;