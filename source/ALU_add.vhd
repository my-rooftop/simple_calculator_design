library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 8비트 Adder의 엔티티 선언
entity ALU_add is
    Port (
        vect_in1 : in STD_LOGIC_VECTOR(3 downto 0); -- 첫 번째 8비트 입력
        vect_in2 : in STD_LOGIC_VECTOR(3 downto 0); -- 두 번째 8비트 입력
        vect_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end ALU_add;

architecture Behavioral of ALU_add is
    signal vect_in1_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in2_expended : STD_LOGIC_VECTOR(7 downto 0);
begin
    EX0: entity work.signed_expander port map(vect_in => vect_in1, vect_out => vect_in1_expended);
    EX1: entity work.signed_expander port map(vect_in => vect_in2, vect_out => vect_in2_expended);

    AD0: entity work.adder_8bit port map(vect_in1 => vect_in1_expended, vect_in2 => vect_in2_expended, vect_out => vect_out);
end Behavioral;
