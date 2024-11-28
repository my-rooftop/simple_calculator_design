library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity signed_expander is
    Port (
        vect_in    : in  STD_LOGIC_VECTOR(3 downto 0); 
        vect_out   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end signed_expander;

architecture Behavioral of signed_expander is
begin
    vect_out(3 downto 0) <= vect_in;
    vect_out(7 downto 4) <= vect_in(3);
end Behavioral;