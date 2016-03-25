-- Author: Graceal S. Villamor
-- Section: T - 4L

library IEEE; use IEEE.std_logic_1164.all;

-- entity declaration
entity buzzer_alarm is
	port(alarm: out std_logic; 
		-- alarm == output
	     i1, i2, i3, o1, o2, o3: in std_logic
		-- input in_buzzers and out_buzzers    
	);
end entity;

-- architecture declaration
architecture buzzer_alarm of buzzer_alarm is
begin
	alarm <= (i1 or i2 or i3) and (o1 or o2 or o3);
	-- will only alarm if result = 1
end architecture;
