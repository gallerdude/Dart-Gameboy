import 'dart:html';
import 'dart:typed_data';

import 'OperationCode.dart';
import 'MemoryMap.dart';

MemoryMap memory;

int program_counter;


FileUploadInputElement input = document.getElementById('your-rom');
var reader = new FileReader();

void main()
{

	input.onChange.listen((e) {
		reader.readAsArrayBuffer(input.files[0]);
	});

	reader.onLoadEnd.listen((e) {
		window.console.clear("");
		memory = new MemoryMap(Uint8List.fromList(reader.result));
		document.querySelector('#title').setInnerHtml(memory.gameName);
		document.querySelector('#mapper').setInnerHtml(memory.mapper);
		document.querySelector('#rom-banks').setInnerHtml("ROM:" + (memory.romSize*0xF).toString() + "K");
		document.querySelector('#ram-banks').setInnerHtml("RAM:" + (memory.ramSize*0x8).toString() + "K");
		startupsequence();

	});

}

void startupsequence()
{
	program_counter = 0x100;
}
