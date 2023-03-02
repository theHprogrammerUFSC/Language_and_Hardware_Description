-------------------------------------------------------------------------------------------------------------------------
-- Author: Helder Henrique da Silva
-- Date: 22/06/2022
-------------------------------------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TB_CRONOMETRO IS
END TB_CRONOMETRO;
ARCHITECTURE Behavioral OF TB_CRONOMETRO IS

    COMPONENT TOP_CRONOMETRO IS
        GENERIC (
            p_WNUMERO : INTEGER := 4
        );
        PORT (
            i_CLK : IN STD_LOGIC;
            i_RST : IN STD_LOGIC;
            i_START : IN STD_LOGIC;
            i_STOP : IN STD_LOGIC;
            i_CLEAR : IN STD_LOGIC;
            --o_CONTADOR	: out STD_LOGIC_VECTOR (27 DOWNTO 0);
            o_SEG_0 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            o_SEG_1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            o_SEG_2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            o_SEG_3 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            o_SEG_4 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            o_SEG_5 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            o_LED : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL w_CLK : STD_LOGIC;
    SIGNAL w_RST : STD_LOGIC;
    SIGNAL w_START : STD_LOGIC;
    SIGNAL w_STOP : STD_LOGIC;
    SIGNAL w_CLEAR : STD_LOGIC;
    SIGNAL w_o_SEG_0 : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL w_o_SEG_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL w_o_SEG_2 : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL w_o_SEG_3 : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL w_o_SEG_4 : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL w_o_SEG_5 : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL w_LED : STD_LOGIC;

    -------------------------------------------------------------------------------------------------------------------------

BEGIN

    UUT : TOP_CRONOMETRO
    GENERIC MAP(
        p_WNUMERO => 4
    )
    PORT MAP(
        i_CLK => w_CLK,
        i_RST => w_RST,
        i_START => w_START,
        i_STOP => w_STOP,
        i_CLEAR => w_CLEAR,
        o_SEG_0 => w_o_SEG_0,
        o_SEG_1 => w_o_SEG_1,
        o_SEG_2 => w_o_SEG_2,
        o_SEG_3 => w_o_SEG_3,
        o_SEG_4 => w_o_SEG_4,
        o_SEG_5 => w_o_SEG_5,
        o_LED => w_LED
    );

    ---
    -- TESTE DE RELÓGIO
    ---
    PROCESS
    BEGIN
        w_CLK <= '0';
        WAIT FOR 10 ns;
        w_CLK <= '1';
        WAIT FOR 10 ns;
    END PROCESS;

    ---
    -- CIRCUITO DE RESET
    ---
    PROCESS
    BEGIN
        w_RST <= '1';
        WAIT FOR 100 ns;
        w_RST <= '0';
        WAIT;
    END PROCESS;

    ---
    -- TESTE DE CRONOMETRO
    ---
    PROCESS
    BEGIN
        w_START <= '0';
        w_STOP <= '0';
        w_CLEAR <= '0';
        WAIT FOR 150 ns;

        w_START <= '1';
        WAIT;

    END PROCESS;

END Behavioral;