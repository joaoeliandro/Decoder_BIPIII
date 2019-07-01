library ieee;
use ieee.std_logic_1164.all;

entity Decodificador is
	PORT(	Clk		:	in  std_logic; 
			rst		:	in  std_logic;
			Opcode	:	in  std_logic_vector (4 downto 0);
			N			:	in  std_logic; 
			Z			:	in  std_logic;
			Branch	:	out std_logic;
			WrPC		:	out std_logic;
			SeletorB		:	out std_logic;
			WrAcc		:	out std_logic;
			WrRam		:	out std_logic; 
			RdRam		:	out std_logic; 
			WrStatus	:	out std_logic;
			SeletorA		:	out std_logic_vector (1 downto 0);
			Op			:	out std_logic_vector (2 downto 0));
end Decodificador;

architecture hardware of Decodificador is

type Estado is (inicio, HLT, LD4, LD3, OORI, EADD, EADD2, EADD4, SUB4, 
				OOR, SUB3, EADD3, ANNDI, EADDI1, ESP1, ESP2, STO, LD, LD2, LDI, SUB1, SUB2,
				SUBI1, BEQ, BNE, BGT, BGE, BLT, BLE, JMP, NO, ANND, ANND1, ANND2, ANND3, 
				OOR1, OOR2, OOR3, ORI, XOOR, XOOR1, XOOR2, XOOR3, XORI, SLLL, SRLL);
signal estadoAtual, proximoEstado	:	Estado;

