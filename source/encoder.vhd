library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Encoder is
    Port (
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
        sign_B_vector : out STD_LOGIC
    );
end Encoder;

architecture Behavioral of Encoder is
    signal vect_in1_complement_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in1_complement_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    
    signal vect_in2_complement_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_in2_complement_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    signal vect_out_complement_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal vect_out_complement_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

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

    -- Main process to handle signals
    process(vect_in1_expended, vect_in2_expended, vect_out)
    begin
        -- Handle vect_in1_expended
        if vect_in1_expended(7) = '1' then
            vect_in1_complement_in <= vect_in1_expended;
            sign_A_vector <= '1';
        else
            vect_in1_complement_in <= (others => '0');
            vect_in1_complement_out <= vect_in1_expended;
            sign_A_vector <= '0';
        end if;

        -- Handle vect_in2_expended
        if vect_in2_expended(7) = '1' then
            vect_in2_complement_in <= vect_in2_expended;
            sign_B_vector <= '1';
        else
            vect_in2_complement_in <= (others => '0');
            vect_in2_complement_out <= vect_in2_expended;
            sign_B_vector <= '0';
        end if;

        -- Handle vect_out
        if vect_out(7) = '1' then
            vect_out_complement_in <= vect_out;
            sign_vector <= '1';
        else
            vect_out_complement_in <= (others => '0');
            vect_out_complement_out <= vect_out;
            sign_vector <= '0';
        end if;

        -- Generate Sel_out_vector
        Sel_out_vector <= '1' & Sel(1 downto 0);

        -- Generate out_1 and out_2
        out_1 <= vect_out_complement_out(3 downto 0);
        out_2 <= vect_out_complement_out(6 downto 4);

        -- Generate mag_A and mag_B
        mag_A <= vect_in1_complement_out(3 downto 0);
        mag_B <= vect_in2_complement_out(3 downto 0);
    end process;

end Behavioral;