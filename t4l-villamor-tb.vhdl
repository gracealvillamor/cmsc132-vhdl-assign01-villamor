-- Author: Graceal S. Villamor
-- Section: T - 4L
-- Test bench for buzzer alarm problem

library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity declaration
entity buzzer_alarm_tb is
	constant MAX_COMB: integer := 64;
	constant DELAY: time := 10 ns;
end entity;

-- architecture declaration
architecture tb of buzzer_alarm_tb is
	
	signal alarm: std_logic;
	signal i1, i2, i3, o1, o2, o3: std_logic;

	component buzzer_alarm is
			port(alarm: out std_logic; 
				--alarm is the output
	     		    i1, i2, i3, o1, o2, o3: in std_logic
				--input in_buzzers and out_buzzers    
			);
	end component;
	
begin --architecture

	uut: component buzzer_alarm port map(alarm, i1, i2, i3, o1, o2, o3);
	main: process is
			variable temp: unsigned(5 downto 0);
			variable expected_alarm: std_logic;
			variable error_count: integer := 0;
			
	begin --process
		
		report "Start simulation";
		
		for i in 0 to 63 loop -- 2^6 combinations
			temp := TO_UNSIGNED(i, 6);
			--assign each input a value from temp
			o3 <= temp(5);
			o2 <= temp(4);
			o1 <= temp(3);
			i3 <= temp(2);
			i2 <= temp(1);
			i1 <= temp(0);
			
			-- according to the truth table, alarm = 0 on this lines
			if(i <= 8 or i = 16 or i = 24 or i = 32 or i = 40 or i = 48 or i = 56) then
				expected_alarm := '0';
			else
				expected_alarm := '1';
			end if;
			
			wait for DELAY;
	
			assert((expected_alarm = alarm))
				report "ERROR: Expected alarm " & std_logic'image(expected_alarm)& " /= actual alarm " & 
					std_logic'image(alarm) &
					" at time " & time'image(now);
				
			if (expected_alarm /= alarm)
				then error_count := error_count + 1;
			end if;
		
		end loop;

			assert (error_count = 0)
				report "ERROR: There were " &
					integer'image(error_count) & " errors!";
				if(error_count = 0) then 
					report "Simulation completed with NO errors.";
				end if;
			wait;
		end process;
end architecture tb;

