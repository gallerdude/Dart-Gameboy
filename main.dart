import 'dart:html';
import 'dart:typed_data';

var memory;

FileUploadInputElement input = document.getElementById('your-rom');
var reader = new FileReader();

void main()
{
	input.onChange.listen((e) {
		print("ech");
		reader.readAsArrayBuffer(input.files[0]);
	});

	reader.onLoadEnd.listen((e) {
		memory = new Uint8List.fromList(reader.result);
		print(memory);
		document.querySelector('#result').setInnerHtml(readGameName());
	});

}

String readGameName()
{
	String gameTitle = "";

	for (num i = 0x134; i < 0x144; i++)
	{
		gameTitle += String.fromCharCode(memory[i]);
	}

	return gameTitle;
}

String sayHi()
{
	print("hi");
}
