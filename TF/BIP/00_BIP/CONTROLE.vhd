-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implementação de um componente para a lógica de controle.
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CONTROLE IS
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
END CONTROLE;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF CONTROLE IS
BEGIN
	-- Implementação da Lógica de Controle (Seguindo a tabela verdade disponibilizada)
	-------------------------------------------------------------------------------------------------------------------------

	WITH (i_OPCODE) SELECT o_SEL_OP1 <=
	"00" WHEN "0000", -- STOP
	"00" WHEN "0001", --	STO
	"00" WHEN "0010", --	LD
	"01" WHEN "0011", --	LDI
	"10" WHEN "0100", --	ADD
	"10" WHEN "0101", --	ADDI
	"10" WHEN "0110", --	SUB
	"10" WHEN "0111", -- SUBI
	"01" WHEN "1001", -- INP
	"ZZ" WHEN OTHERS;

	WITH (i_OPCODE) SELECT o_SEL_OP2 <=
	'0' WHEN "0000", -- STOP
	'0' WHEN "0001", --	STO
	'0' WHEN "0010", --	LD
	'1' WHEN "0011", --	LDI
	'0' WHEN "0100", --	ADD
	'1' WHEN "0101", --	ADDI
	'0' WHEN "0110", --	SUB
	'1' WHEN "0111", -- SUBI
	'1' WHEN "1001", -- INP
	'Z' WHEN OTHERS;

	WITH (i_OPCODE) SELECT o_EN_PC <=
	'0' WHEN "0000", -- STOP
	'1' WHEN "0001", --	STO
	'1' WHEN "0010", --	LD
	'1' WHEN "0011", --	LDI
	'1' WHEN "0100", --	ADD
	'1' WHEN "0101", --	ADDI
	'1' WHEN "0110", --	SUB
	'1' WHEN "0111", -- SUBI
	'1' WHEN "1001", -- INP
	'Z' WHEN OTHERS;

	WITH (i_OPCODE) SELECT o_EN_ROM <=
	'1' WHEN "0000", -- STOP
	'1' WHEN "0001", --	STO
	'1' WHEN "0010", --	LD
	'1' WHEN "0011", --	LDI
	'1' WHEN "0100", --	ADD
	'1' WHEN "0101", --	ADDI
	'1' WHEN "0110", --	SUB
	'1' WHEN "0111", -- SUBI
	'1' WHEN "1001", -- INP
	'Z' WHEN OTHERS;

	WITH (i_OPCODE) SELECT o_EN_RAM <=
	'0' WHEN "0000", -- STOP
	'1' WHEN "0001", --	STO
	'1' WHEN "0010", --	LD
	'0' WHEN "0011", --	LDI
	'1' WHEN "0100", --	ADD
	'0' WHEN "0101", --	ADDI
	'1' WHEN "0110", --	SUB
	'0' WHEN "0111", -- SUBI
	'0' WHEN "1001", -- INP
	'Z' WHEN OTHERS;

	WITH (i_OPCODE) SELECT o_WR_ACC <=
	'0' WHEN "0000", -- STOP
	'0' WHEN "0001", --	STO
	'1' WHEN "0010", --	LD
	'1' WHEN "0011", --	LDI
	'1' WHEN "0100", --	ADD
	'1' WHEN "0101", --	ADDI
	'1' WHEN "0110", --	SUB
	'1' WHEN "0111", -- SUBI
	'1' WHEN "1001", -- INP
	'Z' WHEN OTHERS;

	WITH (i_OPCODE) SELECT o_WR_RAM <=
	'0' WHEN "0000", -- STOP
	'1' WHEN "0001", --	STO
	'0' WHEN "0010", --	LD
	'0' WHEN "0011", --	LDI
	'0' WHEN "0100", --	ADD
	'0' WHEN "0101", --	ADDI
	'0' WHEN "0110", --	SUB
	'0' WHEN "0111", -- SUBI
	'0' WHEN "1001", -- INP
	'Z' WHEN OTHERS;

	WITH (i_OPCODE) SELECT o_SEL_ULA <=
	'0' WHEN "0000", -- STOP
	'0' WHEN "0001", --	STO
	'0' WHEN "0010", --	LD
	'0' WHEN "0011", --	LDI
	'0' WHEN "0100", --	ADD
	'0' WHEN "0101", --	ADDI
	'1' WHEN "0110", --	SUB
	'1' WHEN "0111", -- SUBI
	'0' WHEN "1001", -- INP
	'Z' WHEN OTHERS;

	WITH (i_OPCODE) SELECT o_EN_IN <=
	'0' WHEN "0000", -- STOP
	'0' WHEN "0001", --	STO
	'0' WHEN "0010", --	LD
	'0' WHEN "0011", --	LDI
	'0' WHEN "0100", --	ADD
	'0' WHEN "0101", --	ADDI
	'0' WHEN "0110", --	SUB
	'0' WHEN "0111", -- SUBI
	'1' WHEN "1001", -- INP
	'Z' WHEN OTHERS;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;