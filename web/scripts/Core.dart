import 'dart:html';
import 'dart:typed_data';

import 'OperationCodes.dart';
import 'MemoryMap.dart';
import 'Register.dart';
import 'ProgramCounter.dart';

class Core
{
	MemoryMap memory;

	List<Register> registers;

	Register a;
	Register b;
	Register c;
	Register d;
	Register e;
	Register f;
	Register h;
	Register l;

	OperationCodes instructions;

	ProgramCounter program_counter;

	FileUploadInputElement input = document.getElementById('your-rom');
	FileReader reader = new FileReader();

	Core()
	{
		program_counter = new ProgramCounter(0x100);

		a = new Register();
		b = new Register();
		c = new Register();
		d = new Register();
		e = new Register();
		f = new Register();
		h = new Register();
		l = new Register();

		registers = [a, b, c, d, e, f, h, l];

		input.onChange.listen((e) {
			reader.readAsArrayBuffer(input.files[0]);
		});

		reader.onLoadEnd.listen((e) {

			window.console.clear("");
			memory = new MemoryMap(Uint8List.fromList(reader.result));
			instructions = new OperationCodes(memory, program_counter, registers);
			document.querySelector('#title').setInnerHtml(memory.gameName);
			document.querySelector('#mapper').setInnerHtml(memory.mapper);
			document.querySelector('#rom-banks').setInnerHtml("ROM:" + (memory.romSize*0xF).toString() + "K");
			document.querySelector('#ram-banks').setInnerHtml("RAM:" + (memory.ramSize*0x8).toString() + "K");
			print(l.get());
			startupsequence();

		});
	}

	void startupsequence()
	{
		print("PC: " + program_counter.toString());
		instructions.execute(memory.read(program_counter.get()));
		instructions.execute(memory.read(program_counter.get()));
		instructions.execute(memory.read(program_counter.get()));
		instructions.execute(memory.read(program_counter.get()));

	}
}
