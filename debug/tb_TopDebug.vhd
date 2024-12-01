library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Top_File_tb is
end Top_File_tb;

architecture Behavioral of Top_File_tb is
    -- Component Declaration
    component Top_File
        port(Clk: in std_logic;
             Reset: in std_logic;
             Start: in std_logic;
             Done: out std_logic;
             A: in std_logic_vector(3 downto 0);
             B: in std_logic_vector(3 downto 0);
             Sel: in std_logic_vector(1 downto 0);
             a_to_g: out std_logic_vector(7 downto 0);
             an: out std_logic_vector(7 downto 0);
             debug_x_inter: out std_logic_vector(20 downto 0)
        );
    end component;
    
    -- Signal Declaration
    signal Clk_tb : std_logic := '0';
    signal Reset_tb : std_logic := '0';
    signal Start_tb : std_logic := '0';
    signal Done_tb : std_logic;
    signal A_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal B_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal Sel_tb : std_logic_vector(1 downto 0) := (others => '0');
    signal a_to_g_tb : std_logic_vector(7 downto 0);
    signal an_tb : std_logic_vector(7 downto 0);
    signal debug_x_inter_tb : std_logic_vector(20 downto 0);
    
    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Top_File port map (
        Clk => Clk_tb,
        Reset => Reset_tb,
        Start => Start_tb,
        Done => Done_tb,
        A => A_tb,
        B => B_tb,
        Sel => Sel_tb,
        a_to_g => a_to_g_tb,
        an => an_tb,
        debug_x_inter => debug_x_inter_tb
    );
    
    -- Clock process
    Clk_process: process
    begin
        Clk_tb <= '0';
        wait for CLK_PERIOD/2;
        Clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- -- Initialize inputs
        -- Reset_tb <= '1';
        -- wait for CLK_PERIOD*2;
        -- Reset_tb <= '0';
        -- wait for CLK_PERIOD;
        
        -- -- Test Addition (Sel = "00")
        -- A_tb <= "1101";  -- 5
        -- B_tb <= "1001";  -- 3
        -- Sel_tb <= "00";
        -- Start_tb <= '1';
        -- wait for CLK_PERIOD;
        -- Start_tb <= '0';
        -- wait until Done_tb = '1';
        -- wait for CLK_PERIOD*2;

        -- -- Initialize inputs
        -- Reset_tb <= '1';
        -- wait for CLK_PERIOD*2;
        -- Reset_tb <= '0';
        -- wait for CLK_PERIOD;
        
        -- -- Test Subtraction (Sel = "01")
        -- A_tb <= "0110";  -- 6
        -- B_tb <= "0010";  -- 2
        -- Sel_tb <= "01";
        -- Start_tb <= '1';
        -- wait for CLK_PERIOD;
        -- Start_tb <= '0';
        -- wait until Done_tb = '1';
        -- wait for CLK_PERIOD*2;

        -- Initialize inputs
        Reset_tb <= '1';
        wait for CLK_PERIOD*2;
        Reset_tb <= '0';
        wait for CLK_PERIOD;
        
        -- Test Multiplication (Sel = "10")
        A_tb <= "1011";  -- 3
        B_tb <= "0110";  -- 2
        Sel_tb <= "10";
        Start_tb <= '1';
        wait for CLK_PERIOD;
        Start_tb <= '0';
        wait until Done_tb = '1';
        wait for CLK_PERIOD*40;
        
        -- End simulation
        wait for CLK_PERIOD*10;
        assert false report "Simulation Completed Successfully" severity failure;
        
        wait;
    end process;
    
    -- Monitor process to display debug_x_inter values
    monitor_proc: process(Clk_tb)
    begin
        if rising_edge(Clk_tb) then
            report "debug_x_inter = " & 
                   "Sign_A: " & std_logic'image(debug_x_inter_tb(20)) &
                   ", Mag_A: " & integer'image(to_integer(unsigned(debug_x_inter_tb(19 downto 16)))) &
                   ", Sign_B: " & std_logic'image(debug_x_inter_tb(15)) &
                   ", Mag_B: " & integer'image(to_integer(unsigned(debug_x_inter_tb(14 downto 11)))) &
                   ", Sign: " & std_logic'image(debug_x_inter_tb(10)) &
                   ", Out_1: " & integer'image(to_integer(unsigned(debug_x_inter_tb(6 downto 3)))) &
                   ", Out_2: " & integer'image(to_integer(unsigned(debug_x_inter_tb(9 downto 7)))) &
                   ", Sel: " & integer'image(to_integer(unsigned(debug_x_inter_tb(2 downto 0))));
        end if;
    end process;
    
end Behavioral;
