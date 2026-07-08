module SimpleHash_tb;
    reg  [15:0] msg;
    reg  [7:0]  key;
    wire [7:0]  hash;

    integer i;
    integer distinct_count;
    integer max_bucket, min_bucket;

    //histogram buckets
    reg [31:0] buckets [0:255];

    SimpleHash uut (
        .msg(msg),
        .key(key),
        .hash(hash)
    );

    initial begin
        
        $dumpfile("SimpleHash.vcd");
        $dumpvars(0, SimpleHash_tb);

        
        $display("\n   SimpleHash Demo (keyed, 8-bit digest)    \n");
        key = 8'h3C; //key can be changed

        
        msg = 16'h0000; #1 $display("msg=0x%04h -> hash=0x%02h", msg, hash);
        msg = 16'h0001; #1 $display("msg=0x%04h -> hash=0x%02h", msg, hash);
        msg = 16'h00FF; #1 $display("msg=0x%04h -> hash=0x%02h", msg, hash);
        msg = 16'hFFFF; #1 $display("msg=0x%04h -> hash=0x%02h", msg, hash);
        msg = 16'hBEEF; #1 $display("msg=0x%04h -> hash=0x%02h", msg, hash);

        //Very close Values, Avalanche demo
        msg = 16'h1234; #1 $display("msg=0x%04h -> hash=0x%02h", msg, hash);
        msg = 16'h1235; #1 $display("msg=0x%04h -> hash=0x%02h", msg, hash);

        
        $display("\nStarting exhaustive distribution test (this may take some time)...");

        for (i = 0; i < 256; i = i + 1) begin
            buckets[i] = 0;
        end

        for (i = 0; i < 65536; i = i + 1) begin
            msg = i[15:0];
            #1;
            buckets[hash] = buckets[hash] + 1;
        end

        //Computing Statistics
        distinct_count = 0;
        max_bucket = 0;
        min_bucket = 32'h7fffffff;
        for (i = 0; i < 256; i = i + 1) begin
            if (buckets[i] != 0) distinct_count = distinct_count + 1;
            if (buckets[i] > max_bucket) max_bucket = buckets[i];
            if (buckets[i] < min_bucket) min_bucket = buckets[i];
        end

        
        force SimpleHash_tb.distinct_count = distinct_count;
        force SimpleHash_tb.max_bucket = max_bucket;
        force SimpleHash_tb.min_bucket = min_bucket;
        #1;

        $display("\nExhaustive test completed.");
        $display("Distinct digest values observed: %0d / 256", distinct_count);
        $display("Min bucket count: %0d", min_bucket);
        $display("Max bucket count: %0d", max_bucket);

        $display("\nSample bucket counts (digest:count):");
        for (i = 0; i < 16; i = i + 1) begin
            $display("0x%02h : %0d", i, buckets[i]);
        end

        $stop;
    end

endmodule
