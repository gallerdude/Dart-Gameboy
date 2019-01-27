import 'Gameboy.dart';
import 'dart:html';
import 'dart:typed_data';

void main()
{

  Gameboy gameboy;
  FileUploadInputElement input = document.getElementById('your-rom');
  FileReader reader = new FileReader();

  input.onChange.listen((e) {
    reader.readAsArrayBuffer(input.files[0]);
  });

  reader.onLoadEnd.listen((e) {
    window.console.clear("");
    gameboy = new Gameboy(Uint8List.fromList(reader.result));
  });

}
