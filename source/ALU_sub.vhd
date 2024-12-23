library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 8비트 Adder의 엔티티 선언
entity ALU_sub is
    Port (
        vect_in1 : in STD_LOGIC_VECTOR(3 downto 0); -- 첫 번째 8비트 입력
        vect_in2 : in STD_LOGIC_VECTOR(3 downto 0); -- 두 번째 8비트 입력
        vect_in1_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
        vect_in2_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
        vect_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end ALU_sub;

architecture Behavioral of ALU_sub is
    signal vect_in1_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in2_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in2_complement : STD_LOGIC_VECTOR(7 downto 0);
begin
    EX0: entity work.signed_expander port map(vect_in => vect_in1, vect_out => vect_in1_expended);
    EX1: entity work.signed_expander port map(vect_in => vect_in2, vect_out => vect_in2_expended);

    CM0: entity work.two_complement port map(vect_in => vect_in2_expended, vect_out => vect_in2_complement);

    AD0: entity work.adder_8bit port map(vect_in1 => vect_in1_expended, vect_in2 => vect_in2_complement, vect_out => vect_out);
    vect_in1_expended_out <= vect_in1_expended;
    vect_in2_expended_out <= vect_in2_expended;
end Behavioral;
