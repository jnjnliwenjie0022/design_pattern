typedef class Mediator;
typedef class Colleague;

virtual class Mediator;
    pure virtual function void attachColleague (Colleague colleague);
    pure virtual function void notifyColleague (string name, string msg);
endclass

class ProductManager extends Mediator;
    protected Colleague m_colleague_hash[string];

    virtual function void attachColleague (Colleague colleague);
        m_colleague_hash[colleague.getName()] = colleague;
        colleague.setMediator(this);
    endfunction

    virtual function void notifyColleague (string name, string msg);
        m_colleague_hash[name].getMsg(msg);
    endfunction

endclass

virtual class Colleague;
    protected Mediator mediator;
    protected string m_name;

    function void setMediator(Mediator mediator);
        this.mediator = mediator;
    endfunction

    function string getName();
        return m_name;
    endfunction

    pure virtual function void putMsg (string name, string msg);
    pure virtual function void getMsg (string msg);
endclass

class A1Colleague extends Colleague;

    function new(string name);
        m_name = "A1Colleague";
    endfunction

    virtual function void putMsg (string name, string msg);
        $display("A1 Colleague send msg: %s to %s", msg, name);
        mediator.notifyColleague(name, msg);
    endfunction

    virtual function void getMsg (string msg);
        $display("A1 Colleague receive msg: %s", msg);
    endfunction
endclass

class B1Colleague extends Colleague;

    function new(string name);
        m_name = "B1Colleague";
    endfunction

    virtual function void putMsg (string name, string msg);
        $display("B1 Colleague send msg: %s to %s", msg, name);
        mediator.notifyColleague(name, msg);
    endfunction

    virtual function void getMsg (string msg);
        $display("B1 Colleague receive msg: %s", msg);
    endfunction
endclass

class D1Colleague extends Colleague;

    function new(string name);
        m_name = "D1Colleague";
    endfunction

    virtual function void putMsg (string name, string msg);
        $display("D1 Colleague send msg: %s to %s", msg, name);
        mediator.notifyColleague(name, msg);
    endfunction

    virtual function void getMsg (string msg);
        $display("D1 Colleague receive msg: %s", msg);
    endfunction
endclass

class E1Colleague extends Colleague;

    function new(string name);
        m_name = "E1Colleague";
    endfunction

    virtual function void putMsg (string name, string msg);
        $display("E1 Colleague send msg: %s to %s", msg, name);
        mediator.notifyColleague(name, msg);
    endfunction

    virtual function void getMsg (string msg);
        $display("E1 Colleague receive msg: %s", msg);
    endfunction
endclass

module tb;
    initial begin
        ProductManager product_manager = new();
        A1Colleague a1_colleague = new("");
        B1Colleague b1_colleague = new("");
        D1Colleague d1_colleague = new("");
        E1Colleague e1_colleague = new("");
        product_manager.attachColleague(a1_colleague);
        product_manager.attachColleague(b1_colleague);
        product_manager.attachColleague(d1_colleague);
        product_manager.attachColleague(e1_colleague);
        a1_colleague.putMsg("B1Colleague", "[a to b send test]");
        d1_colleague.putMsg("E1Colleague", "[d to e send test]");
    end
endmodule
