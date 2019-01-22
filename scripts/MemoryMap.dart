import 'dart:typed_data';

class MemoryMap
{
  Uint8List memory;

  MemoryMap()
  {
    memory = new Uint8List(65535);
  }

  display()
  {
    print(this.memory)
  }
}
