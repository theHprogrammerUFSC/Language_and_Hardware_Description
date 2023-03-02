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

ENTITY PROCESSADOR IS
	GENERIC (
		n : INTEGER := 16
	);
	PORT (
		-- Entradas
		i_DATA_ROM : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do valor que vem da ROM
		i_DATA_RAM : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do valor que é carregado da RAM
		i_OUTSIDE : IN STD_LOGIC_VECTOR((n - 7) DOWNTO 0); -- Entrada do valor externo presente no switch
		i_CLOCK : IN STD_LOGIC; -- Entrada do Clock
		i_RESET : IN STD_LOGIC; -- Entrada do Reset

		-- Saídas
		o_ADD_RAM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Saída do endereço da RAM
		o_ADD_ROM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Saída do endereço da ROM
		o_DATA_RAM : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Saída do valor a ser registrado na RAM
		o_EN_ROM : OUT STD_LOGIC; -- Saída do Enable da ROM
		o_EN_RAM : OUT STD_LOGIC; -- Saída do Enable da RAM
		o_WR_RAM : OUT STD_LOGIC; -- Saída do Write da RAM

		o_LED : OUT STD_LOGIC_VECTOR((n - 7) DOWNTO 0) -- Saída do valor presente no acumulador para o LED
	);
END PROCESSADOR;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF PROCESSADOR IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT CAMINHO_DADOS IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_DATA_ROM : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do endereço que vem da ROM
			i_DATA_RAM : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do endereço que é carregado na RAM
			i_OUTSIDE : IN STD_LOGIC_VECTOR((n - 7) DOWNTO 0); -- Entrada de valor externo pelos switchs

			i_CLOCK : IN STD_LOGIC; -- Entrada do Clock
			i_RESET : IN STD_LOGIC; -- Entrada do Reset

			i_WR_ACC : IN STD_LOGIC; -- Entrada do Enable/Write do acumulador
			i_SEL_ULA : IN STD_LOGIC; -- Entrada do seletor de operação
			i_SEL_OP2 : IN STD_LOGIC; -- Entrada do seletor do Mux2x1
			i_SEL_OP1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Entrada do seletor do Mux3x1
			i_EN_IN : IN STD_LOGIC; -- Entrada do Enable do INP (pega o valor externo)

			-- Saídas
			o_CONTROLE : OUT STD_LOGIC_VECTOR((n - 13) DOWNTO 0); -- Saída do código de operação
			o_ADD_RAM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Saída do endereço da RAM para salvar um valor
			o_DATA_RAM : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Saída do valor para ser salvo na RAM
			o_LED : OUT STD_LOGIC_VECTOR((n - 7) DOWNTO 0) -- Saída do valor que está no acumulador para os leds
		);
	END COMPONENT;

	COMPONENT CAMINHO_CONTROLE IS
		GENERIC (
			add : INTEGER := 12;
			control : INTEGER := 4
		);
		PORT (
			-- Entradas
			i_CONTROLE : IN STD_LOGIC_VECTOR((control - 1) DOWNTO 0); -- Entrada da operação a ser efetuada
			i_RESET : IN STD_LOGIC; -- Entrada para o reset	
			i_CLOCK : IN STD_LOGIC; -- Entrada para o clock

			-- Saídas
			o_SEL_OP1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Selecionador de caminho para o multiplexador 3x1
			o_SEL_OP2 : OUT STD_LOGIC; -- Selecionador de caminho para o multiplexador 2x1
			o_EN_ROM : OUT STD_LOGIC; -- Enable da memória de programa (ROM)
			o_EN_RAM : OUT STD_LOGIC; -- Enable da memória de dados (RAM)
			o_WR_ACC : OUT STD_LOGIC; -- Write/Enable do Aculumador (em '1' o valor que esta na entrada é registrado)
			o_WR_RAM : OUT STD_LOGIC; -- Write da RAM (em '1' escreve na ram e em '0' faz a leitura da mesma)
			o_SEL_ULA : OUT STD_LOGIC; -- Selecionador de operação (Soma e Subtração)
			o_EN_IN : OUT STD_LOGIC; -- Enable para pegar valor externo.
			o_ADD_ROM : OUT STD_LOGIC_VECTOR((add - 1) DOWNTO 0) -- Saída para a ROM
		);
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos
	SIGNAL w_CONTROLE : STD_LOGIC_VECTOR((n - 13) DOWNTO 0); -- Sinal para ligar o código de operação
	SIGNAL w_SEL_OP1 : STD_LOGIC_VECTOR(1 DOWNTO 0); -- Sinal para ligar o seletor do OP1
	SIGNAL w_SEL_OP2 : STD_LOGIC; -- Sinal para ligar o seletor do OP2
	SIGNAL w_WR_ACC : STD_LOGIC; -- Sinal para ligar o Enable/Write do acumulador
	SIGNAL w_SEL_ULA : STD_LOGIC; -- Sinal para ligar o seletor da ULA
	SIGNAL w_EN_IN : STD_LOGIC; -- Sinal para ativar o INP

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do Processador

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	U01 : CAMINHO_DADOS
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_DATA_ROM => i_DATA_ROM, -- Entradada da ROM
		i_DATA_RAM => i_DATA_RAM, -- Entradada da RAM
		i_OUTSIDE => i_OUTSIDE,
		i_CLOCK => i_CLOCK,
		i_RESET => i_RESET,
		i_WR_ACC => w_WR_ACC,
		i_SEL_ULA => w_SEL_ULA,
		i_SEL_OP2 => w_SEL_OP2,
		i_SEL_OP1 => w_SEL_OP1,
		i_EN_IN => w_EN_IN,

		-- Saídas
		o_CONTROLE => w_CONTROLE, -- Código do controle sai do caminho de dados 
		o_ADD_RAM => o_ADD_RAM, -- Saída do endereço da RAM
		o_DATA_RAM => o_DATA_RAM, -- Saída do valor a ser registrado na RAM
		o_LED => o_LED
	);

	U02 : CAMINHO_CONTROLE
	GENERIC MAP(
		add => 12,
		control => 4
	)
	PORT MAP(
		-- Entradas
		i_CONTROLE => w_CONTROLE, -- Código de controle entra no caminho de controle
		i_RESET => i_RESET,
		i_CLOCK => i_CLOCK,

		-- Saídas
		o_SEL_OP1 => w_SEL_OP1,
		o_SEL_OP2 => w_SEL_OP2,
		o_EN_ROM => o_EN_ROM,
		o_EN_RAM => o_EN_RAM,
		o_WR_ACC => w_WR_ACC,
		o_WR_RAM => o_WR_RAM,
		o_SEL_ULA => w_SEL_ULA,
		o_EN_IN => w_EN_IN,
		o_ADD_ROM => o_ADD_ROM -- Saída do endereço da ROM
	);

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;