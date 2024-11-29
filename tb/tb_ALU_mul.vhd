library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ALU_mul is
end tb_ALU_mul;

architecture Behavioral of tb_ALU_mul is
    -- DUT의 포트와 연결될 신호 선언
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal vect_in1 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal vect_in2 : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal vect_out : STD_LOGIC_VECTOR(7 downto 0);
    signal done : STD_LOGIC;

    -- 내부 신호를 디버깅하기 위한 추가 신호
    signal debug_vect_in1_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal debug_vect_in2_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal debug_acc_vect : STD_LOGIC_VECTOR(7 downto 0);
    signal debug_state : INTEGER range 0 to 3;

    -- DUT 선언
    component ALU_mul
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            vect_in1 : in STD_LOGIC_VECTOR(3 downto 0);
            vect_in2 : in STD_LOGIC_VECTOR(3 downto 0);
            vect_out : out STD_LOGIC_VECTOR(7 downto 0);
            done : out STD_LOGIC
        );
    end component;

begin
    -- DUT 인스턴스
    DUT: ALU_mul
        Port map (
            clk => clk,
            rst => rst,
            vect_in1 => vect_in1,
            vect_in2 => vect_in2,
            vect_out => vect_out,
            done => done
        );

    -- 클럭 생성 프로세스
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- 테스트 시퀀스
    stimulus_process : process
    begin
        -- 초기화
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- 테스트 케이스 1: 3 * 2 = 6
        vect_in1 <= "0011"; -- 3
        vect_in2 <= "0010"; -- 2
        wait until done = '1';
        assert vect_out = "00000110"
        report "Test Case 1 Failed: Expected 6" severity error;

        -- 테스트 케이스 2: 7 * 4 = 28
        vect_in1 <= "0111"; -- 7
        vect_in2 <= "0100"; -- 4
        wait until done = '1';
        assert vect_out = "00011100"
        report "Test Case 2 Failed: Expected 28" severity error;

        -- 테스트 케이스 3: -2 * 3 = -6
        vect_in1 <= "1110"; -- -2 (2의 보수 표현)
        vect_in2 <= "0011"; -- 3
        wait until done = '1';
        assert vect_out = "11111010"
        report "Test Case 3 Failed: Expected -6" severity error;

        -- 테스트 케이스 4: 0 * 5 = 0
        vect_in1 <= "0000"; -- 0
        vect_in2 <= "0101"; -- 5
        wait until done = '1';
        assert vect_out = "00000000"
        report "Test Case 4 Failed: Expected 0" severity error;

        -- 테스트 완료
        report "All Test Cases Passed!" severity note;
        wait;
    end process;
end Behavioral;