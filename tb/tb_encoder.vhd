library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Encoder_tb is
-- No ports for testbench
end Encoder_tb;

architecture Behavioral of Encoder_tb is
    -- Component Declaration
    component Encoder
        Port (
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
            sign_B_vector : out STD_LOGIC
        );
    end component;

    -- Testbench Signals
    signal vect_in1_expended_tb : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_expended_tb : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_out_tb : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Sel_tb : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal Sel_out_vector_tb : STD_LOGIC_VECTOR(2 downto 0);
    signal out_1_tb : STD_LOGIC_VECTOR(3 downto 0); 
    signal out_2_tb : STD_LOGIC_VECTOR(2 downto 0); 
    signal sign_vector_tb : STD_LOGIC;
    signal mag_A_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal sign_A_vector_tb : STD_LOGIC;
    signal mag_B_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal sign_B_vector_tb : STD_LOGIC;

begin
    -- Instantiate Encoder
    DUT: Encoder
        Port map (
            vect_in1_expended => vect_in1_expended_tb,
            vect_in2_expended => vect_in2_expended_tb,
            vect_out => vect_out_tb,
            Sel => Sel_tb,
            Sel_out_vector => Sel_out_vector_tb,
            out_1 => out_1_tb,
            out_2 => out_2_tb,
            sign_vector => sign_vector_tb,
            mag_A => mag_A_tb,
            sign_A_vector => sign_A_vector_tb,
            mag_B => mag_B_tb,
            sign_B_vector => sign_B_vector_tb
        );

    -- Test Process
    process
    begin
        -- Test Case 1: Positive vect_in1 and vect_in2
        vect_in1_expended_tb <= "00001111"; -- +15
        vect_in2_expended_tb <= "00000101"; -- +5
        vect_out_tb <= "00010010";         -- +18
        Sel_tb <= "01";
        wait for 10 ns;

        -- Test Case 2: Negative vect_in1, Positive vect_in2
        vect_in1_expended_tb <= "11110001"; -- -15
        vect_in2_expended_tb <= "00000101"; -- +5
        vect_out_tb <= "11100011";         -- -29
        Sel_tb <= "10";
        wait for 10 ns;

        -- Test Case 3: Positive vect_in1, Negative vect_in2
        vect_in1_expended_tb <= "00001101"; -- +13
        vect_in2_expended_tb <= "11111011"; -- -5
        vect_out_tb <= "00000010";         -- +2
        Sel_tb <= "11";
        wait for 10 ns;

        -- Test Case 4: Negative vect_in1 and vect_in2
        vect_in1_expended_tb <= "11110110"; -- -10
        vect_in2_expended_tb <= "11110011"; -- -13
        vect_out_tb <= "11100101";         -- -23
        Sel_tb <= "00";
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;