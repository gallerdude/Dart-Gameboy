import 'dart:typed_data';

class ReadOnlyMemoryBank
{
  Uint8List data;

  ReadOnlyMemoryBank()
  {
    this.data = new Uint8List(0x4000);
  }

}
