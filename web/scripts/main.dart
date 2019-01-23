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
		memory = new MemoryMap();
		memory.loadCartridge(Uint8List.fromList(reader.result));
		memory.readMapperType();

		document.querySelector('#title').setInnerHtml(memory.readGameName());
		document.querySelector('#mapper').setInnerHtml(memory.readMapperType());
		document.querySelector('#rom-banks').setInnerHtml("ROM:" + memory.readROMSize());
		document.querySelector('#ram-banks').setInnerHtml("RAM: " + memory.readRAMSize());
		startupsequence();

	});

}

void startupsequence()
{
	program_counter = 0x100;
}
