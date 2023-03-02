-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implemente uma memória ROM com 1K células de memória, de 16 bits cada:
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_ROM IS
	GENERIC (
		p_DATA_WIDTH : INTEGER := 16;
		p_ADD_WIDTH : INTEGER := 12);
END TB_ROM;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF TB_ROM IS

	-- Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT ROM IS
		GENERIC (
			p_DATA_WIDTH : INTEGER := 16;
			p_ADD_WIDTH : INTEGER := 12
		);
		PORT (
			-- Entradas
			i_ADD : IN STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0);
			i_EN : IN STD_LOGIC;
			i_RESET : IN STD_LOGIC;
			i_CLOCK : IN STD_LOGIC;

			-- Saídas
			o_DATA : OUT STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0)
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de sinais internos
	-------------------------------------------------------------------------------------------------------------------------
	SIGNAL w_ADD : STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0);
	SIGNAL w_EN : STD_LOGIC;
	SIGNAL w_RST : STD_LOGIC;
	SIGNAL w_CLOCK : STD_LOGIC;
	SIGNAL w_DATA : STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------

BEGIN

	--Instancialização da ROM
	-------------------------------------------------------------------------------------------------------------------------
	UROM : ROM
	GENERIC MAP(
		p_DATA_WIDTH => 16,
		p_ADD_WIDTH => 12
	)
	PORT MAP(
		-- Entradas
		i_ADD => w_ADD,
		i_EN => w_EN,
		i_RESET => w_RST,
		i_CLOCK => w_CLOCK,

		-- Saídas
		o_DATA => w_DATA
	);
	-------------------------------------------------------------------------------------------------------------------------

	-- Teste
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

	-- Teste de Enable
	PROCESS
	BEGIN
		w_EN <= '0';
		WAIT FOR 40 ns;
		w_EN <= '1';
		WAIT;
	END PROCESS;

	-- Teste de Endereço
	PROCESS
	BEGIN
		w_ADD <= x"000";
		WAIT FOR 80 ns;

		w_ADD <= x"001";
		WAIT FOR 40 ns;

		w_ADD <= x"002";
		WAIT FOR 40 ns;

		w_ADD <= x"003";
		WAIT FOR 40 ns;

		w_ADD <= x"004";
		WAIT FOR 40 ns;

		w_ADD <= x"005";
		WAIT FOR 40 ns;

		w_ADD <= x"006";
		WAIT FOR 40 ns;

		w_ADD <= x"007";
		WAIT FOR 40 ns;

		w_ADD <= x"008";
		WAIT FOR 40 ns;

		w_ADD <= x"009";
		WAIT FOR 40 ns;

		w_ADD <= x"00A";
		WAIT FOR 40 ns;

		w_ADD <= x"00B";
		WAIT FOR 40 ns;

		w_ADD <= x"00C";
		WAIT FOR 40 ns;

		w_ADD <= x"00D";
		WAIT FOR 40 ns;

		w_ADD <= x"00E";
		WAIT FOR 40 ns;

		w_ADD <= x"00F";
		WAIT FOR 40 ns;

		w_ADD <= x"010";
		WAIT FOR 40 ns;

		w_ADD <= x"011";
		WAIT FOR 40 ns;

		w_ADD <= x"012";
		WAIT FOR 40 ns;

		w_ADD <= x"013";
		WAIT FOR 40 ns;

		w_ADD <= x"014";
		WAIT FOR 40 ns;

		w_ADD <= x"015";
		WAIT FOR 40 ns;

		w_ADD <= x"016";
		WAIT FOR 40 ns;

		w_ADD <= x"017";
		WAIT FOR 40 ns;

		w_ADD <= x"018";
		WAIT FOR 40 ns;

		w_ADD <= x"019";
		WAIT FOR 40 ns;

		w_ADD <= x"01A";
		WAIT FOR 40 ns;

		w_ADD <= x"01B";
		WAIT FOR 40 ns;

		w_ADD <= x"01C";
		WAIT FOR 40 ns;

		w_ADD <= x"01D";
		WAIT FOR 40 ns;

		w_ADD <= x"01E";
		WAIT FOR 40 ns;

		w_ADD <= x"01F";
		WAIT;
	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------

END Behavioral;