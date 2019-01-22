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

		document.querySelector('#result').setInnerHtml(memory.readGameName());
		startupsequence();

	});

}

void startupsequence()
{
	program_counter = 0x100;
}
