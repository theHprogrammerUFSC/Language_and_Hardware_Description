-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CONTADOR IS
	GENERIC (
		p_DATA : INTEGER := 28;
		p_CONTAGEM : INTEGER := 50000000;
		p_DIGITOS : INTEGER := 9;
		p_WNUMERO : INTEGER := 4
	);
	PORT (

		i_RST : IN STD_LOGIC;
		i_CLK : IN STD_LOGIC;
		i_contagem : IN STD_LOGIC_VECTOR (p_DATA - 1 DOWNTO 0);
		o_segundo : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0); -- Max = 9
		o_dsegundo : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0); -- Max = 5
		o_minuto : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0); -- Max = 9
		o_dminuto : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0); -- Max = 5
		o_hora : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0); -- Max = 2
		o_dhora : OUT STD_LOGIC_VECTOR (p_WNUMERO - 1 DOWNTO 0) -- Max = 3
	);
END CONTADOR;

-------------------------------------------------------------------------------------------------------------------------

ARCHITECTURE Behavioral OF CONTADOR IS
	SIGNAL w_LIMITE : STD_LOGIC_VECTOR(i_CONTAGEM'RANGE);

BEGIN
	w_LIMITE <= STD_LOGIC_VECTOR(to_unsigned(p_CONTAGEM, w_LIMITE'length));

	PROCESS (i_RST, i_CLK)
		VARIABLE v_segundo : STD_LOGIC_VECTOR (o_segundo'RANGE);
		VARIABLE v_dsegundo : STD_LOGIC_VECTOR (o_dsegundo'RANGE);
		VARIABLE v_minuto : STD_LOGIC_VECTOR (o_minuto'RANGE);
		VARIABLE v_dminuto : STD_LOGIC_VECTOR (o_dminuto'RANGE);
		VARIABLE v_hora : STD_LOGIC_VECTOR (o_hora'RANGE);
		VARIABLE v_dhora : STD_LOGIC_VECTOR (o_dhora'RANGE);
	BEGIN

		-- Verificação do Reset
		IF (i_RST = '1') THEN
			v_segundo := (OTHERS => '0');
			v_dsegundo := (OTHERS => '0');
			v_minuto := (OTHERS => '0');
			v_dminuto := (OTHERS => '0');
			v_hora := (OTHERS => '0');
			v_dhora := (OTHERS => '0');

			-- Se o clock estiver na borda de subida faz o incremento do número
		ELSIF rising_edge (i_CLK) THEN
			IF (i_CONTAGEM = w_LIMITE) THEN
				v_segundo := v_segundo + 1;
			END IF;

			-- Se a unidade de segundo for maior que 9 ela volta para 0 e incrementa a dezena de segundo
			IF (v_segundo > STD_LOGIC_VECTOR(to_unsigned(p_DIGITOS, v_segundo'length))) THEN
				v_segundo := (OTHERS => '0');
				o_segundo <= v_segundo;
				v_dsegundo := v_dsegundo + 1;
				o_dsegundo <= v_dsegundo;

				-- Se a dezena de segundo for maior que 5 ela volta para 0 e incrementa a unidade de minuto
			ELSIF (v_dsegundo > STD_LOGIC_VECTOR(to_unsigned((p_DIGITOS - 4), v_dsegundo'length))) THEN
				v_dsegundo := (OTHERS => '0');
				o_dsegundo <= v_dsegundo;
				v_minuto := v_minuto + 1;
				o_minuto <= v_minuto;

				-- Se a unidade de minuto for maior que 9 ela volta para 0 e incrementa a dezena de minuto
			ELSIF (v_minuto > STD_LOGIC_VECTOR(to_unsigned(p_DIGITOS, v_minuto'length))) THEN
				v_minuto := (OTHERS => '0');
				o_minuto <= v_minuto;
				v_dminuto := v_dminuto + 1;
				o_dminuto <= v_dminuto;

				-- Se a dezena de minuto for maior que 5 ela volta para 0 e incrementa a unidade de hora
			ELSIF (v_dminuto > STD_LOGIC_VECTOR(to_unsigned((p_DIGITOS - 4), v_dminuto'length))) THEN
				v_dminuto := (OTHERS => '0');
				o_dminuto <= v_dminuto;
				v_hora := v_hora + 1;
				o_hora <= v_hora;

				-- Se a unidade de hora for maior que 9 ela volta para 0 e incrementa a dezena de hora
			ELSIF (v_hora > STD_LOGIC_VECTOR(to_unsigned(p_DIGITOS, v_hora'length))) THEN
				v_hora := (OTHERS => '0');
				o_hora <= v_hora;
				v_dhora := v_dhora + 1;
				o_dhora <= v_dhora;

				-- Se a dezena de hora for igual a 2 e a unidade de hora igual a 3 tudo é zerado
			ELSIF (v_dhora >= STD_LOGIC_VECTOR(to_unsigned((p_DIGITOS - 7), v_dhora'length))) THEN
				IF (v_hora >= STD_LOGIC_VECTOR(to_unsigned((p_DIGITOS - 5), v_hora'length))) THEN
					v_dhora := (OTHERS => '0');
					o_dhora <= v_dhora;
					v_hora := (OTHERS => '0');
					o_hora <= v_hora;
					v_dminuto := (OTHERS => '0');
					o_dminuto <= v_dminuto;
					v_minuto := (OTHERS => '0');
					o_minuto <= v_minuto;
					v_dsegundo := (OTHERS => '0');
					o_dsegundo <= v_dsegundo;
					v_segundo := (OTHERS => '0');
					o_segundo <= v_segundo;
				END IF;
			ELSE
				o_segundo <= v_segundo;
				o_dsegundo <= v_dsegundo;
				o_minuto <= v_minuto;
				o_dminuto <= v_dminuto;
				o_hora <= v_hora;
				o_dhora <= v_dhora;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;