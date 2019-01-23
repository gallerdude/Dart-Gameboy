import 'dart:typed_data';

class MemoryMap
{
  Uint8List memory;
  List<Uint8List> banks;
  String memoryBankControllerType;

  MemoryMap()
  {
    memory = new Uint8List(0x4FFFFF);
  }

  void loadCartridge(Uint8List cart)
  {
    for (int i = 0; i < cart.length; i++)
    {
      this.memory[i] = cart[i];
    }

    //print(readGameName());
    //print(readMapperType());
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

  String readMapperType()
  {
    String result;
    switch (memory[0x147])
    {
      case 0x00:
        result = "ROM only";
        break;
      case 0x01:
        result = "MBC1";
        break;
      case 0x02:
        result = "MBC1+RAM";
        break;
      case 0x03:
        result = "MBC1+RAM+Battery";
        break;
      case 0x05:
        result = "MBC2";
        break;
      case 0x06:
        result = "MBC2+BATTERY";
        break;
      case 0x07:
        result = "ROM+RAM";
        break;
      case 0x011:
        result = "MBC3";
        break;
      case 0x012:
        result = "MBC3+RAM";
        break;
      case 0x013:
        result = "MBC3+RAM+BATTERY";
        break;

    }

    return result;
  }

  String readROMSize()
  {
    String result;
    switch (memory[0x148])
    {
      case 0x00:
        result = "32KByte";
        break;
      case 0x01:
        result = "64KByte";
        break;
      case 0x02:
        result = "128KByte";
        break;
      case 0x03:
        result = "256KByte";
        break;
      case 0x04:
        result = "512KByte";
        break;
      case 0x05:
        result = "1MByte";
        break;
      case 0x06:
        result = "2MByte";
        break;

    }

    return result;
  }

  String readRAMSize()
  {
    String result;
    switch (memory[0x148])
    {
      case 0x00:
        result = "No RAM";
        break;
      case 0x01:
        result = " 2KB RAM";
        break;
      case 0x02:
        result = "8KB RAM";
        break;
      case 0x03:
        result = "32 KBytes (4 banks of 8KBytes each)";
        break;
      case 0x04:
        result = "128 KBytes (16 banks of 8KBytes each)";
        break;
      case 0x05:
        result = "64 KBytes (8 banks of 8KBytes each)";
        break;
    }

    return result;
  }
}
