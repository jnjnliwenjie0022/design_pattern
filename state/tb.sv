/////////////////////////////////////////////////////////////////////////////////////////////////
//
// Author: jasonli LI,WEN-JIE
//
// LastMod: 09/05/2023 09:23:12
//
// Source: /home/jnjn0022/design_pattern/state/tb.sv
//
// Comment: N/A
//
/////////////////////////////////////////////////////////////////////////////////////////////////
typedef class IdleState;
typedef class AState;
typedef class BState;
typedef class FinalState;
typedef class Context;

virtual class State;
    // TODO: store content class pointer can individually proceed
    pure virtual function bit handle(Context content, bit status);
    pure virtual function string get_state_id();
endclass

class IdleState extends State;
    string m_id = "IdleState";
    AState state;
    function bit handle(Context content, bit status);
        $display("In Idle state");
        if (status) begin
            $display("Idle state finished");
            $display("From Idle state to A state");
            state = new();
            content.set_state(state);
            return 1;
        end else begin
            $display("Idle state still busy");
            return 0;
        end
    endfunction

    function string get_state_id();
        return this.m_id;
    endfunction
endclass

class AState extends State;
    string m_id = "AState";
    BState state;
    function bit handle(Context content, bit status);
        $display("In A state");
        if (status) begin
            $display("A state finished");
            $display("From A state to B state");
            state = new();
            content.set_state(state);
            return 1;
        end else begin
            $display("A state still busy");
            return 0;
        end
    endfunction

    function string get_state_id();
        return this.m_id;
    endfunction
endclass

class BState extends State;
    string m_id = "BState";
    FinalState state;
    function bit handle(Context content, bit status);
        $display("In B state");
        if (status) begin
            $display("B state finished");
            $display("From B state to Final state");
            state = new();
            content.set_state(state);
            return 1;
        end else begin
            $display("B state still busy");
            return 0;
        end
    endfunction

    function string get_state_id();
        return this.m_id;
    endfunction
endclass

class FinalState extends State;
    string m_id = "FinalState";
    function bit handle(Context content, bit status);
        $display("In Final state");
        if (status) begin
            $display("Final state finished");
            return 1;
        end else begin
            $display("Final state still busy");
            return 0;
        end
    endfunction

    function string get_state_id();
        return this.m_id;
    endfunction
endclass

class Context;
    local State state;

    function new ();
        IdleState state = new();
        this.state = state;
    endfunction

    function void set_state (State state);
        this.state = state;
    endfunction

    function string get_state_id ();
        return this.state.get_state_id();
    endfunction

    function bit handle (bit status);
        return state.handle (this, status); // TODO:
    endfunction
endclass

module tb;
    Context content;
    string id;
    string finalstate = "FinalState";
    bit finish;
    bit behavior;

    initial begin
        content = new();
        do begin
            do begin
                std:randomize(behavior) with { 0 <= behavior; behavior <= 1;};
                id = content.get_state_id();
                finish = content.handle(behavior);
            end while (~finish);
        end while (id != finalstate);
    end
endmodule
