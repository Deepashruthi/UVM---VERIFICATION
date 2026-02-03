//Environment 

class my_env extends uvm_env;
  
  my_agent agnt;
  my_score sb;
  
  //Factory reg
  `uvm_component_utils(my_env)
  
  //Constructor
  function new(string name ="environment",uvm_component parent);
    super.new(name, parent);
    `uvm_info("ENV", "Environment Created",UVM_LOW)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt= my_agent:: type_id ::create("agnt",this);    
    sb= my_score::type_id:: create("sb",this);    
  endfunction
  
  function void  connect_phase (uvm_phase phase); 
    super.connect_phase(phase);  
    agnt.mntr.mon_ap.connect(sb.sb_imp);  
  endfunction
  
endclass
