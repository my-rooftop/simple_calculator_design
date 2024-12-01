library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Top_File is
    port(Clk: in std_logic;
         Reset: in std_logic;
         Start: in std_logic;
         Done: out std_logic;
         A: in std_logic_vector(3 downto 0);
         B:in std_logic_vector (3 downto 0);
         Sel: in std_logic_vector(1 downto 0);
         a_to_g:out std_logic_vector(7 downto 0);
         an:out std_logic_vector(7 downto 0);
         debug_x_inter: out std_logic_vector(20 downto 0)  -- Added debug output
    );
end Top_File;

architecture Behavioral of Top_File is


-- Internal signals
signal vect_in1_expended_add : STD_LOGIC_VECTOR(7 downto 0);
signal vect_in2_expended_add : STD_LOGIC_VECTOR(7 downto 0);
signal vect_out_add : STD_LOGIC_VECTOR(7 downto 0);

signal vect_in1_expended_sub : STD_LOGIC_VECTOR(7 downto 0);
signal vect_in2_expended_sub : STD_LOGIC_VECTOR(7 downto 0);
signal vect_out_sub : STD_LOGIC_VECTOR(7 downto 0);

signal vect_in1_expended_mul : STD_LOGIC_VECTOR(7 downto 0);
signal vect_in2_expended_mul : STD_LOGIC_VECTOR(7 downto 0);
signal vect_out_mul : STD_LOGIC_VECTOR(7 downto 0);
signal done_mul : STD_LOGIC;

signal vect_in1_expended_final : STD_LOGIC_VECTOR(7 downto 0);
signal vect_in2_expended_final : STD_LOGIC_VECTOR(7 downto 0);
signal vect_out_final : STD_LOGIC_VECTOR(7 downto 0);

signal x_inter : std_logic_vector(20 downto 0);
signal Sel_out_vector : std_logic_vector(2 downto 0);
signal out_1 : std_logic_vector(3 downto 0);
signal out_2 : std_logic_vector(2 downto 0);
signal sign_vector : std_logic;
signal mag_A : std_logic_vector(3 downto 0);
signal sign_A_vector : std_logic;
signal mag_B : std_logic_vector(3 downto 0);
signal sign_B_vector : std_logic;
signal done_encoder : std_logic;

component ALU_mul is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        vect_in1 : in STD_LOGIC_VECTOR(3 downto 0);
        vect_in2 : in STD_LOGIC_VECTOR(3 downto 0);
        vect_in1_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
        vect_in2_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
        vect_out : out STD_LOGIC_VECTOR(7 downto 0);
        done : out STD_LOGIC
    );
end component;

component ALU_add is
    Port (
        vect_in1 : in STD_LOGIC_VECTOR(3 downto 0);
        vect_in2 : in STD_LOGIC_VECTOR(3 downto 0);
        vect_in1_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
        vect_in2_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
        vect_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

component ALU_sub is
    Port (
        vect_in1 : in STD_LOGIC_VECTOR(3 downto 0);
        vect_in2 : in STD_LOGIC_VECTOR(3 downto 0);
        vect_in1_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
        vect_in2_expended_out : out STD_LOGIC_VECTOR(7 downto 0);
        vect_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

component Encoder is
    Port (
        clk : in STD_LOGIC;
        rst : in std_logic;
        vect_in1_expended : in STD_LOGIC_VECTOR(7 downto 0);
        vect_in2_expended : in STD_LOGIC_VECTOR(7 downto 0);
        vect_out : in STD_LOGIC_VECTOR(7 downto 0);
        Sel : in std_logic_vector(1 downto 0);
        Sel_out_vector : out std_logic_vector(2 downto 0);
        out_1 : out std_logic_vector(3 downto 0);
        out_2 : out std_logic_vector(2 downto 0);
        sign_vector : out std_logic;
        mag_A : out std_logic_vector(3 downto 0);
        sign_A_vector : out std_logic;
        mag_B : out std_logic_vector(3 downto 0);
        sign_B_vector : out std_logic;
        done : out std_logic
    );
end component;

component myseven_segments is
    port( x:in std_logic_vector(20 downto 0);
          clk: in std_logic;
          clr: in std_logic;
          reset: in std_logic;
          a_to_g: out std_logic_vector(7 downto 0);
          an: out std_logic_vector(7 downto 0));
end component;

begin

-- Component instantiations
ADD0: ALU_add port map(
    vect_in1 => A,
    vect_in2 => B,
    vect_in1_expended_out => vect_in1_expended_add,
    vect_in2_expended_out => vect_in2_expended_add,
    vect_out => vect_out_add
);

SUB0: ALU_sub port map(
    vect_in1 => A,
    vect_in2 => B,
    vect_in1_expended_out => vect_in1_expended_sub,
    vect_in2_expended_out => vect_in2_expended_sub,
    vect_out => vect_out_sub
);

MUL0: ALU_mul port map(
    clk => Clk,
    rst => Reset,
    vect_in1 => A,
    vect_in2 => B,
    vect_in1_expended_out => vect_in1_expended_mul,
    vect_in2_expended_out => vect_in2_expended_mul,
    vect_out => vect_out_mul,
    done => done_mul
);

ENC0: Encoder port map(
    clk => Clk,
    rst => Reset,
    vect_in1_expended => vect_in1_expended_final,
    vect_in2_expended => vect_in2_expended_final,
    vect_out => vect_out_final,
    Sel => Sel,
    Sel_out_vector => Sel_out_vector,
    out_1 => out_1,
    out_2 => out_2,
    sign_vector => sign_vector,
    mag_A => mag_A,
    sign_A_vector => sign_A_vector,
    mag_B => mag_B,
    sign_B_vector => sign_B_vector,
    done => done_encoder
);

-- Main process
process (Clk, Reset)
begin
    if Reset = '1' then
        Done <= '0';
        vect_in1_expended_final <= (others => '0');
        vect_in2_expended_final <= (others => '0');
        vect_out_final <= (others => '0');
    elsif rising_edge(Clk) then
        case Sel is
            when "00" =>  -- Addition
                vect_in1_expended_final <= vect_in1_expended_add;
                vect_in2_expended_final <= vect_in2_expended_add;
                vect_out_final <= vect_out_add;
                Done <= '1';
                
            when "01" =>  -- Subtraction
                vect_in1_expended_final <= vect_in1_expended_sub;
                vect_in2_expended_final <= vect_in2_expended_sub;
                vect_out_final <= vect_out_sub;
                Done <= '1';
                
            when "10" =>  -- Multiplication
                vect_in1_expended_final <= vect_in1_expended_mul;
                vect_in2_expended_final <= vect_in2_expended_mul;
                vect_out_final <= vect_out_mul;
                Done <= done_mul;
                
            when others => -- Pass through
                vect_in1_expended_final <= (others => '0');
                vect_in2_expended_final <= (others => '0');
                vect_out_final <= (others => '0');
                Done <= '1';
        end case;
    end if;
end process;

-- Seven segment display connection
x_inter(2 downto 0) <= Sel_out_vector;
x_inter(6 downto 3) <= out_1;
x_inter(9 downto 7) <= out_2;
x_inter(10) <= sign_vector;
x_inter(14 downto 11) <= mag_B;
x_inter(15) <= sign_B_vector;
x_inter(19 downto 16) <= mag_A;
x_inter(20) <= sign_A_vector;

-- Debug output
debug_x_inter <= x_inter;

X1: myseven_segments port map (
    x => x_inter,
    clk => Clk,
    reset => Reset,
    clr => Start,
    a_to_g => a_to_g,
    an => an
);

end Behavioral;