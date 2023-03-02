--*************************************************************************************
--
-- Module   :  PAR2SER
-- Inputs   :
--			      	i_CLK		--> Global system clock.
--			      	i_RST 		--> Assynchronous reset for the FPGA.
--			      	i_DATA    	--> Eight bits word to be serialized.
--					i_LOAD		--> Pulse to load the serializer with an 8 bit word.
--					i_ND		--> Pulse informing the serializer to send a new bit into 
--                             the serial uart (TX).
-- Outputs:
--         			o_TX     	--> Serialized data.
--
--*************************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_PAR2SER IS
END TB_PAR2SER;

ARCHITECTURE Behavioral OF TB_PAR2SER IS
	----------------------------------------------------------------------------------------------
	-- Internal signals.
	----------------------------------------------------------------------------------------------
	COMPONENT PAR2SER IS PORT (
		i_RST : IN STD_LOGIC;
		i_CLK : IN STD_LOGIC;
		--
		i_LOAD : IN STD_LOGIC;
		i_ND : IN STD_LOGIC;
		i_DATA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_TX : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL w_CLK : STD_LOGIC;
	SIGNAL w_RST : STD_LOGIC;
	SIGNAL w_LOAD : STD_LOGIC;
	SIGNAL w_ND : STD_LOGIC;
	SIGNAL w_DATA : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL w_TX : STD_LOGIC;

	----------------------------------------------------------------------------------------------
BEGIN

	UUT : PAR2SER
	PORT MAP(
		i_RST => w_RST,
		i_CLK => w_CLK,
		i_LOAD => w_LOAD,
		i_ND => w_ND,
		i_DATA => w_DATA,
		o_TX => w_TX
	);

	PROCESS
	BEGIN
		w_CLK <= '1';
		WAIT FOR 10 ns;
		w_clk <= '0';
		WAIT FOR 10 ns;
	END PROCESS;

	PROCESS
	BEGIN
		w_RST <= '1';
		WAIT FOR 40 ns;
		w_RST <= '0';
		WAIT;
	END PROCESS;

	PROCESS
	BEGIN
		w_LOAD <= '0';
		w_ND <= '0';
		w_DATA <= (OTHERS => '0');

		WAIT FOR 50 ns;

		w_DATA <= x"55";
		w_LOAD <= '1';
		WAIT FOR 20 ns;
		w_LOAD <= '0';

		w_ND <= '1';
		WAIT FOR 20 ns;
		w_ND <= '0';
		WAIT FOR 50 ns;

		w_ND <= '1';
		WAIT FOR 20 ns;
		w_ND <= '0';
		WAIT FOR 50 ns;

		w_ND <= '1';
		WAIT FOR 20 ns;
		w_ND <= '0';
		WAIT FOR 50 ns;

		w_ND <= '1';
		WAIT FOR 20 ns;
		w_ND <= '0';
		WAIT FOR 50 ns;

		w_ND <= '1';
		WAIT FOR 20 ns;
		w_ND <= '0';
		WAIT FOR 50 ns;

		w_ND <= '1';
		WAIT FOR 20 ns;
		w_ND <= '0';
		WAIT FOR 50 ns;

		w_ND <= '1';
		WAIT FOR 20 ns;
		w_ND <= '0';
		WAIT FOR 50 ns;

		w_ND <= '1';
		WAIT FOR 20 ns;
		w_ND <= '0';
		WAIT FOR 50 ns;

		WAIT;
	END PROCESS;

	----------------------------------------------------------------------------------------------
END Behavioral;