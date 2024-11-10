library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           SUM : out STD_LOGIC;
           CARRY : out STD_LOGIC);
end half_adder;

architecture Behavioral of half_adder is
begin
    -- XOR for SUM
    SUM <= A XOR B;
    -- AND for CARRY
    CARRY <= A AND B;
end Behavioral;