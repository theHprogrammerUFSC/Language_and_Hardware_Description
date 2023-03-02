-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implemente um componente chamado CONTROLE descrita na forma de circuitos combinacionais
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_CONTROLE IS
END TB_CONTROLE;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF TB_CONTROLE IS

	-- Declaração do componente
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT CONTROLE IS
		PORT (
			-- Entradas
			i_OPCODE : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

			-- Saídas
			o_SEL_OP1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			o_SEL_OP2 : OUT STD_LOGIC;
			o_EN_PC : OUT STD_LOGIC;
			o_EN_ROM : OUT STD_LOGIC;
			o_EN_RAM : OUT STD_LOGIC;
			o_WR_ACC : OUT STD_LOGIC;
			o_WR_RAM : OUT STD_LOGIC;
			o_SEL_ULA : OUT STD_LOGIC;
			o_EN_IN : OUT STD_LOGIC
		);
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de sinais internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_OPCODE : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL w_SEL_OP1 : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL w_SEL_OP2 : STD_LOGIC;
	SIGNAL w_EN_PC : STD_LOGIC;
	SIGNAL w_EN_ROM : STD_LOGIC;
	SIGNAL w_EN_RAM : STD_LOGIC;
	SIGNAL w_WR_ACC : STD_LOGIC;
	SIGNAL w_WR_RAM : STD_LOGIC;
	SIGNAL w_SEL_ULA : STD_LOGIC;
	SIGNAL w_EN_IN : STD_LOGIC;
	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Instancialização do componente
	-------------------------------------------------------------------------------------------------------------------------
	UN : CONTROLE
	PORT MAP(
		-- Entradas
		i_OPCODE => w_OPCODE,

		-- Saídas
		o_SEL_OP1 => w_SEL_OP1,
		o_SEL_OP2 => w_SEL_OP2,
		o_EN_PC => w_EN_PC,
		o_EN_ROM => w_EN_ROM,
		o_EN_RAM => w_EN_RAM,
		o_WR_ACC => w_WR_ACC,
		o_WR_RAM => w_WR_RAM,
		o_SEL_ULA => w_SEL_ULA,
		o_EN_IN => w_EN_IN
	);
	-------------------------------------------------------------------------------------------------------------------------

	-- Processos do teste
	-------------------------------------------------------------------------------------------------------------------------
	PROCESS
	BEGIN
		w_OPCODE <= "0000";
		WAIT FOR 20 ns;

		w_OPCODE <= "0001";
		WAIT FOR 20 ns;

		w_OPCODE <= "0010";
		WAIT FOR 20 ns;

		w_OPCODE <= "0011";
		WAIT FOR 20 ns;

		w_OPCODE <= "0100";
		WAIT FOR 20 ns;

		w_OPCODE <= "0101";
		WAIT FOR 20 ns;

		w_OPCODE <= "0110";
		WAIT FOR 20 ns;

		w_OPCODE <= "0111";
		WAIT FOR 20 ns;

		w_OPCODE <= "1000";
		WAIT FOR 20 ns;

		w_OPCODE <= "0000";
		WAIT FOR 20 ns;

		w_OPCODE <= "1001";
		WAIT FOR 20 ns;

		w_OPCODE <= "ZZZZ";
		WAIT;
	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;