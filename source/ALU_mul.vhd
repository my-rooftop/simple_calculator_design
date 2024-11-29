library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 8비트 Adder의 엔티티 선언
entity ALU_mul is
    Port (
        clk : in STD_LOGIC; -- 클럭 입력
        rst : in STD_LOGIC; -- 리셋 입력
        vect_in1 : in STD_LOGIC_VECTOR(3 downto 0); -- 첫 번째 8비트 입력
        vect_in2 : in STD_LOGIC_VECTOR(3 downto 0); -- 두 번째 8비트 입력
        vect_out : out STD_LOGIC_VECTOR(7 downto 0);
        done : out STD_LOGIC
    );
end ALU_mul;

architecture Behavioral of ALU_mul is

    component adder_8bit
        Port (
            vect_in1 : in STD_LOGIC_VECTOR(7 downto 0); -- 첫 번째 8비트 입력
            vect_in2 : in STD_LOGIC_VECTOR(7 downto 0); -- 두 번째 8비트 입력
            vect_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component signed_expander
        Port (
            vect_in    : in  STD_LOGIC_VECTOR(3 downto 0); 
            vect_out   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component two_complement
        Port (
            vect_in    : in  STD_LOGIC_VECTOR(7 downto 0); 
            vect_out   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    signal vect_in1_origin : STD_LOGIC_VECTOR(3 downto 0);
    signal vect_in2_origin : STD_LOGIC_VECTOR(3 downto 0);
    signal vect_in1_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in2_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in1_complement : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in2_complement : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in1_comp_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_in2_comp_expended : STD_LOGIC_VECTOR(7 downto 0);
    signal addicant : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_out_buf : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_out_buf2 : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_out_comp : STD_LOGIC_VECTOR(7 downto 0);
    signal vect_out_comp_buf : STD_LOGIC_VECTOR(7 downto 0);
    signal acc_vect : STD_LOGIC_VECTOR(7 downto 0);
    signal state : INTEGER range 0 to 3 := 0;
    signal count : INTEGER range 0 to 3 := 0;
    signal sign : STD_LOGIC;
begin

    EX0: signed_expander port map(vect_in => vect_in1_origin, vect_out => vect_in1_expended);
    EX1: signed_expander port map(vect_in => vect_in2_origin, vect_out => vect_in2_expended);

    CM0: two_complement port map(vect_in => vect_in1_complement, vect_out => vect_in1_comp_expended);
    CM1: two_complement port map(vect_in => vect_in2_complement, vect_out => vect_in2_comp_expended);

    CM2: two_complement port map(vect_in => vect_out_comp, vect_out => vect_out_comp_buf);

    AD0: adder_8bit port map(vect_in1 => addicant, vect_in2 => acc_vect, vect_out => vect_out_buf);

    process (clk, rst)
    begin
        if rst = '1' then
            vect_in1_expended <= (others => '0');
            vect_in2_expended <= (others => '0');
            vect_in1_complement <= (others => '0');
            vect_in2_complement <= (others => '0');
            vect_in1_comp_expended <= (others => '0');
            vect_in2_comp_expended <= (others => '0');
            addicant <= (others => '0');
            vect_out_buf <= (others => '0');
            vect_out_buf2 <= (others => '0');
            acc_vect <= (others => '0');
            state <= 0;
            count <= 0;
            sign <= '0';
            done <= '0';
            vect_out <= (others => '0');
        elsif rising_edge(clk) then
            case state is
                when 0 =>
                    sign <= vect_in1(3) XOR vect_in2(3);
                    vect_in1_origin <= vect_in1;
                    vect_in2_origin <= vect_in2;
                    if vect_in1_origin(3) = '1' then
                        vect_in1_complement <= vect_in1_expended;
                    else 
                        vect_in1_comp_expended <= vect_in1_expended;
                    end if;
                    if vect_in2_origin(3) = '1' then
                        vect_in2_complement <= vect_in2_expended;
                    else
                        vect_in2_comp_expended <= vect_in2_expended;
                    end if;
                    acc_vect <= (others => '0');
                    count <= 0;
                    state <= 1;
                when 1 =>
                    if count < 4 then
                        count <= count + 1;
                        if vect_in2_comp_expended(0) = '1' then
                            addicant <= vect_in1_comp_expended;
                            vect_out_buf2 <= vect_out_buf;
                            acc_vect <= vect_out_buf2;
                        else
                            vect_in1_comp_expended <= vect_in1_comp_expended(6 downto 0) & '0';
                            vect_in2_comp_expended <= '0' & vect_in2_comp_expended(7 downto 1);
                        end if;
                    else
                        state <= 2;
                    end if;
                when 2 =>
                    state <= 3;
                    -- vect_out <= vect_out_buf;
                    if sign = '1' then 
                        vect_out_comp <= vect_out_buf;
                    end if;
                when 3 =>
                    if sign = '1' then
                        vect_out <= vect_out_buf;
                    else
                        vect_out <= vect_out_comp;
                    end if;
                    done <= '1';
                    state <= 0;
                when others =>
                    done <= '0'; -- 기본 동작
                    state <= 0;
            end case;
        end if;
    end process;
end Behavioral;
