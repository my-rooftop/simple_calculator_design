library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ALU_add is
end tb_ALU_add;

architecture Behavioral of tb_ALU_add is
    -- DUT (Device Under Test) 신호 선언
    signal vect_in1  : STD_LOGIC_VECTOR(3 downto 0);
    signal vect_in2  : STD_LOGIC_VECTOR(3 downto 0);
    signal vect_out  : STD_LOGIC_VECTOR(7 downto 0);

    -- DUT 선언
    component ALU_add
        Port (
            vect_in1 : in STD_LOGIC_VECTOR(3 downto 0);
            vect_in2 : in STD_LOGIC_VECTOR(3 downto 0);
            vect_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
begin
    -- DUT 인스턴스 연결
    uut: ALU_add
        Port map (
            vect_in1 => vect_in1,
            vect_in2 => vect_in2,
            vect_out => vect_out
        );

    -- 테스트 벤치 프로세스
    process
    begin
        -- Test Case 1: Positive + Positive
        vect_in1 <= "0010"; -- 2
        vect_in2 <= "0011"; -- 3
        wait for 10 ns;     -- Expected vect_out = 000000101 (5)

        -- Test Case 2: Positive + Negative
        vect_in1 <= "0111"; -- 7
        vect_in2 <= "1101"; -- -3 (Two's Complement)
        wait for 10 ns;     -- Expected vect_out = 000000100 (4)

        -- Test Case 3: Negative + Negative
        vect_in1 <= "1111"; -- -1
        vect_in2 <= "1110"; -- -2
        wait for 10 ns;     -- Expected vect_out = 111111101 (-3)

        -- Test Case 4: Zero + Positive
        vect_in1 <= "0000"; -- 0
        vect_in2 <= "0101"; -- 5
        wait for 10 ns;     -- Expected vect_out = 000000101 (5)

        -- Test Case 5: Zero + Negative
        vect_in1 <= "0000"; -- 0
        vect_in2 <= "1001"; -- -7
        wait for 10 ns;     -- Expected vect_out = 111111001 (-7)

        -- 시뮬레이션 종료
        wait;
    end process;
end Behavioral;