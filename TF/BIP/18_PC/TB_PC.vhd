-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 28/06/2022
--
-- Implementar o Testbench de um contador de programa
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_PC IS
	GENERIC (p_ADD_WIDTH : INTEGER := 12);
END TB_PC;

ARCHITECTURE Behavioral OF TB_PC IS

	-- Declaração de componente
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT PC IS
		GENERIC (
			p_ADD_WIDTH : INTEGER := 12
		);
		PORT (
			-- Entradas
			i_RESET : IN STD_LOGIC;
			i_CLOCK : IN STD_LOGIC;
			i_EN : IN STD_LOGIC;

			-- Saídas
			o_ADD_ROM : OUT STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0)
		);
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos
	-------------------------------------------------------------------------------------------------------------------------

	SIGNAL w_RESET : STD_LOGIC;
	SIGNAL w_CLOCK : STD_LOGIC;
	SIGNAL w_EN : STD_LOGIC;
	SIGNAL w_ADD_ROM : STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Instancialização do componente
	-------------------------------------------------------------------------------------------------------------------------
	UN : PC
	GENERIC MAP(
		p_ADD_WIDTH => 12
	)
	PORT MAP(
		-- Entradas
		i_RESET => w_RESET,
		i_CLOCK => w_CLOCK,
		i_EN => w_EN,

		-- Saídas
		o_ADD_ROM => w_ADD_ROM
	);

	-------------------------------------------------------------------------------------------------------------------------

	-- Teste
	-------------------------------------------------------------------------------------------------------------------------

	-- Teste de reset
	PROCESS
	BEGIN
		w_RESET <= '1';
		WAIT FOR 40 ns;
		w_RESET <= '0';
		WAIT FOR 40 ns;
		w_RESET <= '1';
		WAIT FOR 40 ns;
		w_RESET <= '0';
		WAIT;
	END PROCESS;

	-- Teste de enable
	PROCESS
	BEGIN
		w_EN <= '0';
		WAIT FOR 60 ns;
		w_EN <= '1';
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

	-------------------------------------------------------------------------------------------------------------------------	
END Behavioral;