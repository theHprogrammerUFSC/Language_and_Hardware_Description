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

ENTITY PAR2SER IS PORT (
	i_RST : IN STD_LOGIC;
	i_CLK : IN STD_LOGIC;
	--
	i_LOAD : IN STD_LOGIC;
	i_ND : IN STD_LOGIC;
	i_DATA : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	o_TX : OUT STD_LOGIC
);
END PAR2SER;

ARCHITECTURE Behavioral OF PAR2SER IS
	----------------------------------------------------------------------------------------------
	-- Internal signals.
	----------------------------------------------------------------------------------------------
	SIGNAL w_DATA : STD_LOGIC_VECTOR (i_DATA'RANGE);
	SIGNAL w_ND : STD_LOGIC;

	----------------------------------------------------------------------------------------------
BEGIN
	----------------------------------------------------------------------------------------------
	-- Serializer (MSB first).
	----------------------------------------------------------------------------------------------
	U1 : PROCESS (i_CLK, i_RST)
	BEGIN
		IF (i_RST = '1') THEN
			w_ND <= '0';

		ELSIF falling_edge(i_CLK) THEN
			IF (i_ND = '1') THEN
				o_TX <= w_DATA(7);
				w_ND <= '1';
			ELSE
				w_ND <= '0';
			END IF;
		END IF;

	END PROCESS U1;

	--
	-- Loading (or Shifting) the data into the serializer.
	--
	U2 : PROCESS (i_CLK)
	BEGIN

		IF rising_edge(i_CLK) THEN
			IF (i_LOAD = '1') THEN
				w_DATA <= i_DATA;

			ELSIF (w_ND = '1') THEN
				w_DATA <= w_DATA(6 DOWNTO 0) & '0';
			END IF;
		END IF;

	END PROCESS U2;

	----------------------------------------------------------------------------------------------
END Behavioral;