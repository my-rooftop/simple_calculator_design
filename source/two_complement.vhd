library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 2's Complement의 엔티티 선언
entity two_complement is
    Port (
        vect_in    : in  STD_LOGIC_VECTOR(7 downto 0); 
        vect_out   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end two_complement;


-- 2's Complement의 아키텍처 구현
architecture Behavioral of two_complement is
begin
    vect_out <= vect_in XOR "11111111";

end Behavioral;