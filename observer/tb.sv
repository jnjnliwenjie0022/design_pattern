virtual class Observer;
    protected string m_name;
    pure virtual function void update(string message);
    pure virtual function string getName();
endclass

class Investor extends Observer;
    string message;

    function new(string name);
        m_name = name;
    endfunction

    virtual function void update (string message);
        $display("%4s receive message: \"%s\"", m_name, message);
        this.message = message;
    endfunction

    virtual function string getName ();
        return m_name;
    endfunction
endclass

virtual class Subject;
    pure virtual function void attachObserver (Observer observer);
    pure virtual function void detachObserver (Observer observer);
    pure virtual function void notifyObserver (string message);
    pure virtual function void change (int price);
endclass

class Stock extends Subject;
    protected Observer m_observer_hash[string];

    virtual function void change(int price);
        if (price > 20)
            notifyObserver("The stock price > 20$");
        else if (price < 10)
            notifyObserver("The stock price < 10$");
    endfunction

    virtual function void notifyObserver (string message);
        foreach(m_observer_hash[i])
            m_observer_hash[i].update(message);
    endfunction

    virtual function void attachObserver(Observer observer);
        m_observer_hash[observer.getName()] = observer;
    endfunction

    virtual function void detachObserver(Observer observer);
        m_observer_hash.delete(observer.getName());
    endfunction

endclass

module tb;
    initial begin
        Investor invertor1 = new("Jack");
        Investor invertor2 = new("Tom");

        Stock stock = new();

        stock.attachObserver(invertor1);
        stock.attachObserver(invertor2);

        stock.change(21);
        $display("invertor1: %s", invertor1.message);
        $display("invertor2: %s", invertor2.message);

        stock.change(9);
        $display("invertor1: %s", invertor1.message);
        $display("invertor2: %s", invertor2.message);
    end
endmodule
