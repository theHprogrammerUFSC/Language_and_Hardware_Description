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

ENTITY TB_BIP IS
END TB_BIP;

-------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF TB_BIP IS

	--Declaração de Componentes
	-------------------------------------------------------------------------------------------------------------------------
	COMPONENT BIP IS
		GENERIC (
			n : INTEGER := 16
		);
		PORT (
			-- Entradas
			i_OUTSIDE : IN STD_LOGIC_VECTOR((n - 7) DOWNTO 0);
			i_CLOCK : IN STD_LOGIC;
			i_RESET : IN STD_LOGIC;

			o_LED : OUT STD_LOGIC_VECTOR((n - 7) DOWNTO 0)
		);
	END COMPONENT;
	-------------------------------------------------------------------------------------------------------------------------

	-- Declaração dos Sinais Internos

	SIGNAL w_OUTSIDE : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL w_CLOCK : STD_LOGIC;
	SIGNAL w_RST : STD_LOGIC;
	SIGNAL w_LED : STD_LOGIC_VECTOR(9 DOWNTO 0);

	-------------------------------------------------------------------------------------------------------------------------
BEGIN
	-- Implementação do BIP

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	UN : BIP
	GENERIC MAP(
		n => 16
	)
	PORT MAP(
		-- Entradas
		i_OUTSIDE => w_OUTSIDE,
		i_CLOCK => w_CLOCK,
		i_RESET => w_RST,
		o_LED => w_LED
	);
	-------------------------------------------------------------------------------------------------------------------------

	-- Instancialização dos Componentes
	-------------------------------------------------------------------------------------------------------------------------
	w_OUTSIDE <= "0000000111";

	PROCESS
	BEGIN
		w_RST <= '1';
		WAIT FOR 40 ns;
		w_RST <= '0';
		WAIT;
	END PROCESS;
	PROCESS
	BEGIN
		w_CLOCK <= '0';
		WAIT FOR 60 ns;
		w_CLOCK <= '1';
		WAIT FOR 60 ns;
	END PROCESS;
	-------------------------------------------------------------------------------------------------------------------------
END Behavioral;