virtual class isStrategy;
    pure virtual function void add_oid();
endclass : isStrategy

class add_gasoline extends isStrategy;

    virtual function void add_oid();
        $display("Please add gasoline");
    endfunction

endclass : add_gasoline

class add_diesel extends isStrategy;

    virtual function void add_oid();
        $display("Please add diesel");
    endfunction

endclass : add_diesel

virtual class car;
    protected isStrategy strategy;

    function void set_oid_type(isStrategy strategy);
        this.strategy = strategy;
    endfunction

    function void request_add_oil();
        this.strategy.add_oid();
    endfunction
endclass

class sedan extends car;
    protected add_gasoline add_gasoline_h;

    function new();
        $display("This is sedan car!");
        add_gasoline_h = new();
        set_oid_type(add_gasoline_h);
    endfunction
endclass

class truck extends car;
    protected add_diesel add_diesel_h;

    function new();
        $display("This is truck car!");
        add_diesel_h = new();
        set_oid_type(add_diesel_h);
    endfunction
endclass

module tb;
    truck truck_h;
    sedan sedan_h;

    add_diesel add_diesel_h;
    add_gasoline add_gasoline_h;

    initial begin
        truck_h = new();
        sedan_h =  new();
        add_diesel_h = new();
        add_gasoline_h = new() ;

        sedan_h.set_oid_type(add_gasoline_h);
        sedan_h.request_add_oil();
        truck_h.set_oid_type(add_diesel_h);
        truck_h.request_add_oil();
    end
endmodule
