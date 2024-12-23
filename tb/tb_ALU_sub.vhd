library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ALU_sub is
end tb_ALU_sub;

architecture Behavioral of tb_ALU_sub is
    -- DUT (Device Under Test) 신호 선언
    signal vect_in1  : STD_LOGIC_VECTOR(3 downto 0);
    signal vect_in2  : STD_LOGIC_VECTOR(3 downto 0);
    signal vect_in1_expended_out : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in2_expended_out : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_out  : STD_LOGIC_VECTOR(7 downto 0);

    -- DUT 선언
    component ALU_sub
        Port (
            vect_in1 : in STD_LOGIC_VECTOR(3 downto 0); -- 첫 번째 8비트 입력
            vect_in2 : in STD_LOGIC_VECTOR(3 downto 0); -- 두 번째 8비트 입력
            vect_in1_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
            vect_in2_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
            vect_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
begin
    -- DUT 인스턴스 연결
    uut: ALU_sub
        Port map (
            vect_in1 => vect_in1,
            vect_in2 => vect_in2,
            vect_in1_expended_out => vect_in1_expended_out,
            vect_in2_expended_out => vect_in2_expended_out,
            vect_out => vect_out
        );

    -- 테스트 벤치 프로세스
    process
    begin
        -- Test Case 1: Positive - Positive
        vect_in1 <= "0101"; -- 5
        vect_in2 <= "0011"; -- 3
        wait for 10 ns;     -- Expected vect_out = 00000010 (2)

        -- Test Case 2: Positive - Negative
        vect_in1 <= "0110"; -- 6
        vect_in2 <= "1100"; -- -4
        wait for 10 ns;     -- Expected vect_out = 00001010 (10)

        -- 시뮬레이션 종료
        wait;
    end process;
end Behavioral;