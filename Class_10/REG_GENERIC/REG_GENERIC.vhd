-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Crie um registrador utilizando a declaração GENERIC. O valor do tamanho de dados do registrador deve ser de 8 (oito) bits.
-- Instancialize 2 (duas) vezes o componente “registrador” criado no exercício anterior (em um novo projeto). Use para 
-- este novo projeto uma declaração GENERIC na qual o valor do tamanho de dados do registrador deve ser de 16 (dezeseis) bits 
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY REG_GENERIC IS
GENERIC (
	N : INTEGER := 16
);

PORT (
	i_RESET : IN STD_LOGIC;
	i_CLOCK : IN STD_LOGIC;
	i_LOAD : IN STD_LOGIC;
	i_DATA : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
	o_DATA : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0)
);
END REG_GENERIC;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF REG_GENERIC IS

COMPONENT REGISTRADOR IS
	GENERIC (
		n : INTEGER := 16
	);

	PORT (
		i_RESET : IN STD_LOGIC;
		i_CLOCK : IN STD_LOGIC;
		i_LOAD : IN STD_LOGIC;
		i_DATA : IN STD_LOGIC_VECTOR((n - 1) DOWNTO 0);
		o_DATA : OUT STD_LOGIC_VECTOR((n - 1) DOWNTO 0)
	);
END COMPONENT;

BEGIN

U01 : REGISTRADOR
GENERIC MAP(
	n => 8
)

PORT MAP(
	i_RESET => i_RESET,
	i_CLOCK => i_CLOCK,
	i_LOAD => i_LOAD,
	i_DATA => i_DATA(15 DOWNTO 8),
	o_DATA => o_DATA(15 DOWNTO 8)
);

-------------------------------------------------------------------------------------------------------------------------

U02 : REGISTRADOR
GENERIC MAP(
	n => 8
)

PORT MAP(
	i_RESET => i_RESET,
	i_CLOCK => i_CLOCK,
	i_LOAD => i_LOAD,
	i_DATA => i_DATA(7 DOWNTO 0),
	o_DATA => o_DATA(7 DOWNTO 0)
);

END Behavioral;