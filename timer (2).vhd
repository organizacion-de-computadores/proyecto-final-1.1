 ----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity timer is
    PORT (
        clk    		: IN  STD_LOGIC;
		  reset  		: IN  STD_LOGIC_VECTOR(7 downto 0);
		  enable 		: IN  STD_LOGIC_VECTOR(7 downto 0);
        con_out		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		  con_usuario  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		  int_timer_periferico				: out std_LOGIC_VECTOR(7 downto 0);
		  int_timer  	: out std_logic 
    );
end timer;

architecture Behavioral of timer is
    -- Señal temporal para el contador.
    signal con_s: STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	 signal fin_s: std_logic := '0';
	 signal clk_real:std_LOGIC;
begin

divisor_real : ENTITY work.divisor
	PORT MAP	(clk	=> clk,
				 clk_seg => clk_real);

contador8: process (clk_real,reset,enable,con_usuario) begin
	 if (reset="00000000") then
    con_s<="00000000";
	 fin_s<='0';
	 int_timer<='0';
	 int_timer_periferico<="00000000";
		elsif (reset="00000001")and(enable="00000001") and (rising_edge(clk_real)) then
		  If (fin_s='1') then
		    con_s<=con_usuario;
            ELSIF (con_s=con_usuario) then
				   fin_s<='1';
					int_timer<='1';
					int_timer_periferico<="00000001";
					con_s<=con_usuario;
				else con_s <= con_s + 1;
						int_timer_periferico<="00000000";
        end if;
		  end if;  
    end process;
    con_out <= con_s;
end Behavioral;

