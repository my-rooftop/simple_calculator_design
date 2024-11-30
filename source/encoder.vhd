library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Encoder is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        vect_in1_expended : in STD_LOGIC_VECTOR(7 downto 0);
        vect_in2_expended : in STD_LOGIC_VECTOR(7 downto 0);
        vect_out : in STD_LOGIC_VECTOR(7 downto 0);
        Sel : in STD_LOGIC_VECTOR(1 downto 0);
        Sel_out_vector : out STD_LOGIC_VECTOR(2 downto 0);
        out_1 : out STD_LOGIC_VECTOR(3 downto 0); 
        out_2 : out STD_LOGIC_VECTOR(2 downto 0); 
        sign_vector : out STD_LOGIC;
        mag_A : out STD_LOGIC_VECTOR(3 downto 0);
        sign_A_vector : out STD_LOGIC;
        mag_B : out STD_LOGIC_VECTOR(3 downto 0);
        sign_B_vector : out STD_LOGIC;
        done : out STD_LOGIC
    );
end Encoder;

architecture Behavioral of Encoder is
    -- Internal signals
    signal vect_in1_complement_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in1_complement_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in1_complement_buf : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_complement_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_complement_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_complement_buf : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_out_complement_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_out_complement_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_out_complement_buf : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal done_signal : STD_LOGIC := '0';  -- Internal signal for 'done'
    signal state : INTEGER range 0 to 4 := 0;  -- State signal

    component two_complement
        Port (
            vect_in    : in  STD_LOGIC_VECTOR(7 downto 0); 
            vect_out   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin
    -- Instantiate two_complement components
    CM0: two_complement port map(
        vect_in => vect_in1_complement_in, 
        vect_out => vect_in1_complement_out
    );

    CM1: two_complement port map(
        vect_in => vect_in2_complement_in, 
        vect_out => vect_in2_complement_out
    );

    CM2: two_complement port map(
        vect_in => vect_out_complement_in, 
        vect_out => vect_out_complement_out
    );

    -- Main process (Sequential Logic)
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset logic
            vect_in1_complement_in <= (others => '0');
            vect_in2_complement_in <= (others => '0');
            vect_out_complement_in <= (others => '0');
            sign_A_vector <= '0';
            sign_B_vector <= '0';
            sign_vector <= '0';
            Sel_out_vector <= (others => '0');
            out_1 <= (others => '0');
            out_2 <= (others => '0');
            mag_A <= (others => '0');
            mag_B <= (others => '0');
            done_signal <= '0';
            state <= 0;  -- Reset state
        elsif rising_edge(clk) then
            case state is
                when 0 =>
                    -- Handle vect_in1_expended
                    if vect_in1_expended(7) = '1' then
                        vect_in1_complement_in <= vect_in1_expended;
                        vect_in1_complement_buf <= vect_in1_complement_out;
                        sign_A_vector <= '1';
                    else
                        vect_in1_complement_in <= (others => '0');
                        vect_in1_complement_buf <= vect_in1_expended;
                        sign_A_vector <= '0';
                    end if;
                    state <= 1;

                when 1 =>
                    -- Handle vect_in2_expended
                    if vect_in2_expended(7) = '1' then
                        vect_in2_complement_in <= vect_in2_expended;
                        vect_in2_complement_buf <= vect_in2_complement_out;
                        sign_B_vector <= '1';
                    else
                        vect_in2_complement_in <= (others => '0');
                        vect_in2_complement_buf <= vect_in2_expended;
                        sign_B_vector <= '0';
                    end if;
                    state <= 2;

                when 2 =>
                    -- Process vect_out results
                    if vect_out(7) = '1' then
                        vect_out_complement_in <= vect_out;
                        vect_out_complement_buf <= vect_out_complement_out;
                        sign_vector <= '1';
                    else
                        vect_out_complement_in <= (others => '0');
                        vect_out_complement_buf <= vect_out;
                        sign_vector <= '0';
                    end if;

                    -- Prepare to assign results
                    state <= 3;

                when 3 =>
                    -- Assign results to outputs
                    Sel_out_vector <= '1' & Sel(1 downto 0);
                    out_1 <= vect_out_complement_buf(3 downto 0);
                    out_2 <= vect_out_complement_buf(6 downto 4);
                    mag_A <= vect_in1_complement_buf(3 downto 0);
                    mag_B <= vect_in2_complement_buf(3 downto 0);

                    -- Set done signal
                    done_signal <= '1';
                    state <= 4;

                when 4 =>
                    -- Reset done signal and state
                    done_signal <= '0';
                    state <= 0;

                when others =>
                    state <= 0;
                    done_signal <= '0';
            end case;
        end if;
    end process;

    -- Assign internal 'done' signal to output port
    done <= done_signal;

end Behavioral;