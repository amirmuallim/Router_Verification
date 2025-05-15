class write_xtn extends uvm_sequence_item;

	`uvm_object_utils(write_xtn)

	function new(string name = "write_xtn");
		super.new(name);
	endfunction : new

	rand bit [7:0] header;
	rand bit [7:0] payload[];
	bit [7:0] parity;
	bit error;

	constraint c1 {header[1:0] != 3;}
	constraint c2 {payload.size() == header[7:2];}
	constraint c3 {header[7:2] != 0;}

	function void post_randomize();
		parity = 0 ^ header;
			foreach (payload[i])
			begin
				parity = payload[i] ^ parity;
			end
	endfunction

	function void do_print (uvm_printer printer);
		//print_field((string name,bitstream value,size,radix//
		printer.print_field("header",this.header,8,UVM_HEX);
		foreach(payload[i])
			printer.print_field($sformatf("payload[%0d] : ",i),this.payload[i],8,UVM_HEX);
		printer.print_field("parity",this.parity,8,UVM_HEX);
	endfunction

endclass : write_xtn
