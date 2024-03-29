library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ULA is
generic (n: integer := 8);
Port ( 
inX : in STD_LOGIC_VECTOR (n-1 downto 0);
inY : in STD_LOGIC_VECTOR (n-1 downto 0);
selULA : in std_LOGIC_VECTOR (2 downto 0);
oULA : out STD_LOGIC_VECTOR (n-1 downto 0);
zero: out std_logic;
Negativo: out std_logic);
end ULA;

architecture Behavioral of ULA is
  signal c0,c1,c2,c3,c4,c5,c6,c7 : std_logic := '0';
  signal somando: std_LOGIC_VECTOR (7 downto 0);
  signal saida: std_LOGIC_VECTOR(7 downto 0);
  begin  
 
  somando(0) <= inX(0) xor inY(0);  
  c0 <= inX(0) and inY(0);
  
  somando(1) <= inX(1) xor inY(1) xor c0;
  c1 <= (inX(1) and inY(1)) or (inX(1) and c0) or (inY(1) and c0);
 
  somando(2) <= inX(2) xor inY(2) xor c1;
  c2 <= (inX(2) and inY(2)) or (inX(2) and c1) or (inY(2) and c1);
 
  somando(3) <= inX(3) xor inY(3) xor c2;
  c3 <= (inX(3) and inY(3)) or (inX(3) and c2) or (inY(3) and c2);
 
  somando(4) <= inX(4) xor inY(4) xor c3;
  c4 <= (inX(4) and inY(4)) or (inX(4) and c3) or (inY(4) and c3);
  
  somando(5) <= inX(5) xor inY(5) xor c4;
  c5 <= (inX(5) and inY(5)) or (inX(5) and c4) or (inY(5) and c4);
  
  somando(6) <= inX(6) xor inY(6) xor c5;
  c6 <= (inX(6) and inY(6)) or (inX(6) and c5) or (inY(6) and c5);
  
  somando(7) <= inX(7) xor inY(7) xor c6;

 saida <= somando when (selULA = "000") else "ZZZZZZZZ";
 saida  <= inX and inY when (selULA = "001") else "ZZZZZZZZ";
 saida <= inX or inY when (selULA = "010") else "ZZZZZZZZ";
 saida <= not inX when (selULA = "011") else "ZZZZZZZZ";
 saida <= inY when (selULA = "100") else "ZZZZZZZZ";

 
Zero <= not(saida(7)) and not(saida(6)) and not(saida(5)) and not(saida(4)) and not(saida(3)) and not(saida(2)) and not(saida(1)) and not(saida(0));
--Zero <= "1" when saida = "00000000" else "ZZZZZZZZ";
Negativo <= saida(7); 
oULA <= saida;

 end Behavioral;