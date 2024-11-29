library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_mul_debug is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        vect_in1 : in STD_LOGIC_VECTOR(3 downto 0);
        vect_in2 : in STD_LOGIC_VECTOR(3 downto 0);
        vect_out : out STD_LOGIC_VECTOR(7 downto 0);
        done : out STD_LOGIC
    );
end ALU_mul_debug;

architecture Behavioral of ALU_mul_debug is
    component adder_8bit
        Port (
            vect_in1 : in STD_LOGIC_VECTOR(7 downto 0);
            vect_in2 : in STD_LOGIC_VECTOR(7 downto 0);
            vect_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component signed_expander
        Port (
            vect_in : in STD_LOGIC_VECTOR(3 downto 0);
            vect_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component two_complement
        Port (
            vect_in    : in  STD_LOGIC_VECTOR(7 downto 0); 
            vect_out   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Internal signals with initial values
    signal vect_in1_buf : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal vect_in2_buf : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal vect_in1_expended : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_expended : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in1_complement : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_complement : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in1_comp_expended : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_comp_expended : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_out_buf : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_out_buf2 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal state : INTEGER range 0 to 4 := 0;
    signal sign : STD_LOGIC := '0';
    signal vect_in1_done : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_done : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal addicant : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal acc_vect : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal count : INTEGER range 0 to 4 := 0;

begin
    -- Instantiate signed_expander components
    EX1: signed_expander port map(
        vect_in => vect_in1_buf,
        vect_out => vect_in1_expended
    );

    EX2: signed_expander port map(
        vect_in => vect_in2_buf,
        vect_out => vect_in2_expended
    );

    CM0: two_complement port map(
        vect_in => vect_in1_complement, 
        vect_out => vect_in1_comp_expended
    );

    CM1: two_complement port map(
        vect_in => vect_in2_complement, 
        vect_out => vect_in2_comp_expended
    );

    -- Adder instance
    AD0: adder_8bit port map(
        vect_in1 => addicant,
        vect_in2 => acc_vect,
        vect_out => vect_out_buf
    );

    -- Main control process
    process (clk, rst)
    begin
        -- reset 로직 수정
        if rst = '1' then
            vect_in1_buf <= (others => '0');
            vect_in2_buf <= (others => '0');
            vect_in1_complement <= (others => '0');
            vect_in2_complement <= (others => '0');
            vect_out <= (others => '0');
            addicant <= (others => '0');
            acc_vect <= (others => '0');
            vect_in1_done <= (others => '0');
            vect_in2_done <= (others => '0');
            sign <= '0';
            state <= 0;
            done <= '0';
            count <= 0;
        elsif rising_edge(clk) then
            case state is
                when 0 =>
                    -- Store input values in buffers
                    vect_in1_buf <= vect_in1;
                    vect_in2_buf <= vect_in2;
                    state <= 1;
                    done <= '0';

                when 1 =>
                    -- Calculate sign and prepare complement inputs
                    sign <= vect_in1_expended(7) XOR vect_in2_expended(7);
                    state <= 2;

                when 2 =>
                    -- Handle two's complement conversion
                    if vect_in1_expended(7) = '1' then
                        vect_in1_complement <= vect_in1_expended;
                        vect_in1_done <= vect_in1_comp_expended;
                    else
                        vect_in1_done <= vect_in1_expended;
                    end if;
                    
                    if vect_in2_expended(7) = '1' then
                        vect_in2_complement <= vect_in2_expended;
                        vect_in2_done <= vect_in2_comp_expended;
                    else
                        vect_in2_done <= vect_in2_expended;
                    end if;
                    state <= 3;

                when 3 =>
                    if count < 4 then
                        count <= count + 1;
                        if vect_in2_done(0) = '1' then
                            addicant <= vect_in1_done;
                            acc_vect <= vect_out_buf2;
                        end if;
                        vect_out_buf2 <= vect_out_buf; 
                        vect_in1_done <= vect_in1_done(6 downto 0) & '0';
                        vect_in2_done <= '0' & vect_in2_done(7 downto 1);
                    else
                        count <= 0;  -- Reset count for next operation
                        state <= 4;
                    end if;
                when 4 =>
                    -- Wait for complement and addition to complete
                    vect_out <= vect_in1_done;
                    done <= '1';
                    state <= 0;

                when others =>
                    state <= 0;
                    done <= '0';
            end case;
        end if;
    end process;

end Behavioral;