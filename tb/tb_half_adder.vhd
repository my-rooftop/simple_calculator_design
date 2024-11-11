library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder_tb is
end half_adder_tb;

architecture Behavioral of half_adder_tb is
    -- 신호 선언
    signal A : STD_LOGIC := '0';
    signal B : STD_LOGIC := '0';
    signal SUM : STD_LOGIC;
    signal CARRY : STD_LOGIC;

    -- 반가산기 인스턴스화
    component half_adder
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               SUM : out STD_LOGIC;
               CARRY : out STD_LOGIC);
    end component;

begin
    -- DUT (Device Under Test)
    DUT: half_adder Port map (A => A, B => B, SUM => SUM, CARRY => CARRY);

    -- 테스트 프로세스
    process
    begin
        -- 테스트 케이스 1: A = 0, B = 0
        A <= '0';
        B <= '0';
        wait for 10 ns;
        
        -- 테스트 케이스 2: A = 0, B = 1
        A <= '0';
        B <= '1';
        wait for 10 ns;

        -- 테스트 케이스 3: A = 1, B = 0
        A <= '1';
        B <= '0';
        wait for 10 ns;

        -- 테스트 케이스 4: A = 1, B = 1
        A <= '1';
        B <= '1';
        wait for 10 ns;

        -- 시뮬레이션 종료
        wait;
    end process;
end Behavioral;