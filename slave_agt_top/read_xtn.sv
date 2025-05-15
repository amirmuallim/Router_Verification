class read_xtn extends uvm_sequence_item;

	`uvm_object_utils(read_xtn)

	bit [7:0]header;
	bit [7:0]payload[];
	bit [7:0]parity;
	bit rd_en, vld_out;
	rand bit [5:0]delay;

	function new(string name = "read_xtn");
		super.new(name);
	endfunction : new

	function void do_print(uvm_printer printer);
		printer.print_field("header",this.header,8,UVM_HEX);
		foreach(payload[i])
			printer.print_field($sformatf("payload[%0d]:",i),this.payload[i],8,UVM_HEX);
		printer.print_field("parity",this.parity,8,UVM_HEX);
	//	printer.print_field("read_eb",this.rd_en,1,UVM_BIN);
	//	printer.print_field("vld_out",this.vld_out,1,UVM_BIN);
	endfunction

endclass : read_xtn

