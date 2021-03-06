// $ID: $
// File name: moore.sv$  
// Author: Rishab Verma mg147$
// Lab Section: Friday 11 30 am $
// Description: Moore machine 1101 detector $


module moore
(
	input wire clk,
	input wire n_rst,
	input wire i,
	output reg o
);


//defining the diferent states
parameter [2:0] startstate = 3'b000;
parameter [2:0] state1 = 3'b001;
parameter [2:0] state2 = 3'b010;
parameter [2:0] state3 = 3'b011;
parameter [2:0] state4 = 3'b100;

//states
reg [2:0] current;
reg [2:0] next;


always_ff @ (posedge clk, negedge n_rst)
begin
	if(n_rst == 0)
		current <= startstate; //state start is 0 bits
	else	
		current <= next;
end

always_comb 
begin
	next = current;

	case(current)
		startstate: 
			begin
			if(i == 1)
				next = state1;
			else
				next = startstate;
			end  	 

		state1: 
			begin
			if(i ==1)
				next = state2;
			else
				next = startstate;
			end
		state2:
			begin
			if (i == 0)
				next = state3;
			else
				next = state2;
			end
		state3:
			begin
			if(i == 1)
				next = state4;
			else
				next = startstate;
			end
		state4:
			begin
			if(i == 1)
				next = state2;
			else
				next = startstate;
			end
			
		default:
			begin
				next = startstate;
			end
	endcase	
end


assign o = (current == state4);					

endmodule
