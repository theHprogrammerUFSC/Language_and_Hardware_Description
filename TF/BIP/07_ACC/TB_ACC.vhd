-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 27/06/2022
--
-- Implementar o testbench para um registrador genérico
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_ACC IS
	GENERIC (n : INTEGER := 16);
END TB_ACC;

ARCHITECTURE Behavioral OF TB_ACC IS

	-- Implementação do componente
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT ACC IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_RESET : IN STD_LOGIC;
			i_CLOCK : IN STD_LOGIC;
			i_EN : IN STD_LOGIC;
			i_DATA : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);

			-- Saídas
			o_DATA : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
			o_LED : OUT STD_LOGIC_VECTOR((n - 7) DOWNTO 0)
		);
	END COMPONENT;

	-- Declaração de sinais internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_RESET : STD_LOGIC;
	SIGNAL w_CLOCK : STD_LOGIC;
	SIGNAL w_EN : STD_LOGIC;
	SIGNAL w_iDATA : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_oDATA : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_oLED : STD_LOGIC_VECTOR((n - 7) DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Instancialização do componente
	-------------------------------------------------------------------------------------------------------------------------
	UN : ACC
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_RESET => w_RESET,
		i_CLOCK => w_CLOCK,
		i_EN => w_EN,
		i_DATA => w_iDATA,

		-- Saídas
		o_DATA => w_oDATA,
		o_LED => w_oLED
	);

	-------------------------------------------------------------------------------------------------------------------------

	-- Processos para teste
	-------------------------------------------------------------------------------------------------------------------------

	-- Teste de reset
	PROCESS
	BEGIN
		w_RESET <= '1';
		WAIT FOR 40 ns;
		w_RESET <= '0';
		WAIT;
	END PROCESS;

	-- Teste de clock
	PROCESS
	BEGIN
		w_CLOCK <= '1';
		WAIT FOR 20 ns;
		w_CLOCK <= '0';
		WAIT FOR 20 ns;
	END PROCESS;

	-- Teste de enable
	PROCESS
	BEGIN
		w_EN <= '0';
		WAIT FOR 50 ns;
		w_EN <= '1';
		WAIT FOR 50 ns;
	END PROCESS;

	-- iDATA
	PROCESS
	BEGIN
		w_iDATA <= x"AAAA";
		WAIT FOR 40 ns;
		w_iDATA <= x"BBBB";
		WAIT FOR 40 ns;
		w_iDATA <= x"CCCC";
		WAIT FOR 40 ns;
		w_iDATA <= x"DDDD";
		WAIT FOR 40 ns;
		w_iDATA <= x"EEEE";
		WAIT FOR 40 ns;
		w_iDATA <= x"FFFF";
		WAIT FOR 40 ns;
	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------	
END Behavioral;