-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 26/06/2022
--
-- Implemente uma memória ROM com 1K células de memória, de 16 bits cada:
-------------------------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_ROM is
	generic (
		p_DATA_WIDTH : integer := 16; p_ADD_WIDTH : integer := 12);
end TB_ROM;

-------------------------------------------------------------------------------------------------------------------------
architecture Behavioral of TB_ROM is

	-- Declaração de Componentes
-------------------------------------------------------------------------------------------------------------------------
	component ROM is
		generic (
			p_DATA_WIDTH			: integer := 16;
			p_ADD_WIDTH				: integer := 12
		);
		port (
			-- Entradas
			i_ADD						: in	STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0);
			i_EN						: in	STD_LOGIC;
			i_RESET					: in 	STD_LOGIC;
			i_CLOCK					: in 	STD_LOGIC;
				
			-- Saídas
			o_DATA					: out	STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0)
		);
	end component;
-------------------------------------------------------------------------------------------------------------------------

	-- Declaração de sinais internos
-------------------------------------------------------------------------------------------------------------------------
	signal w_ADD			: STD_LOGIC_VECTOR((p_ADD_WIDTH - 1) DOWNTO 0);
	signal w_EN				: STD_LOGIC;
	signal w_RST			: STD_LOGIC;
	signal w_CLOCK			: STD_LOGIC;
	signal w_DATA			: STD_LOGIC_VECTOR((p_DATA_WIDTH - 1) DOWNTO 0);

-------------------------------------------------------------------------------------------------------------------------

begin

	--Instancialização da ROM
-------------------------------------------------------------------------------------------------------------------------
	UROM : ROM
		generic map (
			p_DATA_WIDTH			=> 16,
			p_ADD_WIDTH				=> 12
		)
		port map (
			-- Entradas
			i_ADD						=> w_ADD,
			i_EN						=> w_EN,
			i_RESET					=> w_RST,
			i_CLOCK					=> w_CLOCK,
				
			-- Saídas
			o_DATA					=> w_DATA
		);
-------------------------------------------------------------------------------------------------------------------------

	-- Teste
-------------------------------------------------------------------------------------------------------------------------
	
	-- Teste de Reset
	process
	begin
		w_RST <= '1';
		wait for 40 ns;
		w_RST <= '0';
		wait;
	end process;
	
	-- Teste de Clock
	process
	begin
		w_CLOCK <= '0';
		wait for 20 ns;
		w_CLOCK <= '1';
		wait for 20 ns;
	end process;
	
	-- Teste de Enable
	process
	begin
		w_EN <= '0';
		wait for 40 ns;
		w_EN <= '1';
		wait;
	end process;
	
	-- Teste de Endereço
	process
	begin
		w_ADD <= x"000";
		wait for 80 ns;
		
		w_ADD <= x"001";
		wait for 40 ns;
		
		w_ADD <= x"002";
		wait for 40 ns;
		
		w_ADD <= x"003";
		wait for 40 ns;
		
		w_ADD <= x"004";
		wait for 40 ns;
		
		w_ADD <= x"005";
		wait for 40 ns;
		
		w_ADD <= x"006";
		wait for 40 ns;
		
		w_ADD <= x"007";
		wait for 40 ns;
		
		w_ADD <= x"008";
		wait for 40 ns;
		
		w_ADD <= x"009";
		wait for 40 ns;
		
		w_ADD <= x"00A";
		wait for 40 ns;
		
		w_ADD <= x"00B";
		wait for 40 ns;
		
		w_ADD <= x"00C";
		wait for 40 ns;
		
		w_ADD <= x"00D";
		wait for 40 ns;
		
		w_ADD <= x"00E";
		wait for 40 ns;
		
		w_ADD <= x"00F";
		wait for 40 ns;
		
		w_ADD <= x"010";
		wait for 40 ns;
		
		w_ADD <= x"011";
		wait for 40 ns;
		
		w_ADD <= x"012";
		wait for 40 ns;
		
		w_ADD <= x"013";
		wait for 40 ns;
		
		w_ADD <= x"014";
		wait for 40 ns;
		
		w_ADD <= x"015";
		wait for 40 ns;
		
		w_ADD <= x"016";
		wait for 40 ns;
		
		w_ADD <= x"017";
		wait for 40 ns;
		
		w_ADD <= x"018";
		wait for 40 ns;
		
		w_ADD <= x"019";
		wait for 40 ns;
		
		w_ADD <= x"01A";
		wait for 40 ns;
		
		w_ADD <= x"01B";
		wait for 40 ns;
		
		w_ADD <= x"01C";
		wait for 40 ns;
		
		w_ADD <= x"01D";
		wait for 40 ns;
		
		w_ADD <= x"01E";
		wait for 40 ns;
		
		w_ADD <= x"01F";
		wait;
	end process;
-------------------------------------------------------------------------------------------------------------------------



end Behavioral;