/////////////////////////////////////////////////////////////////////////////////////////////////
//
// Author: jasonli LI,WEN-JIE
//
// LastMod: 09/03/2023 11:53:01
//
// Source: /home/jnjn0022/design_pattern/iterator/tb.sv
//
// Comment: N/A
//
/////////////////////////////////////////////////////////////////////////////////////////////////

virtual class Callback;
    pure virtual function void print();
endclass

class ErrInjectCallback extends Callback;
    virtual function void print();
        $display("Callback: inject error!!");
    endfunction
endclass

class RstRegisterCallback extends Callback;
    virtual function void print();
        $display("Callback: reset register!!");
    endfunction
endclass

class RandomCallback extends Callback;
    virtual function void print();
        $display("Callback: random");
    endfunction
endclass

class Callbacks;
    Callback q[$];

    function void add (Callback callback, bit is_append = 1);
        if (is_append)
            q.push_back(callback);
        else
            q.push_front(callback);
    endfunction

    function void delete (Callback callback);
        if (find_callback(q,callback))
            $display("Warning! Cannot obtained this callback");
        else
            q.delete(find_callback(q,callback));
    endfunction

    local function int find_callback(ref Callback q[$], Callback callback);
        foreach(q[i])
            return i;
        return -1;
    endfunction
endclass

virtual class Iterator;
    pure virtual function void reset ();
    pure virtual function bit hasNext ();
    pure virtual function Callback getNext ();
endclass

class CallbackIterator extends Iterator;
    Callbacks m_container;
    local int current_position;

    function new (Callbacks container);
        m_container = container;
    endfunction

    function bit hasNext ();
        return current_position < m_container.q.size();
    endfunction

    function Callback getNext ();
        Callback callback;
        if (!hasNext())
            return null;
        callback = m_container.q[current_position];
        current_position++;

        return callback;
    endfunction

    function void reset ();
        current_position = 0;
    endfunction

    function void print ();
        while (hasNext) begin
            Callback callback = getNext();
            callback.print();
        end
        reset();
    endfunction
endclass

module tb;
    ErrInjectCallback err_inject_callback;
    RstRegisterCallback rst_register_callback;
    RandomCallback random_callback;
    Callbacks container;
    CallbackIterator callback_iterator;
    initial begin
        err_inject_callback = new();
        rst_register_callback = new();
        random_callback = new();
        container = new();

        container.add(err_inject_callback, 1);
        container.add(rst_register_callback, 0);
        container.add(random_callback, 1);

        callback_iterator = new(container);

        $display("Display all callback");
        callback_iterator.print();

        $display("Delete the rst_register_callback");
        container.delete(rst_register_callback);
        callback_iterator.print();
    end
endmodule
