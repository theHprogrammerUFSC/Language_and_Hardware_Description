--*************************************************************************************
--
-- Module   :  SINC_UART
-- Inputs   :
--			    i_CLK			--> Global system clock.
--			    i_RST 		--> Assynchronous reset for the FPGA.
--			    i_CLK_UART 	--> Reference signal for the UART. It comes from the PLL.
-- Outputs:
--         		o_EDGE_UP	--> Pulse informing the rising edge of the UART clock.
--		        o_EDGE_DOWN	--> Pulse informing the falling edge of the UART clock.
--
--
--	Timing diagram:
--
--			                     /---\		 /---\	     /---\	     /---\       
--			i_CLK_UART	 <------/     \-----/     \-----/     \-----/     \-----
--
--                                  |            |           |           | 
--       	o_EDGE_DOWN <-----------|------------|-----------|-----------|-----
--
--                              |           |           |           |
--        	O_EDGE_UP <---------|-----------|-----------|-----------|----------
--
--*************************************************************************************

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_SINC_UART IS
END TB_SINC_UART;

ARCHITECTURE Behavioral OF TB_SINC_UART IS
	----------------------------------------------------------------------------------------------
	-- Internal signals.
	----------------------------------------------------------------------------------------------

	COMPONENT SINC_UART IS
		PORT (
			i_RST : IN STD_LOGIC;
			i_CLK : IN STD_LOGIC;
			--
			i_CLK_UART : IN STD_LOGIC;
			o_EDGE_UP : OUT STD_LOGIC;
			o_EDGE_DOWN : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL w_RST : STD_LOGIC;
	SIGNAL w_CLK : STD_LOGIC;
	SIGNAL w_CLK_UART : STD_LOGIC;
	SIGNAL w_EDGE_UP : STD_LOGIC;
	SIGNAL w_EDGE_DOWN : STD_LOGIC;

BEGIN
	----------------------------------------------------------------------------------------------

	UUT : SINC_UART
	PORT MAP(
		i_RST => w_RST,
		i_CLK => w_CLK,
		i_CLK_UART => w_CLK_UART,
		o_EDGE_UP => w_EDGE_UP,
		o_EDGE_DOWN => w_EDGE_DOWN
	);

	PROCESS
	BEGIN
		w_RST <= '1';
		WAIT FOR 40 ns;
		w_RST <= '0';
		WAIT;
	END PROCESS;

	PROCESS
	BEGIN
		w_CLK <= '1';
		WAIT FOR 10 ns;
		w_CLK <= '0';
		WAIT FOR 10 ns;
	END PROCESS;

	PROCESS
	BEGIN
		w_CLK_UART <= '1';
		WAIT FOR 90 ns;
		w_CLK_UART <= '0';
		WAIT FOR 90 ns;
	END PROCESS;

	----------------------------------------------------------------------------------------------
END Behavioral;