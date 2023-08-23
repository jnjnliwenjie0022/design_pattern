virtual class Strategy;
    pure virtual function void add_oid();
endclass : Strategy

class AddGasonlineStrategy extends Strategy;

    virtual function void add_oid();
        $display("Please add gasoline");
    endfunction

endclass : AddGasonlineStrategy

class AddDieselStrategy extends Strategy;

    virtual function void add_oid();
        $display("Please add diesel");
    endfunction

endclass : AddDieselStrategy

virtual class Car;
    protected Strategy strategy;

    function void set_oid_type(Strategy strategy);
        this.strategy = strategy;
    endfunction

    function void request_add_oil();
        this.strategy.add_oid();
    endfunction
endclass

class Sedan extends Car;
    function new();
        $display("This is Sedan car!");
    endfunction
endclass

class Truck extends Car;
    function new();
        $display("This is Truck car!");
    endfunction
endclass

module tb;
    Truck truck;
    Sedan sedan;

    AddDieselStrategy add_diesel_strategy;
    AddGasonlineStrategy add_gasoline_strategy;

    initial begin
        truck = new();
        sedan =  new();
        add_diesel_strategy = new();
        add_gasoline_strategy = new();

        sedan.set_oid_type(add_gasoline_strategy);
        sedan.request_add_oil();
        truck.set_oid_type(add_diesel_strategy);
        truck.request_add_oil();
    end
endmodule
