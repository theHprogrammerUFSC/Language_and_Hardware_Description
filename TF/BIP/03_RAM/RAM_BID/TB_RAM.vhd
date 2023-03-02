-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implemente uma memória RAM com 1K células de memória, de 16 bits cada:
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_RAM IS
	GENERIC (
		p_DATA_WIDTH : INTEGER := 16;
		p_ADD_WIDTH : INTEGER := 12);
END TB_RAM;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF TB_RAM IS

	-- Declaração de Componente
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT RAM IS
		GENERIC (
			p_DATA_WIDTH : INTEGER := 16;
			p_ADD_WIDTH : INTEGER := 12
		);
		PORT (
			-- Entradas
			i_ADD : IN STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0);
			i_EN : IN STD_LOGIC;
			i_WR : IN STD_LOGIC;
			i_RESET : IN STD_LOGIC;
			i_CLOCK : IN STD_LOGIC;

			-- Saídas
			io_DATA : INOUT STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0)
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de Sinais Internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_ADD : STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0);
	SIGNAL w_EN : STD_LOGIC;
	SIGNAL w_WR : STD_LOGIC;
	SIGNAL w_RST : STD_LOGIC;
	SIGNAL w_CLOCK : STD_LOGIC;
	SIGNAL w_DATA : STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0);
	-------------------------------------------------------------------------------------------------------------------------	
BEGIN

	-- Instancialização da RAM
	-------------------------------------------------------------------------------------------------------------------------
	U00 : RAM
	GENERIC MAP(
		p_DATA_WIDTH => 16,
		p_ADD_WIDTH => 12
	)
	PORT MAP(
		-- Entradas
		i_ADD => w_ADD,
		i_EN => w_EN,
		i_WR => w_WR,
		i_RESET => w_RST,
		i_CLOCK => w_CLOCK,

		-- Saídas
		io_DATA => w_DATA
	);
	-------------------------------------------------------------------------------------------------------------------------

	-- Teste de Reset
	PROCESS
	BEGIN
		w_RST <= '1';
		WAIT FOR 40 ns;
		w_RST <= '0';
		WAIT;
	END PROCESS;

	-- Teste de Clock
	PROCESS
	BEGIN
		w_CLOCK <= '0';
		WAIT FOR 20 ns;
		w_CLOCK <= '1';
		WAIT FOR 20 ns;
	END PROCESS;
	PROCESS
	BEGIN

		w_ADD <= (OTHERS => '0');
		w_EN <= '0';
		w_WR <= '0';
		w_DATA <= (OTHERS => '0');
		WAIT FOR 50 NS;

		-- TESTE DE ESCRITA
		w_ADD <= (OTHERS => '0');
		w_DATA <= x"0014";
		w_WR <= '1';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';

		WAIT FOR 140 NS;

		-- TESTE DE LEITURA
		w_ADD <= (OTHERS => '0');
		w_WR <= '0';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';

		WAIT FOR 140 NS;

		-- TESTE DE ESCRITA
		w_ADD <= x"001";
		w_DATA <= x"0019";
		w_WR <= '1';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';

		WAIT FOR 140 NS;

		-- TESTE DE LEITURA
		w_ADD <= x"001";
		w_WR <= '0';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';

		WAIT FOR 140 NS;

		-- TESTE DE ESCRITA
		w_ADD <= x"002";
		w_DATA <= x"0003";
		w_WR <= '1';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';

		WAIT FOR 140 NS;

		-- TESTE DE LEITURA
		w_ADD <= x"002";
		w_WR <= '0';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';

		WAIT FOR 140 NS;

		-- TESTE DE LEITURA
		w_ADD <= x"002";
		w_WR <= '0';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';

		WAIT FOR 140 NS;

		-- TESTE DE ESCRITA
		w_ADD <= x"003";
		w_DATA <= x"001A";
		w_WR <= '1';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';

		WAIT FOR 140 NS;

		-- TESTE DE LEITURA
		w_ADD <= x"003";
		w_WR <= '0';
		w_EN <= '1';
		WAIT FOR 60 NS;
		w_EN <= '0';
		WAIT;

	END PROCESS;

	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;