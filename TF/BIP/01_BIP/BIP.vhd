-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 28/06/2022
--
-- Implementar o BIP
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BIP IS
	GENERIC (
		n : INTEGER := 16
	);
	PORT (
		-- Entradas
		i_OUTSIDE : IN STD_LOGIC_VECTOR((n - 7) DOWNTO 0); -- Entrada externa obtida pelo switch
		i_CLOCK : IN STD_LOGIC; -- Entrada de Clock
		i_RESET : IN STD_LOGIC; -- Entrada de Reset

		o_LED : OUT STD_LOGIC_VECTOR((n - 7) DOWNTO 0) -- Saída do valor que está no acumulador no LED
	);
END BIP;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF BIP IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT RAM IS
		GENERIC (
			p_DATA_WIDTH : INTEGER := 16;
			p_ADD_WIDTH : INTEGER := 12
		);
		PORT (
			-- Entradas
			i_ADD : IN STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0); -- Entrada do endereço a ser acessado
			i_EN : IN STD_LOGIC; -- Enable da RAM
			i_WR : IN STD_LOGIC; -- Write da RAM
			i_RESET : IN STD_LOGIC; -- Entrada de Reset
			i_CLOCK : IN STD_LOGIC; -- Entrada de Clock

			-- Saídas
			io_DATA : INOUT STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0) -- Entrada e saída de valores
		);
	END COMPONENT;

	COMPONENT ROM IS
		GENERIC (
			p_DATA_WIDTH : INTEGER := 16;
			p_ADD_WIDTH : INTEGER := 12
		);
		PORT (
			-- Entradas
			i_ADD : IN STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0); -- Entrada do endereço de acesso da ROM
			i_EN : IN STD_LOGIC; -- Enable da ROM
			i_RESET : IN STD_LOGIC; -- Entrada de Reset
			i_CLOCK : IN STD_LOGIC; -- Entrada de Clock

			-- Saídas
			o_DATA : OUT STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0) -- Saída do valaor salvo no endereço acessado
		);
	END COMPONENT;

	COMPONENT PROCESSADOR IS
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
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos

	SIGNAL w_EN_ROM : STD_LOGIC; -- Sinal de enable para a ROM
	SIGNAL w_EN_RAM : STD_LOGIC; -- Sinal de enable para a RAM
	SIGNAL w_WR_RAM : STD_LOGIC; -- Sinal de Write para a RAM

	SIGNAL w_ADD_ROM : STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Sinal de conexão da ROM com o caminho de controle
	SIGNAL w_DATA_ROM : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal de conexão da ROM com a caminho de dados

	SIGNAL w_DATA_RAM : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal de conexão com o I/O da RAM
	SIGNAL w_ADD_RAM : STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Sinal de endereçamento da RAM

	SIGNAL w_RST : STD_LOGIC; -- Sinal para inversão do RESET

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do BIP

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	U01 : RAM
	GENERIC MAP(
		p_DATA_WIDTH => 16,
		p_ADD_WIDTH => 12
	)
	PORT MAP(
		-- Entradas
		i_ADD => w_ADD_RAM, -- Entrada da RAM recebe o valor de endereçamento
		i_EN => w_EN_RAM, -- Enable da RAM vindo do processador
		i_WR => w_WR_RAM, -- Write da RAM vindo do processador
		i_RESET => w_RST,
		i_CLOCK => i_CLOCK,

		-- Saídas
		io_DATA => w_DATA_RAM -- Entrada/Saída vindo ou indo para o processador
	);

	U02 : ROM
	GENERIC MAP(
		p_DATA_WIDTH => 16,
		p_ADD_WIDTH => 12
	)
	PORT MAP(
		-- Entradas
		i_ADD => w_ADD_ROM, -- Entrada do endereçamento da ROM
		i_EN => w_EN_ROM, -- Enable da ROM vindo do processador
		i_RESET => w_RST,
		i_CLOCK => i_CLOCK,

		-- Saídas
		o_DATA => w_DATA_ROM -- Saída de valores da ROM para o processador
	);

	U03 : PROCESSADOR
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_DATA_ROM => w_DATA_ROM, -- Processador recebe os valores da ROM
		i_DATA_RAM => w_DATA_RAM, -- Processador recebe os dados da RAM
		i_OUTSIDE => i_OUTSIDE, -- Recebimento dos valores extenos do Switch
		i_CLOCK => i_CLOCK,
		i_RESET => w_RST,

		-- Saídas
		o_ADD_RAM => w_ADD_RAM, -- Envio do endereçamento para a RAM
		o_ADD_ROM => w_ADD_ROM, -- Envio do endereçamento para a ROM
		o_DATA_RAM => w_DATA_RAM, -- Processador envia os dados para a RAM
		o_EN_ROM => w_EN_ROM, -- Envio do sinal de enable para a ROM
		o_EN_RAM => w_EN_RAM, -- Envio do sinal de enable para a RAM
		o_WR_RAM => w_WR_RAM, -- Envio do sinal de Write para a RAM
		o_LED => o_LED -- Saída dos valores do acumulador para o LED
	);

	w_RST <= NOT i_RESET; -- Inversão de RESET

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;