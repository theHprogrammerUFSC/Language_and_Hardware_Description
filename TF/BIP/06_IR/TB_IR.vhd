-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 27/06/2022
--
-- Implementar o Testbench do instruction register
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_IR IS
	GENERIC (n : INTEGER := 16);
END TB_IR;

ARCHITECTURE Behavioral OF TB_IR IS

	-- Declaração de componente
	-------------------------------------------------------------------------------------------------------------------------

	COMPONENT IR IS
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
			o_ADD_RAM : OUT STD_LOGIC_VECTOR((n - 5) DOWNTO 0); -- Saída para o mux e para a ram
			o_CONTROLE : OUT STD_LOGIC_VECTOR((n - 13) DOWNTO 0) -- Saída para o caminho de controle
		);
	END COMPONENT;

	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de sinais internos
	-------------------------------------------------------------------------------------------------------------------------

	SIGNAL w_RESET : STD_LOGIC;
	SIGNAL w_CLOCK : STD_LOGIC;
	SIGNAL w_iDATA : STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	SIGNAL w_ADD_RAM : STD_LOGIC_VECTOR((n - 5) DOWNTO 0);
	SIGNAL w_CONTROLE : STD_LOGIC_VECTOR((n - 13) DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------

BEGIN
	-- Instancialização do componente
	-------------------------------------------------------------------------------------------------------------------------

	UN : IR
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_RESET => w_RESET,
		i_CLOCK => w_CLOCK,
		i_EN => '1',
		i_DATA => w_iDATA,

		-- Saídas
		o_ADD_RAM => w_ADD_RAM,
		o_CONTROLE => w_CONTROLE
	);

	-------------------------------------------------------------------------------------------------------------------------

	-- Teste
	-------------------------------------------------------------------------------------------------------------------------

	-- Teste de Reset
	PROCESS
	BEGIN
		w_RESET <= '1';
		WAIT FOR 30 ns;
		w_RESET <= '0';
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
		w_iDATA <= x"0000";
		WAIT FOR 40 ns;
		w_iDATA <= x"3014";
		WAIT FOR 40 ns;
		w_iDATA <= x"1000";
		WAIT FOR 40 ns;
		w_iDATA <= x"3019";
		WAIT FOR 40 ns;
		w_iDATA <= x"1001";
		WAIT FOR 40 ns;
		w_iDATA <= x"3003";
		WAIT FOR 40 ns;
		w_iDATA <= x"1002";
		WAIT FOR 40 ns;
		w_iDATA <= x"301A";
		WAIT FOR 40 ns;
		w_iDATA <= x"1003";
		WAIT FOR 40 ns;
		w_iDATA <= x"2000";
		WAIT FOR 40 ns;
		w_iDATA <= x"4000";
		WAIT FOR 40 ns;
		w_iDATA <= x"6001";
		WAIT FOR 40 ns;
		w_iDATA <= x"4002";
		WAIT FOR 40 ns;
		w_iDATA <= x"4002";
		WAIT FOR 40 ns;
		w_iDATA <= x"4003";
		WAIT FOR 40 ns;
		w_iDATA <= x"1004";
		WAIT FOR 40 ns;
		w_iDATA <= x"9000";
		WAIT FOR 40 ns;
		w_iDATA <= x"0000";
		WAIT;
	END PROCESS;

	-------------------------------------------------------------------------------------------------------------------------	
END Behavioral;