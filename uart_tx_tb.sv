module uart_tx_tb;

    reg clk, rst, start;
    reg [7:0] data;
    wire tx, done;

    uart_tx UUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data(data),
        .tx(tx),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        rst   = 1;
        start = 0;
        data  = 8'b0;

        #20 rst = 0;

        #10 data = 8'h41; start = 1;
        #10 start = 0;
        wait(done == 1);
        #20;

        #10 data = 8'h55; start = 1;
        #10 start = 0;
        wait(done == 1);
        #20;

        $display("UART Transmission Complete!");
        $finish;
    end

    initial begin
        $monitor("Time=%0t | clk=%b rst=%b start=%b data=%h tx=%b done=%b",
                  $time, clk, rst, start, data, tx, done);
    end

endmodule
