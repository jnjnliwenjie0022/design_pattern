class Adaptee;
    function void adapteeOperation ();
        $display("adapteeOperation");
    endfunction
endclass

virtual class Target;
    pure virtual function void operation();
endclass

class Adapter extends Target;
    local Adaptee adaptee;

    function new (Adaptee adaptee);
        this.adaptee = adaptee;
    endfunction

    function void operation();
        adaptee.adapteeOperation();
    endfunction
endclass

module tb;

    initial begin
        Adaptee adaptee = new();
        Adapter adapter = new(adaptee);
        Target target = adapter;
        target.operation();
    end
endmodule