begin
	process(Clk)
	begin
		if(Clk'event and Clk = '1') then
			if(rst = '1') then
				estadoAtual <= inicio;
			else
				estadoAtual <= proximoEstado;
			end if;
		end if;
	end process;

	process(estadoAtual, Opcode)
	begin
		case estadoAtual is
			when inicio =>
				if (Opcode = "00000") 
				then
					proximoEstado <= HLT;
				elsif (Opcode = "00001") 
				then
					proximoEstado <= STO;
				elsif (Opcode = "00010") 
				then
					proximoEstado <= LD;
				elsif (Opcode = "00011") 
				then
					proximoEstado <= LDI;
				elsif (Opcode = "00100") 
				then
					proximoEstado <= EADD;
				elsif (Opcode = "00101") 
				then
					proximoEstado <= EADDI1;
		      elsif (Opcode = "00110") 
				then
					proximoEstado <= SUB1;
				elsif (Opcode = "00111") 
				then
					proximoEstado <= SUBI1;
				elsif (Opcode = "01000") 
				then
					proximoEstado <= BEQ;
				elsif ( Opcode = "01001" )
				then
	            proximoEstado <= BNE;
				elsif ( Opcode = "01010") 
				then
					proximoEstado <= BGT;
				elsif ( Opcode = "01011") 
				then
					proximoEstado <= BGE;
				elsif ( Opcode = "01100") 
				then
					proximoEstado <= BLT;
				elsif ( Opcode = "01010") 
				then
					proximoEstado <= BGT;
				elsif ( Opcode = "01011") 
				then
					proximoEstado <= BGE;
				elsif ( Opcode = "01100") 
				then
					proximoEstado <= BLT;
				elsif ( Opcode = "01101") 
				then
					proximoEstado <= BLE;
				elsif ( Opcode = "01110") 
				then
					proximoEstado <= JMP;
				
---------------------------------------------------------------------------------------------------------------------				
				
				elsif (Opcode = "01111") 
				then
					proximoEstado <= NO;
				elsif ( Opcode = "10000") 
				then
	            proximoEstado <= ANND;
				elsif ( Opcode = "10001") 
				then
					proximoEstado <= ANNDI;
				elsif ( Opcode = "10010") 
				then
					proximoEstado <= OOR;
				elsif ( Opcode = "10011") 
				then
					proximoEstado <= OORI;
				elsif ( Opcode = "10101") 
				then
					proximoEstado <= XOOR;
				elsif ( Opcode = "10101") 
				then
					proximoEstado <= XORI;
				elsif ( Opcode = "10110") 
				then
					proximoEstado <= SLLL;
				elsif ( Opcode = "10111") 
				then
					proximoEstado <= SRLL;
				end if;
				
			when HLT =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= HLT;
				
			when STO =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '1';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
				
			when LD =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= LD2;
				
			when LD2 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= LD3;
			
			when LD3 =>
			    SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= LD4;
			
			when LD4 =>
			    SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= inicio;
			
			when LDI =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "01";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
				
			when EADD =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= EADD2;
				
			when EADD2 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= EADD3;
			
			when EADD3 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= EADD4;
			
			when EADD4 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '1';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= inicio;
				
			when EADDI1 =>
				SeletorB <= '1';
				Op <= "000";
				WrStatus <= '1';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
				
			when ESP1 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= ESP2;
				
			when ESP2 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= inicio;
			
				
			when SUB1 =>
				SeletorB <= '0';
				Op <= "001";
				WrStatus <= '1';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= SUB2;
				
			when SUB2 =>
				SeletorB <= '0';
				Op <= "001";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= SUB3;
			
			when SUB3 =>
				SeletorB <= '0';
				Op <= "001";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= SUB4;
			
			when SUB4 =>
				SeletorB <= '0';
				Op <= "001";
				WrStatus <= '1';
				SeletorA <= "10";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= inicio;
				
			when SUBI1 =>
				SeletorB <= '1';
				Op <= "001";
				WrStatus <= '1';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
				
-------------------------------------------------------------------------------------------------------------------
				
				when BEQ =>
					if (Z='1') 
					then
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '1';
						WrPC <= '1';
						proximoEstado <= ESP1;
					else
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '0';
						WrPC <= '1';
						proximoEstado <= ESP1;
					end if;
				when BNE =>
					if (Z='0') 
					then
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '1';
						WrPC <= '1';
						proximoEstado <= ESP1;
					else
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '0';
						WrPC <= '1';
						proximoEstado <= ESP1;
					end if;
				when BGT =>
					if (Z='0' and N='0') 
					then
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '1';
						WrPC <= '1';
						proximoEstado <= ESP1;
					else
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '0';
						WrPC <= '1';
						proximoEstado <= ESP1;
					end if;				
				when BGE=>
					if (N='0') 
					then
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '1';
						WrPC <= '1';
						proximoEstado <= ESP1;
					else
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '0';
						WrPC <= '1';
						proximoEstado <= ESP1;
					end if;
				when BLT =>
					if (N='1') 
					then
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '1';
						WrPC <= '1';
						proximoEstado <= ESP1;
					else
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '0';
						WrPC <= '1';
						proximoEstado <= ESP1;
					end if;
					
				when BLE =>
					if (Z='1' OR N='1') 
					then
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '1';
						WrPC <= '1';
						proximoEstado <= ESP1;
					else
						SeletorB <= '0';
						Op <= "000";
						WrStatus <= '0';
						SeletorA <= "00";
						WrAcc <= '0';
						WrRam <= '0';
						RdRam <= '0';
						Branch <= '0';
						WrPC <= '1';
						proximoEstado <= ESP1;
					end if;
			when JMP =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '1';
				WrPC <= '1';
				proximoEstado <= ESP1;	
			when NO =>
				SeletorB <= '0';
				Op <= "101";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
			when ANND =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= ANND1;
			when ANND1 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= ANND2;
			when ANND2 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ANND3;
			when ANND3 =>
				SeletorB <= '0';
				Op <= "010";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= ESP2;
			when ANNDI =>
				SeletorB <= '1';
				Op <= "010";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
			when OOR =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= OOR1;
			when OOR1 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= OOR2;
			when OOR2 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= OOR3;
			when OOR3 =>
				SeletorB <= '0';
				Op <= "011";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= ESP2;
			when OORI =>
				SeletorB <= '1';
				Op <= "011";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
			when XOOR =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '1';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= XOOR1;
			when XOOR1 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= XOOR2;	
			when XOOR2 =>
				SeletorB <= '0';
				Op <= "000";
				WrStatus <= '0';
				SeletorA <= "00";
				WrAcc <= '0';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= XOOR3;
			when XOOR3 =>
				SeletorB <= '0';
				Op <= "100";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '0';
				proximoEstado <= ESP2;	
			when XORI =>
				SeletorB <= '1';
				Op <= "100";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
			when SLLL =>
				SeletorB <= '1';
				Op <= "110";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
			when SRLL =>
				SeletorB <= '1';
				Op <= "111";
				WrStatus <= '0';
				SeletorA <= "10";
				WrAcc <= '1';
				WrRam <= '0';
				RdRam <= '0';
				Branch <= '0';
				WrPC <= '1';
				proximoEstado <= ESP1;
			when others =>
				proximoEstado <= inicio;
		end case;
	end process;
end hardware;
