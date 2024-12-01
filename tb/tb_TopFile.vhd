library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_File_tb is
-- No ports for a testbench
end Top_File_tb;

architecture Behavioral of Top_File_tb is

    -- Component declaration
    component Top_File is
        port(
            Clk: in std_logic;
            Reset: in std_logic;
            Start: in std_logic;
            Done: out std_logic;
            A: in std_logic_vector(3 downto 0);
            B: in std_logic_vector (3 downto 0);
            Sel: in std_logic_vector(1 downto 0);
            a_to_g: out std_logic_vector(7 downto 0);
            an: out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals to connect to the UUT (Unit Under Test)
    signal Clk_tb : std_logic := '0';
    signal Reset_tb : std_logic := '0';
    signal Start_tb : std_logic := '0';
    signal Done_tb : std_logic;
    signal A_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal B_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal Sel_tb : std_logic_vector(1 downto 0) := "00";
    signal a_to_g_tb : std_logic_vector(7 downto 0);
    signal an_tb : std_logic_vector(7 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the UUT
    UUT: Top_File port map(
        Clk => Clk_tb,
        Reset => Reset_tb,
        Start => Start_tb,
        Done => Done_tb,
        A => A_tb,
        B => B_tb,
        Sel => Sel_tb,
        a_to_g => a_to_g_tb,
        an => an_tb
    );

    -- Clock generation
    Clk_Process : process
    begin
        Clk_tb <= '0';
        wait for clk_period / 2;
        Clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Testbench process
    Test_Process : process
    begin
        -- Initial reset
        Reset_tb <= '1';
        wait for clk_period * 2;
        Reset_tb <= '0';
        
        -- Test addition
        A_tb <= "0101";  -- A = 5
        B_tb <= "0011";  -- B = 3
        Sel_tb <= "00";  -- Select addition
        wait for clk_period * 10;

        -- Test subtraction
        A_tb <= "1001";  -- A = 9
        B_tb <= "0010";  -- B = 2
        Sel_tb <= "01";  -- Select subtraction
        wait for clk_period * 10;

        -- Test multiplication
        A_tb <= "0011";  -- A = 3
        B_tb <= "0100";  -- B = 4
        Sel_tb <= "10";  -- Select multiplication
        wait for clk_period * 10;

        -- Test invalid operation
        A_tb <= "0001";  -- A = 1
        B_tb <= "0001";  -- B = 1
        Sel_tb <= "11";  -- Invalid selection
        wait for clk_period * 10;

        -- End simulation
        wait;
    end process;

end Behavioral;