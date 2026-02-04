module ready_valid_tb;
logic clk,reset,in_valid,out_ready;
logic [15:0] data_in;
logic in_ready,out_valid;
logic [15:0] data_out;

ready_valid dut(.clk(clk),.reset(reset),.in_valid(in_valid),.out_ready(out_ready),.data_in(data_in),
.in_ready(in_ready),.out_valid(out_valid),.data_out(data_out));

always #5 clk=~clk;
initial begin
    $dumpfile("ready_valid.vcd");
    $dumpvars(0, tb_ready_valid);
    
    clk=0;
    reset=1;
    in_valid=0;
    out_ready=0;
    data_in=16'h0000;

    #20;
    reset=0;

    //checking it for increasing data inputs
    repeat(4) begin
        @(posedge clk);
        in_valid=1;
        out_ready=1;
        data_in=data_in+1;
    end
    @(posedge clk);
    in_valid=0;

    //backpressure check
    @(posedge clk);
    in_valid=1;
    out_ready=0;
    data_in=16'h1002;
    repeat(3) @(posedge clk);
    out_ready=1;
    @(posedge clk);
    in_valid=0;

    //simulation over
    #40;
    $finish;
end

endmodule
