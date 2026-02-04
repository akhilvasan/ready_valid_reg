module ready_valid(
    input logic clk,reset,in_valid,out_ready,
    input logic [15:0]data_in,        //Assuming 16 bit input
    output logic in_ready,out_valid,
    output logic [15:0]data_out
);
logic [15:0] pipe_reg;
logic valid;

//Input_ready is high whenever data inside is empty or data is being taken out
assign in_ready = (~valid)||(out_ready && valid);

always_ff @(posedge clk)begin
    if(reset)begin              //Assuming active high reset
        valid<=1'b0;
    end
    else begin
        if(valid&&out_ready) 
            valid<=1'b0;
        if(in_valid&&in_ready)begin
            pipe_reg<=data_in;
            valid<=1'b1;
        end
    end
end


//output stage
assign out_valid=valid;
assign data_out=pipe_reg;

    
endmodule