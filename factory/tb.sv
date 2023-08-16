`include "uvm_macros.svh"
import uvm_pkg::*;

// factory method design pattern
virtual class lvm_object;
    pure virtual function void print();
endclass

virtual class lvm_object_wrapper;
    pure virtual function lvm_object create_object();
endclass

lvm_object_wrapper factory[lvm_object_wrapper];

class lvm_object_registry #(type T = int) extends lvm_object_wrapper;

    local static lvm_object_registry #(T) me = get();

    virtual function lvm_object create_object();
        T obj;
        obj = new();
        return obj;
    endfunction : create_object

    static function lvm_object_registry #(T) get();
        if(me == null)begin
            me = new();
            factory[me] = me; // typically object_name is the index of the hash table
        end
        return me;
    endfunction : get

    static function T create();
        T obj;
        $cast(obj, factory[get()].create_object());
        return obj;
    endfunction

endclass

// user define object
class A extends lvm_object;
    typedef lvm_object_registry #(A) type_id;

    virtual function void print();
        $display("is class A");
    endfunction
endclass

class B extends lvm_object;
    typedef lvm_object_registry #(B) type_id;

    virtual function void print();
        $display("is class B");
    endfunction
endclass

class C extends A;
    typedef lvm_object_registry #(C) type_id;

    virtual function void print();
        $display("is class C");
    endfunction
endclass

module top_tb;

    initial begin
        A a_obj;
        B b_obj;

        a_obj = A::type_id::create();
        b_obj = B::type_id::create();

        a_obj.print();
        b_obj.print();

        // factory override
        factory[A::type_id::get()] = C::type_id::get();

        a_obj = A::type_id::create();
        a_obj.print();
    end

endmodule
