-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 28/06/2022
--
-- Implementar um componente Caminho de Controle contendo o Program Counter e a Lógica de Controle
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CAMINHO_CONTROLE IS
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
END CAMINHO_CONTROLE;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF CAMINHO_CONTROLE IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT CONTROLE IS
		PORT (
			-- Entradas
			i_OPCODE : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Entrada da operação a ser efetuada

			-- Saídas
			o_SEL_OP1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Selecionador de caminho para o multiplexador 3x1
			o_SEL_OP2 : OUT STD_LOGIC; -- Selecionador de caminho para o multiplexador 2x1
			o_EN_PC : OUT STD_LOGIC; -- Enable do Contador de programa
			o_EN_ROM : OUT STD_LOGIC; -- Enable da memória de programa (ROM)
			o_EN_RAM : OUT STD_LOGIC; -- Enable da memória de dados (RAM)
			o_WR_ACC : OUT STD_LOGIC; -- Write/Enable do Aculumador (em '1' o valor que esta na entrada é registrado)
			o_WR_RAM : OUT STD_LOGIC; -- Write da RAM (em '1' escreve na ram e em '0' faz a leitura da mesma)
			o_SEL_ULA : OUT STD_LOGIC; -- Selecionador de operação (Soma e Subtração)
			o_EN_IN : OUT STD_LOGIC -- Enable para pegar valor externo.
		);
	END COMPONENT;

	COMPONENT PC IS
		GENERIC (
			p_ADD_WIDTH : INTEGER := 12
		);
		PORT (
			-- Entradas
			i_RESET : IN STD_LOGIC; -- Entrada para o reset	
			i_CLOCK : IN STD_LOGIC; -- Entrada para o clock
			i_EN : IN STD_LOGIC; -- Enable do contador de programa

			-- Saídas
			o_ADD_ROM : OUT STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0) -- Saída para a ROM
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos
	SIGNAL w_EN_PC : STD_LOGIC; -- Ligação interna da lógica de controle para o contador de programa

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do Caminho de Controle

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	U00 : CONTROLE
	PORT MAP(
		-- Entradas
		i_OPCODE => i_CONTROLE,

		-- Saídas
		o_SEL_OP1 => o_SEL_OP1,
		o_SEL_OP2 => o_SEL_OP2,
		o_EN_PC => w_EN_PC,
		o_EN_ROM => o_EN_ROM,
		o_EN_RAM => o_EN_RAM,
		o_WR_ACC => o_WR_ACC,
		o_WR_RAM => o_WR_RAM,
		o_SEL_ULA => o_SEL_ULA,
		o_EN_IN => o_EN_IN
	);

	U01 : PC
	GENERIC MAP(
		p_ADD_WIDTH => 12
	)
	PORT MAP(
		-- Entradas
		i_RESET => i_RESET,
		i_CLOCK => i_CLOCK,
		i_EN => w_EN_PC,

		-- Saídas
		o_ADD_ROM => o_ADD_ROM
	);
	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;