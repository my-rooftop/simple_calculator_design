library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Test bench entity
entity full_adder_tb is
end full_adder_tb;

architecture Behavioral of full_adder_tb is

    -- Component declaration for the Full Adder
    component full_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    -- Test signals
    signal A    : STD_LOGIC := '0';
    signal B    : STD_LOGIC := '0';
    signal Cin  : STD_LOGIC := '0';
    signal Sum  : STD_LOGIC;
    signal Cout : STD_LOGIC;

begin

    -- Instantiate the Full Adder
    uut: full_adder
        Port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => Sum,
            Cout => Cout
        );

    -- Test process
    process
    begin
        -- Test case 1: A=0, B=0, Cin=0 -> Sum=0, Cout=0
        A <= '0'; B <= '0'; Cin <= '0';
        wait for 10 ns;
        
        -- Test case 2: A=0, B=0, Cin=1 -> Sum=1, Cout=0
        A <= '0'; B <= '0'; Cin <= '1';
        wait for 10 ns;
        
        -- Test case 3: A=0, B=1, Cin=0 -> Sum=1, Cout=0
        A <= '0'; B <= '1'; Cin <= '0';
        wait for 10 ns;
        
        -- Test case 4: A=0, B=1, Cin=1 -> Sum=0, Cout=1
        A <= '0'; B <= '1'; Cin <= '1';
        wait for 10 ns;
        
        -- Test case 5: A=1, B=0, Cin=0 -> Sum=1, Cout=0
        A <= '1'; B <= '0'; Cin <= '0';
        wait for 10 ns;
        
        -- Test case 6: A=1, B=0, Cin=1 -> Sum=0, Cout=1
        A <= '1'; B <= '0'; Cin <= '1';
        wait for 10 ns;
        
        -- Test case 7: A=1, B=1, Cin=0 -> Sum=0, Cout=1
        A <= '1'; B <= '1'; Cin <= '0';
        wait for 10 ns;
        
        -- Test case 8: A=1, B=1, Cin=1 -> Sum=1, Cout=1
        A <= '1'; B <= '1'; Cin <= '1';
        wait for 10 ns;
        
        -- Stop simulation
        wait;
    end process;

end Behavioral;