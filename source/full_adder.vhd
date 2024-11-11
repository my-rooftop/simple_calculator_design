library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity full_adder is
    Port (
        A    : in  STD_LOGIC;  -- 첫 번째 입력 비트
        B    : in  STD_LOGIC;  -- 두 번째 입력 비트
        Cin  : in  STD_LOGIC;  -- 입력 캐리
        Sum  : out STD_LOGIC;  -- 합 출력
        Cout : out STD_LOGIC   -- 출력 캐리
    );
end full_adder;

architecture Behavioral of full_adder is
begin
    -- Sum = A XOR B XOR Cin
    Sum <= A XOR B XOR Cin;
    
    -- Cout = (A AND B) OR (Cin AND (A XOR B))
    Cout <= (A AND B) OR (Cin AND (A XOR B));
end Behavioral;