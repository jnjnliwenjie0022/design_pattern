typedef class Receiver;

virtual class Command;
    pure virtual function void execute();
endclass

class FireCommand extends Command;
    Receiver m_receiver;
    function new (Receiver receiver);
        m_receiver = receiver;
    endfunction

    function void execute();
        m_receiver.fire();
    endfunction
endclass

class GoCommand extends Command;
    Receiver m_receiver;
    function new (Receiver receiver);
        m_receiver = receiver;
    endfunction

    function void execute();
        m_receiver.go();
    endfunction
endclass

class Sender;
    Command m_command;

    function void setCommand(Command command);
        m_command = command;
    endfunction

    function void invoke();
        m_command.execute();
    endfunction
endclass

class Receiver;
    function void fire();
        $display("Receiver: execute command: fire! fire!");
    endfunction

    function void go();
        $display("Receiver: execute command: go! go!");
    endfunction
endclass

module tb;

    initial begin
        Sender sender = new();
        Receiver receiver = new();

        FireCommand fire_command = new(receiver);
        GoCommand go_command = new(receiver);

        sender.setCommand(go_command);
        sender.invoke();

        sender.setCommand(fire_command);
        sender.invoke();
    end

endmodule
