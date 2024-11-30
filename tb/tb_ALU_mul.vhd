library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_mul_debug_tb is
end ALU_mul_debug_tb;

architecture Behavioral of ALU_mul_debug_tb is
    -- Component Declaration
    component ALU_mul
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            vect_in1 : in STD_LOGIC_VECTOR(3 downto 0);
            vect_in2 : in STD_LOGIC_VECTOR(3 downto 0);
            vect_in1_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
            vect_in2_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
            vect_out : out STD_LOGIC_VECTOR(7 downto 0);
            done : out STD_LOGIC
        );
    end component;

    -- Signal Declaration
    signal clk_tb : STD_LOGIC := '0';
    signal rst_tb : STD_LOGIC := '0';
    signal vect_in1_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal vect_in2_tb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal vect_out_expended1_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_out_expended2_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_out_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal done_tb : STD_LOGIC;

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: ALU_mul port map (
        clk => clk_tb,
        rst => rst_tb,
        vect_in1 => vect_in1_tb,
        vect_in2 => vect_in2_tb,
        vect_in1_expended_out => vect_out_expended1_tb,
        vect_in2_expended_out => vect_out_expended2_tb,
        vect_out => vect_out_tb,
        done => done_tb
    );

    -- Clock process
    clk_process: process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD/2;
        clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- -- Initialize inputs
        -- rst_tb <= '1';
        -- wait for CLK_PERIOD*2;
        
        -- -- Release reset
        -- rst_tb <= '0';
        -- wait for CLK_PERIOD;

        -- -- Test Case 1: Positive numbers
        -- vect_in1_tb <= "0101"; -- 5 in decimal
        -- vect_in2_tb <= "0011"; -- 3 in decimal
        -- wait for CLK_PERIOD*40; -- Wait for operation to complete

        -- rst_tb <= '1';
        -- wait for CLK_PERIOD*2;
        
        -- -- Release reset
        -- rst_tb <= '0';
        -- wait for CLK_PERIOD;

        -- -- Test Case 1: Positive numbers
        -- vect_in1_tb <= "1000"; -- 5 in decimal
        -- vect_in2_tb <= "0011"; -- 3 in decimal
        -- wait for CLK_PERIOD*40; -- Wait for operation to complete

        -- rst_tb <= '1';
        -- wait for CLK_PERIOD*2;
        
        -- -- Release reset
        -- rst_tb <= '0';
        -- wait for CLK_PERIOD;

        -- -- Test Case 1: Positive numbers
        -- vect_in1_tb <= "0001"; -- 5 in decimal
        -- vect_in2_tb <= "1101"; -- 3 in decimal
        -- wait for CLK_PERIOD*60; -- Wait for operation to complete

        rst_tb <= '1';
        wait for CLK_PERIOD*2;
        
        -- Release reset
        rst_tb <= '0';
        wait for CLK_PERIOD;

        -- Test Case 1: Positive numbers
        vect_in1_tb <= "1010"; -- 5 in decimal
        vect_in2_tb <= "1000"; -- 3 in decimal
        wait for CLK_PERIOD*40; -- Wait for operation to complete

        -- End simulation
        wait for CLK_PERIOD*10;
        assert false report "Simulation Completed Successfully" severity failure;
        
        wait;
    end process;

    -- Monitor process to display results
    monitor_proc: process(clk_tb)
    begin
        if rising_edge(clk_tb) and done_tb = '1' then
            report "Input1: " & integer'image(to_integer(signed(vect_in1_tb))) &
                   " Input2: " & integer'image(to_integer(signed(vect_in2_tb))) &
                   " Output: " & integer'image(to_integer(signed(vect_out_tb)));
        end if;
    end process;

end Behavioral;