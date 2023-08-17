class logger;
    local static logger log_h;
    int file_h;

    static logger tag = get_tag_h();

    local function new();
        file_h = $fopen("log.txt", "w");
    endfunction

    static function logger get_log_h();
        if (log_h == null) begin
            log_h = new();
            $display("create log_h!");
        end
        return log_h;
    endfunction

    static function logger get_tag_h();
        if (tag == null) begin
            tag = new();
            $display("create tag_h!");
        end
        return tag;
    endfunction

    function write (string str);
        $fdisplay(file_h, "write: %s", str);
    endfunction
endclass

class user_a;
    logger log_h;
    function new ();
        $display("user_a new()!");
        log_h = logger::get_log_h();
    endfunction
endclass

class user_b;
    logger log_h;
    function new ();
        $display("user_b new()!");
        log_h = logger::get_log_h();
    endfunction
endclass

module tb;

    user_a a_h;
    user_b b_h;

    initial begin
        a_h = new();
        b_h = new();
        fork
            a_h.log_h.write("AAA");
            b_h.log_h.write("BBB");
            $display("a_h.log_h: %d", a_h.log_h);
            $display("b_h.log_h: %d", b_h.log_h);
        join
        #1;
        $finish();
    end
endmodule
