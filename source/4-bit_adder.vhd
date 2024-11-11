library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 4비트 Adder의 엔티티 선언
entity adder_4bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(3 downto 0); -- 첫 번째 4비트 입력
        B    : in  STD_LOGIC_VECTOR(3 downto 0); -- 두 번째 4비트 입력
        Cin  : in  STD_LOGIC;                    -- 입력 캐리
        Sum  : out STD_LOGIC_VECTOR(3 downto 0); -- 합 출력
        Cout : out STD_LOGIC                     -- 최종 캐리 출력
    );
end adder_4bit;

-- 4비트 Adder의 아키텍처 구현
architecture Behavioral of adder_4bit is
    -- 내부 신호 정의: 각 비트의 올림 비트(Carry)
    signal C : STD_LOGIC_VECTOR(4 downto 0); 
begin
    -- 초기 Carry 입력 설정
    C(0) <= Cin;

    -- 각 비트에 Full Adder 인스턴스 생성
    FA0: entity work.full_adder port map(A => A(0), B => B(0), Cin => C(0), Sum => Sum(0), Cout => C(1));
    FA1: entity work.full_adder port map(A => A(1), B => B(1), Cin => C(1), Sum => Sum(1), Cout => C(2));
    FA2: entity work.full_adder port map(A => A(2), B => B(2), Cin => C(2), Sum => Sum(2), Cout => C(3));
    FA3: entity work.full_adder port map(A => A(3), B => B(3), Cin => C(3), Sum => Sum(3), Cout => C(4));

    -- 최종 Carry 출력 설정
    Cout <= C(4);

end Behavioral;