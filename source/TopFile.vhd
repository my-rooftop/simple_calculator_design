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
           a_to_g:out std_logic_vector(7 downto 0);--select which segment to display
           an:out std_logic_vector(7 downto 0)  --selet which digit to display
		);

end Top_File;

architecture Behavioral of Top_File is

------------------ write user signal here 
------------------ (ex) signal S,D: std_logic_vector(4 downto 0);









------------------







------------------ write user component here
--ex ) component negative_complement is
--     port(A: in std_logic_vector(3 downto 0);
--          Comp: out std_logic_vector(3 downto 0) );	  
--end component;











------------------

component myseven_segments is
    port( x:in std_logic_vector(20 downto 0);
          clk: in std_logic;
          clr: in std_logic;
          reset: in std_logic;
          a_to_g: out std_logic_vector(7 downto 0);
          an: out std_logic_vector(7 downto 0));
end component;

begin
Complementing_A:negative_complement port map(A,pos_A);
Complmentng_B:negative_complement port map(B,pos_B);

---------------------------- Write user logic here

























----------------------------

x_inter(2 downto 0)<=Sel_out_vector;
x_inter(6 downto 3)<=out_1; 
x_inter(9 downto 7)<=out_2; 
x_inter(10)<=sign_vector;
x_inter(14 downto 11)<=mag_B;
x_inter(15)<=sign_B_vector;
x_inter(19 downto 16)<=mag_A;
x_inter(20)<=sign_A_vector;

----------------------------


X1: myseven_segments port map (x=>x_inter, clk=>Clk, reset=>Reset , clr=>Start,a_to_g=>a_to_g,an=>an);
end Behavioral;