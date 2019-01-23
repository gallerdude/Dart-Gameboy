import 'dart:typed_data';

class MemoryMap
{
  Uint8List memory;
  List<Uint8List> romBanks;
  List<Uint8List> ramBanks;

  Uint8List romBank1;
  Uint8List romBank2;

  Uint8List ramBank1;
  Uint8List ramBank2;

  String gameName;
  String mapper;

  int romSize;
  int ramSize;

  MemoryMap(Uint8List cart)
  {
    Uint8List thisROMBank = new Uint8List(0x4000);
    int j = 0;

    this.gameName = getGameName(cart.sublist(0x134, 0x144));
    this.mapper  = getMapperType(cart[0x147]);
    this.romSize = getROMSize(cart[0x148]);
    this.ramSize = getRAMSize(cart[0x149]);

    romBanks = new List(this.romSize);
    ramBanks = new List(this.ramSize);
    memory   = new Uint8List(0x4FFFFF);

    for (int i = 0; i < cart.length; i++)
    {
      thisROMBank[i%0x4000] = cart[i];
      this.memory[i] = cart[i];
      if (i > 0 && i % 0x3FFF == 0)
      {
        romBanks[j] = thisROMBank;

        j++;
        if (mapper == "MBC1" && (j == 0x20 || j == 0x40 || j == 0x60))
        {
          j++;
        }

        thisROMBank = new Uint8List(0x4000);
      }
    }

    if (!ramBanks.isEmpty)
    {
      for (int i = 0; i < this.ramSize; i++)
      {
        this.ramBanks[i] = new Uint8List(0x1FFF);
      }

      if (ramBanks.length > 0)
      {
        this.ramBank1 = ramBanks[0];
      }
      if (ramBanks.length > 1)
      {
        this.ramBank2 = ramBanks[1];
      }
    }


    this.romBank1 = romBanks[0];
    this.romBank2 = romBanks[1];


    print(romBanks);
    print(ramBanks);


  }

  int read(int address)
  {
    return address;
  }

  String getGameName(Uint8List titlecodes)
  {
  	String gameTitle = "";

  	for (int i = 0; i < titlecodes.length; i++)
  	{
  		gameTitle += String.fromCharCode(titlecodes[i]);
  	}

  	return gameTitle;
  }

  String getMapperType(int mem)
  {
    String result;
    switch (mem)
    {
      case 0x00:
        result = "ROM";
        break;
      case 0x01:
        result = "MBC1";
        break;
      case 0x02:
        result = "MBC1";
        break;
      case 0x03:
        result = "MBC1";
        break;
      case 0x05:
        result = "MBC2";
        break;
      case 0x06:
        result = "MBC2";
        break;
      case 0x07:
        result = "ROM";
        break;
      case 0x10:
        result = "MBC3";
        break;
      case 0x011:
        result = "MBC3";
        break;
      case 0x012:
        result = "MBC3";
        break;
      case 0x013:
        result = "MBC3";
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

  int getROMSize(int mem)
  {
    int result;
    switch (mem)
    {
      case 0x00:
        result = 2;
        break;
      case 0x01:
        result = 4;
        break;
      case 0x02:
        result = 8;
        break;
      case 0x03:
        result = 16;
        break;
      case 0x04:
        result = 32;
        break;
      case 0x05:
        result = 64;
        break;
      case 0x06:
        result = 128;
        break;
      case 0x07:
        result = 256;
        break;

    }

    return result;
  }

  int getRAMSize(int mem)
  {
    int result;
    switch (mem)
    {
      case 0x00:
        result = 0;
        break;
      case 0x01:
        result = 1;
        break;
      case 0x02:
        result = 1;
        break;
      case 0x03:
        result = 4;
        break;
      case 0x04:
        result = 16;
        break;
      case 0x05:
        result = 8;
        break;
    }

    return result;
  }
}
