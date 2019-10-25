library ieee;
use ieee.std_logic_1164.all;

entity contador is
port(
	clk : in std_logic;
	reset, enable : in std_logic;
	Qc : out std_logic_vector(2 downto 0);
	S : in std_logic;
	saida_7_seg : out std_LOGIC_VECTOR (6 downto 0)
);
end contador;

architecture contadorArch of contador is
component flipFlopJK is
port(
	J,K : in std_logic;
	reset, enable : in std_logic;
	clk : in std_logic;
	Q, Qbar: out std_logic
);
end component;
component conv_7seg is
Port (  
	Qsin : in STD_LOGIC_VECTOR (2 downto 0);
	sete_Seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal qs : std_logic_vector(2 downto 0);
signal Jsinal : std_logic_vector(2 downto 0);
signal Ksinal : std_logic_vector(2 downto 0);
signal a : std_logic;
signal b : std_logic;
signal c : std_logic;
signal d : std_logic;
signal e : std_logic;
signal f : std_logic;
signal g : std_logic;
signal h : std_logic;

begin
     a <= ((not(qs(1) and qs(0))) and not S);
     b <= ((qs(0) or qs(1)) and S);
     Ksinal(2) <= (((a or  b) and enable) or ((not enable) and (not reset)));
    
     c <= ((not qs(0)) and not S);
     d <= (qs(0) and S);
	Ksinal(1) <= (((c or  d) and enable) or ((not enable) and (not reset)));
    
	Ksinal(0) <= (('0') or ((not enable) and (not reset)));
    
     e <= ((not(qs(1) and qs(0))) and not S);
     f <= ((qs(0) or qs(1)) and S);
	Jsinal(2) <= (((e or f) and enable) or ((not enable) and reset));
    
     g <=  ((not qs(0)) and not S);
     h <= ( qs(0) and S);
	Jsinal(1) <= (((g or h) and enable) or (not enable and reset));
    
	Jsinal(0) <= (('0') or (not enable and reset));
    
	FF02: flipFlopJK port map(Jsinal(2), Ksinal(2), '1', '1', clk, qs(2));
	FF01: flipFlopJK port map(Jsinal(1), Ksinal(1), '1', '1', clk, qs(1));
	FF00: flipFlopJK port map(Jsinal(0), Ksinal(0), '1', '1', clk, qs(0));
    
	Qc <= qs;
	
	CONV: conv_7seg port map(qs, saida_7_seg);

	end architecture;