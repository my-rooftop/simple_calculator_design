library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_signed_expander is
end tb_signed_expander;

architecture Behavioral of tb_signed_expander is
    -- DUT (Device Under Test) 신호 선언
    signal vect_in    : std_logic_vector(3 downto 0);
    signal vect_out   : std_logic_vector(7 downto 0);

    -- DUT 컴포넌트 선언
    component signed_expander
        Port (
            vect_in    : in  std_logic_vector(3 downto 0); 
            vect_out   : out std_logic_vector(7 downto 0)
        );
    end component;
begin
    -- DUT 인스턴스 연결
    uut: signed_expander
        port map (
            vect_in => vect_in,
            vect_out => vect_out
        );

    -- 테스트 벤치 프로세스
    process
    begin
        -- Test Case 1: Positive number
        vect_in <= "0000"; -- Expected vect_out: 0000_0000
        wait for 10 ns;

        vect_in <= "0011"; -- Expected vect_out: 0011_0000
        wait for 10 ns;

        -- Test Case 2: Negative number
        vect_in <= "1000"; -- Expected vect_out: 1000_1111
        wait for 10 ns;

        vect_in <= "1111"; -- Expected vect_out: 1111_1111
        wait for 10 ns;

        -- Test Case 3: Mixed values
        vect_in <= "0101"; -- Expected vect_out: 0101_0000
        wait for 10 ns;

        -- 시뮬레이션 종료
        wait;
    end process;
end Behavioral;