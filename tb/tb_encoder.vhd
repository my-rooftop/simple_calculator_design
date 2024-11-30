library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Encoder_tb is
-- Testbench does not have ports
end Encoder_tb;

architecture Behavioral of Encoder_tb is
    -- Component declaration
    component Encoder
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            vect_in1_expended : in STD_LOGIC_VECTOR(7 downto 0);
            vect_in2_expended : in STD_LOGIC_VECTOR(7 downto 0);
            vect_out : in STD_LOGIC_VECTOR(7 downto 0);
            Sel : in STD_LOGIC_VECTOR(1 downto 0);
            Sel_out_vector : out STD_LOGIC_VECTOR(2 downto 0);
            out_1 : out STD_LOGIC_VECTOR(3 downto 0); 
            out_2 : out STD_LOGIC_VECTOR(2 downto 0); 
            sign_vector : out STD_LOGIC;
            mag_A : out STD_LOGIC_VECTOR(3 downto 0);
            sign_A_vector : out STD_LOGIC;
            mag_B : out STD_LOGIC_VECTOR(3 downto 0);
            sign_B_vector : out STD_LOGIC;
            done : out STD_LOGIC
        );
    end component;

    -- Testbench signals
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal vect_in1_expended : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_expended : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Sel : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal Sel_out_vector : STD_LOGIC_VECTOR(2 downto 0);
    signal out_1 : STD_LOGIC_VECTOR(3 downto 0);
    signal out_2 : STD_LOGIC_VECTOR(2 downto 0);
    signal sign_vector : STD_LOGIC;
    signal mag_A : STD_LOGIC_VECTOR(3 downto 0);
    signal sign_A_vector : STD_LOGIC;
    signal mag_B : STD_LOGIC_VECTOR(3 downto 0);
    signal sign_B_vector : STD_LOGIC;
    signal done : STD_LOGIC;

    -- Clock period constant
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the DUT (Device Under Test)
    DUT: Encoder
        Port map (
            clk => clk,
            rst => rst,
            vect_in1_expended => vect_in1_expended,
            vect_in2_expended => vect_in2_expended,
            vect_out => vect_out,
            Sel => Sel,
            Sel_out_vector => Sel_out_vector,
            out_1 => out_1,
            out_2 => out_2,
            sign_vector => sign_vector,
            mag_A => mag_A,
            sign_A_vector => sign_A_vector,
            mag_B => mag_B,
            sign_B_vector => sign_B_vector,
            done => done
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Reset
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period;

        -- Test case 1: Positive numbers
        vect_in1_expended <= "00000011";  -- +3
        vect_in2_expended <= "00000101";  -- +5
        vect_out <= "00001010";          -- +10
        Sel <= "01";
        wait for 6 * clk_period;

        -- Reset
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait for clk_period;

        -- -- Test case 2: Negative vect_in1_expended
        -- vect_in1_expended <= "11111101";  -- -3
        -- vect_in2_expended <= "00000101";  -- +5
        -- vect_out <= "11111011";          -- -5
        -- Sel <= "10";
        -- wait for 6 * clk_period;

        -- -- Reset
        -- rst <= '1';
        -- wait for clk_period;
        -- rst <= '0';
        -- wait for clk_period;


        -- -- Test case 3: Negative vect_in2_expended
        -- vect_in1_expended <= "00000011";  -- +3
        -- vect_in2_expended <= "11111011";  -- -5
        -- vect_out <= "11111111";          -- -1
        -- Sel <= "11";
        -- wait for 6 * clk_period;

        -- -- Reset
        -- rst <= '1';
        -- wait for clk_period;
        -- rst <= '0';
        -- wait for clk_period;


        -- -- Test case 6: All negative
        -- vect_in1_expended <= "11111101";  -- -3
        -- vect_in2_expended <= "11111011";  -- -5
        -- vect_out <= "00000110";          -- +6
        -- Sel <= "00";
        -- wait for 6 * clk_period;

        -- Stop simulation
        wait;
    end process;

end Behavioral;