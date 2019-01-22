import 'dart:typed_data';

class MemoryMap
{
  Uint8List memory;
  String memoryBankControllerType;

  MemoryMap()
  {
    memory = new Uint8List(0xFFFF);
    print(memory[0xFFFF]);
  }

  void loadCartridge(Uint8List cart)
  {
    if ()
    for (int i = 0; i < cart.length; i++)
    {
      this.memory[i] = cart[i];
    }
  }

  String readGameName()
  {
  	String gameTitle = "";

  	for (int i = 0x134; i < 0x144; i++)
  	{
  		gameTitle += String.fromCharCode(this.memory[i]);
  	}

  	return gameTitle;
  }
}
