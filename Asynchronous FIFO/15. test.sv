//Test
class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)

  fifo_env env;
  fifo_sequence seq;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = fifo_env::type_id::create("env", this);
    seq=fifo_sequence::type_id::create("seq");
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seq.start(env.agent.seqr);
    #200;
    phase.drop_objection(this);
  endtask
endclass
