library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_two_complement is
end tb_two_complement;

architecture Behavioral of tb_two_complement is
    -- DUT (Device Under Test) 신호 선언
    signal vect_in    : std_logic_vector(7 downto 0);
    signal vect_out   : std_logic_vector(7 downto 0);

    -- DUT 컴포넌트 선언
    component two_complement
        Port (
            vect_in    : in  std_logic_vector(7 downto 0); 
            vect_out   : out std_logic_vector(7 downto 0)
        );
    end component;
begin
    -- DUT 인스턴스 연결
    uut: two_complement
        port map (
            vect_in => vect_in,
            vect_out => vect_out
        );

    -- 테스트 벤치 프로세스
    process
    begin
        -- Test Case 1: vect_in = 8'b00000001 (1의 2's Complement)
        vect_in <= "00000001";
        wait for 10 ns;

        -- Test Case 2: vect_in = 8'b11111111 (-1의 2's Complement)
        vect_in <= "11111111";
        wait for 10 ns;

        -- Test Case 3: vect_in = 8'b00000000 (0의 2's Complement)
        vect_in <= "00100110";
        wait for 10 ns;

        -- Test Case 4: vect_in = 8'b10000000 (-128의 2's Complement)
        vect_in <= "10001111";
        wait for 10 ns;

        -- Test Case 5: vect_in = 8'b01111111 (127의 2's Complement)
        vect_in <= "01111111";
        wait for 10 ns;

        -- 시뮬레이션 종료
        wait;
    end process;
end Behavioral;