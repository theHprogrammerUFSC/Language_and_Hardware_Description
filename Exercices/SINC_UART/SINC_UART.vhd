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

ENTITY SINC_UART IS PORT (
	i_RST : IN STD_LOGIC;
	i_CLK : IN STD_LOGIC;
	--
	i_CLK_UART : IN STD_LOGIC;
	o_EDGE_UP : OUT STD_LOGIC;
	o_EDGE_DOWN : OUT STD_LOGIC
);
END SINC_UART;

ARCHITECTURE Behavioral OF SINC_UART IS
	----------------------------------------------------------------------------------------------
	-- Internal signals.
	----------------------------------------------------------------------------------------------
	SIGNAL w_CLK_R, w_CLK_S, w_CLK_T : STD_LOGIC;
	SIGNAL w_EDGE_UP, w_EDGE_DOWN : STD_LOGIC;

BEGIN
	----------------------------------------------------------------------------------------------
	-- Edge detector
	----------------------------------------------------------------------------------------------
	U1 : PROCESS (i_CLK, i_RST)
	BEGIN
		IF (i_RST = '1') THEN
			w_CLK_R <= '0';
			w_CLK_S <= '0';
			w_CLK_T <= '0';
		ELSIF rising_edge (i_CLK) THEN
			w_CLK_R <= i_CLK_UART;
			w_CLK_S <= w_CLK_R;
			w_CLK_T <= w_CLK_S;
		END IF;
	END PROCESS U1;

	-- Falling edge of the UART clock.
	o_EDGE_DOWN <= NOT(w_CLK_S) AND w_CLK_T;

	-- Rising edge of the UART clock.
	o_EDGE_UP <= w_CLK_S AND NOT(w_CLK_T);
	----------------------------------------------------------------------------------------------
END Behavioral;