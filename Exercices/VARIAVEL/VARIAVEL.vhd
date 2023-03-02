LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY VARIAVEL IS
	PORT (
		i_CLK : IN STD_LOGIC;
		i_RST : IN STD_LOGIC;
		o_SINAL_1 : OUT STD_LOGIC;
		o_SINAL_2 : OUT STD_LOGIC
	);
END VARIAVEL;

ARCHITECTURE Behavioral OF VARIAVEL IS
	----------------------------------------------------------------------------------
	-- Internal signals.
	----------------------------------------------------------------------------------
	TYPE Estado IS (st_IDLE, st_ATUALIZA);

	ATTRIBUTE syn_encoding : STRING;
	ATTRIBUTE syn_encoding OF Estado : TYPE IS "safe";

	SIGNAL w_STATE : Estado;
	SIGNAL w_CONTADOR : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL w_SINAL : STD_LOGIC;
BEGIN

	----------------------------------------------------------------------------------
	-- State machine.

	--	process(i_RST, i_CLK)
	--		variable v_SINAL : std_logic;
	--		
	--	begin
	--		
	--		if (i_RST = '1') then
	--			w_CONTADOR <= (OTHERS => '0');
	--			w_SINAL <= '0';
	--			v_SINAL := '0';
	--			o_SINAL_1 <= '0';
	--			o_SINAL_2 <= '0';
	--			w_STATE <= st_IDLE;
	--			
	--		elsif rising_edge (i_CLK) then
	--			case w_STATE is
	--				when st_IDLE => 
	--					if (w_CONTADOR < X"A") then
	--						w_CONTADOR <= w_CONTADOR + 1;
	--						w_STATE <= st_IDLE;
	--					else
	--						w_CONTADOR <= (OTHERS => '0');
	--						w_STATE <= st_ATUALIZA;
	--					end if;
	--					
	--				when st_ATUALIZA =>
	--				
	--					w_SINAL <= NOT w_SINAL;
	--					o_SINAL_1 <= w_SINAL;
	--					
	--					v_SINAL := NOT v_SINAL;
	--					o_SINAL_2 <= v_SINAL;
	--					
	--					w_STATE <= st_IDLE;
	--			
	--				when others =>
	--					w_STATE <= st_IDLE;
	--					
	--				end case;
	--			end if;
	--		end process;	

	PROCESS (i_RST, i_CLK)
		VARIABLE v_SINAL : STD_LOGIC;

	BEGIN

		IF (i_RST = '1') THEN
			w_SINAL <= '0';
			v_SINAL := '0';
			o_SINAL_1 <= '0';
			o_SINAL_2 <= '0';

		ELSIF rising_edge (i_CLK) THEN

			w_SINAL <= NOT w_SINAL;
			o_SINAL_1 <= w_SINAL;

			v_SINAL := NOT v_SINAL;
			o_SINAL_2 <= v_SINAL;

		END IF;
	END PROCESS;

END Behavioral;