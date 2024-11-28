library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 8비트 Adder의 엔티티 선언
entity adder_8bit is
    Port (
        vect_in1 : in STD_LOGIC_VECTOR(7 downto 0); -- 첫 번째 8비트 입력
        vect_in2 : in STD_LOGIC_VECTOR(7 downto 0); -- 두 번째 8비트 입력
        vect_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end adder_8bit;

architecture Behavioral of adder_8bit is
    signal Carry : STD_LOGIC_VECTOR(8 downto 0);
begin
    Carry(0) <= '0';
    FA0: entity work.full_adder port map(A => vect_in1(0), B => vect_in2(0), Cin => Carry(0), Sum => vect_out(0), Cout => Carry(1));
    FA1: entity work.full_adder port map(A => vect_in1(1), B => vect_in2(1), Cin => Carry(1), Sum => vect_out(1), Cout => Carry(2));
    FA2: entity work.full_adder port map(A => vect_in1(2), B => vect_in2(2), Cin => Carry(2), Sum => vect_out(2), Cout => Carry(3));
    FA3: entity work.full_adder port map(A => vect_in1(3), B => vect_in2(3), Cin => Carry(3), Sum => vect_out(3), Cout => Carry(4));
    FA4: entity work.full_adder port map(A => vect_in1(4), B => vect_in2(4), Cin => Carry(4), Sum => vect_out(4), Cout => Carry(5));
    FA5: entity work.full_adder port map(A => vect_in1(5), B => vect_in2(5), Cin => Carry(5), Sum => vect_out(5), Cout => Carry(6));
    FA6: entity work.full_adder port map(A => vect_in1(6), B => vect_in2(6), Cin => Carry(6), Sum => vect_out(6), Cout => Carry(7));
    FA7: entity work.full_adder port map(A => vect_in1(7), B => vect_in2(7), Cin => Carry(7), Sum => vect_out(7), Cout => Carry(8));

end Behavioral;