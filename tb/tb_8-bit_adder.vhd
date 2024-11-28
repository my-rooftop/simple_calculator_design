library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_adder_8bit is
end tb_adder_8bit;

architecture Behavioral of tb_adder_8bit is
    -- DUT (Device Under Test) 신호 선언
    signal vect_in  : std_logic_vector(7 downto 0);
    signal vect_in2 : std_logic_vector(7 downto 0);
    signal vect_out : std_logic_vector(7 downto 0);

    -- DUT 컴포넌트 선언
    component adder_8bit
        Port (
            vect_in  : in  std_logic_vector(7 downto 0);
            vect_in2 : in  std_logic_vector(7 downto 0);
            vect_out : out std_logic_vector(7 downto 0)
        );
    end component;
begin
    -- DUT 인스턴스 연결
    uut: adder_8bit
        port map (
            vect_in  => vect_in,
            vect_in2 => vect_in2,
            vect_out => vect_out
        );

    -- 테스트 벤치 프로세스
    process
    begin
        -- Test Case 1: Add 8'b00000001 + 8'b00000001
        vect_in <= "00000001"; -- 입력 1
        vect_in2 <= "00000001"; -- 입력 2
        wait for 10 ns;

        -- Test Case 2: Add 8'b11111111 + 8'b00000001
        vect_in <= "11111111"; -- 입력 1
        vect_in2 <= "00000001"; -- 입력 2
        wait for 10 ns;

        -- Test Case 3: Add 8'b10000000 + 8'b10000000
        vect_in <= "10000000"; -- 입력 1
        vect_in2 <= "10000000"; -- 입력 2
        wait for 10 ns;

        -- Test Case 4: Add 8'b01010101 + 8'b00110011
        vect_in <= "01010101"; -- 입력 1
        vect_in2 <= "00110011"; -- 입력 2
        wait for 10 ns;

        -- Test Case 5: Add 8'b00000000 + 8'b00000000
        vect_in <= "00000000"; -- 입력 1
        vect_in2 <= "00000000"; -- 입력 2
        wait for 10 ns;

        -- 시뮬레이션 종료
        wait;
    end process;
end Behavioral;