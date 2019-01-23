import 'dart:typed_data';

class MemoryMap
{
  Uint8List memory;
  List<Uint8List> romBanks;

  Uint8List romBank1;
  Uint8List romBank2;

  String gameName;
  String mapperType;
  String romSize;
  String ramSize;

  MemoryMap(Uint8List cart)
  {
    Uint8List thisROMBank = new Uint8List(0x4000);
    int j = 0;

    romBanks = new List(0x4FF);
    memory = new Uint8List(0x4FFFFF);

    for (int i = 0; i < cart.length; i++)
    {
      thisROMBank[i%0x4000] = cart[i];
      this.memory[i] = cart[i];
      if (i > 0 && i % 0x3FFF == 0)
      {
        romBanks[j] = thisROMBank;
        j++;
        thisROMBank = new Uint8List(0x4000);
      }
    }

    this.romBank1 = romBanks[0];
    this.romBank2 = romBanks[1];

    this.gameName = getGameName();
    this.mapperType = getMapperType();
    this.romSize = getROMSize();
    this.ramSize = getRAMSize();
  }

  int read(int address)
  {
    return address;
  }

  String getGameName()
  {
  	String gameTitle = "";

  	for (int i = 0x134; i < 0x144; i++)
  	{
  		gameTitle += String.fromCharCode(this.memory[i]);
  	}

  	return gameTitle;
  }

  String getMapperType()
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
      case 0x10:
        result = "MBC3+TIMER+RAM+BATTERY";
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
      case 0x019:
        result = "MBC5";
        break;
      case 0x01A:
        result = "MBC5+RAM";
        break;
      case 0x01B:
        result = "MBC5+RAM+Battery";
        break;
      case 0x020:
        result = "MBC6";
        break;

    }

    return result;
  }

  String getROMSize()
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

  String getRAMSize()
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
