library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Test bench entity 선언
entity adder_4bit_tb is
end adder_4bit_tb;

architecture Behavioral of adder_4bit_tb is

    -- DUT(Design Under Test)인 adder_4bit 컴포넌트 선언
    component adder_4bit
        Port ( 
            A    : in  STD_LOGIC_VECTOR(3 downto 0);
            B    : in  STD_LOGIC_VECTOR(3 downto 0);
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC_VECTOR(3 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

    -- 테스트 입력 신호 정의
    signal A    : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal B    : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Cin  : STD_LOGIC := '0';
    
    -- 테스트 출력 신호 정의
    signal Sum  : STD_LOGIC_VECTOR(3 downto 0);
    signal Cout : STD_LOGIC;

begin

    -- adder_4bit 인스턴스화
    uut: adder_4bit
        Port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            Sum  => Sum,
            Cout => Cout
        );

    -- 테스트 벡터 생성
    process
    begin
        -- Test case 1: A=0001, B=0011, Cin=0 -> Sum=0100, Cout=0
        A <= "0001"; B <= "0011"; Cin <= '0';
        wait for 10 ns;

        -- Test case 2: A=1100, B=0011, Cin=0 -> Sum=1111, Cout=0
        A <= "1100"; B <= "0011"; Cin <= '0';
        wait for 10 ns;

        -- Test case 3: A=1100, B=0011, Cin=1 -> Sum=0000, Cout=1
        A <= "1100"; B <= "0011"; Cin <= '1';
        wait for 10 ns;

        -- Test case 4: A=1111, B=1111, Cin=0 -> Sum=1110, Cout=1
        A <= "1111"; B <= "1111"; Cin <= '0';
        wait for 10 ns;

        -- Test case 5: A=1010, B=0101, Cin=1 -> Sum=0000, Cout=1
        A <= "1010"; B <= "0101"; Cin <= '1';
        wait for 10 ns;

        -- Test case 6: A=0111, B=1001, Cin=1 -> Sum=0001, Cout=1
        A <= "0111"; B <= "1001"; Cin <= '1';
        wait for 10 ns;

        -- 시뮬레이션 종료
        wait;
    end process;

end Behavioral;