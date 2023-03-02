-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
--
-- Componetização
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY FUNCAO_LOGICA IS
	PORT (
		i_A : IN STD_LOGIC;
		i_B : IN STD_LOGIC;
		i_C : IN STD_LOGIC;
		i_D : IN STD_LOGIC;
		i_E : IN STD_LOGIC;
		o_F : OUT STD_LOGIC;
		o_G : OUT STD_LOGIC
	);
END FUNCAO_LOGICA;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF FUNCAO_LOGICA IS

	--
	-- Declarando componente externo.
	--
	COMPONENT LOGICA_AND IS
		PORT (
			i_A : IN STD_LOGIC;
			i_B : IN STD_LOGIC;
			i_C : IN STD_LOGIC;
			i_D : IN STD_LOGIC;
			i_E : IN STD_LOGIC;
			o_C : OUT STD_LOGIC
		);
	END COMPONENT;

	--
	-- Declarando sinais internos
	--
	SIGNAL w_F : STD_LOGIC;

	-- ===========================================
BEGIN

	o_F <= w_F;
	--
	-- Instancialização de um componente lógico
	--
	U01 : LOGICA_AND
	PORT MAP(
		i_A => i_A,
		i_B => i_B,
		i_C => i_C,
		i_D => i_D,
		i_E => i_E,
		o_C => w_F
	);

	U02 : LOGICA_AND
	PORT MAP(
		i_A => i_B,
		i_B => i_C,
		i_C => i_D,
		i_D => i_E,
		i_E => w_F,
		o_C => o_G
	);

END Behavioral;