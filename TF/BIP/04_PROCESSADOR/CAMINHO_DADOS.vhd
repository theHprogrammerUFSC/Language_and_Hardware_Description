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

ENTITY CAMINHO_DADOS IS
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
END CAMINHO_DADOS;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF CAMINHO_DADOS IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT ACC IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_RESET : IN STD_LOGIC; -- Entrada de Reset
			i_CLOCK : IN STD_LOGIC; -- Entrada de Clock
			i_EN : IN STD_LOGIC; -- Enable/Write
			i_DATA : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada de dados no acumulador

			-- Saídas
			o_DATA : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Saída de dados no acumulador
			o_LED : OUT STD_LOGIC_VECTOR((n - 7) DOWNTO 0) -- Saída dos dados do acumulador para o FPGA
		);
	END COMPONENT;

	COMPONENT IR IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_RESET : IN STD_LOGIC; -- Entrada do Reset
			i_CLOCK : IN STD_LOGIC; -- Entrada do Clock
			i_EN : IN STD_LOGIC; -- Enable do Instruct Register
			i_DATA : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do endereço que vem da ROM

			-- Saídas
			o_ADD_RAM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Saída para o mux e para a ram
			o_CONTROLE : OUT STD_LOGIC_VECTOR((n - 13) DOWNTO 0) -- Saída para o caminho de controle
		);
	END COMPONENT;

	COMPONENT MUX4x1 IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_BUS_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 0
			i_BUS_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 1
			i_BUS_C : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 2
			i_SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Seleção para a entrada

			-- Saídas
			o_BUS : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0) -- Saída do valor que está na entrada
		);
	END COMPONENT;

	COMPONENT MUX2x1 IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_BUS_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 0
			i_BUS_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada 1
			i_SEL : IN STD_LOGIC; -- Seletor de entrada

			-- Saídas
			o_BUS : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0) -- Saída do Resultado
		);
	END COMPONENT;

	COMPONENT ULA IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_INPUT_A : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do primeiro valor	
			i_INPUT_B : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Entrada do segundo valor
			i_SEL : IN STD_LOGIC; -- Seletor de operação

			-- Saídas
			o_OUTPUT : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0) -- Saída do Resultado
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos
	SIGNAL w_ADD_RAM : STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Sinal para ligar o endereço da RAM

	SIGNAL w_DATA_12B : STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Sinal para receber valor que sai do IR que será concatenado
	SIGNAL w_DATA_16B : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal para receber valor concatenado

	SIGNAL w_UA_2_OP1 : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal para ligar a saída da ula ao OP1
	SIGNAL w_OP1_2_ACC : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal para ligar a saída do OP1 ao acumulador

	SIGNAL w_out_ACC : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal para receber a saída do acumulador
	SIGNAL w_out_OP2 : STD_LOGIC_VECTOR((n - 1) DOWNTO 0); -- Sinal para a saída do OP2

	SIGNAL w_OUTSIDE_12B : STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Sinal para receber o valor externo dos switchs

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do Caminho de Dados

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	UIR : IR
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_RESET => i_RESET,
		i_CLOCK => i_CLOCK,
		i_EN => '1',
		i_DATA => i_DATA_ROM, -- Entrada do IR recebe o valor que veio da ROM

		-- Saídas
		o_ADD_RAM => w_ADD_RAM, -- Saída do valor do endereço para a RAM
		o_CONTROLE => o_CONTROLE -- Saída do valor da operação a ser executada
	);

	UMUX_OP1 : MUX4x1
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_BUS_A => i_DATA_RAM, -- Entrada 0 do OP1 recebe o valor carregado da RAM
		i_BUS_B => w_DATA_16B, -- Entrada 1 do OP1 recebe o valor concatenado do IR
		i_BUS_C => w_UA_2_OP1, -- Entrada 2 do OP1 recebe o valor que veio da ULA
		i_SEL => i_SEL_OP1,

		-- Saídas
		o_BUS => w_OP1_2_ACC -- Saída do OP1 é conectada ao acumulador
	);

	UACC : ACC
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_RESET => i_RESET,
		i_CLOCK => i_CLOCK,
		i_EN => i_WR_ACC,
		i_DATA => w_OP1_2_ACC, -- Entrada do acumulador recebe o valor da saída do OP1

		-- Saídas
		o_DATA => w_out_ACC, -- Saída do ACC que vai para a ULA e para a RAM
		o_LED => o_LED
	);

	UMUX_OP2 : MUX2x1
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_BUS_A => i_DATA_RAM, -- Entrada 0 do OP2 recebe valor que foi carregado da RAM
		i_BUS_B => w_DATA_16B, -- Entrada 1 do OP2 recebe o valor concatenado do IR
		i_SEL => i_SEL_OP2,

		-- Saídas
		o_BUS => w_out_OP2 -- Saída do OP2 para ser conectada a ULA
	);

	UUA : ULA
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_INPUT_A => w_out_ACC, -- Entrada 0 da ULA recebe valor que veio do acumulador
		i_INPUT_B => w_out_OP2, -- Entrada 1 da ULA recebe valor que veio do OP2
		i_SEL => i_SEL_ULA,

		-- Saídas
		o_OUTPUT => w_UA_2_OP1 -- Saída da ULA volta para o OP1
	);

	UMUX_IN : MUX2x1
	GENERIC MAP(
		n => 12
	)
	PORT MAP(
		-- Entradas
		i_BUS_A => w_ADD_RAM, -- Entrada 0 do INP recebe valor que veio do IR
		i_BUS_B => w_OUTSIDE_12B, -- Entrada 1 do INP recebe valor externo não concatenado
		i_SEL => i_EN_IN,

		-- Saídas
		o_BUS => w_DATA_12B -- Saída do INP é uma valor de 12 bits para ser concatenado com "00" a esquerda
	);

	-------------------------------------------------------------------------------------------------------------------------

	w_DATA_16B <= "0000" & w_DATA_12B; -- Concatena a saída do MUX IN para um endereõ de 16 bits

	w_OUTSIDE_12B <= "00" & i_OUTSIDE; -- Concatena o valor de 10 bits vindas do switch para 12 bits

	o_DATA_RAM <= w_out_ACC; -- Saída do valor que vai pra ram recebe o valor que está no ACC

	o_ADD_RAM <= w_ADD_RAM; -- Endereço para a ram que também vai no MUX IN

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;